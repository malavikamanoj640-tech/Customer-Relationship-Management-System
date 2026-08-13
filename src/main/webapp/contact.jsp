<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Contact Us</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<a href="index.jsp" class="btn btn-primary"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
<%
    String username = (String) session.getAttribute("username");
%>

<div class="container mt-5">
    <h2 class="text-center mb-4">Contact Us</h2>

    <!-- Success / Error Messages -->
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

    <div class="card p-4">

        <form action="contact" method="post">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Your Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Subject</label>
                <input type="text" name="subject" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Message</label>
                <textarea name="message" class="form-control" rows="5" required></textarea>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    Send Message
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>