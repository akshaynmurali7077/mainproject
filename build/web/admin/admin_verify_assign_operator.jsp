<%@ page import="DB.ConnectionClass,java.sql.*" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("user_id") == null) { response.sendRedirect("../login.html"); return; }
    if (!"Admin".equals(session.getAttribute("role"))) { response.sendRedirect("../login.html"); return; }

    int adminId = Integer.parseInt(session.getAttribute("user_id").toString());
    ConnectionClass db = new ConnectionClass();
    String msg = "";

    if (request.getParameter("assign") != null) {

        String unitId = request.getParameter("unit_id");
        String operatorId = request.getParameter("operator_id");

        String q1 =
            "UPDATE production_unit SET " +
            "status='Active', admin_id=" + adminId + ", operator_id=" + operatorId +
            " WHERE unit_id=" + unitId;

        String r1 = db.executeCommandWithError(q1);

        if ("SUCCESS".equals(r1)) {
            String q2 =
                "UPDATE operator SET unit_id=" + unitId + ", status='Active' " +
                "WHERE operator_id=" + operatorId;

            String r2 = db.executeCommandWithError(q2);

            if ("SUCCESS".equals(r2)) msg = "<div style='color:green;font-weight:bold'>? Approved & assigned successfully</div>";
            else msg = "<div style='color:red;font-weight:bold'>? Operator update failed: "+r2+"</div>";
        } else {
            msg = "<div style='color:red;font-weight:bold'>? Unit update failed: "+r1+"</div>";
        }
    }

   ResultSet units = db.selectCommand(
    "SELECT pu.*, u.full_name AS owner_name, u.phone AS owner_phone " +
    "FROM production_unit pu " +
    "JOIN users u ON pu.owner_id = u.user_id " +
    "WHERE pu.status='Pending' " +
    "AND pu.operator_request='Yes' " +
    "ORDER BY pu.requested_at DESC"
);

%>

<!DOCTYPE html>
<html>
<head>
    <title>Verify Unit & Assign Operator</title>
    <style>
        body{ font-family: Arial, sans-serif; background:#f4f6f8; margin:0; padding:18px; }
        .box{ max-width:1100px; margin:auto; background:#fff; padding:18px; border-radius:12px;
              box-shadow:0 10px 25px rgba(0,0,0,0.08); }
        table{ width:100%; border-collapse:collapse; margin-top:12px; }
        th{ background:#2d89ef; color:#fff; padding:10px; text-align:left; font-size:13px; }
        td{ padding:10px; border-bottom:1px solid #e7edf3; vertical-align:middle; }
        select{ padding:8px 10px; border:1px solid #cfd7df; border-radius:8px; min-width:240px; }
        .btn{ padding:9px 12px; border:none; border-radius:8px; background:#1abc9c; color:#fff; font-weight:bold; cursor:pointer; }
        .btn:hover{ background:#139b82; }
        .msg{ margin:10px 0 0; }
    </style>
</head>
<body>

<div class="box">
    <h2>Verify Production Unit & Assign Operator</h2>
    <div class="msg"><%= msg %></div>

    <table>
        <tr>
            <th>Unit ID</th>
            <th>Unit Name</th>
            <th>Category</th>
            <th>Location</th>
            <th>Owner</th>
            <th>Select Operator</th>
            <th>Action</th>
        </tr>

        <%
            boolean found=false;
            while (units != null && units.next()) {
                found=true;
                int unitId = units.getInt("unit_id");
                String cat = units.getString("unit_category");
        %>
        <tr>
            <td><%= unitId %></td>
            <td><%= units.getString("unit_name") %></td>
            <td><%= cat %></td>
            <td><%= units.getString("location") %></td>
            <td>
                <b><%= units.getString("owner_name") %></b><br>
                <span style="color:#666;font-size:12px"><%= units.getString("owner_phone") %></span>
            </td>

            <td>
                <form method="post" style="margin:0">
                    <input type="hidden" name="unit_id" value="<%= unitId %>">
                    <select name="operator_id" required>
                        <option value="">-- Select Operator --</option>
                        <%
                            ResultSet ops = db.selectCommand(
                                "SELECT * FROM operator " +
                                "WHERE unit_category='" + cat + "' " +
                                "AND unit_id IS NULL " +
                                "ORDER BY operator_id DESC"
                            );
                            while (ops != null && ops.next()) {
                        %>
                        <option value="<%= ops.getInt("operator_id") %>">
                            <%= ops.getString("operator_name") %> ( <%= ops.getString("phone") %> )
                        </option>
                        <%
                            }
                        %>
                    </select>
            </td>

            <td>
                    <button class="btn" type="submit" name="assign" value="1">Approve & Assign</button>
                </form>
            </td>
        </tr>
        <%
            }
            if(!found){
        %>
        <tr>
            <td colspan="7" style="text-align:center;color:#666;padding:18px">
                No pending production units found.
            </td>
        </tr>
        <%
            }
        %>

    </table>
</div>

</body>
</html>
