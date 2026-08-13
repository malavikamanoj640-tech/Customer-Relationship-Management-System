package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ================= ADD TO CART =================
        if ("add".equals(action)) {

            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String image = request.getParameter("image");   // ✅ ADD THIS HERE

            try {
                Connection conn = DBConnection.getConnection();

                // Check if product already exists
                String checkSql = "SELECT * FROM cart WHERE username=? AND product_name=?";
                PreparedStatement checkPs = conn.prepareStatement(checkSql);
                checkPs.setString(1, username);
                checkPs.setString(2, productName);
                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    int existingQty = rs.getInt("quantity");

                    String updateSql = "UPDATE cart SET quantity=?, image=? WHERE username=? AND product_name=?";
                    PreparedStatement updatePs = conn.prepareStatement(updateSql);

                    updatePs.setInt(1, existingQty + quantity);
                    updatePs.setString(2, image);
                    updatePs.setString(3, username);
                    updatePs.setString(4, productName);

                    updatePs.executeUpdate();
                } else {
                    String insertSql = "INSERT INTO cart(username, product_name, price, quantity, image) VALUES(?,?,?,?,?)";

                    PreparedStatement insertPs = conn.prepareStatement(insertSql);
                    insertPs.setString(1, username);
                    insertPs.setString(2, productName);
                    insertPs.setDouble(3, price);
                    insertPs.setInt(4, quantity);
                    insertPs.setString(5, image);   // ✅ add this
                    insertPs.executeUpdate();
                }

                conn.close();
                response.sendRedirect("index.jsp?added=true");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ================= CHECKOUT =================
        else if ("checkout".equals(action)) {

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

                if (total > 0) {

                    String orderSql = "INSERT INTO orders(username, product_names, total_amount, status) VALUES(?,?,?,?)";
                    PreparedStatement orderPs = conn.prepareStatement(orderSql);
                    orderPs.setString(1, username);
                    orderPs.setString(2, products.toString());
                    orderPs.setDouble(3, total);
                    orderPs.setString(4, "Pending");
                    orderPs.executeUpdate();

                    // Clear cart after order
                    String clearSql = "DELETE FROM cart WHERE username=?";
                    PreparedStatement clearPs = conn.prepareStatement(clearSql);
                    clearPs.setString(1, username);
                    clearPs.executeUpdate();

                    response.sendRedirect("payment.jsp?amount=" + total);
                } else {
                    response.sendRedirect("cart.jsp");
                }

                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // ================= REMOVE ITEM =================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ================= REMOVE / INCREASE / DECREASE =================

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String product = request.getParameter("product");

        try {
            Connection conn = DBConnection.getConnection();

            // ================= INCREASE QUANTITY =================
            if ("increase".equals(action)) {

                String sql = "UPDATE cart SET quantity = quantity + 1 WHERE username=? AND product_name=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, product);
                ps.executeUpdate();
            }

            // ================= DECREASE QUANTITY =================
            else if ("decrease".equals(action)) {

                String sql = "UPDATE cart SET quantity = quantity - 1 WHERE username=? AND product_name=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, product);
                ps.executeUpdate();

                // Delete if quantity becomes 0
                String deleteSql = "DELETE FROM cart WHERE username=? AND product_name=? AND quantity<=0";
                PreparedStatement deletePs = conn.prepareStatement(deleteSql);
                deletePs.setString(1, username);
                deletePs.setString(2, product);
                deletePs.executeUpdate();
            }

            // ================= REMOVE ITEM =================
            else if ("remove".equals(action)) {

                String sql = "DELETE FROM cart WHERE username=? AND product_name=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, product);
                ps.executeUpdate();
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("cart.jsp");
    }
}
