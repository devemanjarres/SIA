/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manja
 */
public class UsuarioDao {
    public Usuario validar(String user, String pass) throws ClassNotFoundException {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE usuario = ? AND clave = ?";

        try (
                Connection conn = ConexionDao.ObtenerConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user);
            pstmt.setString(2, pass);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setUsuario(rs.getString("usuario"));
                    usuario.setRol(rs.getInt("rol"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al validar usuario: " + e.getMessage());
        } 
        
        return usuario;
    }
    
   
    // creamos el metodo para registrar nueva cuenta en este caso por defecto la cuenta que va a crear es para 2: estudiante
   
     public int NuevaCuenta(Usuario user) {
        int result = 0;

        try {
            Connection conn = ConexionDao.ObtenerConexion();
            String sql = "INSERT INTO usuarios(nombre,usuario,correo,clave,rol) values (?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNombre());
            pstmt.setString(2, user.getUsuario());
            pstmt.setString(3,user.getCorreo());
            pstmt.setString(4,user.getClave());
            pstmt.setInt(5, user.getRol());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al validar usuario: " + e.getMessage());
        } catch (ClassNotFoundException ex) {
            System.getLogger(UsuarioDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return result;
    }
   
    public List<Usuario> listarUsuarios() {

    List<Usuario> lista = new ArrayList<>();

    String sql = "SELECT id, nombre, usuario, correo, rol, estado "
               + "FROM usuarios ORDER BY id DESC";

    try (
        Connection conn = ConexionDao.ObtenerConexion();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery()
    ) {

        while (rs.next()) {

            Usuario user = new Usuario();

            user.setId(rs.getInt("id"));
            user.setNombre(rs.getString("nombre"));
            user.setUsuario(rs.getString("usuario"));
            user.setCorreo(rs.getString("correo"));
            user.setRol(rs.getInt("rol"));
            user.setEstado(rs.getInt("estado"));

            lista.add(user);
        }

    } catch (SQLException e) {
        System.err.println("Error al listar usuarios: " + e.getMessage());

    } catch (ClassNotFoundException e) {
        System.err.println("Error de conexión: " + e.getMessage());
    }

    return lista;
}
public int actualizarUsuario(Usuario user) {

    int resultado = 0;

    String sql = "UPDATE usuarios SET nombre = ?, usuario = ?, correo = ?, rol = ? WHERE id = ?";

    try (Connection conn = ConexionDao.ObtenerConexion();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, user.getNombre());
        pstmt.setString(2, user.getUsuario());
        pstmt.setString(3, user.getCorreo());
        pstmt.setInt(4, user.getRol());
        pstmt.setInt(5, user.getId());

        resultado = pstmt.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    return resultado;
}

    
}