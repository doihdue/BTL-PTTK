<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .card {
            background-color: #fff;
            border-radius: 1rem;
        }

        .card-header {
            background-color: #fff;
            font-weight: 700;
        }

        .card-body h4 {
            border-left: 4px solid #007bff;
            padding-left: 10px;
        }


        .container {
            max-width: 1000px;
        }

        h1 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* giúp padding không làm tràn chiều rộng */
        }        .button-group { text-align: center; margin-top: 20px; }
        .button-group input { padding: 8px 12px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-size: 1em; }
        .button-group .search-button { background-color: #007bff; color: white; }
        .button-group .search-button:hover { background-color: #0056b3; }
        .button-group a.back-button
        { display: block; padding: 8px 12px; margin: 20px auto 0; background-color: #6c757d; color: white; text-align: center; text-decoration: none; border-radius: 5px; }
        .button-group .back-button:hover { background-color: #5a6268; }
        #itemList { margin-top: 20px; border-collapse: collapse; width: 100%; }
        #itemList th, #itemList td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        #itemList th { background-color: #f2f2f2; }


        .navbar h2 {
            margin: 0;
            font-size: 1.5em;
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

<div class="container mt-4">
    <div class="card shadow-lg border-0">
        <div class="card-header text-center py-3">
            <h3 class="fw-bold mb-0"><i class="fas fa-search me-2"></i>Item Search</h3>
        </div>

        <div class="card-body">
            <!-- Thông báo thành công -->
            <c:if test="${param.success == 'true'}">
                <div id="successAlert" class="alert alert-success text-center fw-bold" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    The product has been updated successfully!
                </div>

                <script>
                    // Ẩn thông báo sau 3 giây
                    setTimeout(() => {
                        const alertBox = document.getElementById("successAlert");
                        if (alertBox) alertBox.style.display = "none";
                    }, 3000);
                </script>
            </c:if>

            <!-- Nút Back -->
            <a href="ProductServlet?action=management" class="back-link mb-3">
                <i class="fas fa-arrow-left me-1"></i>Back
            </a>

            <!-- Hàng tìm kiếm -->
            <form class="row g-2 align-items-center mb-4" action="ProductServlet" method="post">
                <div class="col-auto">
                    <label for="itemName" class="col-form-label fw-bold">Item Name:</label>
                    <input type="hidden" name="action" value="search"/>
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


            <div id="outSubListItem">
                <h4 class="fw-bold text-secondary mb-3">
                    <i class="fas fa-list me-2"></i>Search Results
                </h4>

                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

                <!-- Nếu có sản phẩm -->
                <c:if test="${not empty products}">
                    <div class="table-responsive">
                        <table id="itemList" class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Stock Quantity</th>
                                <th>Description</th>
                                <th>Actions</th>
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
                                    <td>${p.stockQuantity}</td>
                                    <td>${p.description}</td>
                                    <td>
                                        <a href="ProductServlet?action=edit&id=${p.id}"
                                           class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <!-- Nếu không có sản phẩm -->
                <c:if test="${empty products}">
                    <div class="alert alert-warning text-center fw-bold mt-3" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        Không tìm thấy sản phẩm nào phù hợp với từ khóa bạn nhập.
                    </div>
                </c:if>
            </div>

        </div>
    </div>
</div>



</body>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const rowsPerPage = 5; // 5 sản phẩm mỗi trang
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
                btn.className = (i === currentPage)
                    ? "btn btn-primary m-1"
                    : "btn btn-outline-primary m-1";
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
