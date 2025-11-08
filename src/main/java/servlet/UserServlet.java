package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class UserServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(username, password);
        if (user != null) {
            req.getSession().setAttribute("user",user);
            if(user.getRole().equals("admin")){
                req.getRequestDispatcher("/Storekeeper/MainStorekeeperView.jsp").forward(req,resp);
            }
            else {
                req.getRequestDispatcher("/Customer/MainCustomerView.jsp").forward(req,resp);
            }
        }
        else {
            req.getRequestDispatcher("/Login/LoginView.jsp").forward(req,resp);
        }
    }
}
