<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PROCESSING SIGNUP</title>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            margin-top:30vh;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #007bff;
        }
    </style>
    <script>
        setTimeout(function(){
            window.location.href = 'index.jsp';
        }, 3000);
    </script>
</head>
<body>
    <div class="container">
        <% 
            try {
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "cuic", "1234");
                String type = request.getParameter("userType");
                String name = request.getParameter("name");
                String pass = request.getParameter("password");
                String usern = request.getParameter("username");
                String info = "NO";
                PreparedStatement ps = con.prepareStatement("insert into users values(?,?,?,?,?);");
                ps.setString(1, name);
                ps.setString(2, usern);
                ps.setString(3, pass);
                ps.setString(4, type);
                ps.setString(5, info);
                ps.executeUpdate();
                out.println("<h1 class='text-center mb-4'>Your signup is complete</h1>");
            } catch(Exception e) {
                e.printStackTrace();
            }
         %>
        <p class="text-center">Redirecting to the login page...</p>
    </div>

    <!-- Bootstrap JS and Popper.js CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
