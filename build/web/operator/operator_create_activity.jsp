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

    // ? Get operator_id + unit_id
    ResultSet opRs = db.selectCommand(
        "SELECT operator_id, unit_id FROM operator WHERE user_id=" + operatorUserId + " LIMIT 1"
    );

    Integer operatorId = null;
    Integer unitId = null;

    if (opRs != null && opRs.next()) {
        operatorId = opRs.getInt("operator_id");
        unitId = (Integer) opRs.getObject("unit_id");
    }

    if (operatorId == null || unitId == null) {
        out.println("<h3 style='color:red;font-family:Arial'>? You are not assigned to any production unit yet.</h3>");
        out.println("<p style='font-family:Arial'>Please contact Admin to assign your unit.</p>");
        return;
    }

    // ? Create Activity
    if (request.getParameter("save") != null) {

        String stageId = request.getParameter("stage_id");   // required
        String workerId = request.getParameter("worker_id"); // required
        String title = request.getParameter("title");
        String desc = request.getParameter("description");
        String start = request.getParameter("start_date");
        String due = request.getParameter("due_date");

        String sql =
            "INSERT INTO activity " +
            "(unit_id, stage_id, operator_id, worker_id, activity_title, description, start_date, due_date, status, created_at) " +
            "VALUES (" +
            unitId + "," +
            stageId + "," +
            operatorId + "," +
            workerId + ",'" +
            title + "','" +
            desc + "','" +
            start + "','" +
            due + "'," +
            "'Assigned',NOW()" +
            ")";

        String res = db.executeCommandWithError(sql);

        if ("SUCCESS".equals(res)) {
            msg = "<div style='padding:10px;border-radius:8px;background:#d4edda;color:#155724;font-weight:bold;'>? Activity created & assigned</div>";
        } else {
            msg = "<div style='padding:10px;border-radius:8px;background:#f8d7da;color:#721c24;font-weight:bold;'>? Failed: " + res + "</div>";
        }
    }

    // ? Load Stages
    ResultSet stages = db.selectCommand(
        "SELECT stage_id, stage_name FROM stage_master ORDER BY stage_id"
    );

    // ? Load Workers (only active workers in this unit)
    ResultSet workers = db.selectCommand(
        "SELECT worker_id, worker_name, phone FROM worker " +
        "WHERE unit_id=" + unitId + " AND status='Active' ORDER BY worker_id DESC"
    );
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Activity</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{font-family:Arial;background:#f4f6f8;padding:20px}
        .card{max-width:720px;margin:auto;background:#fff;padding:20px;border-radius:12px;
              box-shadow:0 10px 25px rgba(0,0,0,0.08)}
        label{font-weight:bold;display:block;margin-top:12px;font-size:13px}
        input,select,textarea{width:100%;padding:10px;border-radius:8px;border:1px solid #cfd7df;box-sizing:border-box}
        textarea{min-height:110px;resize:vertical}
        .row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
        button{margin-top:18px;width:100%;padding:12px;border:none;
               background:#1abc9c;color:#fff;font-weight:bold;border-radius:10px;cursor:pointer}
        button:hover{background:#139b82}
        .top{display:flex;justify-content:space-between;align-items:flex-end;gap:12px}
        .pill{background:#e9f1f7;color:#333;padding:6px 10px;border-radius:999px;font-size:12px}
        .muted{color:#666;font-size:13px;margin-top:0}
        @media(max-width:700px){ .row{grid-template-columns:1fr;} }
        .msg{margin:10px 0}
    </style>
</head>
<body>

<div class="card">
    <div class="top">
        <div>
            <h2 style="margin:0">Create Activity</h2>
            <p class="muted">Create activity and assign to a worker in your unit.</p>
        </div>
        <div class="pill">Unit ID: <b><%= unitId %></b></div>
    </div>

    <div class="msg"><%= msg %></div>

    <form method="post">

        <label>Stage</label>
        <select name="stage_id" required>
            <option value="">-- Select Stage --</option>
            <%
                while (stages != null && stages.next()) {
            %>
            <option value="<%= stages.getInt("stage_id") %>">
                <%= stages.getString("stage_name") %>
            </option>
            <%
                }
            %>
        </select>

        <label>Assign Worker</label>
        <select name="worker_id" required>
            <option value="">-- Select Worker --</option>
            <%
                boolean anyWorker = false;
                while (workers != null && workers.next()) {
                    anyWorker = true;
            %>
            <option value="<%= workers.getInt("worker_id") %>">
                <%= workers.getString("worker_name") %> ( <%= workers.getString("phone") %> )
            </option>
            <%
                }
                if(!anyWorker){
            %>
            <option value="" disabled>No active workers found. Add worker first.</option>
            <%
                }
            %>
        </select>

        <label>Activity Title</label>
        <input type="text" name="title" required>

        <label>Description</label>
        <textarea name="description" required></textarea>

        <div class="row">
            <div>
                <label>Start Date</label>
                <input type="date" name="start_date" required>
            </div>
            <div>
                <label>Due Date</label>
                <input type="date" name="due_date" required>
            </div>
        </div>

        <button type="submit" name="save" value="1">Create Activity</button>
    </form>
</div>

</body>
</html>
