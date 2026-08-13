<%@ page import="java.sql.*" %>
<h2>User Management</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Status</th>
    </tr>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("users");
        while(rs.next()){
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("role") %></td>
        <td><%= rs.getString("status") %></td>
    </tr>
    <% } %>
</table>