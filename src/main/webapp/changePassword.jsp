<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password - ShopEasy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container mt-5" style="max-width:500px;">
    <div class="card p-4 shadow">
        <h3 class="text-center mb-3">Change Password</h3>

        <% if(request.getAttribute("success") != null){ %>
        <div class="alert alert-success">
            <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <% if(request.getAttribute("error") != null){ %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="updatePassword" method="post">
            <div class="mb-3">
                <label>Current Password</label>
                <input type="password" name="currentPassword" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>New Password</label>
                <input type="password" name="newPassword" class="form-control" required>
            </div>

            <div class="d-grid">
                <button class="btn btn-primary">Update Password</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>