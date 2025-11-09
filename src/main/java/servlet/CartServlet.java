package servlet;

import dao.CartDAO;
import dao.ProductDAO;
import model.Cart;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath()+"/");
        }

        int customerId = user.getId();

        try {
            switch (action) {
                case "add":
                    int pid = Integer.parseInt(req.getParameter("id"));
                    int qty = Integer.parseInt(req.getParameter("qty"));
                    cartDAO.addToCart(customerId, pid, qty);
                    resp.sendRedirect("ProductServlet?action=searchitem");
                    break;
                case "remove":
                    int productId = Integer.parseInt(req.getParameter("id"));
                    cartDAO.removeItem(customerId, productId);
                    resp.sendRedirect("CartServlet?action=view");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "view";

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath()+"/");
        }

        int customerId = user.getId();
        Cart cart = cartDAO.getCartByCustomerId(customerId);
        req.setAttribute("cart", cart);
        req.setAttribute("user", user);

        String success = req.getParameter("success");

        if (success != null) {
            if ("true".equals(success)) {
                req.setAttribute("successMessage", "Order placed successfully! Thank you for your purchase.");
                req.setAttribute("alertClass", "alert-success");
            } else if ("false".equals(success)) {
                req.setAttribute("successMessage", "The requested quantity exceeds the available stock.");
                req.setAttribute("alertClass", "alert-danger");
            }
        }

        req.getRequestDispatcher("/Customer/CartView.jsp").forward(req, resp);
    }
}
