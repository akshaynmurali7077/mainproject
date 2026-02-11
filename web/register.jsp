<%@ page import="DB.ConnectionClass" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>

<%
    String username = "", password = "", fullname = "", address = "", age = "", phone = "";
    String photoName = "";

    if (!ServletFileUpload.isMultipartContent(request)) {
        out.println("<h3 style='color:red'>Form must be multipart/form-data</h3>");
        return;
    }

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    try {                                                                       
        List<FileItem> items = upload.parseRequest(request);                    

        for (FileItem item : items) {

            // ? Handle normal fields
            if (item.isFormField()) {
                String field = item.getFieldName();
                String value = item.getString("UTF-8"); // supports Tamil/Unicode too

                if ("username".equals(field)) username = value;
                else if ("password".equals(field)) password = value;
                else if ("fullname".equals(field)) fullname = value;
                else if ("address".equals(field)) address = value;
                else if ("age".equals(field)) age = value;
                else if ("phone".equals(field)) phone = value;

            } 
            // ? Handle photo upload
            else {
                String originalName = item.getName();

                // If no file selected, skip
                if (originalName == null || originalName.trim().equals("")) {
                    continue;
                }

                // ? Remove fake path (C:\fakepath\...)
                originalName = new File(originalName).getName();

                // ? Create unique name
                photoName = System.currentTimeMillis() + "_" + originalName;

                // ? Correct deployed path
                String uploadPath = application.getRealPath("/") + "uploads" + File.separator + "owners" + File.separator;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                File savedFile = new File(uploadDir, photoName);

                // (Optional debug - remove later)
                // out.println("Saving to: " + savedFile.getAbsolutePath() + "<br>");

                item.write(savedFile);
            }
        }

        // ? Validation check (simple)
        if (username.equals("") || password.equals("") || fullname.equals("") || address.equals("") ||
            age.equals("") || phone.equals("") || photoName.equals("")) {

            out.println("<h3 style='color:red'>All fields + photo are required.</h3>");
            return;
        }

        // ? DB insert
        ConnectionClass db = new ConnectionClass();

        String sql =
            "INSERT INTO users (username, password, full_name, address, age, phone, photo, role, status, created_at) " +
            "VALUES ('" + username + "','" + password + "','" + fullname + "','" +
                         address + "','" + age + "','" + phone + "','" + photoName + "'," +
                         "'Owner','Pending',NOW())";

        String result = db.executeCommandWithError(sql);

        if ("SUCCESS".equals(result)) {
            out.println("<h3 style='color:green'>? Owner registered successfully. Wait for admin approval.</h3>");
            out.println("<p><a href='login.html'>Go to Login</a></p>");
        } else {
            out.println("<h3 style='color:red'>? Registration failed</h3>");
            out.println("<b>Error:</b> " + result);
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red'>Upload Error:</h3>");
    out.println("<pre>" + e.toString() + "</pre>");
    e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
