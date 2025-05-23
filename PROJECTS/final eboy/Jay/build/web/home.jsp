<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@2.1.0/css/boxicons.min.css">
    <title>Recipe-app</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap');
        body {
            background-color: #F3F0D7;
            font-family: "Poppins", sans-serif;
            transition: background 0.4s linear;
            position: relative;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            width: 86%;
            margin: 0 auto;
            padding: 30px 0;
        }
        .container h3 {
            text-align: center;
            font-size: 32px;
            color: #F29191;
            transition: color 0.4s ease-in-out;
            cursor: pointer;
        }
        .container .meals {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 20px;
            margin-top: 40px;
        }
        .meals img {
            width: 100%;
            height: 250px;
            border-radius: 4px 4px 0 0;
        }
        .meals .meal {
            background-color: white;
            border-radius: 4px;
            cursor: pointer;
            box-shadow: 1px 1px 18px rgba(14,14,14,0.3);
            transition: transform 0.4s ease;
        }
        .meals .meal .desc {
            padding: 21px 20px;
            text-align: center;
        }
        .meals .meal h4 {
            font-size: 15px;
            color: #f29191;
        }
        .meal .rating {
            margin: 8px 0;
        }
        .meals .meal button {
            background-color: #F29191;
            color: white;
            border: none;
            cursor: pointer;
            padding: 8px 15px;
        }
        .inputing {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .inputing input[type="search"] {
            width: 70%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            font-size: 16px;
            outline: none;
        }
        .inputing button[type="submit"] {
            background-color: #F29191;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 0 5px 5px 0;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        button{
            background-color: #F29191;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 0 5px 5px 0;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #D85C5C;
        }
        .inputing button[type="submit"]:hover {
            background-color: #D85C5C;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: -300px;
            width: 300px;
            height: 100%;
            background-color: #fff;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            transition: left 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }
        .sidebar.show {
            left: 0;
        }
        .sidebar .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
        }
        .sidebar .nav-menu {
            padding: 20px;
        }
        .sidebar .nav-menu a {
            display: block;
            margin-bottom: 15px;
            font-size: 18px;
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .sidebar .nav-menu a:hover {
            color: #F29191;
        }
        .menu-icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            z-index: 1100;
            color: #333;
            transition: color 0.3s ease;
        }
        .menu-icon:hover {
            color: #F29191;
        }
        .filter-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 0px;
        }
        .filter-container select {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            outline: none;
            transition: border-color 0.3s ease;
        }
        .filter-container select:focus {
            border-color: #F29191;
        }
        .filter-container select option {
            font-size: 16px;
            padding: 10px;
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
            font-family: arial;
            font-weight: 300;
        }
        footer h4 span {
            font-weight: 300;
        }
        @media screen and (max-width: 576px) {
            .container {
                width: 100%;
                padding: 30px;
            }
            .container .meals {
                width: 100%;
                grid-template-columns: repeat(1, 1fr);
            }
            .container h3 {
                font-size: 20px;
            }
            .menu-icon {
                position: fixed;
                top: 20px;
                right: 20px;
                font-size: 24px;
                cursor: pointer;
                z-index: 1100;
                color: #333;
                transition: color 0.3s ease;
            }
            .sidebar {
                width: 250px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="menu-icon" onclick="toggleSidebar()">
        <i class="bx bx-menu"></i>
    </div>
    <div class="sidebar" id="sidebar">
        <div class="close-btn" onclick="toggleSidebar()">
            <i class="bx bx-x"></i>
        </div>
        <div class="nav-menu">
            <a href="home.jsp">Home</a>
            <a href="profile.jsp">Profile</a>
            <a href="addrecipe.jsp">Add Recipe</a>
            <a href="favorites.jsp">Favorites</a>
            <a href="login.jsp">Logout</a>
        </div>
    </div>
    <h3>Find your food recipe <br> in here</h3>
    <div class="inputing">
        <form method="get" action="home.jsp">
            <input type="search" name="search" placeholder="Search recipe">
            <button type="submit"><i class='bx bx-search'></i></button>
        </form>
        <div class="filter-container">
        <select name="category" id="category" onchange="fetchRecipeList()">
            <option value="">Select Category</option>
            <% 
                String databaseUrl = "jdbc:mysql://localhost:3306/userdatabase";
                String username = "root";
                String password = "";
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                Map<Integer, String> categoryMap = new HashMap<>();
                try {
                    // Establish the database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(databaseUrl, username, password);
                    // Retrieve categories
                    String categoryQuery = "SELECT DISTINCT id, category_name FROM categories";
                    stmt = conn.prepareStatement(categoryQuery);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        categoryMap.put(rs.getInt("id"), rs.getString("category_name"));
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                for (Map.Entry<Integer, String> entry : categoryMap.entrySet()) { 
            %>
            <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% } %>
        </select>
    </div>
    </div>
    <a href="addrecipe.jsp">
        <button type="button">Add a Recipe</button>
    </a>
    
    <div class="meals" id="meals-container">
        <% 
            Cookie[] cookies = request.getCookies();
            int userId = -1; // Default user ID, initialized to -1

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("userId")) {
                        userId = Integer.parseInt(cookie.getValue());
                        break;
                    }
                }
            }

            if (userId != -1) {
                // Database connection parameters
                String query = "SELECT r.id, r.name, r.image, r.rating, u.username as author " +
                               "FROM recipes r " +
                               "INNER JOIN login u ON r.author = u.id ";

                // Check if search parameter is provided
                String search = request.getParameter("search");
                String categoryFilter = request.getParameter("category");
                if (search != null && !search.trim().isEmpty()) {
                    query += "WHERE r.name LIKE ? ";
                }
                if (categoryFilter != null && !categoryFilter.isEmpty()) {
                    if (search == null || search.isEmpty()) {
                        query += " WHERE";
                    } else {
                        query += " AND";
                    }
                    query += " r.category = ?";
                }

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(databaseUrl, username, password);

                    stmt = conn.prepareStatement(query);
                    
                    int paramIndex = 1;
                    if (search != null && !search.trim().isEmpty()) {
                        stmt.setString(paramIndex++, "%" + search.trim() + "%");
                    }
                    if (categoryFilter != null && !categoryFilter.isEmpty()) {
                        stmt.setInt(paramIndex++, Integer.parseInt(categoryFilter));
                    }

                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String image = rs.getString("image");
                        String author = rs.getString("author");
                        float rating = rs.getFloat("rating");
        %>
        <div class="meal">
            <img src="<%= image %>" alt="<%= name %>">
            <div class="desc">
                <h4><%= name %></h4>
                <p>By: <%= author %></p>
                <p>Rating: <%= rating %></p>
                <a href="mealDetails.jsp?id=<%= id %>"><button type="button">View Recipe</button></a>
            </div>
        </div>
        <%
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                // Handle case where userId cookie is not found or user is not logged in
                out.println("<script>alert('User session not found. Please login to access recipes.');</script>");
                response.sendRedirect("login.jsp");
            }
        %>
    </div>
</div>

<!-- Import Boxicons -->
<script src="https://unpkg.com/boxicons@2.1.0/dist/boxicons.js"></script>

<script>
    function toggleSidebar() {
        var sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("show");
    }

    function fetchRecipeList() {
        var selectedCategory = document.getElementById("category").value;
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("meals-container").innerHTML = this.responseText;
            }
        };
        xhttp.open("GET", "filterRecipe.jsp?category=" + selectedCategory, true);
        xhttp.send();
    }
</script>
</body>
</html>
