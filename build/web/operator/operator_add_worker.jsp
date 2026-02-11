<%@ page import="DB.ConnectionClass,java.sql.*" %>
<%@ page session="true" %>

<%
    // ? Session & Role check
    if (session.getAttribute("user_id") == null ||
        !"Operator".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.html");
        return;
    }

    int operatorUserId = Integer.parseInt(session.getAttribute("user_id").toString());
    ConnectionClass db = new ConnectionClass();
    String msg = "";

    // ? Get operator_id + unit_id from operator table
    ResultSet opRs = db.selectCommand(
        "SELECT operator_id, unit_id FROM operator WHERE user_id=" + operatorUserId + " LIMIT 1"
    );

    Integer operatorId = null;
    Integer unitId = null;

    if (opRs != null && opRs.next()) {
        operatorId = opRs.getInt("operator_id");
        unitId = (Integer) opRs.getObject("unit_id"); // can be NULL
    }

    // ? If not assigned to any unit, stop
    if (operatorId == null || unitId == null) {
        out.println("<h3 style='color:red;font-family:Arial'>? You are not assigned to any production unit yet.</h3>");
        out.println("<p style='font-family:Arial'>Please contact Admin to assign your unit.</p>");
        return;
    }

    // ? Submit: Add worker directly (no owner approval)
    if (request.getParameter("save") != null) {

        String name = request.getParameter("worker_name");
        String phone = request.getParameter("phone");
        String skill = request.getParameter("skill");

        // request_status/status values can be anything, but keep consistent
        String sql =
            "INSERT INTO worker " +
            "(user_id, unit_id, worker_name, phone, skill, request_status, status, requested_by, approved_by, created_at) " +
            "VALUES (" +
            "NULL," +                        // user_id not mandatory
            unitId + "," +
            "'" + name + "'," +
            "'" + phone + "'," +
            "'" + skill + "'," +
            "'Approved'," +                    // direct add
            "'Active'," +                    // active immediately
            operatorId + "," +               // requested_by = operator_id
            operatorId + "," +               // approved_by = operator_id
            "NOW()" +
            ")";

        String res = db.executeCommandWithError(sql);

        if ("SUCCESS".equals(res)) {
            msg = "<div style='padding:10px;border-radius:8px;background:#d4edda;color:#155724;font-weight:bold;'>? Worker added successfully</div>";
        } else {
            msg = "<div style='padding:10px;border-radius:8px;background:#f8d7da;color:#721c24;font-weight:bold;'>? Failed: " + res + "</div>";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Worker</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{font-family:Arial;background:#f4f6f8;padding:20px}
        .card{max-width:560px;margin:auto;background:#fff;padding:20px;border-radius:12px;
              box-shadow:0 10px 25px rgba(0,0,0,0.08)}
        label{font-weight:bold;display:block;margin-top:12px;font-size:13px}
        input{width:100%;padding:10px;border-radius:8px;border:1px solid #cfd7df;box-sizing:border-box}
        button{margin-top:18px;width:100%;padding:12px;border:none;
               background:#2d89ef;color:#fff;font-weight:bold;border-radius:10px;cursor:pointer}
        button:hover{background:#1f73d6}
        .muted{color:#666;font-size:13px;margin-top:0}
        .top{display:flex;justify-content:space-between;align-items:flex-end;gap:12px}
        .pill{background:#e9f1f7;color:#333;padding:6px 10px;border-radius:999px;font-size:12px}
        .msg{margin:10px 0}
    </style>
</head>
<body>

<div class="card">
    <div class="top">
        <div>
            <h2 style="margin:0">Add Worker</h2>
            <p class="muted">Add worker directly for your unit.</p>
        </div>
        <div class="pill">Unit ID: <b><%= unitId %></b></div>
    </div>

    <div class="msg"><%= msg %></div>

    <form method="post">
        <label>Worker Name</label>
        <input type="text" name="worker_name" required>

        <label>Phone</label>
        <input type="text" name="phone" required pattern="[0-9]{10,15}" title="Enter 10 to 15 digits">

        <label>Skill</label>
        <input type="text" name="skill" placeholder="Example: Planting / Harvest / Maintenance" required>

        <button type="submit" name="save" value="1">Add Worker</button>
    </form>
</div>

</body>
</html>
