<%@page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Favorite</title>
</head>
<body>
<%
    String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
    String username = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Get recipe ID from request parameters
        String recipeIdStr = request.getParameter("id");
        int recipeId = Integer.parseInt(recipeIdStr);

        // Get user ID from cookie
        Cookie[] cookies = request.getCookies();
        int userId = -1;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userId")) {
                    userId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        // If user ID is found, proceed to delete the favorite recipe
        if (userId != -1) {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(databaseUrl, username, password);

            // Delete favorite recipe from the database
            String deleteQuery = "DELETE FROM favorites WHERE user_id = ? AND recipe_id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, userId);
            stmt.setInt(2, recipeId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>alert('Recipe removed from favorites successfully.');</script>");
            } else {
                out.println("<script>alert('Failed to remove recipe from favorites.');</script>");
            }
        } else {
            // Handle case where user is not logged in
            out.println("<script>alert('User session not found. Please login to delete favorite recipes.');</script>");
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred while removing the recipe from favorites.');</script>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Redirect back to the favorites page after deletion
    response.sendRedirect("favorites.jsp");
%>
</body>
</html>
