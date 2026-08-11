<%--
  Created by IntelliJ IDEA.
  User: DEII
  Date: 28-02-2026
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar { background: #343a40; padding: 15px 0; }
        .product-card { border: none; border-radius: 15px; transition: transform 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .product-card:hover { transform: translateY(-5px); }
        .product-img { height: 200px; object-fit: cover; border-radius: 15px 15px 0 0; }
        .price { color: #ff6b6b; font-weight: bold; font-size: 1.2rem; }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    java.util.List<String[]> cart = (java.util.List<String[]>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
    String searchQuery = (String) request.getAttribute("searchQuery");
    List<String[]> results = (List<String[]>) request.getAttribute("results");
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-shopping-bag me-2"></i>ShopEasy
        </a>

        <!-- Search Bar -->
        <form action="search" method="post" class="d-flex mx-auto" style="width: 400px;">
            <input class="form-control me-2" type="search" name="query" placeholder="Search for products..." value="<%= searchQuery != null ? searchQuery : "" %>">
            <button class="btn btn-warning" type="submit"><i class="fas fa-search"></i></button>
        </form>

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

<!-- Results -->
<div class="container mt-5">
    <h3 class="mb-4">Search Results for "<%= searchQuery != null ? searchQuery : "" %>"</h3>

    <% if (results != null && !results.isEmpty()) { %>
    <div class="row">
        <% for (String[] product : results) { %>
        <div class="col-md-3 mb-4">
            <div class="card product-card">
                <img src="<%= product[2] %>" class="product-img" alt="<%= product[0] %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product[0] %></h5>
                    <p class="text-muted"><%= product[3] %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">$<%= product[1] %></span>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productName" value="<%= product[0] %>">
                            <input type="hidden" name="price" value="<%= product[1] %>">
                            <button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-cart-plus"></i> Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="alert alert-warning">
        <h4>No products found!</h4>
        <p>Try searching for: Nike, Sony, Watch, Camera, iPhone, MacBook</p>
        <a href="index.jsp" class="btn btn-primary">Back to Home</a>
    </div>
    <% } %>
</div>

</body>
</html>