<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Sign Up</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background: white;
            padding: 40px;
            width: 400px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            text-align: center;
        }

        .logo {
            font-size: 40px;
            color: #ff6b6b;
        }

        h1 {
            margin: 10px 0;
        }

        p {
            color: gray;
            margin-bottom: 30px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #ff6b6b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #ff4c4c;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .login-link {
            margin-top: 20px;
            display: block;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

    </style>
</head>
<body>

<div class="card">

    <div class="logo">👜</div>

    <h1>ShopEasy</h1>
    <p>Create your account to start shopping</p>

    <form action="signup" method="post">
        <input type="text" name="username" placeholder="Enter username" required>
        <input type="email" name="email" placeholder="Enter email address" required>
        <input type="password" name="password" placeholder="Create password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm password" required>
        <button type="submit">Sign Up</button>
    </form>

    <%
        String error = request.getParameter("error");
        if ("exists".equals(error)) {
    %>
    <div class="error">Username already exists!</div>
    <%
        }
        if ("mismatch".equals(error)) {
    %>
    <div class="error">Passwords do not match!</div>
    <%
        }
    %>

    <div class="login-link">
        Already have an account? <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>