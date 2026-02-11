<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Introduction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body{
            margin:0;
            font-family: Arial, sans-serif;
            min-height:100vh;
            background-image: url("https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        /* Dark overlay */
        body::before{
            content:"";
            position:fixed;
            inset:0;
            background:rgba(0,0,0,0.55);
            z-index:-1;
        }

        .container{
            max-width:800px;
            margin:60px auto;
            padding:20px;
        }

        .intro-box{
            background: rgba(255,255,255,0.95);
            border-radius:16px;
            padding:30px;
            box-shadow:0 18px 40px rgba(0,0,0,0.3);
        }

        h1{
            margin:0;
            font-size:30px;
            color:#2c3e50;
        }

        .sub{
            margin-top:10px;
            font-size:15px;
            color:#555;
            line-height:1.6;
        }

        .highlight{
            margin-top:18px;
            padding:14px;
            background:#e8f4fd;
            border-left:6px solid #2d89ef;
            border-radius:10px;
            font-size:14px;
            color:#333;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="intro-box">
        <h1>Welcome to AgriFlow ? Admin Panel</h1>

        <p class="sub">
            This panel allows administrators to manage and monitor agricultural operations
            across multiple production units. The admin ensures that only verified owners,
            units, and operators participate in the system.
        </p>

        <p class="sub">
            Through this dashboard, the admin maintains overall control, transparency,
            and smooth coordination between owners, operators, and workers.
        </p>

        <div class="highlight">
            ? Use the left menu to verify owners, approve production units, assign operators,
            and monitor development progress.
        </div>
    </div>

</div>

</body>
</html>
