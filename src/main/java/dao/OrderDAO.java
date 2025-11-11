package dao;

import model.Order;
import model.OrderDetail;

import java.sql.*;
import java.util.List;

public class OrderDAO extends DAO {

    public OrderDAO() {
        super();
    }

    // Chỉ lưu đơn hàng và chi tiết
    public int saveOrder(Order order) {
        int orderId = -1;

        String sqlOrder = "INSERT INTO tblorder(orderDate, status, customer_id, addressId) VALUES (?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO tblorderdetail(order_id, product_id, quantity, unitPrice) VALUES (?, ?, ?, ?)";
        String sqlUpdateStock = "UPDATE tblproduct SET stockQuantity = stockQuantity - ? WHERE id = ?";

        try {
            con.setAutoCommit(false);

            // --- 1. Lưu thông tin đơn hàng ---
            try (PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setDate(1, new java.sql.Date(order.getOrderDate().getTime()));
                psOrder.setString(2, order.getStatus());
                psOrder.setInt(3, order.getCustomer().getId());
                psOrder.setInt(4, order.getAddress().getId()); // 🆕 địa chỉ giao hàng

                psOrder.executeUpdate();

                ResultSet rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // --- 2. Lưu chi tiết đơn hàng và cập nhật tồn kho ---
            try (
                    PreparedStatement psDetail = con.prepareStatement(sqlDetail);
                    PreparedStatement psUpdateStock = con.prepareStatement(sqlUpdateStock)
            ) {
                for (OrderDetail d : order.getOrderDetails()) {
                    // Thêm chi tiết đơn hàng
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, d.getProduct().getId());
                    psDetail.setInt(3, d.getQuantity());
                    psDetail.setDouble(4, d.getUnitPrice());
                    psDetail.addBatch();

                    // Trừ tồn kho
                    psUpdateStock.setInt(1, d.getQuantity());
                    psUpdateStock.setInt(2, d.getProduct().getId());
                    psUpdateStock.addBatch();
                }

                psDetail.executeBatch();
                psUpdateStock.executeBatch();
            }

            con.commit();
            System.out.println("✅ Đơn hàng #" + orderId + " lưu thành công, đã cập nhật tồn kho và địa chỉ giao hàng.");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                con.rollback();
                System.err.println("❌ Lỗi khi lưu đơn hàng, rollback hoàn tất.");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderId;
    }


}
