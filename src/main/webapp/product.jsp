<%--
  Created by IntelliJ IDEA.
  User: DEII
  Date: 01-03-2026
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Product Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar { background: #343a40; padding: 15px 0; }
        .product-img { height: 400px; object-fit: cover; border-radius: 15px; }
        .price { color: #ff6b6b; font-weight: bold; font-size: 2rem; }
        .related-card { border: none; border-radius: 10px; transition: transform 0.3s; }
        .related-card:hover { transform: scale(1.05); }
        .related-img { height: 150px; object-fit: cover; border-radius: 10px 10px 0 0; }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    java.util.List<String> cart = (java.util.List<String>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
    String[] product = (String[]) request.getAttribute("product");
    List<String[]> related = (List<String[]>) request.getAttribute("related");
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-shopping-bag me-2"></i>ShopEasy
        </a>
        <a href="cart.jsp" class="btn btn-outline-light me-2 position-relative">
            <i class="fas fa-shopping-cart"></i>
            <% if (cartCount > 0) { %>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%= cartCount %></span>
            <% } %>
        </a>
        <div class="d-flex">
            <% if (username != null) { %>
            <span class="text-white me-3 align-self-center">Welcome, <strong><%= username %></strong></span>
            <a href="logout" class="btn btn-outline-light">Logout</a>
            <% } else { %>
            <a href="login.jsp" class="btn btn-outline-light">Login</a>
            <% } %>
        </div>
    </div>
</nav>

<% if (product != null) { %>
<!-- Product Details -->
<div class="container mt-5">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <img src="<%= product[3] %>" class="product-img w-100" alt="<%= product[1] %>">
        </div>

        <!-- Product Info -->
        <div class="col-md-6">
            <span class="badge bg-secondary mb-2"><%= product[4] %></span>
            <h2 class="mt-2"><%= product[1] %></h2>
            <p class="text-muted"><%= product[5] %></p>
            <h1 class="price">$<%= product[2] %></h1>

            <div class="mt-4">
                <form action="cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productName" value="<%= product[1] %>">
                    <input type="hidden" name="price" value="<%= product[2] %>">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </form>
            </div>

            <div class="mt-4">
                <p><i class="fas fa-check text-success"></i> Free Shipping</p>
                <p><i class="fas fa-check text-success"></i> 7 Days Replacement</p>
                <p><i class="fas fa-check text-success"></i> 1 Year Warranty</p>
            </div>
        </div>
    </div>
</div>

<!-- Related Products -->
<div class="container mt-5 mb-5">
    <h3 class="mb-4">Related Products <small class="text-muted">(You may also like)</small></h3>
    <div class="row">
        <% if (related != null) { %>
        <% for (String[] rel : related) { %>
        <div class="col-md-3 mb-4">
            <div class="card related-card h-100">
                <img src="<%= rel[3] %>" class="related-img w-100" alt="<%= rel[1] %>">
                <div class="card-body">
                    <h6><%= rel[1] %></h6>
                    <p class="text-muted small"><%= rel[4] %></p>
                    <div class="d-flex justify-content-between">
                        <span class="price" style="font-size: 1rem;">$<%= rel[2] %></span>
                        <a href="product?id=<%= rel[0] %>" class="btn btn-sm btn-outline-primary">View</a>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>
</div>
<% } else { %>
<div class="container mt-5">
    <div class="alert alert-danger">Product not found!</div>
    <a href="index.jsp" class="btn btn-primary">Back to Home</a>
</div>
<% } %>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <p class="mb-0">&copy; 2024 ShopEasy. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
