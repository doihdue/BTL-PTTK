<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
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

        .menu-card {
            background: #fff;
            border-radius: 12px; /* Bo tròn góc nhẹ hơn */
            box-shadow: 0 8px 25px rgba(0,0,0,0.1); /* Đổ bóng sâu hơn, chuyên nghiệp hơn */
            padding: 35px; /* Giảm padding một chút cho gọn gàng */
        }
        .menu-card h2 {
            text-align: left; /* Căn trái tiêu đề */
            font-weight: 700;
            color: #333; /* Màu chữ tiêu đề đậm hơn */
            margin-bottom: 25px; /* Giảm margin bottom */
            font-size: 2em; /* Kích thước tiêu đề lớn hơn một chút */
            border-bottom: 2px solid #007bff; /* Đường kẻ dưới tiêu đề */
            padding-bottom: 10px;
        }

        .customer-info-and-total {
            /*margin-top: 10px; !* Điều chỉnh margin *!*/
            margin-bottom: 25px;
            background-color: #e9f2ff; /* Nền màu xanh nhạt cho thông tin khách hàng */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng nhẹ cho phần này */
        }
        .customer-info-and-total h5 {
            margin-bottom: 15px;
            font-weight: 600;
            color: #007bff; /* Màu chữ tiêu đề xanh */
        }
        .customer-info-and-total p {
            margin-bottom: 8px; /* Giảm khoảng cách giữa các dòng thông tin */
            color: #555;
        }

        .btn-checkout {
            background-color: #28a745;
            color: white;
            font-weight: 600;
            padding: 10px 25px; /* Tăng kích thước nút checkout */
            border-radius: 8px; /* Bo tròn góc nút */
            transition: background-color 0.3s ease, transform 0.2s ease; /* Hiệu ứng mượt mà */
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.2);
        }
        .btn-checkout:hover {
            background-color: #218838;
            transform: translateY(-2px); /* Nâng nhẹ nút khi hover */
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.3);
        }

        .table-container {
            max-height: 450px; /* Điều chỉnh chiều cao cho phù hợp */
            overflow-y: auto;
            border: 1px solid #e0e0e0; /* Viền bảng tinh tế hơn */
            border-radius: 8px;
            margin-bottom: 20px;
            background-color: #fff; /* Nền trắng cho bảng */
        }

        .table {
            --bs-table-bg: #fff; /* Đảm bảo nền bảng trắng */
        }

        .table thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa; /* Nền header bảng */
            z-index: 1;
            font-weight: 600;
            color: #495057;
            padding: 12px 10px; /* Tăng padding cho header */
            border-bottom: 2px solid #dee2e6; /* Đường kẻ dưới header */
        }

        .table tbody td {
            padding: 10px 10px; /* Tăng padding cho cell */
            vertical-align: middle;
            color: #343a40;
            border-color: #f0f0f0; /* Màu viền cell nhẹ nhàng */
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

        .flex-container {
            display: flex;
            flex-wrap: wrap;
            gap: 25px; /* Tăng khoảng cách giữa các cột */
        }

        .left-panel {
            flex: 2;
            min-width: 380px; /* Đảm bảo đủ rộng cho bảng */
        }

        .right-panel {
            flex: 1;
            min-width: 300px; /* Đảm bảo đủ rộng cho thông tin KH và tổng tiền */
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            padding: 8px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
            transform: translateY(-1px);
        }

        .btn-danger {
            padding: 5px 10px;
            font-size: 0.85em;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-danger:hover {
            transform: scale(1.05);
        }

        .total-amount-box {
            background-color: #d1ecf1; /* Nền xanh nhạt cho tổng tiền */
            border: 1px solid #bee5eb;
            border-radius: 8px;
            padding: 15px 20px;
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.2em;
            font-weight: 700;
            color: #0c5460;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .total-amount-box h4 {
            margin: 0;
            font-size: 1.3em;
            color: #0c5460;
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
        <div class="col-md-11"> <!-- Tăng độ rộng tổng thể để bố cục thoáng hơn -->
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <div class="menu-card">
                <h2>Your Cart</h2>

                <c:if test="${not empty successMessage}">
                    <div class="alert ${alertClass} alert-dismissible fade show mt-3" role="alert">
                        <i class="fas fa-info-circle me-2"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <input type="hidden" name="customerId" value="${sessionScope.customerId}">

                <div class="flex-container">
                    <!-- Bảng giỏ hàng (Bên trái) -->
                    <div class="left-panel">
                        <div class="table-container">
                            <table class="table table-hover align-middle text-center">
                                <thead class="table-light">
                                <tr>
                                    <th>Item</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty cart.cartItems}">
                                        <c:set var="total" value="0" />
                                        <c:forEach var="item" items="${cart.cartItems}">
                                            <tr>
                                                <td>${item.product.name}</td>
                                                <td>${item.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.product.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ
                                                </td>
                                                <td>
                                                    <form action="CartServlet" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="id" value="${item.product.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash-alt"></i> Remove
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">
                                                <i class="fas fa-box-open fa-2x mb-2"></i><br>
                                                Your cart is currently empty.
                                                <p class="mt-2">Add some products to get started!</p>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <a href="ProductServlet?action=searchitem" class="btn btn-secondary mt-3">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                    </div>

                    <!-- Thông tin khách hàng và Tổng tiền (Bên phải) -->
                    <!-- Thông tin khách hàng và Tổng tiền (Bên phải) -->
                    <div class="right-panel">
                        <div class="customer-info-and-total">
                            <h5><i class="fas fa-user-circle me-2"></i>Delivery Address</h5>

                            <!-- Dropdown chọn địa chỉ -->
                            <label for="addressSelect" class="form-label">Select Address:</label>
                            <form id="addressForm" action="AddressServlet" method="post">
                                <input type="hidden" name="action" value="setDefault">
                                <select id="addressSelect" name="addressId" class="form-select mb-3" onchange="document.getElementById('addressForm').submit()">
                                    <c:forEach var="a" items="${addresses}">
                                        <option value="${a.id}" ${a.defaultAddress ? 'selected' : ''}>
                                                ${a.fullName} - ${a.phone} (${a.address})
                                            <c:if test="${a.defaultAddress}">(Default)</c:if>
                                        </option>

                                    </c:forEach>
                                </select>
                            </form>


                            <!-- Nút mở form thêm địa chỉ -->
                            <button type="button" class="btn btn-primary w-100 mb-3" onclick="toggleAddressForm()">
                                <i class="fas fa-plus"></i> Add New Address
                            </button>

                            <!-- Form ẩn để thêm địa chỉ mới -->
                            <form id="newAddressForm" action="AddressServlet" method="post" style="display:none;">
                                <div class="mb-2">
                                    <input type="text" name="fullName" class="form-control" placeholder="Full name" required>
                                </div>
                                <div class="mb-2">
                                    <input type="text" name="phone" class="form-control" placeholder="Phone number" required>
                                </div>
                                <div class="mb-2">
                                    <input type="text" name="address" class="form-control" placeholder="Address" required>
                                </div>
                                <div class="form-check mb-2">
                                    <input type="checkbox" name="isDefault" class="form-check-input" id="defaultCheck">
                                    <label class="form-check-label" for="defaultCheck">Set as default</label>
                                </div>
                                <button type="submit" class="btn btn-success w-100">Save Address</button>
                            </form>

                            <hr class="my-4">

                            <!-- Hiển thị thông tin địa chỉ đang chọn -->
                            <c:if test="${not empty addresses}">
                                <c:set var="selected" value="${addresses[0]}" />
                                <p><strong>Full Name:</strong> ${selected.fullName}</p>
                                <p><strong>Phone:</strong> ${selected.phone}</p>
                                <p><strong>Address:</strong> ${selected.address}</p>
                            </c:if>

                            <div class="total-amount-box">
                                <span>Total Amount:</span>
                                <h4>
                                    <fmt:formatNumber value="${cart.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                                </h4>
                            </div>

                            <form action="OrderServlet" method="post" class="mt-4">
                                <input type="hidden" name="addressId" value="${selected.id}">
                                <button type="submit" class="btn btn-checkout w-100">
                                    <i class="fas fa-shopping-cart me-2"></i>Checkout
                                </button>
                            </form>
                        </div>
                    </div>

                    <script>
                        function toggleAddressForm() {
                            const form = document.getElementById("newAddressForm");
                            form.style.display = form.style.display === "none" ? "block" : "none";
                        }
                    </script>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
<script>
    setTimeout(() => {
        const alert = document.querySelector('.alert');
        if (alert) {
            alert.classList.remove('show');
            alert.classList.add('fade');
        }
    }, 3000);
</script>

</html>