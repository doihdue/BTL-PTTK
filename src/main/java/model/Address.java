package model;

import java.util.Date;

public class Address {
    private int id;
    private Customer customer; // Thay customerId bằng Customer
    private String fullName;
    private String phone;
    private String address;
    private boolean isDefault;
    private Date createdDate;

    public Address() {}

    public Address(int id) {
        this.id = id;
    }

    public Address(int id, Customer customer, String fullName, String phone, String address, boolean isDefault, Date createdDate) {
        this.id = id;
        this.customer = customer;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.isDefault = isDefault;
        this.createdDate = createdDate;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public boolean isDefault() { return isDefault; }
    public void setDefault(boolean aDefault) { isDefault = aDefault; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public boolean getDefaultAddress() {
        return isDefault();
    }
}
