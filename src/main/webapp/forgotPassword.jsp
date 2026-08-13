<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - ShopEasy</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>

        body{
            background: linear-gradient(135deg,#ff758c,#ff7eb3);
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .forgot-card{
            width:420px;
            border-radius:15px;
        }

        .title{
            font-weight:600;
        }

        .form-control{
            border-radius:10px;
        }

        .btn-danger{
            border-radius:10px;
        }

    </style>

</head>
<body>

<div class="card forgot-card shadow-lg p-4">

    <div class="text-center mb-3">
        <i class="fa-solid fa-envelope fa-2x text-danger"></i>
        <h3 class="title mt-2">Forgot Password</h3>
        <p class="text-muted">Enter your email to receive OTP</p>
    </div>

    <% if(request.getAttribute("message") != null){ %>
    <div class="alert alert-info">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <form action="forgotPassword" method="post">

        <div class="mb-3">

            <label class="form-label">Email Address</label>

            <div class="input-group">

                <span class="input-group-text">
                    <i class="fa-solid fa-user"></i>
                </span>

                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter your email"
                       required>

            </div>

        </div>

        <div class="d-grid">
            <button class="btn btn-danger">
                Send OTP
            </button>
        </div>

    </form>

</div>

</body>
</html>