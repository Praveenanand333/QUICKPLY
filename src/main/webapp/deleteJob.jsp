<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Job</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> <!-- Include jQuery here -->
    <style>
        body {
            padding: 20px;
        }
    </style>
</head>
<body>
<script>
        setTimeout(function(){
            window.location.href = 'deletePostings.jsp';
        }, 3000);
</script>
<%
    // JDBC connection parameters
    String jdbcUrl = "jdbc:postgresql://localhost:5432/postgres";
    String dbUser = "cuic";
    String dbPassword = "1234";

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the JDBC driver
        Class.forName("org.postgresql.Driver");

        // Establish a connection
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Retrieve jobId from the cookie
        Cookie[] cookies = request.getCookies();
        String jobId = (String)request.getParameter("job");
        if (jobId != null) {
            // Delete the job record based on jobId
            String deleteQuery = "DELETE FROM offers WHERE id = ?";
            preparedStatement = connection.prepareStatement(deleteQuery);
            preparedStatement.setInt(1, Integer.parseInt(jobId));
            preparedStatement.executeUpdate();
%>
            <div class="alert alert-success" role="alert">
                Job with ID <%= jobId %> deleted successfully.
            </div>
<%
        } else {
            // Handle the case where jobId is not found in the cookie
%>
            <div class="alert alert-danger" role="alert">
                Error: Job ID not found.
            </div>
<%
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle the exception
    } finally {
        // Close resources in the finally block to ensure they always happen
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</body>
</html>
    