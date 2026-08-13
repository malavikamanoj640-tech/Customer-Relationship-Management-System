<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("login.jsp");
        return;
    }

    ResultSet rs = (ResultSet) request.getAttribute("ordersResult");
    int totalOrders = (int) request.getAttribute("totalOrders");
    double totalSpent = (double) request.getAttribute("totalSpent");
    int pendingOrders = (int) request.getAttribute("pendingOrders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar { background: #343a40; min-height: 100vh; color: white; }
        .nav-link { color: rgba(255,255,255,0.8); padding: 15px; }
        .nav-link:hover { background: #495057; color: white; }
        .nav-link.active { background: #ff6b6b; color: white; }
        .badge-pending { background-color: #ffc107; color: #000; }
        .badge-shipped { background-color: #17a2b8; }
        .badge-delivered { background-color: #28a745; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar p-0">
            <div class="p-3 text-center border-bottom border-secondary">
                <i class="fas fa-user-circle fa-4x mb-2"></i>
                <h5><%= username %></h5>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="dashboard"><i class="fas fa-box-open me-2"></i> My Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                <li class="nav-item mt-5"><a class="nav-link text-warning" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold"><i class="fas fa-tachometer-alt"></i> Welcome back, <%= username %>!</h2>
                <a href="index.jsp" class="btn btn-primary"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
            </div>

            <!-- SUMMARY CARDS -->
            <div class="row mb-4">
                <div class="col-md-4"><div class="card shadow-sm text-center p-3"><h6>Total Orders</h6><h3 class="text-primary"><%= totalOrders %></h3></div></div>
                <div class="col-md-4"><div class="card shadow-sm text-center p-3"><h6>Total Spent</h6><h3 class="text-success">₹<%= totalSpent %></h3></div></div>
                <div class="col-md-4"><div class="card shadow-sm text-center p-3"><h6>Pending Orders</h6><h3 class="text-warning"><%= pendingOrders %></h3></div></div>
            </div>

            <!-- ORDER TABLE -->
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white"><i class="fas fa-history"></i> Recent Orders</div>
                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Products</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            if (rs != null) {
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><strong>#<%= rs.getInt("id") %></strong></td>
                            <td><%= rs.getTimestamp("order_date") %></td>
                            <td><%= rs.getString("product_names") %></td>
                            <td class="fw-bold text-success">₹<%= rs.getDouble("total_amount") %></td>
                            <td>
                                <span class="badge
                                    <% if(rs.getString("status").equals("Delivered")) { %> badge-delivered
                                    <% } else if(rs.getString("status").equals("Shipped")) { %> badge-shipped <% } else { %> badge-pending <% } %>">
                                    <%= rs.getString("status") %>
                                </span>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-dark" data-bs-toggle="modal" data-bs-target="#orderModal<%= rs.getInt("id") %>">
                                    View Details
                                </button>
                            </td>
                        </tr>

                        <!-- ORDER DETAILS MODAL -->
                        <div class="modal fade" id="orderModal<%= rs.getInt("id") %>" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Order Details</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p><strong>Order ID:</strong> #<%= rs.getInt("id") %></p>
                                        <p><strong>Date:</strong> <%= rs.getTimestamp("order_date") %></p>
                                        <p><strong>Products:</strong> <%= rs.getString("product_names") %></p>
                                        <p><strong>Total:</strong> ₹<%= rs.getDouble("total_amount") %></p>
                                        <p><strong>Status:</strong> <%= rs.getString("status") %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="6" class="text-center py-4 text-muted">No orders found. <a href="index.jsp">Start shopping now!</a></td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>