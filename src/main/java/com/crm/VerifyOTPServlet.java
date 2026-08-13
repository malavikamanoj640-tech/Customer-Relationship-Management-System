package com.crm;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/verifyOTP")
public class VerifyOTPServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String otp = request.getParameter("otp");

        try{

            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM users WHERE email=? AND otp=? AND otp_expiry > NOW()");

            ps.setString(1,email);
            ps.setString(2,otp);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                request.setAttribute("email",email);
                request.getRequestDispatcher("resetPassword.jsp")
                        .forward(request,response);

            }
            else{

                request.setAttribute("message","Invalid or expired OTP");
                request.getRequestDispatcher("verifyOTP.jsp")
                        .forward(request,response);

            }

        }
        catch(Exception e){
            e.printStackTrace();
        }

    }
}