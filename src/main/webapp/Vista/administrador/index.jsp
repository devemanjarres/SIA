<%-- 
    Document   : index
    Created on : Nov 13, 2026, 12:36:45 PM
    Author     : Administrator
--%>

<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Validar sesión y acceso exclusivo del administrador
    Usuario usuarioLogueado =
        (Usuario) session.getAttribute("usuario");

    if (usuarioLogueado == null ||
        usuarioLogueado.getRol() != 1) {

        response.sendRedirect(
            request.getContextPath() + "/index.jsp?error=acceso"
        );
        return;
    }

    String nombreUsuario = usuarioLogueado.getNombre();
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SIA | Panel del Administrador</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Public/css/dashboard_1.css">
</head>

<body>

<div class="app">

    <!-- MENÚ LATERAL -->
    <aside class="sidebar">

        <a class="brand" href="#">

            <span class="brand-mark">S</span>

            <span>
                <strong>SIA</strong>
                <small>Sistema de Información Académico</small>
            </span>

        </a>

        <p class="menu-caption">MENÚ PRINCIPAL</p>

        <nav aria-label="Navegación principal">

            <a class="menu-link active" href="#">
                <span class="menu-icon">⌂</span>
                <span>Inicio</span>
            </a>

            <a class="menu-link"
               href="${pageContext.request.contextPath}/Vista/administrador/perfil.jsp">

                <span class="menu-icon">♙</span>
                <span>Mi perfil</span>

            </a>

            <a class="menu-link" href="${pageContext.request.contextPath}/Vista/administrador/gestion_usuarios.jsp">
                <span class="menu-icon">♧</span>
                <span>Gestión de usuarios</span>
            </a>

            <a class="menu-link" href="#">
                <span class="menu-icon">▤</span>
                <span>Gestión académica</span>
            </a>

            <a class="menu-link" href="#">
                <span class="menu-icon">▧</span>
                <span>Reportes</span>
            </a>

        </nav>

        <!-- INFORMACIÓN DEL SISTEMA -->
        <div class="sidebar-footer">

            <span class="status-dot"></span>
            Portal académico

            <small>Acceso de Administrador</small>

        </div>

        <!-- CERRAR SESIÓN -->
        <form class="logout-form"
              action="${pageContext.request.contextPath}/CerrarSesionServlet"
              method="post">

            <button class="logout-button" type="submit">

                <span class="menu-icon">↪</span>
                <span>Cerrar sesión</span>

            </button>

        </form>

    </aside>


    <!-- CONTENIDO PRINCIPAL -->
    <main class="main-content">

        <!-- ENCABEZADO -->
        <header class="topbar">

            <div>

                <p class="eyebrow">PORTAL ACADÉMICO</p>

                <h1>Panel de administración</h1>

            </div>

            <div class="user-profile">

                <div class="avatar">AD</div>

                <div class="user-details">

                    <strong>
                        <%= nombreUsuario %>
                    </strong>

                    <span>Administrador del sistema</span>

                </div>

            </div>

        </header>


        <!-- BIENVENIDA -->
        <section class="welcome">

            <div>

                <p class="welcome-label">
                    SISTEMA DE INFORMACIÓN ACADÉMICO
                </p>

                <h2>
                    ¡Bienvenido, <%= nombreUsuario %>!
                </h2>

                <p>
                    Administra los usuarios, consulta la información
                    académica y gestiona los procesos del sistema SIA
                    desde un solo lugar.
                </p>

            </div>

            <div class="welcome-decoration">
                SIA
            </div>

        </section>


        <!-- TARJETAS ADMINISTRATIVAS -->
        <section class="summary-grid"
                 aria-label="Módulos administrativos">

            <article class="summary-card">

                <div class="summary-icon icon-blue">
                    ♧
                </div>

                <div>

                    <span class="summary-label">
                        Administración
                    </span>

                    <strong class="summary-value">
                        Usuarios
                    </strong>

                    <span class="summary-note">
                        Gestionar cuentas del sistema
                    </span>

                </div>

            </article>


            <article class="summary-card">

                <div class="summary-icon icon-green">
                    ▤
                </div>

                <div>

                    <span class="summary-label">
                        Organización
                    </span>

                    <strong class="summary-value">
                        Académico
                    </strong>

                    <span class="summary-note">
                        Gestionar información académica
                    </span>

                </div>

            </article>


            <article class="summary-card">

                <div class="summary-icon icon-orange">
                    ▧
                </div>

                <div>

                    <span class="summary-label">
                        Información
                    </span>

                    <strong class="summary-value">
                        Reportes
                    </strong>

                    <span class="summary-note">
                        Consultar información del sistema
                    </span>

                </div>

            </article>

        </section>


        <!-- MÓDULOS DEL ADMINISTRADOR -->
        <div class="content-grid">

            <section class="panel">

                <div class="panel-heading">

                    <div>

                        <p class="eyebrow">
                            ADMINISTRACIÓN
                        </p>

                        <h3>Gestión del sistema</h3>

                    </div>

                </div>

                <p class="panel-description">
                    Selecciona un módulo para administrar
                    los recursos de la plataforma académica.
                </p>


                <div class="admin-options">

                    <a href="#" class="admin-option">

                        <div class="option-icon icon-blue">
                            ♧
                        </div>

                        <div>

                            <strong>Gestión de usuarios</strong>

                            <small>
                                Registrar, consultar y administrar usuarios.
                            </small>

                        </div>

                        <span class="option-arrow">→</span>

                    </a>


                    <a href="#" class="admin-option">

                        <div class="option-icon icon-green">
                            ▤
                        </div>

                        <div>

                            <strong>Gestión académica</strong>

                            <small>
                                Administrar la información académica.
                            </small>

                        </div>

                        <span class="option-arrow">→</span>

                    </a>


                    <a href="#" class="admin-option">

                        <div class="option-icon icon-orange">
                            ▧
                        </div>

                        <div>

                            <strong>Reportes</strong>

                            <small>
                                Consultar y generar reportes del sistema.
                            </small>

                        </div>

                        <span class="option-arrow">→</span>

                    </a>

                </div>

            </section>


            <!-- PERFIL -->
            <section class="panel admin-profile-panel">

                <div class="security-icon">
                    ♙
                </div>

                <p class="eyebrow">
                    CUENTA PERSONAL
                </p>

                <h3>Mi perfil</h3>

                <p class="panel-description">
                    Consulta y actualiza tus datos personales,
                    correo electrónico y contraseña.
                </p>

                <a class="primary-button"
                   href="${pageContext.request.contextPath}/Vista/perfil.jsp">

                    Administrar mi perfil
                    <span>→</span>

                </a>

            </section>

        </div>


        <!-- PIE DE PÁGINA -->
        <footer class="footer">

            <span>
                SIA · Sistema de Información Académico
            </span>

            <span>
                Panel de administración
            </span>

        </footer>

    </main>

</div>

</body>
</html>
