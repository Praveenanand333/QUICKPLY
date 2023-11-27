<%-- 
    Document   : signup
    Created on : 23-Nov-2023, 3:00:00 pm
    Author     : nish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Signup Page</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-image: url('https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
            background-position: center;
            background-attachment: fixed;
            background-color: rgba(248, 249, 250, 0.7); /* White color with 70% opacity */
            background-size: cover;
        }
        .card {
            margin-top: 70px;
            height: 80vh; /* Adjusted height */
            display: flex;
            flex-direction: column;
            gap: 10px;
            background-color: rgba(255, 255, 255, 0.9); /* White color with 90% opacity */
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
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title text-center">Signup for CUIC Quickply</h1>

                        <form action="process_signup.jsp" method="post">
                            <div class="form-group">
                                <label for="userType">Select User Type:</label>
                                <select class="form-control" id="userType" name="userType">
                                    <option value="admin">Admin</option>
                                    <option value="user">User</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>

                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="form-group" id="userDetails">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" id="name" name="name">
                            </div>

                            <!-- Add other user details fields as needed -->

                            <button type="submit" class="btn btn-primary btn-lg btn-block button">Signup</button>
                        </form>

                        <p class="text-center mt-3">Already have an account? <a class="link" href="index.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
