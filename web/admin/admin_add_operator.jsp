<%@ page import="DB.ConnectionClass,java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) { response.sendRedirect("../login.html"); return; }
    if (!"Admin".equals(session.getAttribute("role"))) { response.sendRedirect("../login.html"); return; }

    ConnectionClass db = new ConnectionClass();
    String msg = "";

    if (request.getParameter("save") != null) {

        String opName = request.getParameter("operator_name");
        String phone = request.getParameter("phone");
        String cat = request.getParameter("unit_category"); // Plant/Aquatic/Animal
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        // 1) Insert into users (login)
        String q1 =
            "INSERT INTO users (username,password,role,status,full_name,phone,age,address,created_at) " +
            "VALUES ('"+username+"','"+password+"','Operator','Active','"+opName+"','"+phone+"','"+age+"','"+address+"',NOW())";

        String r1 = db.executeCommandWithError(q1);

        if ("SUCCESS".equals(r1)) {

            // 2) Get user_id safely (by username)
            ResultSet rs = db.selectCommand("SELECT user_id FROM users WHERE username='" + username + "' LIMIT 1");
            int uid = 0;
            if (rs != null && rs.next()) uid = rs.getInt("user_id");

            // 3) Insert into operator (unit_id NULL until assigned)
            String q2 =
                "INSERT INTO operator (user_id, unit_id, operator_name, phone, unit_category, status, created_at) " +
                "VALUES (" + uid + ", NULL, '" + opName + "', '" + phone + "', '" + cat + "', 'Active', NOW())";

            String r2 = db.executeCommandWithError(q2);

            if ("SUCCESS".equals(r2)) msg = "<div style='color:green;font-weight:bold'>? Operator added successfully</div>";
            else msg = "<div style='color:red;font-weight:bold'>? Operator insert failed: "+r2+"</div>";

        } else {
            msg = "<div style='color:red;font-weight:bold'>? Users insert failed: "+r1+"</div>";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Add Operator</title>
  <style>
    body{font-family:Arial;padding:18px;background:#fff;}
    .card{max-width:700px;margin:auto;border:1px solid #e3e8ee;border-radius:12px;padding:18px;background:#f9fbfd;}
    label{font-weight:bold;display:block;margin-top:10px;}
    input,select{width:100%;padding:10px;border:1px solid #cfd7df;border-radius:8px;box-sizing:border-box;}
    .btn{margin-top:14px;width:100%;padding:12px;border:none;border-radius:10px;background:#1abc9c;color:#fff;font-weight:bold;cursor:pointer;}
    .btn:hover{background:#139b82;}
  </style>
</head>
<body>
<div class="card">
  <h2>Add Operator</h2>
  <%= msg %>

  <form method="post">
    <label>Operator full Name</label>
    <input type="text" name="operator_name" required>

    <label>Phone</label>
    <input type="text" name="phone" required>
    <label>age</label>
    <input type="text" name="age" required>
    <label>address</label>
    <input  type="text" name="address" required>

    <label>Unit Category</label>
    <select name="unit_category" required>
      <option value="">-- Select --</option>
      <option value="Plant">Plant</option>
      <option value="Aquatic">Aquatic</option>
      <option value="Animal">Animal</option>
    </select>

    <label>Login Username</label>
    <input type="text" name="username" required>

    <label>Login Password</label>
    <input type="password" name="password" required>

    <input class="btn" type="submit" name="save" value="Create Operator">
  </form>
</div>
</body>
</html>
