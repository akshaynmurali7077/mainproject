<%@ page import="DB.ConnectionClass" %>

<%
    String action = request.getParameter("action");
    String id = request.getParameter("id");

    ConnectionClass db = new ConnectionClass();
    String sql = "";

    if ("approve".equals(action)) {
        sql = "UPDATE users SET status='Active' WHERE user_id=" + id;
    } 
    else if ("reject".equals(action)) {
        sql = "UPDATE users SET status='Rejected' WHERE user_id=" + id;
    }

   
    String result = db.executeCommandWithError(sql);

    if ("SUCCESS".equals(result)) {
        response.sendRedirect("admin_verify_owner.jsp");
    } else {
        out.println("<h3 style='color:red'>Database Error:</h3>");
        out.println("<pre>" + result + "</pre>");
    }
%>

