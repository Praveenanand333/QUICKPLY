<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Postings</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> <!-- Include jQuery here -->
    <style>
        body {
            padding: 20px;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        button {
            margin: 0;
        }
    </style>
</head>
<body>

<%
    // JDBC connection parameters
    String jdbcUrl = "jdbc:postgresql://localhost:5432/postgres";
    String dbUser = "cuic";
    String dbPassword = "1234";

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Load the JDBC driver
        Class.forName("org.postgresql.Driver");

        // Establish a connection
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Retrieve job openings from the offers table
        String query = "SELECT * FROM offers where admin = '" + (String)session.getAttribute("un") + "';";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(query);
%>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Company</th>
                    <th>Title</th>
                    <th>Renumeration</th>
                    <th>No Arrear</th>
                    <th>Min CGPA</th>
                    <th>Year</th>
                    <th>Admin</th>
                    <th>Id</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
<%
        while (resultSet.next()) {
%>
                <tr>
                    <td><%= resultSet.getString("type") %></td>
                    <td><%= resultSet.getString("company") %></td>
                    <td><%= resultSet.getString("title") %></td>
                    <td><%= resultSet.getString("renumeration") %></td>
                    <td><%= resultSet.getString("no_arrear") %></td>
                    <td><%= resultSet.getString("min_cgpa") %></td>
                    <td><%= resultSet.getString("year") %></td>
                    <td><%= resultSet.getString("admin") %></td>
                    <td><%= resultSet.getString("id") %></td>
                    <td>
                        <form action="deleteJob.jsp" method="post">
                            <input type="hidden" value="<%= resultSet.getString("id") %>" name="job"/>
                            <button action="submit">Delete</button>
                        </form>
                    </td>
                </tr>
<%
        }
%>
            </tbody>
        </table>
<%
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources in the finally block to ensure they always happen
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
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

<script>
    function deleteJob(jobId) {
        document.cookie = "jobId=" + jobId;
        // Redirect to deleteJob.jsp
        window.location.href = "deleteJob.jsp";
    }
</script>
</body>
</html>
