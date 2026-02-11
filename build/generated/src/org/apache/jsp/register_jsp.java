package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import DB.ConnectionClass;
import java.util.*;
import java.io.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    String username = "";
    String password = "";
    String fullname = "";
    String address = "";
    String age = "";
    String phone = "";
    String photoName = "";

    // Check multipart form
    if (ServletFileUpload.isMultipartContent(request)) {

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {

                if (item.isFormField()) {
                    String field = item.getFieldName();
                    String value = item.getString();

                    if (field.equals("username")) username = value;
                    if (field.equals("password")) password = value;
                    if (field.equals("fullname")) fullname = value;
                    if (field.equals("address")) address = value;
                    if (field.equals("age")) age = value;
                    if (field.equals("phone")) phone = value;

                } else {
                    // Handle photo upload
                   // Handle photo upload
photoName = System.currentTimeMillis() + "_" + new File(item.getName()).getName();

// ? Correct path inside your deployed web app
String uploadPath = application.getRealPath("uploads/owners/");

File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}
out.println("Saving to: " + uploadPath + "<br>");
out.println("File: " + photoName + "<br>");


// ? Save file safely
File uploadedFile = new File(uploadDir, photoName);
item.write(uploadedFile);

                }
            }

            // DB insert
            ConnectionClass db = new ConnectionClass();

            String sql = "INSERT INTO users (username, password, full_name, address, age, phone, photo, role, status, created_at) " +
                         "VALUES ('" + username + "','" + password + "','" + fullname + "','" +
                         address + "','" + age + "','" + phone + "','" + photoName + "'," +
                         "'Owner','Pending',NOW())";

            String result = db.executeCommandWithError(sql);

            if ("SUCCESS".equals(result)) {
                out.println("<h3 style='color:green'>!Owner registered successfully. Wait for admin approval.</h3>");
            } else {
                out.println("<h3 style='color:red'>? Registration failed</h3>");
                out.println("<b>Error:</b> " + result);
            }

        } catch (Exception e) {
            out.println("<h3 style='color:red'>Upload Error:</h3> " + e.getMessage());
        }

    } else {
        out.println("<h3 style='color:red'>Form must be multipart/form-data</h3>");
    }

      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
