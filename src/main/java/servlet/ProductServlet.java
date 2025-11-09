package servlet;

import dao.ProductDAO;
// Đổi từ jakarta.* sang javax.*
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Product;
import model.User;

import java.io.IOException;
import java.util.List;

public class ProductServlet extends HttpServlet {
    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath()+"/");
        }

        String action = req.getParameter("action");
        if (action == null) action = "search";

        switch (action) {
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Product p = dao.getProductById(id);
                req.setAttribute("product", p);
                req.getRequestDispatcher("/Storekeeper/EditItemView.jsp").forward(req, resp);
                break;
            case "itemdetail":
                int idp = Integer.parseInt(req.getParameter("id"));
                Product pr = dao.getProductById(idp);
                req.setAttribute("product", pr);
                req.getRequestDispatcher("/Customer/ItemDetailView.jsp").forward(req, resp);
                break;
            case "management":
                req.getRequestDispatcher("/Storekeeper/ItemManagementView.jsp").forward(req, resp);
                break;
            case "customer":
                req.getRequestDispatcher("/Customer/MainCustomerView.jsp").forward(req, resp);
                break;
            case "mainsk":
                req.getRequestDispatcher("/Storekeeper/MainStorekeeperView.jsp").forward(req, resp);
                break;
            case "searchitem":
                List<Product> list = dao.getAllProducts();
                req.setAttribute("products", list);
                req.getRequestDispatcher("/Customer/SearchView.jsp").forward(req, resp);
                break;
            case "search":
            default:
                List<Product> products = dao.getAllProducts();
                req.setAttribute("products", products);
                req.getRequestDispatcher("/Storekeeper/ItemSearchView.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath()+"/");
        }

        String action = req.getParameter("action");

        if ("searchcustomer".equals(action)) {
            String name = req.getParameter("itemName");
            List<Product> products = dao.getAllProductByName(name);
            if (products == null || products.isEmpty()) {
                req.setAttribute("products", null);
            }
            req.setAttribute("products", products);
            req.getRequestDispatcher("/Customer/SearchView.jsp").forward(req, resp);
        } else if ("search".equals(action)) {
            String name = req.getParameter("itemName");
            List<Product> products = dao.getAllProductByName(name);
            req.setAttribute("products", products);
            req.getRequestDispatcher("/Storekeeper/ItemSearchView.jsp").forward(req, resp);
        } else if ("save".equals(action)) {
            int id = req.getParameter("id") != null && !req.getParameter("id").isEmpty() ? Integer.parseInt(req.getParameter("id")) : 0;
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            int stock = Integer.parseInt(req.getParameter("stockQuantity"));
            String description = req.getParameter("description");

            Product product = new Product(id, name, price, stock, description);
            dao.saveProduct(product);
            resp.sendRedirect("ProductServlet?action=search&success=true");
        }
    }
}
