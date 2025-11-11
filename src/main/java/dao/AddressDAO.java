package dao;

import model.Address;
import model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO extends DAO {

    public AddressDAO() {
        super();
    }

    // Lấy danh sách địa chỉ theo customerId
    public List<Address> getAddressesByCustomerId(int customerId) {
        List<Address> list = new ArrayList<>();
        String sql = "SELECT * FROM tblAddress WHERE customerId = ? ORDER BY isDefault DESC, createdDate DESC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt("id"));
                // Tạo Customer chỉ với ID
                Customer c = new Customer();
                c.setId(rs.getInt("customerId"));
                a.setCustomer(c);
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getString("phone"));
                a.setAddress(rs.getString("address"));
                a.setDefault(rs.getBoolean("isDefault"));
                a.setCreatedDate(rs.getTimestamp("createdDate"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm địa chỉ mới
    public void addAddress(Address a) {
        String sql = "INSERT INTO tblAddress (customerId, fullName, phone, address, isDefault) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, a.getCustomer().getId());
            ps.setString(2, a.getFullName());
            ps.setString(3, a.getPhone());
            ps.setString(4, a.getAddress());
            ps.setBoolean(5, a.isDefault());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Bỏ mặc định tất cả địa chỉ của customer
    public void unsetDefaultForCustomer(int customerId) {
        String sql = "UPDATE tblAddress SET isDefault = false WHERE customerId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đặt một địa chỉ cụ thể là mặc định
    public void setDefaultAddress(int addressId) {
        String sql = "UPDATE tblAddress SET isDefault = true WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
