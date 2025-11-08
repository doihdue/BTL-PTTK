<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }
        .login-card {
            background: #fff;
            color: #333;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
        }
        .login-card h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Đăng nhập</h2>
    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label">Tên đăng nhập</label>
            <input type="text" name="username" class="form-control" required placeholder="Nhập tên đăng nhập">
        </div>
        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu">
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>

        <p class="text-danger mt-3 text-center">${error}</p>

        <!-- ✅ Thêm liên kết đến trang đăng ký -->
        <p class="mt-3 text-center">
            Chưa có tài khoản?
            <a href="SignupView.jsp" class="text-decoration-none">Đăng ký ngay</a>
        </p>
    </form>
</div>

</body>
</html>
