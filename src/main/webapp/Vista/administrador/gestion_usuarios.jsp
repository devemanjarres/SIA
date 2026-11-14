<%-- 
    Document   : gestion_usuarios
    Created on : Nov 14, 2026, 9:16:48 AM
    Author     : Administrator
--%>


<%@page import="Modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario administrador = (Usuario) session.getAttribute("usuario");

    if (administrador == null || administrador.getRol() != 1) {
        response.sendRedirect(
            request.getContextPath() + "/index.jsp?error=acceso"
        );
        return;
    }

    List<Usuario> usuarios =
        (List<Usuario>) request.getAttribute("usuarios");

    String mensaje = request.getParameter("mensaje");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gestión de usuarios | SIA</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Public/css/dashboard_1.css">
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

        <nav>

            <p class="menu-caption">MENÚ PRINCIPAL</p>

            <a href="${pageContext.request.contextPath}/administrador/dashboard.jsp"
               class="menu-link">
                <span class="menu-icon">⌂</span>
                Inicio
            </a>

            <a href="${pageContext.request.contextPath}/administrador/perfil.jsp"
               class="menu-link">
                <span class="menu-icon">◉</span>
                Mi perfil
            </a>

            <a href="${pageContext.request.contextPath}/administrador/gestion_usuarios.jsp"
               class="menu-link active">
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

    <!-- CONTENIDO PRINCIPAL -->
    <main class="main-content">

        <header class="topbar">

            <div>
                <p class="eyebrow">ADMINISTRACIÓN</p>
                <h1>Gestión de usuarios</h1>
            </div>

            <div class="user-profile">
                <div class="avatar">
                    <%= administrador.getNombre().substring(0, 1).toUpperCase() %>
                </div>

                <div class="user-details">
                    <strong><%= administrador.getNombre() %></strong>
                    <span>Administrador</span>
                </div>
            </div>

        </header>

        <section class="users-welcome">
            <div>
                <span>ADMINISTRACIÓN DE CUENTAS</span>
                <h2>Usuarios registrados</h2>
                <p>Consulta, actualiza y administra las cuentas del sistema.</p>
            </div>
        </section>

        <% if ("actualizado".equals(mensaje)) { %>
            <div class="users-message success-message">
                Usuario actualizado correctamente.
            </div>
        <% } else if ("estado".equals(mensaje)) { %>
            <div class="users-message success-message">
                Estado del usuario actualizado correctamente.
            </div>
        <% } else if ("error".equals(mensaje)) { %>
            <div class="users-message error-message">
                No fue posible realizar la operación.
            </div>
        <% } %>

        <section class="panel users-panel">

            <div class="panel-heading">
                <div>
                    <h3>Listado de usuarios</h3>
                    <p class="panel-description">
                        Puedes modificar los datos directamente en la tabla.
                    </p>
                </div>
            </div>

            <div class="table-wrapper">

                <table class="data-table users-table">

                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Usuario</th>
                            <th>Correo</th>
                            <th>Clave</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>

                    <% if (usuarios != null && !usuarios.isEmpty()) { %>

                        <% for (Usuario user : usuarios) { %>

                            <tr>

                                <form action="${pageContext.request.contextPath}/GestionUsuariosServlet"
                                      method="POST">

                                    <input type="hidden"
                                           name="accion"
                                           value="actualizar">

                                    <input type="hidden"
                                           name="id"
                                           value="<%= user.getId() %>">

                                    <td>
                                        <input class="user-input"
                                               type="text"
                                               name="nombre"
                                               value="<%= user.getNombre() %>"
                                               required>
                                    </td>

                                    <td>
                                        <input class="user-input"
                                               type="text"
                                               name="usuario"
                                               value="<%= user.getUsuario() %>"
                                               required>
                                    </td>

                                    <td>
                                        <input class="user-input"
                                               type="email"
                                               name="correo"
                                               value="<%= user.getCorreo() %>"
                                               required>
                                    </td>

                                    <td>
                                        <span class="password-hidden">
                                            ••••••••
                                        </span>
                                        <small class="password-note">
                                            No visible
                                        </small>
                                    </td>

                                    <td>
                                        <select name="rol" class="user-select">

                                            <option value="1"
                                                <%= user.getRol() == 1 ? "selected" : "" %>>
                                                Administrador
                                            </option>

                                            <option value="2"
                                                <%= user.getRol() == 2 ? "selected" : "" %>>
                                                Estudiante
                                            </option>

                                            <option value="3"
                                                <%= user.getRol() == 3 ? "selected" : "" %>>
                                                Docente
                                            </option>

                                            <option value="4"
                                                <%= user.getRol() == 4 ? "selected" : "" %>>
                                                Funcionario
                                            </option>

                                        </select>
                                    </td>

                                    <td>
                                        <% if (user.getEstado() == 1) { %>
                                            <span class="user-status active-status">
                                                Activo
                                            </span>
                                        <% } else { %>
                                            <span class="user-status inactive-status">
                                                Inactivo
                                            </span>
                                        <% } %>
                                    </td>

                                    <td class="user-actions">

                                        <button type="submit"
                                                class="user-action save-action">
                                            Guardar
                                        </button>

                                </form>

                                        <form action="${pageContext.request.contextPath}/GestionUsuariosServlet"
                                              method="POST">

                                            <input type="hidden"
                                                   name="accion"
                                                   value="cambiarEstado">

                                            <input type="hidden"
                                                   name="id"
                                                   value="<%= user.getId() %>">

                                            <input type="hidden"
                                                   name="estado"
                                                   value="<%= user.getEstado() == 1 ? 0 : 1 %>">

                                            <% if (user.getEstado() == 1) { %>

                                                <button type="submit"
                                                        class="user-action disable-action">
                                                    Inhabilitar
                                                </button>

                                            <% } else { %>

                                                <button type="submit"
                                                        class="user-action enable-action">
                                                    Activar
                                                </button>

                                            <% } %>

                                        </form>

                                    </td>

                            </tr>

                        <% } %>

                    <% } else { %>

                        <tr>
                            <td colspan="7" class="empty-users">
                                No hay usuarios registrados para mostrar.
                            </td>
                        </tr>

                    <% } %>

                    </tbody>

                </table>

            </div>

            <p class="users-footer">
                La contraseña no se muestra ni se recupera desde esta pantalla.
            </p>

        </section>

        <footer class="footer">
            <span>Sistema de Información Académico SIA</span>
            <span>Gestión administrativa</span>
        </footer>

    </main>

</div>

</body>
</html>
