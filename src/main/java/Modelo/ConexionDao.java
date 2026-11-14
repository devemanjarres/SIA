/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Administrator
 */
public class ConexionDao {
    // declaramos variables
    private static final String url ="jdbc:mysql://gateway01.ap-northeast-1.prod.aws.tidbcloud.com:4000/centrouniversitario?sslMode=VERIFY_IDENTITY";
    public static final String username ="3FTqfYcrPbSjdQJ.root";
    public static final String pass ="aOBxkyg4lbpkzJ4E";
    // crear una funcion para conectarnos a la base de datos
    
   public static Connection ObtenerConexion() throws ClassNotFoundException, SQLException{
       Connection conn = null;
       try{
           // cargar el drive de MySQL
           Class.forName("com.mysql.cj.jdbc.Driver");
           //  Intentar la conexion 
           conn = DriverManager.getConnection(url,username,pass);
           System.out.println("Conexion exitosa a la base de datos");
           
       }catch(ClassNotFoundException e){
           System.out.println("No se encontro el driver JDBC de MySQL" + e.getMessage());
       }
       return conn;
   }
   
   public static void main(String [] args) throws SQLException{
        try {
           Connection test = ConexionDao.ObtenerConexion();
           if(test!=null){
               System.out.println("Conexión probada correctamente desde main.");
           }else{
               System.out.println("No se pudo establecer la conexión.");
           }
       } catch (ClassNotFoundException ex) {
           System.getLogger(ConexionDao.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
       }
       }
   }
   

