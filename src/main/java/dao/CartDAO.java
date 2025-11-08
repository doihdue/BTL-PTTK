package dao;

import model.Cart;
import model.CartItem;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends DAO {

    // Thêm sản phẩm vào giỏ (tự động tạo giỏ nếu chưa có)
    public void addToCart(int customerId, int productId, int quantity) {
        try {
            int cartId = -1;

            // Kiểm tra xem đã có giỏ hàng chưa
            String checkCartSql = "SELECT id FROM tblcart WHERE customer_id=?";
            PreparedStatement checkCartStm = con.prepareStatement(checkCartSql);
            checkCartStm.setInt(1, customerId);
            ResultSet rsCart = checkCartStm.executeQuery();
            if (rsCart.next()) {
                cartId = rsCart.getInt("id");
            } else {
                // Nếu chưa có -> tạo mới giỏ
                String insertCartSql = "INSERT INTO tblcart(createdDate, customer_id) VALUES (NOW(), ?)";
                PreparedStatement insertCartStm = con.prepareStatement(insertCartSql, Statement.RETURN_GENERATED_KEYS);
                insertCartStm.setInt(1, customerId);
                insertCartStm.executeUpdate();
                ResultSet keys = insertCartStm.getGeneratedKeys();
                if (keys.next()) {
                    cartId = keys.getInt(1);
                }
            }

            if (cartId == -1) {
                throw new SQLException("Không thể tạo hoặc lấy giỏ hàng!");
            }

            // Kiểm tra sản phẩm đã có trong giỏ chưa
            String checkItemSql = "SELECT quantity FROM tblcartitem WHERE cart_id=? AND product_id=?";
            PreparedStatement checkItemStm = con.prepareStatement(checkItemSql);
            checkItemStm.setInt(1, cartId);
            checkItemStm.setInt(2, productId);
            ResultSet rsItem = checkItemStm.executeQuery();

            if (rsItem.next()) {
                // Cập nhật số lượng nếu đã có
                int oldQty = rsItem.getInt("quantity");
                String updateSql = "UPDATE tblcartitem SET quantity=? WHERE cart_id=? AND product_id=?";
                PreparedStatement updateStm = con.prepareStatement(updateSql);
                updateStm.setInt(1, oldQty + quantity);
                updateStm.setInt(2, cartId);
                updateStm.setInt(3, productId);
                updateStm.executeUpdate();
            } else {
                // Thêm mới nếu chưa có
                String insertSql = "INSERT INTO tblcartitem(quantity, product_id, cart_id) VALUES (?, ?, ?)";
                PreparedStatement insertStm = con.prepareStatement(insertSql);
                insertStm.setInt(1, quantity);
                insertStm.setInt(2, productId);
                insertStm.setInt(3, cartId);
                insertStm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách sản phẩm trong giỏ hàng của customer
    public Cart getCartByCustomerId(int customerId) {
        Cart cart = null;
        try {
            String sql = "SELECT c.id AS cart_id, c.createdDate, " +
                    "p.id AS pid, p.name, p.price, ci.quantity " +
                    "FROM tblcart c " +
                    "LEFT JOIN tblcartitem ci ON c.id = ci.cart_id " +
                    "LEFT JOIN tblproduct p ON ci.product_id = p.id " +
                    "WHERE c.customer_id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, customerId);
            ResultSet rs = stm.executeQuery();

            List<CartItem> items = new ArrayList<>();
            int cartId = -1;
            Date createdDate = null;

            while (rs.next()) {
                if (cartId == -1) {
                    cartId = rs.getInt("cart_id");
                    createdDate = rs.getDate("createdDate");
                }

                int pid = rs.getInt("pid");
                if (pid > 0) { // có sản phẩm
                    Product p = new Product();
                    p.setId(pid);
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));

                    CartItem item = new CartItem(p, rs.getInt("quantity"));
                    items.add(item);
                }
            }

            if (cartId != -1) {
                cart = new Cart(cartId, createdDate, items);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }


    // Xóa 1 sản phẩm khỏi giỏ
    public void removeItem(int customerId, int productId) {
        try {
            String sql = "DELETE ci FROM tblcartitem ci " +
                    "JOIN tblcart c ON ci.cart_id = c.id " +
                    "WHERE c.customer_id=? AND ci.product_id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, customerId);
            stm.setInt(2, productId);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa toàn bộ giỏ hàng (sau khi thanh toán)
    public void clearCart(int customerId) {
        try {
            String sql = "DELETE ci FROM tblcartitem ci " +
                    "JOIN tblcart c ON ci.cart_id = c.id " +
                    "WHERE c.customer_id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, customerId);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
