<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("login.jsp");
        return;
    }

    double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Secure Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg,#1cc88a,#4e73df);
        }

        .payment-card {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .form-control {
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="container mt-5">
    <div class="card payment-card p-4">

        <h3 class="mb-4">💳 Secure Payment</h3>

        <%
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM cart WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                total += rs.getDouble("price") * rs.getInt("quantity");
            }
            conn.close();
        %>

        <!-- Order Summary -->
        <div class="alert alert-info">
            <h5>Total Amount to Pay:</h5>
            <h4 class="text-success">₹<%= total %></h4>
        </div>

        <!-- Payment Form -->
        <form action="payment" method="post">

            <input type="hidden" name="totalAmount" value="<%= total %>">

            <div class="mb-3">
                <label>Card Holder Name</label>
                <input type="text" name="cardName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Card Number</label>
                <input type="text" name="cardNumber" maxlength="16"
                       class="form-control" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Expiry Date</label>
                    <input type="month" name="expiry" class="form-control" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>CVV</label>
                    <input type="password" name="cvv" maxlength="3"
                           class="form-control" required>
                </div>
            </div>

            <button type="submit" class="btn btn-dark w-100">
                Pay Now
            </button>

        </form>

    </div>
</div>

</body>
</html>