<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Download Resume</title>
</head>
<body>

<%
    // Retrieve roll number from the request
    String roll = request.getParameter("roll");

    // Database connection parameters
    String url = "jdbc:postgresql://localhost:5432/postgres";
    String username = "your_username";
    String password = "your_password";

    Connection connection = null;
    InputStream resumeInputStream = null;

    try {
        // Load the JDBC driver
        Class.forName("org.postgresql.Driver");

        // Establish a connection
        connection = DriverManager.getConnection(url, username, password);

        // SQL query to fetch resume from user_info table based on roll number
        String resumeQuery = "SELECT resume FROM user_info WHERE roll = ?";
        try (PreparedStatement resumeStatement = connection.prepareStatement(resumeQuery)) {
            resumeStatement.setString(1, roll);

            // Execute the query
            ResultSet resumeResultSet = resumeStatement.executeQuery();

            if (resumeResultSet.next()) {
                // Get the resume data as InputStream
                resumeInputStream = resumeResultSet.getBinaryStream("resume");

                // Set the content type and headers for the download
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"resume_" + roll + ".pdf\"");

                // Copy the resume data to the response output stream
                int bytesRead;
                byte[] buffer = new byte[4096];
                while ((bytesRead = resumeInputStream.read(buffer)) != -1) {
                    response.getOutputStream().write(buffer, 0, bytesRead);
                }
            } else {
%>
                <h2>Resume not found for Roll No: <%= roll %></h2>
<%
            }
        }
    } catch (ClassNotFoundException | SQLException | IOException e) {
        e.printStackTrace();
        // Handle exceptions, e.g., redirect to an error page
    } finally {
        // Close the InputStream in the finally block to ensure it always happens
        if (resumeInputStream != null) {
            try {
                resumeInputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

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
