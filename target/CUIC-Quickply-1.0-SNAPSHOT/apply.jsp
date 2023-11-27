<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 20px;
            margin-top: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #007bff;
        }

        p {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <%
        // Retrieve values from the form
        String uname = request.getParameter("uname");

        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5432/postgres";
        String username = "cuic";
        String password = "1234";

        Connection connection = null;
        try {
            // Load the JDBC driver
            Class.forName("org.postgresql.Driver");

            // Establish a connection
            connection = DriverManager.getConnection(url, username, password);

            // Get the roll from user_info table based on uname
            String rollQuery = "SELECT roll FROM user_info WHERE uname = ?";
            try (PreparedStatement rollStatement = connection.prepareStatement(rollQuery)) {
                rollStatement.setString(1, uname);

                ResultSet rollResultSet = rollStatement.executeQuery();
                if (rollResultSet.next()) {
                    String roll = rollResultSet.getString("roll");

                    // Retrieve other values from the form
                    String company = request.getParameter("company");
                    String title = request.getParameter("title");
                    String id = request.getParameter("id");
                    // Insert application details into the applications table
                    String insertQuery = "INSERT INTO applications VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                        insertStatement.setString(1, uname);
                        insertStatement.setString(2, roll);
                        insertStatement.setString(3, company);
                        insertStatement.setString(4, title);
                        insertStatement.setString(5, id);
                        // Execute the insert query
                        int rowsAffected = insertStatement.executeUpdate();
                        if (rowsAffected > 0) {
    %>
                            <h2>Application Submitted Successfully</h2>
                            <p>Company: <%= company %></p>
                            <p>Title: <%= title %></p>
                            <p>Name: <%= uname %></p>
                            <p>Roll: <%= roll %></p>
    <%
                        } else {
    %>
                            <h2>Error Submitting Application</h2>
    <%
                        }
                    }
                } else {
    %>
                    <h2>Error: User Roll not found</h2>
                    <p>Name: <%= uname %></p>
    <%
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions, e.g., redirect to an error page
        } finally {
            // Close the connection in the finally block to ensure it always happens
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</div>

<!-- JavaScript redirect to userdash.jsp after 2 seconds -->
<script>
    setTimeout(function(){
        window.location.href = "userdash.jsp";
    }, 2000);
</script>

<!-- Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</body>
</html>
