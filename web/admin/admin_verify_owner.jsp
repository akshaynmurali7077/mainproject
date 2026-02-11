<%@ page import="DB.ConnectionClass,java.sql.*" %>

<%
    ConnectionClass db = new ConnectionClass();
    String qry = "SELECT * FROM users WHERE role='Owner' AND status='Pending'";
    ResultSet rs = db.selectCommand(qry);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Verify Owners</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body{
            margin:0;
            font-family: Arial, sans-serif;
            background:#f4f6f8;
            padding:20px;
        }

        .container{
            max-width: 1200px;
            margin:auto;
            background:#fff;
            padding:18px;
            border-radius:12px;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
        }

        h2{ margin:0; font-size:22px; }

        table{
            width:100%;
            border-collapse:collapse;
            margin-top:14px;
        }

        thead th{
            background:#2d89ef;
            color:#fff;
            padding:12px;
            font-size:13px;
            text-align:left;
        }

        tbody td{
            padding:12px;
            border-bottom:1px solid #e7edf3;
            font-size:14px;
            vertical-align:middle;
        }

        tbody tr:hover{
            background:#f2f8ff;
        }

        .photo{
            width:60px;
            height:60px;
            border-radius:50%;
            object-fit:cover;
            border:2px solid #ddd;
        }

        .actions{
            display:flex;
            gap:8px;
        }

        .btn{
            padding:8px 12px;
            border-radius:8px;
            text-decoration:none;
            font-weight:bold;
            font-size:13px;
            color:#fff;
        }
        /* Reserve space so layout doesn't jump */
.photo-box{
  width:60px;
  height:60px;
  border-radius:50%;
  overflow:hidden;
  border:2px solid #ddd;
  background:#f0f0f0;
  display:flex;
  align-items:center;
  justify-content:center;
  flex-shrink:0;
}

.photo{
  width:60px;
  height:60px;
  object-fit:cover;
  display:block;
}
table{ table-layout: fixed; }
td, th{ word-wrap: break-word; }



        .approve{ background:#1abc9c; }
        .approve:hover{ background:#139b82; }

        .reject{ background:#e74c3c; }
        .reject:hover{ background:#c0392b; }

        @media(max-width:900px){
            thead{ display:none; }
            table, tbody, tr, td{ display:block; width:100%; }
            tbody tr{
                border:1px solid #e7edf3;
                border-radius:10px;
                margin-bottom:12px;
                padding:10px;
            }
            tbody td{
                border:none;
                display:flex;
                justify-content:space-between;
                padding:6px 0;
            }
            tbody td::before{
                content: attr(data-label);
                font-weight:bold;
            }
            .actions{ justify-content:flex-end; }
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Pending Owner Requests</h2>

    <table>
        <thead>
            <tr>
                <th>Photo</th>
                <th>ID</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Address</th>
                <th>Age</th>
                <th>Phone</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
        <%
            boolean hasData=false;
            while(rs!=null && rs.next()){
                hasData=true;
        %>
            <tr>
                <td data-label="Photo">
  <div class="photo-box">
    <img class="photo"
         src="../uploads/owners/<%= rs.getString("photo") %>"
         onerror="this.onerror=null; this.src='../images/user.png';">
  </div>
</td>

                </td>
                <td data-label="ID"><%= rs.getInt("user_id") %></td>
                <td data-label="Full Name"><%= rs.getString("full_name") %></td>
                <td data-label="Username"><%= rs.getString("username") %></td>
                <td data-label="Address"><%= rs.getString("address") %></td>
                <td data-label="Age"><%= rs.getString("age") %></td>
                <td data-label="Phone"><%= rs.getString("phone") %></td>
                <td data-label="Action">
                    <div class="actions">
                        <a class="btn approve"
                           href="owner_action.jsp?action=approve&id=<%= rs.getInt("user_id") %>">
                           Approve
                        </a>
                        <a class="btn reject"
                           href="owner_action.jsp?action=reject&id=<%= rs.getInt("user_id") %>">
                           Reject
                        </a>
                    </div>
                </td>
            </tr>
        <%
            }
            if(!hasData){
        %>
            <tr>
                <td colspan="8" style="text-align:center;color:#666;">
                    No pending owner requests.
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

</body>
</html>
