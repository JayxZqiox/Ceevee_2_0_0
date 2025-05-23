<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Retrieve selected category from request parameters
        String selectedCategory = request.getParameter("category");

        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Construct SQL query based on selected category
        String sql = "SELECT r.id, r.name, r.image, r.rating, u.username as author " +
                     "FROM recipes r " +
                     "INNER JOIN login u ON r.author = u.id " +
                     "INNER JOIN categories c ON r.category = c.id " +
                     "WHERE 1=1 ";

        // Check if category filter is selected
        if (selectedCategory != null && !selectedCategory.isEmpty()) {
            // Add condition to filter by category
            sql += "AND c.id = ? ";
        }

        // Prepare the SQL statement
        pstmt = conn.prepareStatement(sql);
        int parameterIndex = 1; // Index for parameters in PreparedStatement

        // If category filter is selected, set the category parameter
        if (selectedCategory != null && !selectedCategory.isEmpty()) {
            pstmt.setInt(parameterIndex++, Integer.parseInt(selectedCategory));
        }

        rs = pstmt.executeQuery();

        StringBuilder recipeListHTML = new StringBuilder();
        while (rs.next()) {
            // Generate HTML markup for each recipe
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String image = rs.getString("image");
            String author = rs.getString("author");
            float rating = rs.getFloat("rating");
            recipeListHTML.append("<div class=\"meal\">");
            recipeListHTML.append("<img src=\"" + image + "\" alt=\"" + name + "\">");
            recipeListHTML.append("<div class=\"desc\">");
            recipeListHTML.append("<h4>" + name + "</h4>");
            recipeListHTML.append("<p>By: " + author + "</p>");
            recipeListHTML.append("<p>Rating: " + rating + "</p>");
            recipeListHTML.append("<a href=\"mealDetails.jsp?id=" + id + "\">");
            recipeListHTML.append("<button type=\"button\">View Recipe</button>");
            recipeListHTML.append("</a>");
            recipeListHTML.append("</div></div>");
        }

        out.println(recipeListHTML.toString());

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
