<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Customer View</title>
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

        .menu-card h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333333;
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

        /* Menu chính */
        .menu-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            padding: 40px;
            text-align: center;
        }

        .menu-card h2 {
            font-weight: 700;
            margin-bottom: 30px;
        }

        .menu-btn {
            width: 100%;
            margin-bottom: 15px;
            font-size: 18px;
            padding: 12px;
            border-radius: 10px;
        }

        .btn-primary {
            background-color: #007bff;
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
                <h2>Main Customer Menu</h2>
                <input type="hidden" name="customerId" value="${sessionScope.customerId}">
                <a href="ProductServlet?action=searchitem" class="btn btn-primary menu-btn">Place Online Order</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
