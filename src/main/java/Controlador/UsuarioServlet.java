/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;
import Modelo.Usuario;
import Modelo.UsuarioDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrator
 */
public class UsuarioServlet extends HttpServlet {
private final UsuarioDao usuarioDao = new UsuarioDao();
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
            String accion = request.getParameter("accion");
            // Switch
            switch(accion){
                case "nuevacuenta":
                    NuevaCuentaUsuario(request,response);
                break;
                case "listar":
                    listarUsuarios(request,response);
                case "actualizar":
                     actualizarUsuario(request, response);
                break;
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

    private void NuevaCuentaUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
         Usuario users = new Usuario();

    users.setNombre(request.getParameter("nombre"));
    users.setUsuario(request.getParameter("usuario"));
    users.setCorreo(request.getParameter("correo"));
    users.setClave(request.getParameter("clave"));
    users.setRol(Integer.parseInt(request.getParameter("rol")));

    int resultado = usuarioDao.NuevaCuenta(users);

    if (resultado > 0) {
        response.sendRedirect(
            request.getContextPath() +
            "/UsuarioServlet?accion=listar&mensaje=creado"
        );
    } else {
        response.sendRedirect(
            request.getContextPath() +
            "/UsuarioServlet?accion=listar&mensaje=error"
        );
    }
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      
        request.setAttribute("usuarios", usuarioDao.listarUsuarios());

        request.getRequestDispatcher(
                "/Vista/administrador/gestion_usuarios.jsp")
                .forward(request, response);
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
         Usuario usuario = new Usuario();

    usuario.setId(Integer.parseInt(request.getParameter("id")));
    usuario.setNombre(request.getParameter("nombre"));
    usuario.setUsuario(request.getParameter("usuario"));
    usuario.setCorreo(request.getParameter("correo"));
    usuario.setRol(Integer.parseInt(request.getParameter("rol")));

    int resultado = usuarioDao.actualizarUsuario(usuario);

    response.sendRedirect(request.getContextPath()
            + "/UsuarioServlet?accion=listar&mensaje="
            + (resultado > 0 ? "actualizado" : "error"));
    }

}
