<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head><title>Edit Item View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }

        /* Thanh menu */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            color: white;
            padding: 12px 30px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .container { width: 80%; margin: auto; margin-top: 50px; padding: 20px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea { width: calc(100% - 22px); padding: 10px; border: 1px solid #ddd; border-radius: 4px; }
        .button-group { text-align: center; margin-top: 20px; }

        .button-group .save-button { background-color: #007bff; color: white; padding: 8px 12px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 1em; }
        .button-group .save-button:hover { background-color: #0056b3; }
        .button-group .cancel-button { display: block; padding: 8px 12px; margin: 20px auto 0; background-color: #6c757d; color: white; text-align: center; text-decoration: none; border-radius: 5px; }
        .button-group .cancel-button:hover { background-color: #5a6268; }


        .navbar h2 {
            margin: 0;
            font-size: 1.5em;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info span {
            font-size: 1em;
            font-weight: 500;
        }

        .logout-btn {
            background-color: #ff6b6b; /* Màu đỏ tươi hơn */
            color: white;
            border: none;
            padding: 8px 18px; /* Tăng padding */
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95em;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .logout-btn:hover {
            background-color: #ff4d4d;
            transform: translateY(-1px);
        }
    </style></head>
<body>

<!-- Thanh menu -->
<div class="navbar">
    <h2>Supermarket System</h2>
    <div class="user-info">
        <span><i class="fas fa-user-circle me-2"></i>Welcome, <strong>${sessionScope.user.name}</strong></span>
        <form action="LogoutServlet" method="post" style="margin:0;">
            <button type="submit" class="logout-btn">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </button>
        </form>
    </div>
</div>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container">
    <h1>Edit Item</h1>
    <form action="ProductServlet" method="post">
        <input type="hidden" name="action" value="save"/>
        <input type="hidden" name="id" value="${product.id}"/>

        <div class="form-group">
            <label for="itemName">Name:</label>
            <input type="text" name="name" value="${product.name}"/><br/>
        </div>

        <div class="form-group">
            <label for="itemPrice">Price:</label>
            <!-- Hiển thị giá dạng số có dấu chấm phân cách, không có ₫ -->
            <fmt:formatNumber
                    value="${product.price}"
                    type="number"
                    groupingUsed="false"
                    minFractionDigits="0"
                    maxFractionDigits="0"
                    var="formattedPrice"/>
            <input type="text" name="price" value="${formattedPrice}"/>

        </div>


        <div class="form-group">
            <label for="itemStockQuantity">Stock Quantity:</label>
            <input type="text" name="stockQuantity" value="${product.stockQuantity}"/><br/>
        </div>

        <div class="form-group">
            <label for="itemDescription">Description:</label>
            <input type="text" name="description" value="${product.description}"/><br/>
        </div>

        <div class="button-group">
            <input class="save-button" type="submit" value="Save"/>
            <a href="ProductServlet?action=search" class="button-group cancel-button"
               style="text-decoration: none; display: inline-block;">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
