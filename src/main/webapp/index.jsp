<%-- 
    Document   : index.jsp
    Created on : Nov 10, 2026, 7:35:56 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIA | Iniciar Sesion</title>
    <link href="Public/css/estilos.css" rel="stylesheet">
</head>
<body>
    <!-- Contenedor de la pagina para iniciar sesión-->
     <div class="login-card">
        <!-- Encabezado informativo-->
         <div class="login-header">
            <h1>Iniciar Sesion</h1>
            <p>Ingrese a sus credenciales para acceder al sistema</p>
         </div>
         <!-- Formulario de inicio de sesión-->
          <form action="Login" method="POST">
            <!--Campo de usuario o Correo electronico-->
            <div class="form-group">
                <label for="username">Usuario o Correo Electrónico</label>
                <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ej: 2021001 o usuario@dominio.com" required>
            </div>
            <!--Campo de contraseña-->
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="clave" name="clave" class="form-control" placeholder="Ingrese su contraseña" required>
            </div>
            
            <!-- Boton de inicio de sesión-->
             <button type="submit" class="btn-submit">Iniciar Sesion</button>
        
                    <%-- Mostrar mensaje de error si existe --%>
                    <% if (request.getParameter("error") != null) { %>
                    <p class="error">Usuario o contraseña incorrectos.</p>
                    <br>
                    <br>
                    <% } else if (request.getParameter("estado") != null && request.getParameter("estado").equals("cerrado")) { %>
                    <p class="exito">¡Has cerrado la sesión correctamente!</p>
                    <% } else if (request.getParameter("estado") != null && request.getParameter("estado").equals("registrado")) { %>
                    <p class="exito">¡Tu cuenta ha sido creada exitosamente! Ahora inicia sesión.</p>
                    <% }%>
             <!--Pie Pagina-->
             <footer class="login-footer">
                <p> ¿Aun no tienes tu cuenta? <a href="Vista/Account/register.jsp">Registrate aquí</a></p>
             </footer>
          </form>
     </div>
        <script src="Public/js/jquery-3.3.1.min.js"></script>
        <script src="Public/js/main.js"></script>
</body>
</html>