package servlet;

import dao.AddressDAO;
import model.Address;
import model.Customer;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddressServlet extends HttpServlet {
    private AddressDAO addressDAO;

    @Override
    public void init() {
        addressDAO = new AddressDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String action = req.getParameter("action");
        int customerId = user.getId();

        if ("setDefault".equals(action)) {
            int addressId = Integer.parseInt(req.getParameter("addressId"));
            addressDAO.unsetDefaultForCustomer(customerId);
            addressDAO.setDefaultAddress(addressId);
            resp.sendRedirect(req.getContextPath() + "/CartServlet?action=view");
            return;
        }

        // Nếu không phải setDefault, thêm địa chỉ mới
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String addressText = req.getParameter("address");
        boolean isDefault = req.getParameter("isDefault") != null;

        if (isDefault) {
            addressDAO.unsetDefaultForCustomer(customerId);
        }

        Address a = new Address();
        Customer customer = new Customer();
        customer.setId(user.getId());
        customer.setName(user.getName());
        a.setCustomer(customer);
        a.setFullName(fullName);
        a.setPhone(phone);
        a.setAddress(addressText);
        a.setDefault(isDefault);

        addressDAO.addAddress(a);

        resp.sendRedirect(req.getContextPath() + "/CartServlet?action=view");
    }
}
