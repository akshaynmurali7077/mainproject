<%@ page import="DB.ConnectionClass,java.sql.*" %>
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

    int userId = Integer.parseInt(session.getAttribute("user_id").toString());
    ConnectionClass db = new ConnectionClass();

    // 1) Find operator record by user_id
    ResultSet opRs = db.selectCommand("SELECT * FROM operator WHERE user_id=" + userId + " LIMIT 1");

    Integer unitId = null;
    String opName = "";
    String opPhone = "";
    String opCategory = "";

    if (opRs != null && opRs.next()) {
        opName = opRs.getString("operator_name");
        opPhone = opRs.getString("phone");
        opCategory = opRs.getString("unit_category");
        unitId = (Integer) opRs.getObject("unit_id"); // can be NULL if not assigned
    }

    ResultSet unitRs = null;
    if (unitId != null) {
        unitRs = db.selectCommand(
            "SELECT pu.*, u.full_name AS owner_name, u.phone AS owner_phone " +
            "FROM production_unit pu " +
            "JOIN users u ON pu.owner_id=u.user_id " +
            "WHERE pu.unit_id=" + unitId + " LIMIT 1"
        );
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Unit Details</title>
    <style>
        body{ font-family:Arial; background:#fff; padding:18px; }
        .box{ max-width:900px; margin:auto; border:1px solid #e7edf3; border-radius:12px; padding:16px; background:#f9fbfd; }
        h2{ margin:0 0 10px; }
        .row{ display:grid; grid-template-columns:1fr 1fr; gap:12px; }
        .card{ background:#fff; border:1px solid #e7edf3; border-radius:12px; padding:12px; }
        .label{ font-size:12px; color:#777; margin-bottom:4px; }
        .value{ font-weight:bold; color:#333; }
        .badge{ display:inline-block; padding:4px 10px; border-radius:999px; font-size:12px; font-weight:bold; }
        .pending{ background:#fff3cd; color:#856404; }
        .active{ background:#d4edda; color:#155724; }
        .inactive{ background:#f8d7da; color:#721c24; }
        @media(max-width:700px){ .row{ grid-template-columns:1fr; } }
    </style>
</head>
<body>

<div class="box">
    <h2>My Unit Details</h2>

    <div class="card">
        <div class="label">Operator</div>
        <div class="value"><%= opName %> <span style="font-weight:normal;color:#666;">( <%= opPhone %> )</span></div>
        <div class="label" style="margin-top:8px;">Category</div>
        <div class="value"><%= opCategory %></div>
    </div>

    <%
        if (unitId == null) {
    %>
        <div class="card" style="margin-top:12px;">
            <div class="value" style="color:#8a1f11;">Not assigned to any unit yet.</div>
            <div class="label">Wait for Admin to assign a production unit.</div>
        </div>
    <%
        } else if (unitRs != null && unitRs.next()) {
            String st = unitRs.getString("status");
            String cls = "pending";
            if ("Active".equalsIgnoreCase(st)) cls="active";
            else if ("Inactive".equalsIgnoreCase(st)) cls="inactive";
    %>

    <div class="row" style="margin-top:12px;">
        <div class="card">
            <div class="label">Unit ID</div>
            <div class="value"><%= unitRs.getInt("unit_id") %></div>
        </div>
        <div class="card">
            <div class="label">Unit Name</div>
            <div class="value"><%= unitRs.getString("unit_name") %></div>
        </div>

        <div class="card">
            <div class="label">Location</div>
            <div class="value"><%= unitRs.getString("location") %></div>
        </div>
        <div class="card">
            <div class="label">Status</div>
            <div class="value"><span class="badge <%= cls %>"><%= st %></span></div>
        </div>

        <div class="card">
            <div class="label">Start Date</div>
            <div class="value"><%= unitRs.getString("start_date") %></div>
        </div>
        <div class="card">
            <div class="label">End Date</div>
            <div class="value"><%= unitRs.getString("end_date") %></div>
        </div>

        <div class="card" style="grid-column:span 2;">
            <div class="label">Owner</div>
            <div class="value">
                <%= unitRs.getString("owner_name") %>
                <span style="font-weight:normal;color:#666;">( <%= unitRs.getString("owner_phone") %> )</span>
            </div>
        </div>
    </div>

    <%
        } else {
    %>
        <div class="card" style="margin-top:12px;">
            <div class="value" style="color:#8a1f11;">Unit not found.</div>
        </div>
    <%
        }
    %>

</div>

</body>
</html>
