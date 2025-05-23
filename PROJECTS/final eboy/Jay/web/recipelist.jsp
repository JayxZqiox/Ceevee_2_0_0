<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Recipe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #87ceeb;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #87ceeb;
            color: black;
            text-align: center;
            padding: 1em 0;
            position: relative;
        }

        header h1 {
            font-size: 2.5em;
            margin: 0.5em 0;
        }

        nav {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            gap: 20px;
        }

        nav a {
            color: black;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.2em;
        }

        nav a:hover {
            text-decoration: underline;
        }

        main {
            padding: 2em;
        }

        #recipe-list {
            margin-bottom: 2em;
        }

        .recipe {
            display: flex;
            margin-bottom: 1em;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 1em;
            position: relative;
        }

        .recipe-img {
            width: 150px;
            height: auto;
            margin-right: 1em;
            border-radius: 5px;
        }

        .recipe-content h3 {
            margin-top: 0;
        }

        .recipe-actions {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .recipe-actions button {
            background-color: #6b8e23;
            color: white;
            border: none;
            padding: 0.5em;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 0.5em;
        }

        .recipe-actions button:hover {
            background-color: #556b2f;
        }

        #add-recipe-form {
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 2em;
        }

        #add-recipe-form label {
            display: block;
            margin-bottom: 0.5em;
        }

        #add-recipe-form input[type="text"],
        #add-recipe-form textarea,
        #add-recipe-form input[type="file"] {
            width: 100%;
            padding: 0.5em;
            margin-bottom: 1em;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        #add-recipe-form button {
            background-color: #6b8e23;
            color: white;
            border: none;
            padding: 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        #add-recipe-form button:hover {
            background-color: #556b2f;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <a href="signup.jsp">Create Account</a>
            <a href="addrecipe.jsp">Add Recipes</a>
            <a href="profile.jsp">Profile</a>
        </nav>
    </header>
    <main>
        <section id="recipe-list">
            <h2>Recipes</h2>
            <%
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/userdatabase";
                String dbUser = "root";
                String dbPassword = "";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Establish the database connection
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // SQL query to retrieve all recipes
                    String selectSql = "SELECT * FROM recipes";
                    pstmt = conn.prepareStatement(selectSql);
                    rs = pstmt.executeQuery();

                    // Loop through the result set and display each recipe
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String ingredients = rs.getString("ingredients");
                        String instructions = rs.getString("instructions");
                        String image = rs.getString("image");
            %>
            <div class="recipe">
                <img src="uploads/<%= image %>" alt="<%= name %>" class="recipe-img">
                <div class="recipe-content">
                    <h3><%= name %></h3>
                    <p><strong>Ingredients:</strong> <%= ingredients %></p>
                    <p><strong>Instructions:</strong> <%= instructions %></p>
                </div>
                <div class="recipe-actions">
                    <button onclick="editRecipe('<%= rs.getInt("id") %>')">Edit</button>
                    <button onclick="deleteRecipe('<%= rs.getInt("id") %>')">Delete</button>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
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
        </section>
    </main>
    <script>
        function editRecipe(id) {
            // Redirect to edit recipe page with recipe ID
            window.location.href = `editRecipe.jsp?id=${id}`;
        }

        function deleteRecipe(id) {
            if (confirm('Are you sure you want to delete this recipe?')) {
                // Redirect to delete recipe servlet with recipe ID
                window.location.href = `deleteRecipe.jsp?id=${id}`;
            }
        }
    </script>
</body>
</html>
