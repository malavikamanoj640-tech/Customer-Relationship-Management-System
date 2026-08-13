                                                                                                                                      <%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("login.jsp");
        return;
    }

    double total = 0;
    int cartCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg,#4e73df,#1cc88a);
        }

        .cart-card {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 10px;
        }

        .qty-btn {
            border-radius: 50%;
            width: 32px;
            height: 32px;
            padding: 0;
            font-weight: bold;
        }

        .total-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
        }
    </style>
</head>

<body>

<div class="container mt-5">
    <div class="card cart-card p-4">
        <a href="index.jsp" class="btn btn-primary"><i class="fas fa-shopping-bag"></i> Continue Shopping</a>
        <h3 class="mb-4"> My Shopping Cart</h3>

        <table class="table align-middle">
            <thead>
            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th></th>
            </tr>
            </thead>

            <tbody>

            <%
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM cart WHERE username=?");
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                boolean empty = true;

                while(rs.next()){

                    empty = false;

                    String name = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");

                    double itemTotal = price * quantity;
                    total += itemTotal;
                    cartCount += quantity;
            %>

            <tr>
                <td>
                    <img src="<%= image %>" class="product-img">
                </td>

                <td><strong><%= name %></strong></td>

                <td>$<%= price %></td>

                <td>
                    <a href="cart?action=decrease&product=<%= name %>"
                       class="btn btn-outline-danger qty-btn">-</a>

                    <span class="mx-2 fw-bold"><%= quantity %></span>

                    <a href="cart?action=increase&product=<%= name %>"
                       class="btn btn-outline-success qty-btn">+</a>
                </td>

                <td class="fw-bold text-success">$<%= itemTotal %></td>

                <td>
                    <a href="cart?action=remove&product=<%= name %>"
                       class="btn btn-danger btn-sm">
                        Remove
                    </a>
                </td>
            </tr>

            <%
                }

                if(empty){
            %>

            <tr>
                <td colspan="6" class="text-center text-muted p-4">
                    Your cart is empty 🛍
                </td>
            </tr>

            <%
                }
                conn.close();
            %>

            </tbody>
        </table>

        <% if(cartCount > 0){ %>

        <div class="total-box mt-4">

            <h5>Total Items:
                <span class="text-primary"><%= cartCount %></span>
            </h5>

            <h4>Total Amount:
                <span class="text-success">$<%= total %></span>
            </h4>

            <form action="cart" method="post" class="mt-3">
                <input type="hidden" name="action" value="checkout">
                <button class="btn btn-dark px-4">Proceed to Checkout</button>
            </form>

        </div>

        <% } %>

    </div>
</div>

</body>
</html>                                                                                                                                                                                                                                                                                                                         <%@ page import="java.sql.*" %>
