package model;

public class Customer extends User {
    private String customerType;
    private Cart cart; // Quan hệ 1-1 với Cart

    public Customer(int id) {
        setId(id);
    }

    public String getCustomerType() { return customerType; }
    public void setCustomerType(String customerType) { this.customerType = customerType; }

    public Cart getCart() { return cart; }
    public void setCart(Cart cart) { this.cart = cart; }
}
