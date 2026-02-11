package org.apache.jsp.owner;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class owner_005fdashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');

    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    // Optional: ensure owner role
    if (!"Owner".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Owner Dashboard</title>\n");
      out.write("    <style>\n");
      out.write("        body { margin: 0; font-family: Arial, sans-serif; background-color: #f4f6f8; }\n");
      out.write("        .wrapper { display: flex; height: 100vh; }\n");
      out.write("\n");
      out.write("        .sidebar {\n");
      out.write("            width: 250px;\n");
      out.write("            background-color: #2c3e50;\n");
      out.write("            color: white;\n");
      out.write("            padding-top: 20px;\n");
      out.write("            position: relative;\n");
      out.write("        }\n");
      out.write("        .sidebar h2 { text-align: center; margin-bottom: 30px; }\n");
      out.write("        .sidebar a {\n");
      out.write("            display: block;\n");
      out.write("            padding: 15px;\n");
      out.write("            color: white;\n");
      out.write("            text-decoration: none;\n");
      out.write("            border-bottom: 1px solid #34495e;\n");
      out.write("        }\n");
      out.write("        .sidebar a:hover { background-color: #1abc9c; }\n");
      out.write("\n");
      out.write("        .content { flex: 1; background-color: #ecf0f1; padding: 20px; }\n");
      out.write("        iframe { width: 100%; height: 100%; border: none; background: white; border-radius: 6px; }\n");
      out.write("\n");
      out.write("        .logout { position: absolute; bottom: 20px; width: 250px; text-align: center; }\n");
      out.write("        .logout a { color: #ecf0f1; text-decoration: none; }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"wrapper\">\n");
      out.write("\n");
      out.write("    <div class=\"sidebar\">\n");
      out.write("        <h2>Owner Panel</h2>\n");
      out.write("\n");
      out.write("        <a href=\"owner_select_unit.jsp\" target=\"contentFrame\">Select / Create Production Unit</a>\n");
      out.write("        <a href=\"owner_my_units.jsp\" target=\"contentFrame\">My Production Units</a>\n");
      out.write("\n");
      out.write("        <div class=\"logout\">\n");
      out.write("            <a href=\"../LogoutServlet\">Logout</a>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div class=\"content\">\n");
      out.write("        <iframe name=\"contentFrame\" src=\"owner_welcome.jsp\"></iframe>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
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
