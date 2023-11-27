<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Applicant Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 20px;
        }

        h2 {
            color: #007bff;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        .print-button {
            margin-top: 20px;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .print-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
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

        // SQL query to fetch applicant details
        String applicantQuery = "SELECT * FROM applications";

        // Create a prepared statement
        try (PreparedStatement applicantStatement = connection.prepareStatement(applicantQuery)) {

            // Execute the query
            ResultSet applicantResultSet = applicantStatement.executeQuery();
%>
            <h2>Applicant Details</h2>
            <table id="applicantTable">
                <tr>
                    <th>Name</th>
                    <th>Roll No</th>
                    <th>Company Name</th>
                    <th>Role</th>
                    <th>Department</th>
                    <th>Year</th>
                    <th>CGPA</th>
                    <th>Current Arrear</th>
                    <th>Resume</th>
                </tr>
<%
            // Iterate through the results
            while (applicantResultSet.next()) {
                String rollNo = applicantResultSet.getString("roll_no");

                // Fetch details from user_info table based on roll_no
                String userQuery = "SELECT * FROM user_info WHERE roll = ?";
                try (PreparedStatement userStatement = connection.prepareStatement(userQuery)) {
                    userStatement.setString(1, rollNo);
                    ResultSet userResultSet = userStatement.executeQuery();

                    if (userResultSet.next()) {
%>
                        <tr>
                            <td><%= userResultSet.getString("uname") %></td>
                            <td><%= userResultSet.getString("roll") %></td>
                            <td><%= applicantResultSet.getString("company_name") %></td>
                            <td><%= applicantResultSet.getString("role") %></td>
                            <td><%= userResultSet.getString("dept") %></td>
                            <td><%= userResultSet.getString("year") %></td>
                            <td><%= userResultSet.getString("cgpa") %></td>
                            <td><%= userResultSet.getString("current_arrear") %></td>
                            <td>
                                <form action="textdown.jsp" method="post">
                                    <input type="hidden" name="roll" value="<%= userResultSet.getString("roll") %>">
                                    <button type="submit">Download Resume</button>
                                </form>
                            </td>
                        </tr>
<%
                    }
                }
            }
%>
            </table>

            <button class="print-button" onclick="window.print()">Print</button>
<%
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

</body>
</html>
