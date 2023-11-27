<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information Form</title>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
            background-position: center;
            background-attachment: fixed;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .card {
            width: 800px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(255,255,255,0.8);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="card">
        <h2 class="text-center mb-4">Hello <%=(String)session.getAttribute("un")%><br><small>Enter the mandatory information to continue</small></h2>
        <form action="updateinfo" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="roll">Roll:</label>
                <input type="text" class="form-control" id="roll" name="roll" required>
            </div>
            <div class="form-group">
                <label for="dept">Department:</label>
                <input type="text" class="form-control" id="dept" name="dept" required>
            </div>
            <div class="form-group">
                <label for="year">Year:</label>
                <input type="number" class="form-control" id="year" name="year" required>
            </div>
            <div class="form-group">
                <label for="cgpa">CGPA:</label>
                <input type="number" class="form-control" id="cgpa" name="cgpa" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="current_arrear">Current Arrear:</label>
                <input type="number" class="form-control" id="current_arrear" name="current_arrear" required>
            </div>
            <div class="form-group">
                <label for="resume">Resume (PDF):</label>
                <input type="file" class="form-control-file" id="resume" name="resume" accept=".pdf" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
