    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Retrieve recipe ID from request parameter
    int recipeId = Integer.parseInt(request.getParameter("recipeId"));

    // SQL query to fetch recipe details by ID
    String fetchSql = "SELECT * FROM recipes WHERE id = ?";

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
        pstmt.setInt(1, recipeId);

        // Execute the query to fetch the recipe details
        rs = pstmt.executeQuery();

        // Check if recipe exists
        if (rs.next()) {
            // Retrieve recipe details
            String name = rs.getString("name");
            String image = rs.getString("image");
            String ingredients = rs.getString("ingredients");
            String instructions = rs.getString("instructions");
            int category = rs.getInt("category");
            String rating = rs.getString("rating");

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
                    <h2>Update Recipe</h2>
                    <h3>Edit details for <%= name %></h3>
                </div>

                <!-- update form -->
                <div class="form-container">
                    <form action="updateRecipeAction.jsp" method="post">
                        <input type="hidden" name="recipeId" value="<%= recipeId %>">
                        <label>Recipe Name:</label>
                        <input type="text" name="name" value="<%= name %>" required><br><br>
                        <label>Image URL:</label>
                        <input type="text" name="image" value="<%= image %>" required><br><br>
                        <label>Ingredients:</label><br>
                        <textarea name="ingredients" rows="4" required><%= ingredients %></textarea><br><br>
                        <label>Instructions:</label><br>
                        <textarea name="instructions" rows="4" required><%= instructions %></textarea><br><br>
                        <label>Category:</label>
                        <select name="category" required>
                        <% 
                        conn = null;
                        pstmt = null;
                        rs = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection(url, dbUser, dbPassword);
                            String fetchCategoriesSql = "SELECT * FROM categories";
                            pstmt = conn.prepareStatement(fetchCategoriesSql);
                            rs = pstmt.executeQuery();
                            while (rs.next()) { %>
                        <option value="<%= rs.getInt("id") %>" <%= (rs.getInt("id") == category) ? "selected" : "" %>><%= rs.getString("category_name") %></option>
                        <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println(e.getMessage());
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                        </select><br><br>
                        <label>Rating:</label>
                        <input type="text" name="rating" value="<%= rating %>" required><br><br>
                        <button type="submit" class="button">Update Recipe</button>
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
