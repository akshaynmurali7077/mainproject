<%@ page import="DB.ConnectionClass,java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }

    int ownerId = Integer.parseInt(session.getAttribute("user_id").toString());
    ConnectionClass db = new ConnectionClass();
    String msg = "";

    // ? Handle request button click
    if (request.getParameter("requestOperator") != null) {
        String unitId = request.getParameter("unit_id");

        String up =
            "UPDATE production_unit SET operator_request='Yes', requested_at=NOW() " +
            "WHERE unit_id=" + unitId + " AND owner_id=" + ownerId;

        String res = db.executeCommandWithError(up);

        if ("SUCCESS".equals(res)) {
            msg = "<div style='padding:10px;border-radius:8px;background:#e8f4fd;color:#0b5394;font-weight:bold;margin-bottom:12px;'>"
                + "? Operator request sent to Admin."
                + "</div>";
        } else {
            msg = "<div style='padding:10px;border-radius:8px;background:#fde8e8;color:#8a1f11;font-weight:bold;margin-bottom:12px;'>"
                + "? Request failed: " + res
                + "</div>";
        }
    }

    // ? Fetch units + operator/admin info + request status
    String qry =
        "SELECT pu.*, " +
        "       au.full_name AS admin_name, " +
        "       op.operator_name, op.phone AS operator_phone " +
        "FROM production_unit pu " +
        "LEFT JOIN users au ON pu.admin_id = au.user_id " +
        "LEFT JOIN operator op ON pu.operator_id = op.operator_id " +
        "WHERE pu.owner_id=" + ownerId + " " +
        "ORDER BY pu.unit_id DESC";

    ResultSet rs = db.selectCommand(qry);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Production Units</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{ font-family: Arial, sans-serif; padding:18px; background:#fff; }
        table{ width:100%; border-collapse:collapse; }
        th{ background:#2d89ef; color:#fff; text-align:left; padding:10px; font-size:13px; }
        td{ border-bottom:1px solid #e7edf3; padding:10px; vertical-align:top; }
        .badge{ padding:4px 10px; border-radius:999px; font-size:12px; font-weight:bold; display:inline-block; }
        .pending{ background:#fff3cd; color:#856404; }
        .active{ background:#d4edda; color:#155724; }
        .inactive{ background:#f8d7da; color:#721c24; }
        .muted{ color:#777; font-size:12px; }

        .btn{
            padding:8px 12px;
            border:none;
            border-radius:8px;
            background:#1abc9c;
            color:#fff;
            font-weight:bold;
            cursor:pointer;
        }
        .btn:hover{ background:#139b82; }

        .btn-disabled{
            background:#cfd7df;
            color:#555;
            cursor:not-allowed;
        }
    </style>
</head>
<body>

<h2>My Production Units</h2>
<%= msg %>

<table>
    <tr>
        <th>ID</th>
        <th>Unit</th>
        <th>Status</th>
        <th>Admin</th>
        <th>Operator</th>
        <th>Request</th>
    </tr>

<%
    boolean found=false;
    while (rs != null && rs.next()) {
        found=true;

        int unitId = rs.getInt("unit_id");

        String st = rs.getString("status");
        String cls = "pending";
        if ("Active".equalsIgnoreCase(st)) cls="active";
        else if ("Inactive".equalsIgnoreCase(st)) cls="inactive";

        String adminName = rs.getString("admin_name");
        String opName = rs.getString("operator_name");
        String opPhone = rs.getString("operator_phone");

        Integer operatorIdObj = (Integer) rs.getObject("operator_id");

        String req = rs.getString("operator_request"); // Yes/No
        String reqAt = rs.getString("requested_at");

        // ? Request button allowed only if:
        // - unit pending
        // - operator not assigned
        // - request not already sent
        boolean canRequest = "Pending".equalsIgnoreCase(st)
                          && (operatorIdObj == null)
                          && ("No".equalsIgnoreCase(req));
%>
    <tr>
        <td><%= unitId %></td>

        <td>
            <b><%= rs.getString("unit_name") %></b><br>
            <span class="muted"><%= rs.getString("unit_category") %> ? <%= rs.getString("location") %></span>
        </td>

        <td><span class="badge <%= cls %>"><%= st %></span></td>

        <td>
            <%
                if (adminName == null || adminName.trim().equals("")) {
            %>
                <span class="muted">Not verified yet</span>
            <%
                } else {
            %>
                <b><%= adminName %></b>
            <%
                }
            %>
        </td>

        <td>
            <%
                if (opName == null || opName.trim().equals("")) {
            %>
                <span class="muted">Not assigned yet</span><br>
            <%
                } else {
            %>
                <b><%= opName %></b><br>
                <span class="muted">Phone: <%= opPhone %></span>
            <%
                }
            %>
        </td>

        <td>
            <%
                if (canRequest) {
            %>
                <form method="post" style="margin:0">
                    <input type="hidden" name="unit_id" value="<%= unitId %>">
                    <button class="btn" type="submit" name="requestOperator" value="1">Request Operator</button>
                </form>
            <%
                } else if ("Yes".equalsIgnoreCase(req) && (operatorIdObj == null)) {
            %>
                <span class="muted">Requested<br><%= (reqAt==null?"":reqAt) %></span>
            <%
                } else {
            %>
                <button class="btn btn-disabled" type="button" disabled>Not Needed</button>
            <%
                }
            %>
        </td>
    </tr>
<%
    }
    if(!found){
%>
    <tr>
        <td colspan="6" style="text-align:center;color:#666;padding:18px;">
            No production units found.
        </td>
    </tr>
<%
    }
%>
</table>

</body>
</html>

