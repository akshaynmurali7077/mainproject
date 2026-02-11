<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    // Optional: ensure owner role
    if (!"Owner".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>welcome!</title>
    <div class="topbar">
    <div class="title">welcome</div>

    <div class="profile" onclick="openProfile()">
        <img src="../uploads/owners/<%= session.getAttribute("photo") != null ? session.getAttribute("photo") : "user.png" %>"
             onerror="this.src='../images/user.png'">
        <span>My Profile</span>
    </div>
</div>
    <style>
        .topbar{
    height:60px;
    background:#ffffff;
    border-bottom:1px solid #e3e8ee;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 20px;
}

.topbar .title{
    font-size:18px;
    font-weight:bold;
    color:#2c3e50;
}

.profile{
    display:flex;
    align-items:center;
    gap:10px;
    cursor:pointer;
}

.profile img{
    width:36px;
    height:36px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #1abc9c;
}

.profile span{
    font-size:14px;
    font-weight:bold;
    color:#333;
}

        body { margin: 0; font-family: Arial, sans-serif; background-color: #f4f6f8; }
        .wrapper { display: flex; height: calc(100vh - 60px); }


        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding-top: 20px;
            position: relative;
        }
        .sidebar h2 { text-align: center; margin-bottom: 30px; }
        .sidebar a {
            display: block;
            padding: 15px;
            color: white;
            text-decoration: none;
            border-bottom: 1px solid #34495e;
        }
        .sidebar a:hover { background-color: #1abc9c; }

        .content { flex: 1; background-color: #ecf0f1; padding: 20px; }
        iframe { width: 100%; height: 100%; border: none; background: white; border-radius: 6px; }

        .logout { position: absolute; bottom: 20px; width: 250px; text-align: center; }
        .logout a { color: #ecf0f1; text-decoration: none; }
    </style>
</head>
<body>

<div class="wrapper">

    <div class="sidebar">
        <h2>Owner Panel</h2>

        <a href="owner_select_unit.jsp" target="contentFrame">Select / Create Production Unit</a>
        <a href="owner_my_units.jsp" target="contentFrame">My Production Units</a>

        <div class="logout">
            <a href="../LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="content">
        <iframe name="contentFrame" src="owner_welcome.jsp"></iframe>
    </div>

</div>
<script>
function openProfile(){
    document.getElementsByName("contentFrame")[0].src = "owner_profile.jsp";
}
</script>

</body>
</html>

