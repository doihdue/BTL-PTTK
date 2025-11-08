<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Item Management View</title>
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

        .container { width: 80%; margin: auto; margin-top: 50px; padding: 20px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; }
        .menu-button { display: block; width: 200px; padding: 10px 15px; margin: 15px auto; background-color: #007bff; color: white; text-align: center; text-decoration: none; border-radius: 5px; font-size: 1.1em; }
        .menu-button:hover { background-color: #0056b3; }
        .back-button { display: block; width: 100px; padding: 8px 12px; margin: 20px auto 0; background-color: #6c757d; color: white; text-align: center; text-decoration: none; border-radius: 5px; }
        .back-button:hover { background-color: #5a6268; }


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

<div class="container">
    <h1>Item Management</h1>
    <a href="ProductServlet?action=search" class="menu-button">Edit Item</a>
    <a href="ProductServlet?action=mainsk" class="back-button">Back</a>
</div>
</body>
</html>
