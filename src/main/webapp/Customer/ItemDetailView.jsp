<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Item Detail View</title>
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

        .menu-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            transition: all 0.3s ease;
        }

        .menu-card:hover {
            transform: translateY(-3px);
        }

        .menu-card h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333333;
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
            font-weight: 500;
            padding: 8px 20px;
            border-radius: 6px;
        }

        .btn-back:hover {
            background-color: #5a6268;
            color: white;
        }

        .btn-view {
            background-color: #0d6efd;
            color: white;
            font-weight: 500;
            padding: 8px 20px;
            border-radius: 6px;
        }

        .btn-view:hover {
            background-color: #0b5ed7;
        }

        .card {
            border-radius: 10px;
            border: 1px solid #dee2e6;
        }

        .card-body {
            padding: 25px;
        }

        .card-title {
            font-weight: 600;
            font-size: 22px;
            color: #212529;
        }

        .card-text {
            color: #555;
            font-size: 15px;
            margin-bottom: 12px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .btn-add {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border-radius: 6px;
            transition: 0.3s;
        }

        .btn-add:hover {
            background-color: #0056b3;
        }

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
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 8px 18px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95em;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .logout-btn:hover {
            background-color: #ff4d4d;
            transform: translateY(-1px);
        }

        /* Responsive chỉnh nhẹ */
        @media (max-width: 768px) {
            .menu-card {
                padding: 25px;
            }
            .navbar h2 {
                font-size: 1.2em;
            }
        }
    </style>
</head>
<body class="bg-light">

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

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="menu-card">
                <h2>Item Detail</h2>
                <input type="hidden" name="customerId" value="${sessionScope.customerId}">

                <!-- Nút Back và View Cart -->
                <div class="d-flex justify-content-between mb-4">
                    <a href="ProductServlet?action=searchitem" class="btn btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back
                    </a>
                    <a href="CartServlet?action=view" class="btn btn-view">
                        <i class="fas fa-shopping-cart me-2"></i>View Cart
                    </a>
                </div>

                <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!-- Thông tin sản phẩm -->
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-3">
                            <i class="fas fa-box me-2 text-primary"></i>${product.name}
                        </h5>
                        <p class="card-text"><strong>Description:</strong> ${product.description}</p>
                        <p><strong>Price:</strong>
                            <span class="text-success fw-bold">
                                <fmt:formatNumber value="${product.price}" type="number"
                                                  groupingUsed="true" maxFractionDigits="0" /> VNĐ
                            </span>
                        </p>

                        <p><strong>Stock Quantity:</strong>
                            <c:choose>
                                <c:when test="${product.stockQuantity eq '0'}">
                                    <span class="text-danger fw-bold">Out of stock</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="fw-semibold">${product.stockQuantity}</span>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <!-- Form thêm giỏ hàng -->
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="${product.id}">

                            <c:choose>
                                <c:when test="${product.stockQuantity ne '0'}">
                                    <div class="mb-3">
                                        <label for="quantity" class="form-label">Quantity</label>
                                        <input type="number" class="form-control" id="quantity" name="qty"
                                               value="1" min="1" max="${product.stockQuantity}" required>
                                    </div>
                                    <button type="submit" class="btn btn-add w-100">
                                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <div class="mb-3">
                                        <label for="quantity" class="form-label">Quantity</label>
                                        <input type="number" class="form-control" id="quantity" name="qty"
                                               value="0" disabled>
                                    </div>
                                    <button type="button" class="btn btn-secondary w-100" disabled>
                                        Out of stock
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
