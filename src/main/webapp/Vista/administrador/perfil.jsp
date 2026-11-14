<%-- 
    Document   : perfil
    Created on : Nov 14, 2026, 8:52:53 AM
    Author     : Administrator
--%>


<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");

    if (usuarioLogueado == null || usuarioLogueado.getRol() != 1) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acceso");
        return;
    }

    String nombreUsuario = usuarioLogueado.getNombre();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil | SIA</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/Public/css/dashboard_1.css">
</head>

<body>

<div class="app">

    <!-- MENÚ LATERAL -->
    <aside class="sidebar">

        <div class="brand">
            <div class="brand-mark">SIA</div>
            <div>
                <strong>Sistema Académico</strong>
                <small>Panel administrativo</small>
            </div>
        </div>

        <nav class="sidebar-menu">

            <p class="menu-caption">MENÚ PRINCIPAL</p>

            <a href="<%= request.getContextPath() %>/administrador/index.jsp"
               class="menu-link">
                <span class="menu-icon">⌂</span>
                Inicio
            </a>

            <a href="<%= request.getContextPath() %>/administrador/perfil.jsp"
               class="menu-link active">
                <span class="menu-icon">◉</span>
                Mi perfil
            </a>

            <a href="#" class="menu-link">
                <span class="menu-icon">♙</span>
                Gestión de usuarios
            </a>

            <a href="#" class="menu-link">
                <span class="menu-icon">▤</span>
                Gestión académica
            </a>

            <a href="#" class="menu-link">
                <span class="menu-icon">▥</span>
                Reportes
            </a>

        </nav>

        <div class="sidebar-footer">
            <span class="status-dot"></span>
            Sistema activo
        </div>

    </aside>

    <!-- CONTENIDO DERECHO -->
    <main class="main-content">

        <header class="topbar">
            <div>
                <span class="eyebrow">CUENTA</span>
                <h2>Mi perfil</h2>
            </div>

            <div class="user-profile">
                <div class="avatar">
                    <%= nombreUsuario.substring(0, 1).toUpperCase() %>
                </div>

                <div class="user-details">
                    <strong><%= nombreUsuario %></strong>
                    <small>Administrador</small>
                </div>
            </div>
        </header>

        <section class="profile-welcome">
            <div>
                <span class="welcome-label">CONFIGURACIÓN DE CUENTA</span>
                <h1>Información de mi perfil</h1>
                <p>Administra tus datos personales y la seguridad de tu cuenta.</p>
            </div>
        </section>

        <div class="profile-layout">

            <!-- INFORMACIÓN PERSONAL -->
            <section class="panel profile-main-panel">

                <div class="panel-heading">
                    <div>
                        <h3>Información personal</h3>
                        <p class="panel-description">
                            Actualiza la información de tu cuenta.
                        </p>
                    </div>
                </div>

                <form action="<%= request.getContextPath() %>/PerfilServlet"
                      method="POST"
                      enctype="multipart/form-data">

                    <input type="hidden"
                           name="accion"
                           value="actualizarPerfil">

                    <div class="profile-photo-section">

                        <div class="profile-avatar">
                            <%= nombreUsuario.substring(0, 1).toUpperCase() %>
                        </div>

                        <div class="avatar-instructions">
                            <strong>Foto de perfil</strong>
                            <p>Selecciona una imagen para identificar tu cuenta.</p>

                            <input type="file"
                                   name="foto"
                                   accept="image/png,image/jpeg">
                        </div>

                    </div>

                    <div class="form-grid">

                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text"
                                   name="nombre"
                                   value="<%= nombreUsuario %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label>Apellidos</label>
                            <input type="text"
                                   name="apellidos"
                                   placeholder="Ingresa tus apellidos">
                        </div>

                        <div class="form-group full-width">
                            <label>Correo electrónico</label>
                            <input type="email"
                                   name="correo"
                                   placeholder="correo@ejemplo.com">
                        </div>

                    </div>

                    <div class="form-actions">
                        <button type="submit" class="primary-button">
                            Guardar cambios
                        </button>
                    </div>

                </form>

            </section>

            <!-- SEGURIDAD -->
            <section class="panel security-panel">

                <div class="panel-heading">
                    <div>
                        <h3>Seguridad de la cuenta</h3>
                        <p class="panel-description">
                            Actualiza tu contraseña de acceso.
                        </p>
                    </div>
                </div>

                <div class="security-icon">♙</div>

                <h4>Cambiar contraseña</h4>

                <p class="security-note">
                    Utiliza una contraseña segura para proteger tu cuenta.
                </p>

                <form action="<%= request.getContextPath() %>/PerfilServlet"
                      method="POST">

                    <input type="hidden"
                           name="accion"
                           value="cambiarClave">

                    <div class="form-group">
                        <label>Contraseña actual</label>
                        <input type="password"
                               name="claveActual"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Nueva contraseña</label>
                        <input type="password"
                               name="claveNueva"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Confirmar contraseña</label>
                        <input type="password"
                               name="confirmarClave"
                               required>
                    </div>

                    <button type="submit" class="primary-button full-button">
                        Actualizar contraseña
                    </button>

                </form>

            </section>

        </div>

        <footer class="footer">
            Sistema de Información Académico SIA
        </footer>

    </main>

</div>

</body>
</html>
