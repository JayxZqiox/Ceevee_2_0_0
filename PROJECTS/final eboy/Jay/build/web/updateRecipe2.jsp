<%@page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Recipe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #5cb85c;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Update Recipe</h2>
    <%
        int recipeId = Integer.parseInt(request.getParameter("id"));
        String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
        String username = "root";
        String password = "";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(databaseUrl, username, password);

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Handle form submission
                String newName = request.getParameter("name");
                String newImage = request.getParameter("image");
                                String newIngredients = request.getParameter("ingredients");
                                String newInstructions = request.getParameter("instructions");

                float newRating = Float.parseFloat(request.getParameter("rating"));

                String updateQuery = "UPDATE recipes SET name = ?, image = ?,ingredients= ?,Instructions = ?, rating = ? WHERE id = ?";
                stmt = conn.prepareStatement(updateQuery);
                stmt.setString(1, newName);
                stmt.setString(2, newImage);
                stmt.setString(3, newIngredients);
                stmt.setString(4, newInstructions);
                stmt.setFloat(5, newRating);
                stmt.setInt(6, recipeId);

                stmt.executeUpdate();
                response.sendRedirect("profile.jsp");
            } else {
                // Display the form with current recipe details
                String recipeQuery = "SELECT name, image,instructions,ingredients, rating,category FROM recipes WHERE id = ?";
                stmt = conn.prepareStatement(recipeQuery);
                stmt.setInt(1, recipeId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String recipeName = rs.getString("name");
                    String recipeImage = rs.getString("image");
                    String recipeIngredients =rs.getString("ingredients");
                     String recipeInstructions = rs.getString("instructions");
                    float recipeRating = rs.getFloat("rating");
    %>
    <form method="post">
        <div class="form-group">
            <label for="name">Recipe Name:</label>
            <input type="text" id="name" name="name" value="<%= recipeName %>">
        </div>
        <div class="form-group">
            <label for="image">Recipe Image URL:</label>
            <input type="text" id="image" name="image" value="<%= recipeImage %>">
        </div>
        <div class="form-group">
            <label for="ingredients">Recipe Ingredients:</label>
            <input type="text" id="ingredients" name="ingredients" value="<%= recipeIngredients %>">
        </div>
        <div class="form-group">
            <label for="instructions">Recipe Instructions</label>
            <input type="text" id="instructions" name="instructions" value="<%= recipeInstructions %>">
        </div>
        <div class="form-group">
            <label for="rating">Recipe Rating:</label>
            <input type="text" id="rating" name="rating" value="<%= recipeRating %>">
        </div>
        <div class="form-group">
            <button type="submit">Update Recipe</button>
        </div>
    </form>
    <%
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println(e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</div>
</body>
</html>
