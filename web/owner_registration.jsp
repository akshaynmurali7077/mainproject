<!DOCTYPE html>
<html>
<head>
  <title>register</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    body{
      margin:0;
      font-family: Arial, sans-serif;
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      background: #f4f6f8;
      background-image: url("https://images.unsplash.com/photo-1501004318641-b39e6451bec6");
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
    }
    body::before{
      content:"";
      position:fixed;
      inset:0;
      background:rgba(0,0,0,0.50);
      z-index:-1;
    }

    .card{
      width: 720px;
      max-width: 92%;
      background: rgba(255,255,255,0.95);
      border-radius: 14px;
      box-shadow: 0 14px 40px rgba(0,0,0,0.25);
      overflow:hidden;
      display:flex;
    }

    .left{
      width: 38%;
      background: linear-gradient(135deg, #1abc9c, #2d89ef);
      color:#fff;
      padding: 28px 22px;
      display:flex;
      flex-direction:column;
      justify-content:center;
    }

    .left h1{
      margin:0 0 10px;
      font-size: 26px;
      letter-spacing: 0.6px;
      text-transform: capitalize;
    }

    .left p{
      margin:0;
      font-size: 13px;
      line-height: 1.6;
      opacity:0.95;
    }

    .right{
      width: 62%;
      padding: 22px 26px 18px;
    }

    .top-title{
      margin: 0 0 4px;
      font-size: 22px;
      font-weight: bold;
      text-transform: capitalize;
    }

    .sub{
      margin: 0 0 16px;
      color:#555;
      font-size: 13px;
    }

    form{ margin:0; }

    .grid{
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px 14px;
    }

    .field{
      display:flex;
      flex-direction:column;
    }

    label{
      font-weight:bold;
      font-size: 13px;
      margin-bottom: 6px;
      color:#333;
    }

    input[type="text"],
    input[type="password"],
    input[type="number"]{
      padding: 10px 12px;
      border: 1px solid #cfd7df;
      border-radius: 8px;
      outline:none;
      font-size: 14px;
      background:#fff;
      box-sizing:border-box;
    }

    input:focus{
      border-color:#2d89ef;
      box-shadow: 0 0 0 3px rgba(45,137,239,0.15);
    }

    .span2{ grid-column: span 2; }

    input[type="file"]{
      padding: 10px;
      border: 1px dashed #c0c8d0;
      border-radius: 8px;
      background:#fafafa;
      cursor:pointer;
    }

    .hint{
      font-size: 12px;
      color:#666;
      margin-top:6px;
    }

    .error{
      font-size: 12px;
      color:#d93025;
      margin-top:6px;
      display:none;
    }

    .actions{
      display:flex;
      gap: 10px;
      margin-top: 16px;
    }

    .btn{
      flex:1;
      padding: 12px;
      border:none;
      border-radius: 10px;
      font-size: 15px;
      cursor:pointer;
      font-weight:bold;
    }

    .btn-primary{
      background:#2d89ef;
      color:#fff;
    }
    .btn-primary:hover{ background:#1f73d6; }

    .btn-secondary{
      background:#e9f1f7;
      color:#333;
    }
    .btn-secondary:hover{ background:#d9e9f7; }

    .footer{
      margin-top: 10px;
      text-align:center;
      font-size: 12px;
      color:#666;
    }

    @media (max-width: 720px){
      .card{ flex-direction: column; }
      .left, .right{ width:100%; }
      .grid{ grid-template-columns: 1fr; }
      .span2{ grid-column: span 1; }
    }
  </style>
</head>

<body>

  <div class="card">

    <div class="left">
      <h1>Owner Registration</h1>
      <p>
        Register as an owner to create your farming profile.<br>
        Your account will be <b>Pending</b> until the admin verifies you.
      </p>
    </div>

    <div class="right">
      <h2 class="top-title">registration</h2>
      <p class="sub">Fill the form carefully and upload a clear photo.</p>

      <!-- ? DO NOT CHANGE form action/method/enctype -->
      <form id="regForm" action="register.jsp" method="post" enctype="multipart/form-data" novalidate>

        <div class="grid">

          <div class="field span2">
            <label>Full Name</label>
            <input type="text" name="fullname" id="fullname" required>
            <div class="error" id="err_fullname">Full name must be at least 3 characters.</div>
          </div>

          <div class="field">
            <label>Username</label>
            <input type="text" name="username" id="username" required>
            <div class="error" id="err_username">Username must be 4?20 letters/numbers only (no spaces).</div>
          </div>

          <div class="field">
            <label>Password</label>
            <input type="password" name="password" id="password" required>
            <div class="error" id="err_password">Password must be 6+ characters and include a number.</div>
          </div>

          <div class="field span2">
            <label>Address</label>
            <input type="text" name="address" id="address" required>
            <div class="error" id="err_address">Address must be at least 5 characters.</div>
          </div>

          <div class="field">
            <label>Age</label>
            <input type="number" name="age" id="age" required>
            <div class="error" id="err_age">Age must be between 18 and 80.</div>
          </div>

          <div class="field">
            <label>Phone</label>
            <input type="text" name="phone" id="phone" required>
            <div class="error" id="err_phone">Phone must be exactly 10 digits.</div>
          </div>

          <div class="field span2">
            <label>Photo</label>
            <input type="file" name="photo" id="photo" accept="image/*" required>
            <div class="hint">Accepted: JPG/PNG/WebP. Max size: 2MB.</div>
            <div class="error" id="err_photo">Please upload a valid image (JPG/PNG/WebP) under 2MB.</div>
          </div>

        </div>

        <div class="actions">
          <input class="btn btn-primary" type="submit" value="Register">
          <input class="btn btn-secondary" type="reset" value="Clear">
        </div>

      </form>

      <div class="footer">
        By registering, you agree to verification by admin for authorized farmer access.
      </div>
    </div>

  </div>

  <script>
    const form = document.getElementById("regForm");

    const fullname = document.getElementById("fullname");
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    const address  = document.getElementById("address");
    const age      = document.getElementById("age");
    const phone    = document.getElementById("phone");
    const photo    = document.getElementById("photo");

    function show(id, msg){
      const el = document.getElementById(id);
      if(msg) el.textContent = msg;
      el.style.display = "block";
    }
    function hide(id){
      document.getElementById(id).style.display = "none";
    }

    function validate(){
      let ok = true;

      const fn = fullname.value.trim();
      const un = username.value.trim();
      const pw = password.value;
      const ad = address.value.trim();
      const ag = parseInt(age.value, 10);
      const ph = phone.value.trim();
      const file = photo.files && photo.files[0] ? photo.files[0] : null;

      // Full name: 3+ chars
      if(fn.length < 3){
        show("err_fullname");
        ok = false;
      } else hide("err_fullname");

      // Username: 4-20 alphanum only
      if(!/^[a-zA-Z0-9]{4,20}$/.test(un)){
        show("err_username");
        ok = false;
      } else hide("err_username");

      // Password: 6+ chars + at least one digit
      if(pw.length < 6 || !/\d/.test(pw)){
        show("err_password");
        ok = false;
      } else hide("err_password");

      // Address: 5+ chars
      if(ad.length < 5){
        show("err_address");
        ok = false;
      } else hide("err_address");

      // Age: 18-80
      if(isNaN(ag) || ag < 18 || ag > 80){
        show("err_age");
        ok = false;
      } else hide("err_age");

      // Phone: exactly 10 digits
      if(!/^[0-9]{10}$/.test(ph)){
        show("err_phone");
        ok = false;
      } else hide("err_phone");

      // Photo: required, image type, <= 2MB
      if(!file){
        show("err_photo");
        ok = false;
      } else {
        const allowed = ["image/jpeg","image/png","image/webp"];
        const isOkType = allowed.includes(file.type) || file.type.startsWith("image/");
        const isOkSize = file.size <= 7 * 1024 * 1024;

        if(!isOkType || !isOkSize){
          show("err_photo");
          ok = false;
        } else hide("err_photo");
      }

      return ok;
    }

    // Live validation
    [fullname, username, password, address, age, phone, photo].forEach(el => {
      el.addEventListener("input", validate);
      el.addEventListener("change", validate);
    });

    // On submit
    form.addEventListener("submit", function(e){
      if(!validate()){
        e.preventDefault();
      }
    });

    // Reset clears errors
    form.addEventListener("reset", function(){
      ["err_fullname","err_username","err_password","err_address","err_age","err_phone","err_photo"]
        .forEach(hide);
    });
  </script>

</body>
</html>
