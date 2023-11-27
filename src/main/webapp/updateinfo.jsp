<%@ page language="java"%>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page contentType="multipart/form-data"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Processing User Information</title>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .card {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="card">
        <h2 class="text-center mb-4">Processing User Information</h2>

        <% 
            try {
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "cuic", "1234");

                String roll = request.getParameter("roll");
                String dept = request.getParameter("dept");
                String year = request.getParameter("year");
                String cgpa = request.getParameter("cgpa");
                String currentArrear = request.getParameter("current_arrear");

                // Process the file upload
                Part filePart = request.getPart("resume");
                InputStream resumeInputStream = filePart.getInputStream();

                // Insert data into the database
                String sql = "INSERT INTO user_info (roll, dept, year, cgpa, current_arrear, resume) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement preparedStatement = con.prepareStatement(sql);
                preparedStatement.setString(1, roll);
                preparedStatement.setString(2, dept);
                preparedStatement.setString(3, year);
                preparedStatement.setString(4, cgpa);
                preparedStatement.setString(5, currentArrear);
                preparedStatement.setBlob(6, resumeInputStream);
                preparedStatement.executeUpdate();

                out.println("<p class='text-success text-center'>User information successfully inserted into the database!</p>");

                // Close resources
                preparedStatement.close();
                con.close();
            } catch(Exception e) {
                out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
         %>

        <p class="text-center mt-3"><a href="index.jsp">Back to Home</a></p>
    </div>

    <!-- Bootstrap JS and Popper.js CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
