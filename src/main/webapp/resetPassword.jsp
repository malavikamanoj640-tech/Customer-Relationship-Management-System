<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - CRM System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>

        body{
            background: linear-gradient(135deg,#4facfe,#00f2fe);
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .reset-card{
            width:420px;
            border-radius:15px;
        }

        .title{
            font-weight:600;
        }

        .form-control{
            border-radius:10px;
        }

        .btn-primary{
            border-radius:10px;
        }

    </style>

</head>
<body>

<%
    String email = (String) request.getAttribute("email");
%>

<div class="card reset-card shadow-lg p-4">

    <div class="text-center mb-3">
        <i class="fa-solid fa-lock fa-2x text-primary"></i>
        <h3 class="title mt-2">Reset Password</h3>
        <p class="text-muted">Enter your new password</p>
    </div>

    <% if(request.getAttribute("message") != null){ %>
    <div class="alert alert-info">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <form action="resetPassword" method="post">

        <input type="hidden" name="email" value="<%= email %>">

        <div class="mb-3">
            <label class="form-label">New Password</label>

            <div class="input-group">
                <span class="input-group-text">
                    <i class="fa-solid fa-key"></i>
                </span>

                <input type="password"
                       name="newPassword"
                       class="form-control"
                       placeholder="Enter new password"
                       required>
            </div>
        </div>

        <div class="d-grid">
            <button class="btn btn-primary">
                Update Password
            </button>
        </div>

    </form>

</div>

</body>
</html>