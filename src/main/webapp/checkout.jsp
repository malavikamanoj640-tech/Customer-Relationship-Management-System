<%--
  Created by IntelliJ IDEA.
  User: DEII
  Date: 28-02-2026
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar { background: #343a40; padding: 15px 0; }
        .checkout-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    List<String> cart = (List<String>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
    int total = 0;

    if (cart != null) {
        for (String item : cart) {
            String priceStr = item.substring(item.lastIndexOf("$") + 1);
            total += Integer.parseInt(priceStr);
        }
    }
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-shopping-bag me-2"></i>ShopEasy
        </a>
        <a href="cart.jsp" class="btn btn-outline-light">Back to Cart</a>
    </div>
</nav>

<!-- Header -->
<div class="checkout-header text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">Checkout</h1>
    </div>
</div>

<!-- Checkout Content -->
<div class="container mt-5">
    <div class="row">
        <!-- Billing Form -->
        <div class="col-md-8">
            <div class="card p-4 mb-4">
                <h4 class="mb-4"><i class="fas fa-user"></i> Billing Information</h4>
                <form>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <input type="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">City</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">ZIP Code</label>
                            <input type="text" class="form-control" required>
                        </div>
                    </div>
                </form>
            </div>

            <div class="card p-4">
                <h4 class="mb-4"><i class="fas fa-credit-card"></i> Payment Method</h4>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="payment" id="creditCard" checked>
                    <label class="form-check-label" for="creditCard">
                        <i class="fas fa-credit-card"></i> Credit/Debit Card
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="payment" id="paypal">
                    <label class="form-check-label" for="paypal">
                        <i class="fab fa-paypal"></i> PayPal
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="payment" id="cod">
                    <label class="form-check-label" for="cod">
                        <i class="fas fa-money-bill-wave"></i> Cash on Delivery
                    </label>
                </div>

                <hr>

                <div class="mb-3">
                    <label class="form-label">Card Number</label>
                    <input type="text" class="form-control" placeholder="1234 5678 9012 3456">
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Expiry Date</label>
                        <input type="text" class="form-control" placeholder="MM/YY">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">CVV</label>
                        <input type="text" class="form-control" placeholder="123">
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-md-4">
            <div class="card p-4">
                <h4 class="mb-4">Order Summary</h4>

                <% if (cart != null && !cart.isEmpty()) { %>
                <% for (String item : cart) { %>
                <div class="d-flex justify-content-between mb-2">
                    <small><%= item.substring(0, item.lastIndexOf("-")) %></small>
                    <small><%= item.substring(item.lastIndexOf("$") - 1) %></small>
                </div>
                <% } %>
                <% } else { %>
                <p class="text-muted">No items in cart</p>
                <% } %>

                <hr>
                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal:</span>
                    <span>$<%= total %></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Shipping:</span>
                    <span>Free</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Tax (10%):</span>
                    <span>$<%= total * 0.1 %></span>
                </div>
                <hr>
                <div class="d-flex justify-content-between mb-4">
                    <strong>Total:</strong>
                    <strong class="text-success">$<%= total + (total * 0.1) %></strong>
                </div>

                <button class="btn btn-primary w-100 btn-lg" onclick="alert('Order Placed Successfully!')">
                    <i class="fas fa-check"></i> Place Order
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <p class="mb-0">&copy; 2024 ShopEasy. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
