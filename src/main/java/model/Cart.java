package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Cart {
    private int id;
    private Date createdDate;
    private List<CartItem> cartItems = new ArrayList<>();

    public Cart() {}

    public Cart(int id, Date createdDate, List<CartItem> cartItems) {
        this.id = id;
        this.createdDate = createdDate;
        this.cartItems = cartItems;
    }

    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : cartItems) {
            total += item.getTotalPrice(); // gọi hàm có sẵn trong CartItem
        }
        return total;
    }


    public List<CartItem> getItems() { return cartItems; }


    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public List<CartItem> getCartItems() { return cartItems; }
    public void setCartItems(List<CartItem> cartItems) { this.cartItems = cartItems; }
}
