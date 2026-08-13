package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // ================= SUMMARY CARDS =================
            String totalSql = "SELECT COUNT(*) FROM orders WHERE username=?";
            PreparedStatement totalPs = conn.prepareStatement(totalSql);
            totalPs.setString(1, username);
            ResultSet totalRs = totalPs.executeQuery();
            int totalOrders = 0;
            if (totalRs.next()) totalOrders = totalRs.getInt(1);

            String spentSql = "SELECT SUM(total_amount) FROM orders WHERE username=?";
            PreparedStatement spentPs = conn.prepareStatement(spentSql);
            spentPs.setString(1, username);
            ResultSet spentRs = spentPs.executeQuery();
            double totalSpent = 0;
            if (spentRs.next()) totalSpent = spentRs.getDouble(1);

            String pendingSql = "SELECT COUNT(*) FROM orders WHERE username=? AND status='Pending'";
            PreparedStatement pendingPs = conn.prepareStatement(pendingSql);
            pendingPs.setString(1, username);
            ResultSet pendingRs = pendingPs.executeQuery();
            int pendingOrders = 0;
            if (pendingRs.next()) pendingOrders = pendingRs.getInt(1);

            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSpent", totalSpent);
            request.setAttribute("pendingOrders", pendingOrders);

            // ================= FETCH ORDERS =================
            String orderSql = "SELECT * FROM orders WHERE username=? ORDER BY order_date DESC";
            PreparedStatement orderPs = conn.prepareStatement(orderSql);
            orderPs.setString(1, username);
            ResultSet rs = orderPs.executeQuery();
            request.setAttribute("ordersResult", rs);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}