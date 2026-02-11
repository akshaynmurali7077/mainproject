<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Owner</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body{
            margin:0;
            font-family: Arial, sans-serif;
            min-height:100vh;
            background-image: url("https://images.unsplash.com/photo-1501004318641-b39e6451bec6");
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
            max-width:900px;
            margin:40px auto;
            padding:20px;
        }

        .welcome-card{
            background: rgba(255,255,255,0.95);
            border-radius:16px;
            padding:28px;
            box-shadow:0 20px 45px rgba(0,0,0,0.3);
        }

        h1{
            margin:0;
            color:#2c3e50;
            font-size:30px;
        }

        .sub{
            margin-top:6px;
            font-size:15px;
            color:#555;
        }

        .info{
            display:grid;
            grid-template-columns: repeat(3, 1fr);
            gap:16px;
            margin-top:26px;
        }

        .card{
            background:#f9fbfd;
            border:1px solid #e3e8ee;
            border-radius:14px;
            padding:18px;
            text-align:center;
        }

        .card img{
            width:60px;
            margin-bottom:10px;
        }

        .card h3{
            margin:6px 0;
            font-size:16px;
            color:#2d89ef;
        }

        .card p{
            font-size:13px;
            color:#555;
            margin:0;
        }

        .note{
            margin-top:24px;
            padding:14px;
            background:#e8f4fd;
            border-left:6px solid #2d89ef;
            border-radius:10px;
            font-size:14px;
            color:#333;
        }

        @media(max-width:800px){
            .info{ grid-template-columns:1fr; }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="welcome-card">
        <h1>? Welcome to AgriFlow</h1>
        <p class="sub">
            Manage your farms, track progress, and collaborate with operators efficiently.
        </p>

        <div class="info">

            <div class="card">
                <img src="https://cdn-icons-png.flaticon.com/512/2909/2909764.png">
                <h3>Create Production Unit</h3>
                <p>
                    Register your farm or production unit and send it to admin for verification.
                </p>
            </div>

            <div class="card">
                <img src="https://cdn-icons-png.flaticon.com/512/2329/2329087.png">
                <h3>Admin Verification</h3>
                <p>
                    Admin verifies your unit and assigns a suitable operator.
                </p>
            </div>

            <div class="card">
                <img src="https://cdn-icons-png.flaticon.com/512/4149/4149677.png">
                <h3>Monitor Progress</h3>
                <p>
                    View development progress, activities, and updates from operators.
                </p>
            </div>

        </div>

        <div class="note">
            ? Start by selecting or creating a <b>Production Unit</b> from the left menu.
            Once approved, operations will begin automatically.
        </div>

    </div>

</div>

</body>
</html>
