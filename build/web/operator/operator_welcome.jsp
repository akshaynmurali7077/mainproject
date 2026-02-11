<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Operator Welcome</title>
  <style>
    body{ margin:0; font-family:Arial; padding:18px; background:#fff; }
    .hero{
      border-radius:14px;
      padding:18px;
      color:#fff;
      background-image:url("https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg");
      background-size:cover;
      background-position:center;
      position:relative;
      overflow:hidden;
      min-height:220px;
    }
    .hero::before{
      content:"";
      position:absolute;
      inset:0;
      background:rgba(0,0,0,0.55);
    }
    .hero-content{ position:relative; z-index:1; max-width:720px; }
    h2{ margin:0 0 8px; }
    p{ margin:0; line-height:1.6; }
    .cards{
      margin-top:14px;
      display:grid;
      grid-template-columns: repeat(2, 1fr);
      gap:12px;
    }
    .card{
      background:#ffffff;
      border:1px solid #e7edf3;
      border-radius:12px;
      padding:12px;
      color:#333;
    }
    .muted{ color:#666; font-size:13px; }
    @media(max-width:700px){ .cards{ grid-template-columns:1fr; } }
  </style>
</head>
<body>

<div class="hero">
  <div class="hero-content">
    <h2>Welcome Operator</h2>
    <p>
      You are assigned to a production unit. Start by checking your unit details,
      then create and manage activities. Owner will verify completed work.
    </p>

    <div class="cards">
      <div class="card">
        <b>My Unit Details</b>
        <div class="muted">View your unit name, category, location, dates, status.</div>
      </div>
      <div class="card">
        <b>Activities</b>
        <div class="muted">Create activities, assign workers, track progress and submissions.</div>
      </div>
      <div class="card">
        <b>Workers</b>
        <div class="muted">See workers linked to your unit (later: assign and manage).</div>
      </div>
      <div class="card">
        <b>Stock Alerts</b>
        <div class="muted">Review low-stock alerts and forward/track approvals.</div>
      </div>
    </div>
  </div>
</div>

</body>
</html>

