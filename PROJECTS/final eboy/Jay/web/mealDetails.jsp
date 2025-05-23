<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Details</title>
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F3F0D7;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
        }
        .meal-details {
            display: flex;
            flex-direction: column;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 30px;
        }
        .meal-details img {
            width: 100%;
            max-width: 300px;
            height: auto;
            display: block;
            padding-top: 10px;
            margin: 0 auto;
        }
        .meal-info {
            padding: 20px;
        }
        .meal-info h2 {
            color: #F29191;
            margin: 0;
            font-size: 24px;
        }
        .meal-info p {
            color: #333;
            line-height: 1.6;
            margin: 10px 0;
        }
        .meal-info .rating {
            margin: 20px 0;
        }
        .meal-info .rating span {
            color: #F29191;
            font-size: 20px;
            margin-right: 5px;
        }
        .meal-info .ingredients {
            margin: 20px 0;
        }
        .meal-info .ingredients h3 {
            color: #F29191;
            margin-bottom: 10px;
        }
        .meal-info .ingredients ul {
            list-style-type: disc;
            padding-left: 20px;
        }
        .meal-info .ingredients ul li {
            margin-bottom: 5px;
        }
        .back-button {
            margin-bottom: 20px;
        }
        .back-button a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
            display: inline-block;
            margin-bottom: 10px;
        }
        .back-button a i {
            margin-right: 5px;
        }
        .favorite-button {
            background-color: #F29191;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .favorite-button:hover {
            background-color: #D85C5C;
        }
        .comments {
            margin-top: 30px;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .comments h3 {
            color: #F29191;
            margin-bottom: 15px;
        }
        .comments form {
            margin-bottom: 20px;
        }
        .comments textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: vertical;
        }
        .comments button {
            background-color: #F29191;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .comments button:hover {
            background-color: #D85C5C;
        }
        .comment-list {
            list-style: none;
            padding: 0;
        }
        .comment {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .comment .comment-author {
            font-weight: bold;
            color: #F29191;
        }
        .comment .comment-text {
            margin-top: 5px;
        }
        .comment .comment-date {
            font-size: 12px;
            color: #888;
            margin-top: 10px;
        }
        footer {
            width: 100%;
            text-align: center;
            background-color: #f29191;
            color: white;
            padding: 14px 0;
            margin-top: 30px;
        }
        footer h4 {
            font-family: Arial, sans-serif;
            font-weight: 300;
        }
        footer h4 span {
            font-weight: 300;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="back-button">
        <a href="home.jsp" class="back-link"><i class='bx bx-arrow-back'></i> Back</a>
    </div>
    <div class="meal-details">
        <% 
            String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
            String username = "root";
            String password = "";
            int mealId = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(databaseUrl, username, password);

                String query = "SELECT r.*, u.username as author, c.category_name " +
                               "FROM recipes r " +
                               "INNER JOIN login u ON r.author = u.id " +
                               "JOIN categories c ON r.category = c.id " +
                               "WHERE r.id = ?";
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, mealId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    float rating = rs.getFloat("rating");
                    String ingredients = rs.getString("ingredients");
                    String instructions = rs.getString("instructions");
                    String author = rs.getString("author");
                    String category = rs.getString("category_name");
                   
        %>
        <img src="<%= image %>" alt="<%= name %>">
        <div class="meal-info">
            <h2><%= name %></h2>
            <p>Food Category: <%= category %></p>
            <div class="rating">
                <span>&#9733;</span> <%= rating %> / 10
            </div>
            <div class="ingredients">
                <h3>Ingredients:</h3>
                <ul>
                    <% 
                        for (String ingredient : ingredients.split("\n")) {
                            out.println("<li>" + ingredient.trim() + "</li>");
                        }
                    %>
                </ul>
            </div>
            <div class="instructions">
                <h3>Instructions:</h3>
                <ol>
                    <% 
                        for (String instruction : instructions.split("\n")) {
                            out.println("<li>" + instruction.trim() + "</li>");
                        }
                    %>
                </ol>
            </div>
            <form method="post" action="addFavorite.jsp">
                <input type="hidden" name="mealId" value="<%= mealId %>">
                <button class="favorite-button" type="submit">Add to Favorites</button>
            </form>
        </div>
        <% 
                } else {
                    out.println("<p>Recipe not found.</p>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                out.println(e.getMessage());
            } finally {
                if (rs != null) {
                    try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (stmt != null) {
                    try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (conn != null) {
                    try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        <div class="comments">
            <h3>Comments</h3>
            <form method="post" action="addComment.jsp">
                <textarea name="comment" rows="5" placeholder="Add a comment..."></textarea>
                <input type="hidden" name="mealId" value="<%= mealId %>"><br><br>
                <button type="submit">Submit</button>
            </form>
            <h3>All Comments</h3>
            <ul class="comment-list">
            <% 
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(databaseUrl, username, password);
                    String commentQuery = "SELECT c.comment, c.created_at, u.username as commenter " +
                                          "FROM comments c " +
                                          "JOIN login u ON c.user_id = u.id " +
                                          "WHERE c.meal_id = ? " +
                                          "ORDER BY c.created_at DESC";
                    stmt = conn.prepareStatement(commentQuery);
                    stmt.setInt(1, mealId);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        String commenter = rs.getString("commenter");
                        String commentText = rs.getString("comment");
                        Timestamp createdAt = rs.getTimestamp("created_at");

                        // Format the timestamp
                        String formattedDate = new java.text.SimpleDateFormat("MMM dd, yyyy 'at' HH:mm").format(createdAt);
            %>
            <li class="comment">
                <div class="comment-author"><%= commenter %></div>
                <div class="comment-text"><%= commentText %></div>
                <div class="comment-date"><%= formattedDate %></div>
            </li>
            <% 
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) {
                        try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (stmt != null) {
                        try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (conn != null) {
                        try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
