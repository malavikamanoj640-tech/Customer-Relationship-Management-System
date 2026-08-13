<%--
  Created by IntelliJ IDEA.
  User: DEII
  Date: 28-02-2026
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - About Us</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar { background: #343a40; padding: 15px 0; }
        .about-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
        }
        .feature-icon {
            font-size: 3rem;
            color: #ff6b6b;
        }
        .team-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    java.util.List<String> cart = (java.util.List<String>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-shopping-bag me-2"></i>ShopEasy
        </a>
        <a href="index.jsp" class="btn btn-primary"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
        <!-- Cart Icon -->
        <a href="cart.jsp" class="btn btn-outline-light me-2 position-relative">
            <i class="fas fa-shopping-cart"></i>
            <% if (cartCount > 0) { %>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    <%= cartCount %>
                </span>
            <% } %>
        </a>

        <!-- Login / Logout -->
        <div class="d-flex">
            <% if (username != null) { %>
            <span class="text-white me-3 align-self-center">Welcome, <strong><%= username %></strong></span>
            <a href="logout" class="btn btn-outline-light">Logout</a>
            <% } else { %>
            <a href="login.jsp" class="btn btn-outline-light me-2">Login</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Header -->
<div class="about-header text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">About ShopEasy</h1>
        <p class="lead">Your Trusted Online Shopping Destination</p>
    </div>
</div>

<!-- About Content -->
<div class="container mt-5">
    <!-- Our Story -->
    <div class="row mb-5">
        <div class="col-md-6">
            <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600" class="img-fluid rounded" alt="Our Store">
        </div>
        <div class="col-md-6">
            <h2 class="mb-4">Our Story</h2>
            <p class="text-muted">Founded in 2020, ShopEasy has been committed to providing the best online shopping experience for customers worldwide. We believe in quality products, fast delivery, and exceptional customer service.</p>
            <p class="text-muted">Our mission is to make shopping easy, affordable, and enjoyable for everyone.</p>
        </div>
    </div>

    <!-- Features -->
    <div class="row text-center mb-5">
        <div class="col-md-4 mb-4">
            <i class="fas fa-shipping-fast feature-icon mb-3"></i>
            <h4>Fast Shipping</h4>
            <p class="text-muted">Free delivery on orders over ₹50</p>
        </div>
        <div class="col-md-4 mb-4">
            <i class="fas fa-shield-alt feature-icon mb-3"></i>
            <h4>Secure Payment</h4>
            <p class="text-muted">100% secure payment gateway</p>
        </div>
        <div class="col-md-4 mb-4">
            <i class="fas fa-headset feature-icon mb-3"></i>
            <h4>24/7 Support</h4>
            <p class="text-muted">Round the clock customer support</p>
        </div>
    </div>

    <!-- Team Section -->
    <div class="text-center mb-5">
        <h2 class="mb-4">Meet Our Team</h2>
        <div class="row">
            <div class="col-md-4">
                <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?w=300" class="team-img mb-3" alt="CEO">
                <h5>John Smith</h5>
                <p class="text-muted">CEO & Founder</p>
            </div>
            <div class="col-md-4">
                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300" class="team-img mb-3" alt="Manager">
                <h5>Sarah Johnson</h5>
                <p class="text-muted">Operations Manager</p>
            </div>
            <div class="col-md-4">
                <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300" class="team-img mb-3" alt="Developer">
                <h5>Mike Davis</h5>
                <p class="text-muted">Tech Lead</p>
            </div>
        </div>
    </div>

    <!-- Stats -->
    <div class="row text-center bg-light rounded p-4 mb-5">
        <div class="col-md-3">
            <h2 class="fw-bold text-primary">10K+</h2>
            <p class="mb-0">Happy Customers</p>
        </div>
        <div class="col-md-3">
            <h2 class="fw-bold text-primary">500+</h2>
            <p class="mb-0">Products</p>
        </div>
        <div class="col-md-3">
            <h2 class="fw-bold text-primary">50+</h2>
            <p class="mb-0">Countries</p>
        </div>
        <div class="col-md-3">
            <h2 class="fw-bold text-primary">4.9</h2>
            <p class="mb-0">Average Rating</p>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4">
    <div class="container">
        <p class="mb-0">&copy; 2026 ShopEasy. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>