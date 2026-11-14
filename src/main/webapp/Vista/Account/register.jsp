<%-- 
    Document   : index.jsp
    Created on : Nov 10, 2026, 7:41:46 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIA | Crear Nueva Cuenta</title>
    <link rel="stylesheet" href="../../Public/css/estilos.css">
</head>
<body>
   <!-- Contenedor de la pagina para iniciar sesión-->
     <div class="login-card">
        <!-- Encabezado informativo-->
         <div class="login-header">
            <h1>Crear Nueva Cuenta</h1>
            <p>Cree su cuenta para acceder al sistema y a los cursos cortos</p>
         </div>
         <!-- Formulario de inicio de sesión-->
          <form action="${pageContext.request.contextPath}/UsuarioServlet?accion=nuevacuenta" method="POST">
            <!--campo de nombre-->
            <div class="form-group">
                <label for="name">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ingrese su nombre completo" required>
            </div>
            
            
            <!--Campo de usuario -->
            <div class="form-group">
                <label for="username">Usuario</label>
                <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ej: Usuario" required>
            </div>
            <!-- Campo de correo electronico-->
             <div class="form-group">
                <label for="username">Correo</label>
                <input type="text" id="correo" name="correo" class="form-control" placeholder="Ej: 2021001 o usuario@dominio.com" required>
            </div>
            <!--Campo de contraseña-->
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="clave" name="clave" class="form-control" placeholder="Ingrese su contraseña" required>
            </div>
            
            <!-- Boton de inicio de sesión-->
            <input type="hidden" name="rol" value="2">
             <button type="submit" class="btn-submit">Crear Cuenta</button>
             <!--Pie Pagina-->
             <footer class="login-footer">
                <p> derechos reservados  &copy; 2023</p>
             </footer>
          </form>
     </div> 
</body>
</html>