package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!DOCTYPE html>\n");

    String error = request.getParameter("error");
    if ("invalid".equals(error)) {

      out.write("\n");
      out.write("<script>\n");
      out.write("    alert(\"wait for amin approval\");\n");
      out.write("</script>\n");

    }

      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("  <title>Login</title>\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("\n");
      out.write("  <style>\n");
      out.write("    \n");
      out.write("  body{\n");
      out.write("    margin:0;\n");
      out.write("    font-family: Arial, sans-serif;\n");
      out.write("    background-image: url(\"images/farm_bg.jpg\");\n");
      out.write("    background-size: cover;\n");
      out.write("    background-position: center;\n");
      out.write("    background-repeat: no-repeat;\n");
      out.write("    display:flex;\n");
      out.write("    align-items:center;\n");
      out.write("    justify-content:center;\n");
      out.write("    height:100vh;\n");
      out.write("  }\n");
      out.write("\n");
      out.write("\n");
      out.write("    /* optional dark overlay for readability */\n");
      out.write("    body::before{\n");
      out.write("      content:\"\";\n");
      out.write("      position:fixed;\n");
      out.write("      inset:0;\n");
      out.write("      background:rgba(0,0,0,0.45);\n");
      out.write("      z-index:-1;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .card{\n");
      out.write("      width:360px;\n");
      out.write("      background:#fff;\n");
      out.write("      border-radius:10px;\n");
      out.write("      box-shadow:0 8px 20px rgba(0,0,0,0.12);\n");
      out.write("      padding:25px 25px 18px;\n");
      out.write("    }\n");
      out.write("    .title{\n");
      out.write("      text-align:center;\n");
      out.write("      margin:0 0 6px;\n");
      out.write("      font-size:26px;\n");
      out.write("      letter-spacing:1px;\n");
      out.write("    }\n");
      out.write("    .subtitle{\n");
      out.write("      text-align:center;\n");
      out.write("      margin:0 0 18px;\n");
      out.write("      color:#666;\n");
      out.write("      font-size:13px;\n");
      out.write("    }\n");
      out.write("    label{\n");
      out.write("      display:block;\n");
      out.write("      font-weight:bold;\n");
      out.write("      margin:10px 0 6px;\n");
      out.write("      font-size:14px;\n");
      out.write("    }\n");
      out.write("    input[type=\"text\"], input[type=\"password\"]{\n");
      out.write("      width:100%;\n");
      out.write("      padding:10px 12px;\n");
      out.write("      border:1px solid #cfd7df;\n");
      out.write("      border-radius:6px;\n");
      out.write("      outline:none;\n");
      out.write("      font-size:14px;\n");
      out.write("      box-sizing:border-box;\n");
      out.write("    }\n");
      out.write("    input:focus{\n");
      out.write("      border-color:#2d89ef;\n");
      out.write("      box-shadow:0 0 0 3px rgba(45,137,239,0.15);\n");
      out.write("    }\n");
      out.write("    .error{\n");
      out.write("      color:#d93025;\n");
      out.write("      font-size:12px;\n");
      out.write("      margin-top:6px;\n");
      out.write("      display:none;\n");
      out.write("    }\n");
      out.write("    .btn{\n");
      out.write("      width:100%;\n");
      out.write("      padding:11px;\n");
      out.write("      border:none;\n");
      out.write("      border-radius:6px;\n");
      out.write("      font-size:15px;\n");
      out.write("      cursor:pointer;\n");
      out.write("      margin-top:14px;\n");
      out.write("    }\n");
      out.write("    .btn-login{\n");
      out.write("      background:#2d89ef;\n");
      out.write("      color:#fff;\n");
      out.write("      font-weight:bold;\n");
      out.write("    }\n");
      out.write("    .btn-login:hover{ background:#1f73d6; }\n");
      out.write("\n");
      out.write("    .divider{\n");
      out.write("      text-align:center;\n");
      out.write("      margin:14px 0;\n");
      out.write("      color:#999;\n");
      out.write("      font-size:13px;\n");
      out.write("      position:relative;\n");
      out.write("    }\n");
      out.write("    .divider:before, .divider:after{\n");
      out.write("      content:\"\";\n");
      out.write("      position:absolute;\n");
      out.write("      top:50%;\n");
      out.write("      width:40%;\n");
      out.write("      height:1px;\n");
      out.write("      background:#e2e6ea;\n");
      out.write("    }\n");
      out.write("    .divider:before{ left:0; }\n");
      out.write("    .divider:after{ right:0; }\n");
      out.write("\n");
      out.write("    .btn-register{\n");
      out.write("      background:#1abc9c;\n");
      out.write("      color:#fff;\n");
      out.write("      font-weight:bold;\n");
      out.write("    }\n");
      out.write("    .btn-register:hover{ background:#139b82; }\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("  <div class=\"card\">\n");
      out.write("    <h1 class=\"title\">LOGIN</h1>\n");
      out.write("    <p class=\"subtitle\">Agriflow Improvement System</p>\n");
      out.write("\n");
      out.write("    <!-- ? Do not change action/method -->\n");
      out.write("    <form id=\"loginForm\" action=\"LoginServerlet\" method=\"post\" novalidate>\n");
      out.write("\n");
      out.write("      <label>Username</label>\n");
      out.write("      <input id=\"username\" type=\"text\" name=\"username\" required minlength=\"3\" maxlength=\"50\">\n");
      out.write("      <div id=\"userErr\" class=\"error\">enter valid username.</div>\n");
      out.write("\n");
      out.write("      <label>Password</label>\n");
      out.write("      <input id=\"password\" type=\"password\" name=\"password\" required minlength=\"6\" maxlength=\"50\">\n");
      out.write("      <div id=\"passErr\" class=\"error\">Password must be at least 6 characters.</div>\n");
      out.write("\n");
      out.write("      <input class=\"btn btn-login\" type=\"submit\" value=\"Login\">\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    <div class=\"divider\">OR</div>\n");
      out.write("\n");
      out.write("    <!-- ? Do not change action/method -->\n");
      out.write("    <form action=\"owner_registration.jsp\" method=\"get\">\n");
      out.write("      <input class=\"btn btn-register\" type=\"submit\" value=\"Register as Owner\">\n");
      out.write("    </form>\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("  <script>\n");
      out.write("    const form = document.getElementById(\"loginForm\");\n");
      out.write("    const username = document.getElementById(\"username\");\n");
      out.write("    const password = document.getElementById(\"password\");\n");
      out.write("    const userErr = document.getElementById(\"userErr\");\n");
      out.write("    const passErr = document.getElementById(\"passErr\");\n");
      out.write("\n");
      out.write("    function show(el, msg){\n");
      out.write("      el.textContent = msg;\n");
      out.write("      el.style.display = \"block\";\n");
      out.write("    }\n");
      out.write("    function hide(el){\n");
      out.write("      el.style.display = \"none\";\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    function validate(){\n");
      out.write("      let ok = true;\n");
      out.write("\n");
      out.write("      const u = username.value.trim();\n");
      out.write("      const p = password.value.trim();\n");
      out.write("\n");
      out.write("      if(u.length < 3){\n");
      out.write("        show(userErr, \"Username must be at least 3 characters.\");\n");
      out.write("        ok = false;\n");
      out.write("      } else {\n");
      out.write("        hide(userErr);\n");
      out.write("      }\n");
      out.write("\n");
      out.write("      if(p.length < 4){\n");
      out.write("        show(passErr, \"Password must be at least 6 characters.\");\n");
      out.write("        ok = false;\n");
      out.write("      } else {\n");
      out.write("        hide(passErr);\n");
      out.write("      }\n");
      out.write("\n");
      out.write("      return ok;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    username.addEventListener(\"input\", validate);\n");
      out.write("    password.addEventListener(\"input\", validate);\n");
      out.write("\n");
      out.write("    form.addEventListener(\"submit\", function(e){\n");
      out.write("      if(!validate()){\n");
      out.write("        e.preventDefault();\n");
      out.write("      }\n");
      out.write("    });\n");
      out.write("  </script>\n");
      out.write("</body>\n");
      out.write("</html>\n");
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
