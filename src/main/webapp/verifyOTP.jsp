<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP - CRM System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background: linear-gradient(135deg,#667eea,#764ba2);
            height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .otp-card{
            width:420px;
            border-radius:15px;
        }

        .otp-input{
            text-align:center;
            font-size:22px;
            letter-spacing:6px;
            font-weight:bold;
        }

        .title{
            font-weight:600;
        }

    </style>
</head>
<body>

<div class="card otp-card shadow-lg p-4">

    <h3 class="text-center mb-3 title">OTP Verification</h3>

    <p class="text-center text-muted">
        Enter the OTP sent to your email
    </p>

    <% if(request.getAttribute("message") != null){ %>
    <div class="alert alert-danger">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <form action="verifyOTP" method="post">

        <input type="hidden" name="email"
               value="<%= request.getAttribute("email") %>">

        <div class="mb-3">
            <label class="form-label">Enter OTP</label>

            <input type="text"
                   name="otp"
                   class="form-control otp-input"
                   placeholder="------"
                   maxlength="6"
                   required>
        </div>

        <div class="d-grid">
            <button class="btn btn-primary">
                Verify OTP
            </button>
        </div>

    </form>

    <div class="text-center mt-3">
        <small class="text-muted">
            OTP expires in 5 minutes
        </small>
    </div>

</div>

</body>
</html>