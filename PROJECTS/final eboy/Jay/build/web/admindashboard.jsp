<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/userdatabase";
    String dbUser = "root";
    String dbPassword = "";

    // Initialize search query
    String searchQuery = request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "";

    // SQL query to fetch recipes and their authors from the database
    String fetchSql = "SELECT recipes.*, login.username FROM recipes JOIN login ON recipes.Id = login.id";
    if (!searchQuery.isEmpty()) {
        fetchSql += " WHERE recipes.name LIKE ? OR recipes.ingredients LIKE ? OR recipes.category LIKE ? OR login.username LIKE ?";
    }

    // Initialize the database connection and statement
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
        if (!searchQuery.isEmpty()) {
            String searchPattern = "%" + searchQuery + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            pstmt.setString(4, searchPattern);
        }

        // Execute the query to fetch recipes from the database
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Recipe Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        .button-controls {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease-in-out;
        }
        .button:hover {
            background-color: #555;
        }
        .recipe-image {
            width: 100px;
            height: auto;
            display: block;
            margin: 0 auto;
        }
        .searchbar1 {
            margin-top: 50px;
            display: flex;
            align-items: center;
        }
        .searchbar1 input[type="text"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px 0 0 5px;
        }
        .searchbar button {
            padding: 10px 20px;
            border-radius: 0 5px 5px 0;
            border: 1px solid #ddd;
            background-color: #333;
            color: #fff;
        }
        .searchbar button:hover {
            background-color: #555;
        }
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
                <a href="admindashboard.jsp"><button class="button">Recipes</button></a>
                <a href="adminuser.jsp"><button class="button">Users</button></a>
                <a href="admincategory.jsp"><button class="button">Category</button></a>
                <a href="login.jsp"><button class="button">Logout</button></a>
            </div>
        </nav>

        <!-- app container -->
        <div class="app-info-box">
            <div class="app-info-content">
                <!-- headline -->
                <div class="headline">
                    <h2>Food Recipes</h2>
                    <h3>Dashboard</h3>
                </div>

                <!-- searchbar -->
                <div class="searchbar1">
                    <form action="admindashboard.jsp" method="get">
                        <i class="search"></i>
                        <input type="text" name="searchQuery" placeholder="Search Recipe" value="<%= searchQuery %>">
                        <button type="submit" class="button">Search</button>
                    </form>
                </div>

                <!-- app library -->
                <section class="app-library">
                    <table>
                        <thead>
                            <tr>
                                <th>Recipe Name</th>
                                <th>Image</th>
                                <th>Ingredients</th>
                                <th>Instructions</th>
                                <th>Category</th>
                                <th>Rating</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while (rs.next()) { %>
                                <tr>
                                    <td><%= rs.getString("name") %><br/>By <%= rs.getString("username") %></td>
                                    <td><img src="<%= rs.getString("image") %>" class="recipe-image"></td>
                                    <td>
                                        <ul>
                                            <% 
                                                String ingredients = rs.getString("ingredients");
                                                for (String ingredient : ingredients.split("\\r?\\n")) {
                                                    out.println("<li>" + ingredient.trim() + "</li>");
                                                }
                                            %>
                                        </ul>
                                    </td>
                                    <td>
                                        <ol>
                                            <% 
                                                String instructions = rs.getString("instructions");
                                                for (String instruction : instructions.split("\\r?\\n")) {
                                                    out.println("<li>" + instruction.trim() + "</li>");
                                                }
                                            %>
                                        </ol>
                                    </td>
                                    <td><%= rs.getString("category") %></td>
                                    <td><%= rs.getString("rating") %></td>
                                    <td class="action-buttons">
                                        <form action="updateRecipe.jsp" method="post">
                                            <input type="hidden" name="recipeId" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="button">Update</button>
                                        </form>
                                        <form action="deleteRecipe.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this recipe?');">
                                            <input type="hidden" name="recipeId" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="button red">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
    }
  catch (Exception e) {
        // Handle any errors
        e.printStackTrace();
        out.println("<script>alert('Failed to fetch recipes. Please try again.');</script>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        // Close the database resources
}%>
