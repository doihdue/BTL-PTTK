package model;

public class OrderDetail {
    private int id;
    private int orderId;
    private Product product;
    private int quantity;
    private double unitPrice;

    public OrderDetail() {}

    public OrderDetail(int orderId, Product product, int quantity, double unitPrice) {
        this.orderId = orderId;
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // getter & setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getSubTotal() { return unitPrice * quantity; }
}
