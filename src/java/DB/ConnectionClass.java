
package DB;

import java.sql.*;

public class ConnectionClass {

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    public ConnectionClass() {
        try {
            // ✅ Correct driver for MySQL 8/9
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/agriflow_db?useSSL=false&serverTimezone=UTC",
                "root",
                ""
            );

        } catch (Exception ex) {
            ex.printStackTrace();   // 🔥 VERY IMPORTANT
        }
    }

    public String executeCommandWithError(String sql) {
    try {
        st = con.createStatement();
        st.executeUpdate(sql);
        return "SUCCESS";
    } catch (Exception ex) {
        return ex.getMessage();   // 👈 return exact DB error
    }
}


    public ResultSet selectCommand(String sql) {
        try {
            st = con.createStatement();
            return st.executeQuery(sql);
        } catch (Exception ex) {
            ex.printStackTrace();   // 🔥 VERY IMPORTANT
            return null;
        }
    }
}

