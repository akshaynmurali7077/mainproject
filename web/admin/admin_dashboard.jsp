<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        /* Layout */
        .wrapper {
            display: flex;
            height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding-top: 20px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            padding: 15px;
            color: white;
            text-decoration: none;
            border-bottom: 1px solid #34495e;
        }

        .sidebar a:hover {
            background-color: #1abc9c;
        }

        /* Content area */
        .content {
            flex: 1;
            background-color: #ecf0f1;
            padding: 20px;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
            background: white;
            border-radius: 6px;
        }

        .logout {
            position: absolute;
            bottom: 20px;
            width: 250px;
            text-align: center;
        }

        .logout a {
            color: #ecf0f1;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="wrapper">

    <!-- LEFT MENU -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <a href="admin_add_operator.jsp" target="contentFrame">
            Add new operator
        </a>

        <a href="admin_verify_owner.jsp" target="contentFrame">
            Verify Owners
        </a>

        <a href="admin_verify_assign_operator.jsp" target="contentFrame">
            verify & Assign Operators
        </a>

        <a href="monitor_progress.jsp" target="contentFrame">
            Monitor Development
        </a>

        <a href="reports.jsp" target="contentFrame">
            View Reports
        </a>

        <div class="logout">
            <a href="../LogoutServlet">Logout</a>
        </div>
    </div>

    <!-- RIGHT CONTENT -->
    <div class="content">
        <iframe name="contentFrame" src="admin_welcome.jsp"></iframe>
    </div>

</div>

</body>
</html>
