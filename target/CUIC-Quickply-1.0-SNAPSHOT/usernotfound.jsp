<%-- 
    Document   : usernotfound.jsp
    Created on : 26-Nov-2023, 12:32:39 am
    Author     : nish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Not Found</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f8f9fa;
            margin: 0;
        }
        .card {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .link {
            margin-top: 10px;
            display: block;
            text-align: center;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1 class="text-center mb-4">User Not Found</h1>
        <p class="text-center">The user you are looking for does not exist.</p>
        
        <a class="link" href="index.jsp">Login to existing account</a>
        <a class="link" href="signup.jsp">Create a new account</a>
    </div>

    <!-- Bootstrap JS and Popper.js CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
