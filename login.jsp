<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1472851294608-4151058c07dd?q=80&w=2070&auto=format&fit=crop') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
        }
        .overlay {
            background: rgba(0, 0, 0, 0.6);
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            z-index: -1;
        }
        .card {
            border: none;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .brand-logo { font-size: 2.5rem; color: #ff6b6b; }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 2px solid #eee;
        }
        .form-control:focus {
            border-color: #ff6b6b;
            box-shadow: none;
        }
        .btn-login {
            border-radius: 10px;
            padding: 12px;
            background: #ff6b6b;
            border: none;
        }
        .btn-login:hover { background: #ee5253; }

        /* Hide autofill icon */
        input::-webkit-contacts-auto-fill-button { visibility: hidden; display: none !important; }
        input::-webkit-credentials-auto-fill-button { visibility: hidden; display: none !important; }
    </style>
</head>
<body>

<div class="overlay"></div>

<%
    String errorMsg = request.getParameter("error");
%>

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card shadow p-5" style="width: 450px;">

        <!-- Brand Name -->
        <div class="text-center mb-3">
            <i class="fas fa-shopping-bag brand-logo mb-2"></i>
            <h2 class="fw-bold text-dark">ShopEasy</h2>
            <p class="text-muted">Welcome back! Please login to continue shopping.</p>
        </div>

        <!-- Error Message -->
        <% if (errorMsg != null) { %>
        <div class="alert alert-danger">Invalid Username or Password!</div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Email or Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fas fa-envelope"></i></span>
                    <input type="text" name="userInput" class="form-control"
                           placeholder="Enter your email" autocomplete="off" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" class="form-control"
                           placeholder="Enter your password" autocomplete="off" required>
                </div>
            </div>

            <div class="d-flex justify-content-between mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember Me</label>
                </div>
                <a href="forgotPassword.jsp" class="text-decoration-none text-danger">
                    Forgot Password?
                </a>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-login text-white fw-bold">Login</button>
            </div>
        </form>

        <div class="text-center mt-4">
            <p class="text-muted">Don't have an account?
                <a href="signup.jsp" class="text-decoration-none fw-bold text-primary">Sign Up</a>
            </p>
        </div>

        <!-- Back to Home -->
        <div class="text-center mt-2">
            <a href="index.jsp" class="text-decoration-none text-muted">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
        </div>

    </div>
</div>

</body>
</html>