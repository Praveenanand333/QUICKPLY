<%-- 
    Document   : index
    Created on : 22-Nov-2023, 6:33:09 pm
    Author     : nish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Login Page</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-image: url('https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
            background-position: center;
            background-attachment: fixed;
            background-color: rgba(248, 249, 250, 0.7); /* White color with 70% opacity */
            background-size: cover;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            width: 400px;
            background-color: rgba(255, 255, 255, 0.8); /* White color with 80% opacity */
            padding: 20px; /* Added padding for better appearance */
            border-radius: 10px; /* Added border radius for rounded corners */
        }
        .button {
            font-size: 16px;
        }
        .link {
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1 class="card-title text-center">Login to CUIC Quickply</h1>
        <form action="userchk.jsp" method="POST">
            <div class="form-group">
                <label for="usern">Username</label>
                <input type="text" class="form-control" id="usern" name="usern">
            </div>
            <div class="form-group">
                <label for="pass">Password</label>
                <input type="password" class="form-control" id="pass" name="pass">
            </div>
            <button type="submit" class="btn btn-success btn-lg btn-block button">Login</button>
        </form>
        <p class="text-center mt-3">Don't have an account? <a class="link" href="signup.jsp">Sign Up</a></p>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
