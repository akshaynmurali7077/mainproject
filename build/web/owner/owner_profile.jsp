<%@ page import="DB.ConnectionClass,java.sql.*" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }

    int ownerId = Integer.parseInt(session.getAttribute("user_id").toString());

    ConnectionClass db = new ConnectionClass();
    ResultSet rs = db.selectCommand(
        "SELECT * FROM users WHERE user_id=" + ownerId
    );
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body{ font-family: Arial, sans-serif; background:#fff; padding:20px; }
        .card{
            max-width:700px;
            margin:auto;
            background:#f9fbfd;
            border:1px solid #e3e8ee;
            border-radius:14px;
            padding:20px;
            display:flex;
            gap:20px;
        }
        .photo{
            width:140px;
            height:140px;
            border-radius:50%;
            object-fit:cover;
            border:3px solid #2d89ef;
        }
        .info{ flex:1; }
        h2{ margin-top:0; }
        table{ width:100%; border-collapse:collapse; }
        td{ padding:8px 6px; vertical-align:top; }
        td.label{ font-weight:bold; color:#555; width:35%; }
        .status{
            padding:4px 10px;
            border-radius:999px;
            background:#d4edda;
            color:#155724;
            font-size:12px;
            font-weight:bold;
        }
    </style>
</head>
<body>

<%
    if (rs != null && rs.next()) {
        String photo = rs.getString("photo");
        if (photo == null || photo.trim().equals("")) {
            photo = "../images/user.png"; // fallback
        } else {
            photo = "../uploads/owners/" + photo;
        }
%>

<div class="card">

    <img src="<%= photo %>" class="photo"
         onerror="this.src='../images/user.png'">

    <div class="info">
        <h2>My Profile</h2>

        <table>
            <tr>
                <td class="label">Full Name</td>
                <td><%= rs.getString("full_name") %></td>
            </tr>
            <tr>
                <td class="label">Username</td>
                <td><%= rs.getString("username") %></td>
            </tr>
            <tr>
                <td class="label">Age</td>
                <td><%= rs.getString("age") %></td>
            </tr>
            <tr>
                <td class="label">Phone</td>
                <td><%= rs.getString("phone") %></td>
            </tr>
            <tr>
                <td class="label">Address</td>
                <td><%= rs.getString("address") %></td>
            </tr>
            <tr>
                <td class="label">Status</td>
                <td><span class="status"><%= rs.getString("status") %></span></td>
            </tr>
            <tr>
                <td class="label">Registered On</td>
                <td><%= rs.getString("created_at") %></td>
            </tr>
        </table>
    </div>

</div>

<%
    }
%>

</body>
</html>
