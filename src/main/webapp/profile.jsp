<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,util.DBConnection" %>

<%
    // The 'session' object is implicit in JSP
    String email = (String) session.getAttribute("email");
    if(email == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String profileMsg = (String) session.getAttribute("profileMsg");
    session.removeAttribute("profileMsg"); // clear message after showing

    // Fetch user details from DB
    String username="", phone="", address="", profile_image="";
    try(Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            username = rs.getString("username");
            phone = rs.getString("phone");
            address = rs.getString("address");
            profile_image = rs.getString("profile_image");
        }
    } catch(Exception e){ e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .profile-card { max-width: 700px; margin: 50px auto; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); background: #fff; }
        .profile-img { width: 120px; height: 120px; object-fit: cover; border-radius: 50%; border: 3px solid #4e73df; }
        .form-label { font-weight: bold; }
        .btn-update { background: #4e73df; color: #fff; }
        .alert-msg { margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="profile-card">
    <h3 class="mb-4 text-center">👤 My Profile</h3>

    <% if(profileMsg != null){ %>
    <div class="alert alert-info alert-msg text-center">
        <%= profileMsg %>
    </div>
    <% } %>

    <div class="text-center mb-4">
        <img src="<%= (profile_image != null && !profile_image.isEmpty())
    ? (request.getContextPath() + "/" + profile_image)
    : "https://via.placeholder.com/120" %>"
             class="profile-img"
             alt="Profile Image">
    </div>

    <form action="profile" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" class="form-control" name="username" value="<%= username %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" value="<%= email %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone" value="<%= phone %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea class="form-control" name="address" rows="2"><%= address %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Profile Image</label>
            <input type="file" class="form-control" name="profile_image">
        </div>

        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" class="form-control" name="password" placeholder="Leave blank to keep current">
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-update px-4">Update Profile</button>
            <a href="dashboard" class="btn btn-primary"><i class="fas fa-shopping-bag"></i> My Orders</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>