package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if(username == null){
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();

            String fetchSql = "SELECT * FROM cart WHERE username=?";
            PreparedStatement fetchPs = conn.prepareStatement(fetchSql);
            fetchPs.setString(1, username);
            ResultSet rs = fetchPs.executeQuery();

            StringBuilder products = new StringBuilder();
            double total = 0;

            while (rs.next()) {
                String name = rs.getString("product_name");
                int qty = rs.getInt("quantity");
                double price = rs.getDouble("price");

                products.append(name)
                        .append(" (x")
                        .append(qty)
                        .append("), ");

                total += price * qty;
            }

            if(total > 0){

                String orderSql = "INSERT INTO orders(username, product_names, total_amount, status) VALUES(?,?,?,?)";
                PreparedStatement orderPs = conn.prepareStatement(orderSql);

                orderPs.setString(1, username);
                orderPs.setString(2, products.toString());
                orderPs.setDouble(3, total);
                orderPs.setString(4, "Paid");

                orderPs.executeUpdate();

                // Clear cart AFTER payment success
                String clearSql = "DELETE FROM cart WHERE username=?";
                PreparedStatement clearPs = conn.prepareStatement(clearSql);
                clearPs.setString(1, username);
                clearPs.executeUpdate();

                response.sendRedirect("success.jsp");
            }

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}