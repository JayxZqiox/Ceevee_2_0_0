<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve category ID from request parameter
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    // SQL query to fetch category details by ID
    String fetchSql = "SELECT * FROM categories WHERE id = ?";

    // Initialize the database connection, prepared statement, and result set
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create a prepared statement to execute the SQL query
        pstmt = conn.prepareStatement(fetchSql);
        pstmt.setInt(1, categoryId);

        // Execute the query to fetch the category details
        rs = pstmt.executeQuery();

        // Check if category exists
        if (rs.next()) {
            // Retrieve category details
            String categoryName = rs.getString("category_name");

            // Display the update form with pre-filled values
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Recipe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        /* Add your custom styles for update form */
    </style>
</head>
<body>
<div class="app-library-container">
    <div class="grid-container">
        <!-- navigation -->
        <nav class="navigation">
            <div class="navigation-brand">
                <i class="fal fa-angle-left"></i>
                <span>ADMIN DASHBOARD</span>
                <button class="button"><a href="admindashboard.jsp">Recipes</a></button>
                <button class="button"><a href="adminuser.jsp">Users</a></button>
                <button class="button"><a href="admincategory.jsp">Category</a></button>
            </div>
        </nav>

        <!-- app container -->
        <div class="app-info-box">
            <div class="app-info-content">
                <!-- headline -->
                <div class="headline">
                    <h2>Update Category</h2>
                    <h3>Edit details for <%= categoryName %></h3>
                </div>

                <!-- update form -->
                <div class="form-container">
                    <form action="updateCategoryAction.jsp" method="post">
                        <input type="hidden" name="categoryId" value="<%= categoryId %>">
                        <label>Category name:</label>
                        <input type="text" name="category_name" value="<%= categoryName %>" required><br><br>
                        <button type="submit" class="button">Update Category</button>
                    </form>
                </div>

                <!-- button controls -->
                <div class="button-controls">
                    <form action="login.jsp">
                        <button class="button red">Logout</button>
                    </form>
                    <form action="admindashboard.jsp">
                        <button class="button">Back to Dashboard</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
        } else {
            // Recipe not found
            out.println("<script>alert('Recipe not found.');</script>");
        }

    } catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to fetch recipe details. Please try again.');</script>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        // Close the database resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
