<%@ page import="java.sql.*,java.io.*,java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // JDBC connection parameters
    String jdbcUrl = "jdbc:postgresql://localhost:5432/postgres";
    String dbUser = "cuic";
    String dbPassword = "1234";

    // Fetching data from the database
    try {
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        String roll = request.getParameter("roll");// Replace with your parameter name
        String sql = "SELECT resume FROM user_info WHERE roll=?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, roll);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Get the binary data
            byte[] resumeBytes = resultSet.getBytes("resume");

            // Convert binary data to a file
            String fileName = "resume_file.pdf"; // You can set the filename as needed
            File file = new File(fileName);
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(resumeBytes);
            fos.close();

            // Set response headers for file download
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            // Write the file to the response output stream
            FileInputStream fis = new FileInputStream(file);
            OutputStream ot = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                ot.write(buffer, 0, bytesRead);
            }
            ot.flush();
            ot.close();

            // Delete the temporary file
            file.delete();
        } else {
            out.println("Resume not found for roll number: " + roll);
        }

        // Close resources
        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>
