package servlet;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import model.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        int customerId = user.getId();
        int addressId = Integer.parseInt(req.getParameter("addressId"));


        try {
            // Lấy giỏ hàng của khách
            Cart cart = cartDAO.getCartByCustomerId(customerId);

            if (cart == null || cart.getItems().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/CartServlet?action=view&success=false");
                return;
            }

            // Kiểm tra tồn kho & chuẩn bị danh sách chi tiết đơn hàng
            boolean outOfStock = false;
            List<OrderDetail> details = new ArrayList<>();

            for (CartItem item : cart.getItems()) {
                Product product = productDAO.getProductById(item.getProduct().getId());

                if (product.getStockQuantity() < item.getQuantity()) {
                    outOfStock = true;
                    break;
                }

                // Chuẩn bị chi tiết đơn hàng
                OrderDetail detail = new OrderDetail();
                detail.setProduct(product);
                detail.setQuantity(item.getQuantity());
                detail.setUnitPrice(product.getPrice());
                details.add(detail);
            }

            if (outOfStock) {
                resp.sendRedirect(req.getContextPath() + "/CartServlet?action=view&success=false");
                return;
            }

            // Tạo đối tượng Order
            Order order = new Order();
            order.setCustomer(new Customer(customerId));
            order.setOrderDate(new Date());
            order.setStatus("Đang xử lý");
            order.setAddress(new Address(addressId));
            order.setOrderDetails(details);

            // Gọi DAO để lưu
            int orderId = orderDAO.saveOrder(order);

            // Xóa giỏ hàng
            cartDAO.clearCart(customerId);

            // Quay lại giỏ hàng với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/CartServlet?action=view&success=true");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
