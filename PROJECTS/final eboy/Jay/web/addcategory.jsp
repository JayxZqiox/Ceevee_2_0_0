<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve form parameters
    String categoryName = request.getParameter("categoryName");

    // SQL query to insert new category
    String insertSql = "INSERT INTO categories (category_name) VALUES (?)";

    // Initialize the database connection and prepared statement
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the SQL insert query
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, categoryName);

        // Execute the insert query
        int rowsAffected = pstmt.executeUpdate();

        // Check if insertion was successful
        if (rowsAffected > 0) {
            // Redirect back to admincategory.jsp with success message
            response.sendRedirect("admincategory.jsp?addSuccess=true");
        } else {
            // Redirect back to admincategory.jsp with error message
            response.sendRedirect("admincategory.jsp?addSuccess=false");
        }

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Recipe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="app-library-container">
    <div class="grid-container">
        <!-- navigation -->
        <nav class="navigation">
            <div class="navigation-brand">
                <i class="fal fa-angle-left"></i>
                <span>ADMIN DASHBOARD</span>
                <button class="button">Recipes</button>
                <button class="button">Users</button>
            </div>
        </nav>

        <!-- app container -->
        <div class="app-info-box">
            <div class="app-info-content">
                <!-- headline -->
                <div class="headline">
                    <h2>Add New Food Category</h2>
                </div>

                <!-- form to add recipe -->
                <div class="form-container">
                    <h3>Add New Category</h3>
                    <form action="addcategory.jsp" method="post">
                        <label>Category Name:</label>
                        <input type="text" name="categoryName" required>
                        <button type="submit" class="button">Add Category</button>
                    </form>
                </div>
                </div>
                <!-- button controls -->
                <div class="button-controls" style="justify-content: space-between">
                    <button class="button red"><a href="admindashboard.jsp">Back</a></button>
                </div>
            </div>
    </div>
</div>
</body>
</html>
