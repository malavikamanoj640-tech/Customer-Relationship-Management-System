<%@ page import="java.sql.*" %>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <!-- Bootstrap + Chart -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            overflow-x: hidden;
            background: #f1f5f9;
        }

        /* Sidebar */
        .sidebar {
            height: 100vh;
            width: 240px;
            position: fixed;
            background: #111827;
            color: white;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            color: #cbd5e1;
            padding: 12px 20px;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #1f2937;
            color: white;
        }

        .sidebar a.active {
            background: #2563eb;
            color: white;
            border-left: 4px solid #60a5fa;
        }

        /* Content */
        .content {
            margin-left: 240px;
            padding: 20px;
        }

        .topbar {
            background: white;
            padding: 15px 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        /* Cards */
        .card {
            border-radius: 12px;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        /* Profile */
        .profile-img-small {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        /* Dark Mode */
        .dark-mode {
            background: #111;
            color: white;
        }

        .dark-mode .card {
            background: #1f2937;
            color: white;
        }

    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4">CRM Admin</h4>

    <a href="admin" class="active"> Dashboard</a>
    <a href="#"> Users</a>
    <a href="#"> Reports</a>
    <a href="profile.jsp">Settings</a>
    <a href="logout"> Logout</a>
</div>

<!-- Content -->
<div class="content">

    <!-- Topbar -->
    <div class="topbar d-flex justify-content-between align-items-center mb-4">
        <h4>Admin Dashboard</h4>
        <div>
            Welcome, <b><%= session.getAttribute("username") %></b>
            <button onclick="toggleDark()" class="btn btn-dark btn-sm ms-3">Toggle</button>
        </div>
    </div>

    <!-- Cards -->
    <div class="row text-center mb-4">
        <div class="col-md-4">
            <div class="card p-3 bg-primary text-white">
                <h5>Total Users</h5>
                <h3 id="totalUsers"><%= request.getAttribute("totalUsers") %></h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card p-3 bg-success text-white">
                <h5>Active Users</h5>
                <h3><%= request.getAttribute("activeUsers") %></h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card p-3 bg-dark text-white">
                <h5>Total Admins</h5>
                <h3><%= request.getAttribute("totalAdmins") %></h3>
            </div>
        </div>
    </div>

    <!-- Chart -->
    <div class="card p-4 mb-4">
        <h5>User Statistics</h5>
        <canvas id="userChart"></canvas>
    </div>

    <!-- Search + Filter -->
    <div class="d-flex justify-content-between mb-3">
        <input type="text" id="searchUser" class="form-control w-25" placeholder="Search user...">

        <select id="filterStatus" class="form-select w-25">
            <option value="">All</option>
            <option value="active">Active</option>
            <option value="blocked">Blocked</option>
        </select>
    </div>

    <!-- Table -->
    <div class="card p-3">
        <h5>User Management</h5>

        <table class="table table-bordered table-striped">
            <tr>
                <th>ID</th>
                <th>Profile</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <%
                ResultSet rs = (ResultSet) request.getAttribute("users");
                while(rs.next()){
            %>

            <tr>
                <td><%= rs.getInt("id") %></td>

                <td>
                    <%
                        String img = rs.getString("profile_image");
                        if(img != null && !img.isEmpty()){
                    %>
                    <img src="<%= request.getContextPath() + "/" + img %>" class="profile-img-small">
                    <% } else { %>
                    <img src="https://via.placeholder.com/40" class="profile-img-small">
                    <% } %>
                </td>

                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("role") %></td>

                <td>
                    <% if(rs.getString("status").equals("active")){ %>
                    <span class="badge bg-success">Active</span>
                    <% } else { %>
                    <span class="badge bg-danger">Blocked</span>
                    <% } %>
                </td>

                <td>
                    <form action="toggleUser" method="post">
                        <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                        <% if(rs.getString("status").equals("active")){ %>
                        <button class="btn btn-danger btn-sm">Block</button>
                        <% } else { %>
                        <button class="btn btn-success btn-sm">Unblock</button>
                        <% } %>
                    </form>
                </td>
            </tr>

            <% } %>
        </table>

        <!-- Pagination -->
        <div class="mt-3 text-center">
            <button class="btn btn-primary btn-sm" onclick="prevPage()">Prev</button>
            <button class="btn btn-primary btn-sm" onclick="nextPage()">Next</button>
        </div>

    </div>

</div>

<!-- Scripts -->
<script>

    // Chart
    new Chart(document.getElementById('userChart'), {
        type: 'bar',
        data: {
            labels: ['Total Users', 'Active Users', 'Admins'],
            datasets: [{
                label: 'Stats',
                data: [
                    <%= request.getAttribute("totalUsers") %>,
                    <%= request.getAttribute("activeUsers") %>,
                    <%= request.getAttribute("totalAdmins") %>
                ],
                backgroundColor: ['blue','green','black']
            }]
        }
    });

    // Search
    document.getElementById("searchUser").addEventListener("keyup", function() {
        let value = this.value.toLowerCase();
        let rows = document.querySelectorAll("table tr");

        rows.forEach((row, index) => {
            if(index === 0) return;
            row.style.display = row.innerText.toLowerCase().includes(value) ? "" : "none";
        });
    });

    // Filter
    document.getElementById("filterStatus").addEventListener("change", function() {
        let value = this.value;
        let rows = document.querySelectorAll("table tr");

        rows.forEach((row, index) => {
            if(index === 0) return;
            row.style.display = value === "" || row.innerText.toLowerCase().includes(value) ? "" : "none";
        });
    });

    // Pagination
    let currentPage = 1;
    let rowsPerPage = 5;

    function showPage(page) {
        let rows = document.querySelectorAll("table tr");
        let start = (page - 1) * rowsPerPage + 1;
        let end = start + rowsPerPage;

        rows.forEach((row, index) => {
            if(index === 0) return;
            row.style.display = (index >= start && index < end) ? "" : "none";
        });
    }

    function nextPage() {
        currentPage++;
        showPage(currentPage);
    }

    function prevPage() {
        if(currentPage > 1) currentPage--;
        showPage(currentPage);
    }

    showPage(currentPage);

    // Dark mode
    function toggleDark() {
        document.body.classList.toggle("dark-mode");
    }

    // Count animation
    let count = document.getElementById("totalUsers");
    let target = parseInt(count.innerText);
    let i = 0;

    let interval = setInterval(() => {
        i++;
        count.innerText = i;
        if(i >= target) clearInterval(interval);
    }, 30);

</script>

</body>
</html>