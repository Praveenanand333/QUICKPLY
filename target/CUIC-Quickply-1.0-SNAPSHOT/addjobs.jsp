<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<div class="container mt-5">
    <h2>Add Jobs</h2>
    <p>Your admin information will be inserted automatically</p>
    <form action="addjobdb.jsp" method="post">
        <div class="form-group">
            <label for="type">Job Type:</label>
            <input type="text" class="form-control" id="type" name="type" required>
        </div>

        <div class="form-group">
            <label for="company">Company:</label>
            <input type="text" class="form-control" id="company" name="company" required>
        </div>

        <div class="form-group">
            <label for="title">Job Title:</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

        <div class="form-group">
            <label for="renumeration">Renumeration:</label>
            <input type="text" class="form-control" id="renumeration" name="renumeration" required>
        </div>

        <div class="form-group">
            <label for="no_arrear">No. of Arrears Allowed:</label>
            <input type="text" class="form-control" id="no_arrear" name="no_arrear" required>
        </div>

        <div class="form-group">
            <label for="min_cgpa">Minimum CGPA:</label>
            <input type="text" class="form-control" id="min_cgpa" name="min_cgpa" required>
        </div>

        <div class="form-group">
            <label for="year">Year:</label>
            <input type="text" class="form-control" id="year" name="year" required>
        </div>

        <!-- Hidden input for admin (You might want to get this value from the session or elsewhere) -->
        <button type="submit" class="btn btn-primary">Add Job</button>
        <br><!-- comment -->
        <br>
    </form>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</body>
</html>
