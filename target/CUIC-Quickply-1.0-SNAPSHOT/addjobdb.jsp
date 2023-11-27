<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add Jobs</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    // Retrieve form parameters
    String type = request.getParameter("type");
    String company = request.getParameter("company");
    String title = request.getParameter("title");
    String renumeration = request.getParameter("renumeration");
    String no_arrear = request.getParameter("no_arrear");
    String min_cgpa = request.getParameter("min_cgpa");
    String year = request.getParameter("year");
    String admin = (String)session.getAttribute("un");
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

        // SQL query to insert data into the offers table
        String sql = "INSERT INTO offers (type, company, title, renumeration, no_arrear, min_cgpa, year, admin) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        // Create a prepared statement
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, type);
            preparedStatement.setString(2, company);
            preparedStatement.setString(3, title);
            preparedStatement.setString(4, renumeration);
            preparedStatement.setString(5, no_arrear);
            preparedStatement.setString(6, min_cgpa);
            preparedStatement.setString(7, year);
            preparedStatement.setString(8, admin);

            // Execute the query
            preparedStatement.executeUpdate();
        }

        // Redirect to a success page or display a success message

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Redirect to an error page or display an error message
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

<div class="container mt-5">
    <div class="alert alert-success" role="alert">
        <h4 class="alert-heading">Job added successfully!</h4>
        <p>Redirecting to the admin page...</p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script>
    // Automatically redirect to admin page after 2 seconds
    setTimeout(function(){
        window.location.href = "admindash.jsp";
    }, 2000);
</script>

<a href="admindash.jsp">GO</a>
<!-- Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</body>
</html>
