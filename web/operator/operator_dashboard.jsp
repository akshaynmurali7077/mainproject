<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    if (!"Operator".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Operator Dashboard</title>
    <style>
        body { margin:0; font-family: Arial, sans-serif; background:#f4f6f8; }
        .wrapper { display:flex; height:100vh; }

        .sidebar{
            width:260px;
            background:#2c3e50;
            color:#fff;
            padding-top:18px;
            position:relative;
        }
        .sidebar h2{
            text-align:center;
            margin:0 0 14px;
            font-size:20px;
        }
        .sidebar a{
            display:block;
            padding:14px 16px;
            color:#fff;
            text-decoration:none;
            border-bottom:1px solid #34495e;
        }
        .sidebar a:hover{ background:#1abc9c; }

        .content{
            flex:1;
            padding:18px;
            background:#ecf0f1;
        }
        iframe{
            width:100%;
            height:100%;
            border:none;
            background:#fff;
            border-radius:10px;
        }

        .logout{
            position:absolute;
            bottom:18px;
            width:260px;
            text-align:center;
        }
        .logout a{ color:#ecf0f1; text-decoration:none; }
        .logout a:hover{ text-decoration:underline; }
    </style>
</head>
<body>

<div class="wrapper">

    <div class="sidebar">
        <h2>Operator Panel</h2>

        <a href="operator_welcome.jsp" target="contentFrame">Home</a>
        <a href="operator_my_unit.jsp" target="contentFrame">My Unit Details</a>
        <a href="operator_add_worker.jsp" target="contentFrame">Add worker</a>
        <a href="operator_create_activity.jsp" target="contentFrame">Create Activity</a>
        <a href="operator_view_activities.jsp" target="contentFrame">View Activities</a>

        <a href="operator_assigned_workers.jsp" target="contentFrame">Assigned Workers</a>
        <a href="operator_stock_alerts.jsp" target="contentFrame">Stock Alerts</a>

        <div class="logout">
            <a href="../LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="content">
        <iframe name="contentFrame" src="operator_welcome.jsp"></iframe>
    </div>

</div>

</body>
</html>
