<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head><title>Item Search View</title>
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

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info span {
            font-size: 1em;
            font-weight: 500;
        }

        /* Bỏ viền trang */
        .container {
            width: 80%;
            margin: 50px auto;
            padding: 0;
        }

        h1 { text-align: center; color: #333; }

         .card-header h3 {
             font-weight: 750; /* hoặc 700 nếu muốn vừa phải */
             letter-spacing: 0.5px;
             color: #333333;/* tùy chọn: giãn nhẹ chữ cho cân đối */
         }


    /* Căn hàng cho form tìm kiếm */
        .search-row {
            display: flex;
            align-items: end;
            gap: 15px;
        }

        .navbar h2 {
            margin: 0;
            font-size: 1.5em;
        }

        .search-row .form-control {
            flex: 1;
        }

        .search-row button {
            white-space: nowrap;
            height: 100%;
        }

        /* Nút logout */
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

        a.back-link {
            display: inline-block;
            color: #6c757d;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease, transform 0.2s ease;
        }
        a.back-link:hover {
            color: #007bff;
            transform: translateX(-3px);
        }
    </style>
</head>
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

<div class="container mt-5">
    <div class="card shadow-lg border-0">
        <div class="card-header text-center py-3">
            <h3 class="mb-0"><i class="fas fa-search me-2"></i>Item Search</h3>
        </div>

        <div class="card-body">
            <!-- Hàng chứa Back và Cart cùng 1 dòng -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <!-- Nút Back -->
                <a href="ProductServlet?action=customer" class="back-link">
                    <i class="fas fa-arrow-left me-1"></i>Back
                </a>

                <!-- Nút xem giỏ hàng -->
                <a href="CartServlet?action=view" class="btn btn-success">
                    <i class="fas fa-shopping-cart me-2"></i>View Cart
                </a>
            </div>

            <!-- Hàng tìm kiếm -->
            <form class="row g-2 align-items-center mb-4" action="ProductServlet" method="post">
                <div class="col-auto">
                    <label for="itemName" class="col-form-label fw-bold">Item Name:</label>
                    <input type="hidden" name="action" value="searchcustomer"/>
                    <input type="hidden" name="customerId" value="${sessionScope.customerId}" />
                </div>
                <div class="col">
                    <div class="input-group">
                        <input type="text" id="itemName" name="itemName" class="form-control"
                               placeholder="Enter item name...">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search me-1"></i>Search
                        </button>
                    </div>
                </div>
            </form>

            <!-- Kết quả tìm kiếm -->
            <div id="outSubListItem">
                <h4 class="mb-3 border-bottom pb-2">
                    <i class="fas fa-list me-2"></i>Search Results
                </h4>

                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

                <!-- Khối xử lý kết quả tìm kiếm -->
                <c:choose>
                    <c:when test="${not empty products}">
                        <!-- Có kết quả -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover align-middle" id="itemList">
                                <thead class="table-primary">
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Stock Quantity</th>
                                    <th scope="col">Description</th>
                                    <th scope="col" class="text-center">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="p" items="${products}">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td>${p.name}</td>
                                        <td>
                                            <fmt:formatNumber value="${p.price}" type="number"
                                                              groupingUsed="true" maxFractionDigits="0" /> VNĐ
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.stockQuantity == 0}">
                                                    <span class="text-danger fw-bold">Out of stock</span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.stockQuantity}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(p.description) > 30}">
                                                    ${fn:substring(p.description, 0, 30)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${p.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="text-center">
                                            <a href="ProductServlet?action=itemdetail&id=${p.id}"
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="alert alert-warning text-center fw-bold mt-3" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            Không tìm thấy sản phẩm nào phù hợp với từ khóa bạn nhập.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</div>

</body>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const rowsPerPage = 5;
        const table = document.getElementById("itemList");
        const rows = table.querySelectorAll("tbody tr, tr:not(:first-child)");
        const totalRows = rows.length;
        const totalPages = Math.ceil(totalRows / rowsPerPage);
        let currentPage = 1;

        const paginationDiv = document.createElement("div");
        paginationDiv.style.textAlign = "center";
        paginationDiv.style.marginTop = "20px";

        function showPage(page) {
            currentPage = page;
            const start = (page - 1) * rowsPerPage;
            const end = start + rowsPerPage;
            rows.forEach((row, index) => {
                row.style.display = (index >= start && index < end) ? "" : "none";
            });
            renderButtons();
        }

        function renderButtons() {
            paginationDiv.innerHTML = "";
            const prev = document.createElement("button");
            prev.textContent = "Previous";
            prev.className = "btn btn-secondary m-1";
            prev.disabled = currentPage === 1;
            prev.onclick = () => showPage(currentPage - 1);
            paginationDiv.appendChild(prev);

            for (let i = 1; i <= totalPages; i++) {
                const btn = document.createElement("button");
                btn.textContent = i;
                btn.className = (i === currentPage) ? "btn btn-primary m-1" : "btn btn-outline-primary m-1";
                btn.onclick = () => showPage(i);
                paginationDiv.appendChild(btn);
            }

            const next = document.createElement("button");
            next.textContent = "Next";
            next.className = "btn btn-secondary m-1";
            next.disabled = currentPage === totalPages;
            next.onclick = () => showPage(currentPage + 1);
            paginationDiv.appendChild(next);
        }

        table.insertAdjacentElement("afterend", paginationDiv);
        showPage(1);
    });
</script>
</html>
