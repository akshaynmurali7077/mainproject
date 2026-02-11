<%@ page import="DB.ConnectionClass" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    if (!"Owner".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.html");
        return;
    }

    int ownerId = Integer.parseInt(session.getAttribute("user_id").toString());
    ConnectionClass db = new ConnectionClass();
    String msg = "";

    if (request.getParameter("save") != null) {

        String unitName = request.getParameter("unit_name");
        String unitCategory = request.getParameter("unit_category"); // Plant/Aquatic/Animal OR your enum values
        String location = request.getParameter("location");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        String insQry =
            "INSERT INTO production_unit " +
            "(unit_name, unit_category, location, owner_id, admin_id, operator_id, start_date, end_date, status, created_at) " +
            "VALUES (" +
            "'" + unitName + "'," +
            "'" + unitCategory + "'," +
            "'" + location + "'," +
            ownerId + "," +
            "NULL," +
            "NULL," +
            "'" + startDate + "'," +
            "'" + endDate + "'," +
            "'Pending', NOW()" +
            ")";

        String result = db.executeCommandWithError(insQry);

        if ("SUCCESS".equals(result)) {
            msg = "<div style='color:green;font-weight:bold'>? Production Unit request sent to Admin (Pending)</div>";
        } else {
            msg = "<div style='color:red;font-weight:bold'>? Failed: " + result + "</div>";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Production Unit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{ font-family: Arial, sans-serif; padding:18px; background:#fff; }
        .card{ max-width:800px; margin:auto; border:1px solid #e3e8ee; border-radius:12px; padding:18px; background:#f9fbfd; }
        h2{ margin:0 0 10px; }
        .row{ display:grid; grid-template-columns: 1fr 1fr; gap:12px; }
        label{ font-weight:bold; font-size:13px; display:block; margin:10px 0 6px; }
        input, select{
            width:100%; padding:10px 12px; border:1px solid #cfd7df; border-radius:8px; box-sizing:border-box;
        }
        .span2{ grid-column: span 2; }
        .btn{
            margin-top:14px; padding:12px; width:100%;
            border:none; border-radius:10px; background:#2d89ef; color:#fff;
            font-weight:bold; cursor:pointer;
        }
        .btn:hover{ background:#1f73d6; }
        @media(max-width:700px){ .row{ grid-template-columns:1fr; } .span2{ grid-column: span 1; } }
    </style>
</head>
<body>

<div class="card">
    <h2>Create Production Unit (Send to Admin)</h2>
    <p style="color:#555;margin-top:0">After you submit, Admin will verify and assign an Operator.</p>

    <%= msg %>

    <form method="post">
        <div class="row">

            <div class="span2">
                <label>Unit Name</label>
                <input type="text" name="unit_name" required>
            </div>

            <div>
                <label>Unit Category</label>
                <select name="unit_category" required>
                    <option value="">-- Select --</option>
                    <option value="Plant">Plant</option>
                    <option value="Aquatic">Aquatic</option>
                    <option value="Animal">Animal</option>
                </select>
            </div>

            <div>
                <label>Location</label>
                <input type="text" name="location" required>
            </div>

            <div>
                <label>Start Date</label>
                <input type="date" name="start_date" required>
            </div>

            <div>
                <label>End Date</label>
                <input type="date" name="end_date" required>
            </div>

        </div>

        <input type="submit" class="btn" name="save" value="Send to Admin">
    </form>
</div>

</body>
</html>
