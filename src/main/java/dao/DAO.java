package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    protected Connection con; // cho phép các lớp con dùng

    public DAO() {
        try {
            String url = "jdbc:mysql://localhost:3306/storedb";
            String user = "root";
            String pass = "";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Kết nối CSDL thành công!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đóng kết nối
    public void close() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("Đã đóng kết nối CSDL!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
