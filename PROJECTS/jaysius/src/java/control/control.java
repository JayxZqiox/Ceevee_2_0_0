/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class control extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if(uri.equals("/jaysius/home")){
            request.getRequestDispatcher("/WEB-INF/viewer/home.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/letter")){
            request.getRequestDispatcher("/WEB-INF/viewer/letter.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/video")){
            request.getRequestDispatcher("/WEB-INF/viewer/video.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/convert")){
            request.getRequestDispatcher("/WEB-INF/viewer/convert.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/home2")){
            request.getRequestDispatcher("/WEB-INF/viewer/home2.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/bmi")){
            request.getRequestDispatcher("/WEB-INF/viewer/bmi.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/game")){
            request.getRequestDispatcher("/WEB-INF/viewer/game.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/spinner")){
            request.getRequestDispatcher("/WEB-INF/viewer/spinner.jsp").forward(request, response);  
        }
        else if(uri.equals("/jaysius/login")){
            request.getRequestDispatcher("/WEB-INF/viewer/login.jsp").forward(request, response);  
        }
        else{
            request.getRequestDispatcher("/WEB-INF/viewer/login.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
