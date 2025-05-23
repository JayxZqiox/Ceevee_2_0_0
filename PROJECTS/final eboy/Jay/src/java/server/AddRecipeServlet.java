/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package server;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/addrecipe")
@MultipartConfig
public class AddRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String URL = "jdbc:mysql://localhost:3306/userdatabase";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Upload path for images
    private static final String UPLOAD_PATH = "C:\\Users\\user\\OneDrive\\Documents\\NetBeansProjects\\final_jay\\web\\images\\";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String label = request.getParameter("label");
        String ingredients = request.getParameter("ingredients");
        String category = request.getParameter("category");
        String rating = request.getParameter("rating");
        Part imagePart = request.getPart("image");

        if (imagePart == null) {
            response.getWriter().write("<script>alert('No file uploaded. Please try again.'); window.location='addrecipe.jsp';</script>");
            return;
        }

        String imageFileName = imagePart.getSubmittedFileName();
        String fullPath = UPLOAD_PATH + imageFileName;

        try {
            // Registering the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Uploading image to the specified path
            File file = new File(UPLOAD_PATH);
            if (!file.exists()) {
                file.mkdirs();
            }
            try (FileOutputStream fos = new FileOutputStream(fullPath);
                 InputStream is = imagePart.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            }

            // Inserting recipe data into the database
            try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String query = "INSERT INTO recipes (name, image, label, ingredients, category, rating) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(query)) {
                    stmt.setString(1, name);
                    stmt.setString(2, imageFileName);
                    stmt.setString(3, label);
                    stmt.setString(4, ingredients);
                    stmt.setString(5, category);
                    stmt.setFloat(6, Float.parseFloat(rating));
                    stmt.executeUpdate();
                }
            }
            response.getWriter().write("<script>alert('Recipe added successfully.'); window.location='addrecipe.jsp';</script>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('Failed to load MySQL driver: " + e.getMessage() + "'); window.location='addrecipe.jsp';</script>");
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('Failed to add recipe: " + e.getMessage() + "'); window.location='addrecipe.jsp';</script>");
        }
    }
}
