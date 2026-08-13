<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    String msg = request.getParameter("msg");
    String botResponse = "Sorry, I didn't understand.";

    // Get logged-in user
    String username = (String) session.getAttribute("username");

    if(msg != null){
        msg = msg.toLowerCase().trim();

        // 👋 Greeting
        if(msg.contains("hi") || msg.contains("hello")){
            botResponse = "Hello! Welcome " + (username != null ? username : "Guest");
        }

        // 👤 Profile
        else if(msg.contains("my profile")){
            if(username != null){
                try{
                    Connection conn = DBConnection.getConnection();

                    PreparedStatement ps = conn.prepareStatement(
                            "SELECT username, email, phone, address FROM users WHERE username=?"
                    );
                    ps.setString(1, username);

                    ResultSet rs = ps.executeQuery();

                    if(rs.next()){
                        botResponse = "👤 Profile Details:\\n" +
                                "Name: " + rs.getString("username") + "\\n" +
                                "Email: " + rs.getString("email") + "\\n" +
                                "Phone: " + rs.getString("phone") + "\\n" +
                                "Address: " + rs.getString("address");
                    }

                    conn.close();
                }catch(Exception e){
                    botResponse = "Error fetching profile!";
                }
            } else {
                botResponse = "Please login first.";
            }
        }

        // 🛒 My Cart
        else if(msg.contains("my cart")){
            if(username != null){
                try{
                    Connection conn = DBConnection.getConnection();

                    PreparedStatement ps = conn.prepareStatement(
                            "SELECT SUM(quantity) FROM cart WHERE username=?"
                    );
                    ps.setString(1, username);

                    ResultSet rs = ps.executeQuery();

                    if(rs.next()){
                        int count = rs.getInt(1);
                        if(rs.wasNull()) count = 0;

                        botResponse = "You have " + count + " items in your cart 🛒";
                    }

                    conn.close();
                }catch(Exception e){
                    botResponse = "Error fetching cart!";
                }
            } else {
                botResponse = "Please login first.";
            }
        }

        // 📦 Orders
        else if(msg.contains("my orders")){
            botResponse = "You can check your orders in your profile section.";
        }

        // 🧾 General
        else if(msg.contains("cart")){
            botResponse = "Click on 🛒 Cart to view items.";
        }

        else if(msg.contains("order")){
            botResponse = "Go to profile to see your orders.";
        }

        else if(msg.contains("product")){
            botResponse = "We have Electronics, Fashion, and more!";
        }

        else if(msg.contains("contact")){
            botResponse = "Contact us at support@shopeasy.com";
        }
    }

    // ✅ SAVE CHAT TO DATABASE
    try{
        Connection conn = DBConnection.getConnection();

        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO chat_history (username, message, response) VALUES (?, ?, ?)"
        );

        ps.setString(1, username != null ? username : "guest");
        ps.setString(2, msg);
        ps.setString(3, botResponse);

        ps.executeUpdate();

        conn.close();
    }catch(Exception e){
        e.printStackTrace();
    }

    // ✅ SEND RESPONSE
    out.print(botResponse);
%>