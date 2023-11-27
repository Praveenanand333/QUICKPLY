<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>User Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 20px;
        }

        .user-info, .job-grid, .job-card {
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .job-card {
            margin: 20px;
            transition: transform 0.3s ease-in-out;
            display: block;
        }

        .job-card:hover {
            transform: scale(1.05);
        }

        .apply-button {
            margin-top: 10px;
        }

        .welcome-container {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
    </style>
         
</head>
<body>
    <div class="welcome-container">
        <h1>Hello, <%= (String)session.getAttribute("un") %>!</h1>
        <p>Welcome to your dashboard</p>
        <a href="index.jsp" class="btn btn-danger logout-button">Back To Login</a>
    </div>
    <%
        // Assuming you have user information in the session
        String un = (String) session.getAttribute("un");
        String ps = (String) session.getAttribute("ps");

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

            PreparedStatement pps = connection.prepareStatement("select roll from user_info where uname = '" + (String)session.getAttribute("un") + "';");
            ResultSet rs = pps.executeQuery();
            rs.next();
            String userRoll = rs.getString("roll");
            // SQL query to fetch jobs based on user eligibility
            String jobQuery = "SELECT * FROM offers WHERE " +
                    "min_cgpa <= (SELECT cgpa FROM user_info WHERE roll = ?) AND " +
                    "no_arrear >= (SELECT current_arrear FROM user_info WHERE roll = ?) AND " +
                    "year = (SELECT year FROM user_info WHERE roll = ?)";

            // Create a prepared statement
            try (PreparedStatement jobStatement = connection.prepareStatement(jobQuery)) {
                jobStatement.setString(1, userRoll);
                jobStatement.setString(2, userRoll);
                jobStatement.setString(3, userRoll);
                ResultSet jobResultSet = jobStatement.executeQuery();
                PreparedStatement ps2 = connection.prepareStatement("select * from applications where app_name = '"+(String)session.getAttribute("un")+"';");
                ResultSet copy = ps2.executeQuery();

                // Display user information
                String userQuery = "SELECT * FROM user_info WHERE roll = ?";
                try (PreparedStatement userStatement = connection.prepareStatement(userQuery)) {
                    userStatement.setString(1, userRoll);
                    ResultSet userResultSet = userStatement.executeQuery();
                    if (userResultSet.next()) {
                        %>
                        <div class='container user-info'>
                            <h2>User Information</h2>
                            <p><strong>Roll:</strong> <%= userResultSet.getString("roll") %></p>
                            <p><strong>Department:</strong> <%= userResultSet.getString("dept") %></p>
                            <p><strong>Year:</strong> <%= userResultSet.getString("year") %></p>
                            <p><strong>CGPA:</strong> <%= userResultSet.getString("cgpa") %></p>
                            <p><strong>Current Arrear:</strong> <%= userResultSet.getString("current_arrear") %></p>
                            <!-- You can add more details as needed -->
                        </div>
                        <%
                    }
                }

                // Display job details in grid format
                %>
                <div class='container job-grid'>
                    <%
                    out.println("<h2>Job Openings</h2>");
                    while (jobResultSet.next()) {
                        // Check if the user has already applied for this job
                        String checkApplicationQuery = "SELECT * FROM applications WHERE roll_no = ? AND company_name = ? AND role = ?";
                        try (PreparedStatement checkApplicationStatement = connection.prepareStatement(checkApplicationQuery)) {
                            checkApplicationStatement.setString(1, userRoll);
                            checkApplicationStatement.setString(2, jobResultSet.getString("company"));
                            checkApplicationStatement.setString(3, jobResultSet.getString("title"));
                            ResultSet checkApplicationResultSet = checkApplicationStatement.executeQuery();
                            boolean hasApplied = checkApplicationResultSet.next();
                            // If the user hasn't applied, display the job details and apply button
                            if (!hasApplied) {
                                %>
                                <div class='job-card'>
                                    <h4><strong><%= jobResultSet.getString("title") %></strong></h4>
                                    <p><strong>Type:</strong> <%= jobResultSet.getString("type") %></p>
                                    <p><strong>Company:</strong> <%= jobResultSet.getString("company") %></p>
                                    <p><strong>Renumeration:</strong> <%= jobResultSet.getString("renumeration") %></p>
                                    <p><strong>Admin:</strong> <%= jobResultSet.getString("admin") %></p>
                                    <form action='apply.jsp' method='post'>
                                        <input type='hidden' name='company' value='<%= jobResultSet.getString("company") %>'>
                                        <input type='hidden' name='title' value='<%= jobResultSet.getString("title") %>'>
                                        <input type='hidden' name='id' value='<%= jobResultSet.getString("id")%>'>
                                        <input type='hidden' name='uname' value='<%= (String)session.getAttribute("un") %>'>
                                        <button class='btn btn-primary apply-button' type='submit'>APPLY</button>
                                    </form>
                                </div>
                                <%
                            }
                        }
                    }

                    %>

                </div>

                <div class='container job-grid'>
                    <h2>Applied Jobs</h2>
                    <%
                    while (copy.next()) {
                                %>
                                <div class='job-card'>
                                    <h4><strong><%= copy.getString("role") %></strong></h4>
                                    <p><strong>Company:</strong> <%= copy.getString("company_name") %></p>
                                </div>
                                <%
                    }
                    %>
                </div>
                <%
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Redirect to an error page or display an error message
            // response.sendRedirect("error.jsp");
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

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    </body>
    </html>
