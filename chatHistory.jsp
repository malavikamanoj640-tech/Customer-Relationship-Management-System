<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page import="java.time.*" %>

<%
    String username = (String) session.getAttribute("username");

    if(username != null){
        try{
            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                    "SELECT message, response, created_at FROM chat_history WHERE username=? ORDER BY created_at ASC"
            );
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            LocalDate currentDate = null;

            while(rs.next()){

                // 🔥 DATE LOGIC START
                Timestamp ts = rs.getTimestamp("created_at");
                LocalDate chatDate = ts.toLocalDateTime().toLocalDate();

                if(currentDate == null || !chatDate.equals(currentDate)){

                    currentDate = chatDate;

                    LocalDate today = LocalDate.now();
                    String label = "";

                    if(chatDate.equals(today)){
                        label = "Today";
                    }
                    else if(chatDate.equals(today.minusDays(1))){
                        label = "Yesterday";
                    }
                    else{
                        label = chatDate.toString();
                    }
%>

<!-- 📅 DATE HEADER -->
<div style="text-align:center; color:gray; margin:10px;">
    <b><%= label %></b>
</div>

<%
    }
    // 🔥 DATE LOGIC END
%>

<!-- USER MESSAGE -->
<div style="text-align:right; margin:5px;">
    <span style="background:#25D366; color:white; padding:8px 12px; border-radius:10px; display:inline-block;">
        <%= rs.getString("message") %>
    </span>
</div>

<!-- BOT RESPONSE -->
<div style="text-align:left; margin:5px;">
    <span style="background:#eee; padding:8px 12px; border-radius:10px; display:inline-block;">
        <%= rs.getString("response") %>
    </span>
</div>

<%
            }

            conn.close();

        }catch(Exception e){
            out.print("Error loading chat history");
        }
    } else {
        out.print("Please login first.");
    }
%>