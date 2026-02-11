package com.agriflow;

import DB.ConnectionClass;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServerlet")
public class LoginServerlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ConnectionClass db = new ConnectionClass();

        try {
            String sql = "SELECT * FROM users " +
                         "WHERE username='" + username + "' " +
                         "AND password='" + password + "' " +
                         "AND status='Active'";

            ResultSet rs = db.selectCommand(sql);

            if (rs.next()) {

                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("role", role);

                if ("Admin".equals(role)) {
                    response.sendRedirect("admin/admin_dashboard.jsp");
                } else if ("Operator".equals(role)) {
                    response.sendRedirect("operator/operator_dashboard.jsp");
                } else if ("Worker".equals(role)) {
                    response.sendRedirect("worker/dashboard.jsp");
                } else if ("Owner".equals(role)) {
                    response.sendRedirect("owner/owner_dashboard.jsp");
                } else {
                    response.sendRedirect("login.html?error=role");
                }

            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error");
        }
    }
}


