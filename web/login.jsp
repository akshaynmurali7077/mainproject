<!DOCTYPE html>
<%
    String error = request.getParameter("error");
    if ("invalid".equals(error)) {
%>
<script>
    alert("wait for amin approval");
</script>
<%
    }
%>

<html>
<head>
  <title>Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    
  body{
    margin:0;
    font-family: Arial, sans-serif;
    background-image: url("images/farm_bg.jpg");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    display:flex;
    align-items:center;
    justify-content:center;
    height:100vh;
  }


    /* optional dark overlay for readability */
    body::before{
      content:"";
      position:fixed;
      inset:0;
      background:rgba(0,0,0,0.45);
      z-index:-1;
    }

    .card{
      width:360px;
      background:#fff;
      border-radius:10px;
      box-shadow:0 8px 20px rgba(0,0,0,0.12);
      padding:25px 25px 18px;
    }
    .title{
      text-align:center;
      margin:0 0 6px;
      font-size:26px;
      letter-spacing:1px;
    }
    .subtitle{
      text-align:center;
      margin:0 0 18px;
      color:#666;
      font-size:13px;
    }
    label{
      display:block;
      font-weight:bold;
      margin:10px 0 6px;
      font-size:14px;
    }
    input[type="text"], input[type="password"]{
      width:100%;
      padding:10px 12px;
      border:1px solid #cfd7df;
      border-radius:6px;
      outline:none;
      font-size:14px;
      box-sizing:border-box;
    }
    input:focus{
      border-color:#2d89ef;
      box-shadow:0 0 0 3px rgba(45,137,239,0.15);
    }
    .error{
      color:#d93025;
      font-size:12px;
      margin-top:6px;
      display:none;
    }
    .btn{
      width:100%;
      padding:11px;
      border:none;
      border-radius:6px;
      font-size:15px;
      cursor:pointer;
      margin-top:14px;
    }
    .btn-login{
      background:#2d89ef;
      color:#fff;
      font-weight:bold;
    }
    .btn-login:hover{ background:#1f73d6; }

    .divider{
      text-align:center;
      margin:14px 0;
      color:#999;
      font-size:13px;
      position:relative;
    }
    .divider:before, .divider:after{
      content:"";
      position:absolute;
      top:50%;
      width:40%;
      height:1px;
      background:#e2e6ea;
    }
    .divider:before{ left:0; }
    .divider:after{ right:0; }

    .btn-register{
      background:#1abc9c;
      color:#fff;
      font-weight:bold;
    }
    .btn-register:hover{ background:#139b82; }
  </style>
</head>

<body>
  <div class="card">
    <h1 class="title">LOGIN</h1>
    <p class="subtitle">Agriflow Improvement System</p>

    <!-- ? Do not change action/method -->
    <form id="loginForm" action="LoginServerlet" method="post" novalidate>

      <label>Username</label>
      <input id="username" type="text" name="username" required minlength="3" maxlength="50">
      <div id="userErr" class="error">enter valid username.</div>

      <label>Password</label>
      <input id="password" type="password" name="password" required minlength="6" maxlength="50">
      <div id="passErr" class="error">Password must be at least 6 characters.</div>

      <input class="btn btn-login" type="submit" value="Login">
    </form>

    <div class="divider">OR</div>

    <!-- ? Do not change action/method -->
    <form action="owner_registration.jsp" method="get">
      <input class="btn btn-register" type="submit" value="Register as Owner">
    </form>
  </div>

  <script>
    const form = document.getElementById("loginForm");
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    const userErr = document.getElementById("userErr");
    const passErr = document.getElementById("passErr");

    function show(el, msg){
      el.textContent = msg;
      el.style.display = "block";
    }
    function hide(el){
      el.style.display = "none";
    }

    function validate(){
      let ok = true;

      const u = username.value.trim();
      const p = password.value.trim();

      if(u.length < 3){
        show(userErr, "Username must be at least 3 characters.");
        ok = false;
      } else {
        hide(userErr);
      }

      if(p.length < 4){
        show(passErr, "Password must be at least 6 characters.");
        ok = false;
      } else {
        hide(passErr);
      }

      return ok;
    }

    username.addEventListener("input", validate);
    password.addEventListener("input", validate);

    form.addEventListener("submit", function(e){
      if(!validate()){
        e.preventDefault();
      }
    });
  </script>
</body>
</html>
