<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";
    String insertSql = "INSERT INTO recipes (name, image, ingredients, category, rating, instructions, author) VALUES ( ?, ?, ?, ?, ?, ?, ?)";

    if (request.getParameter("addRecipeBtn") != null) {
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String ingredients = request.getParameter("ingredients");
        int categoryId = Integer.parseInt(request.getParameter("category")); // Ensure category_id is parsed as integer
        String rating = request.getParameter("rating");
        String instructions = request.getParameter("instructions");
        
        // Retrieve userId from cookies
        int userId = -1; // Default user ID, initialized to -1
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userId")) {
                    userId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, name);
            pstmt.setString(2, image);
            pstmt.setString(3, ingredients);
            pstmt.setInt(4, categoryId); // Set category_id
            pstmt.setFloat(5, Float.parseFloat(rating));
            pstmt.setString(6, instructions);
            pstmt.setInt(7, userId); // Set author_id
            pstmt.executeUpdate();
            response.sendRedirect("home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println(e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
<!--        <nav class="navigation">
            <div class="navigation-brand">
                <i class="fal fa-angle-left"></i>
                <span>ADMIN DASHBOARD</span>
                <button class="button">Recipes</button>
                <button class="button">Users</button>
            </div>
        </nav>-->

        <!-- app container -->
        <div class="app-info-box">
            <div class="app-info-content">
                <!-- headline -->
                <div class="headline">
                    <h2>Add New Recipe</h2>
                </div>

                <!-- form to add recipe -->
                <div class="form-container">
                    <h2>Add New Recipe</h2>
                    <form method="post" action="addrecipe.jsp">
                        <!-- Form inputs for recipe details -->
                        <label for="name">Recipe Name:</label>
                        <input type="text" id="name" name="name" required><br><br>

                        <label for="image">Image:</label>
                        <input type="text" id="image" name="image" required><br><br>

                        

                        <label for="ingredients">Ingredients:</label>
                        <textarea id="ingredients" name="ingredients" rows="4" cols="50" required></textarea><br><br>

                        <label for="instructions">Instructions:</label>
                        <textarea id="instructions" name="instructions" rows="4" cols="50" required></textarea><br><br>
                        
                        <label for="category">Category:</label>
                        <select id="category" name="category" required>
                            <option value="">Select Category</option>
                            <% 
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                                    String fetchCategoriesSql = "SELECT * FROM categories";
                                    pstmt = conn.prepareStatement(fetchCategoriesSql);
                                    rs = pstmt.executeQuery();
                                    
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("id") %>"><%= rs.getString("category_name") %></option>
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

                        <label for="rating">Rating:</label>
                        <input type="text" id="rating" name="rating" required><br><br>

                        <button type="submit" name="addRecipeBtn">Add Recipe</button>
                    </form>
                </div>

                <!-- button controls -->
                <div class="button-controls" style="justify-content: space-between">
                    <button class="button red"><a href="home.jsp">Back</a></button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
