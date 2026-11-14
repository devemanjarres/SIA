<%-- 
    Document   : index
    Created on : Nov 13, 2026, 12:36:45 PM
    Author     : Administrator
--%>

<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Proteger la página: si no hay sesión, redirigir al login
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
    if (usuarioLogueado == null || usuarioLogueado.getRol() != 1) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acceso");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIA | Panel del Administrador</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Public/css/dashboard_1.css">
</head>
<body>
    <div class="app">
        <!-- Menú lateral -->
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
                    <span class="menu-icon">⌂</span><span>Inicio</span>
                </a>
                <a class="menu-link" href="#">
                    <span class="menu-icon">♙</span><span>Mi perfil</span>
                </a>
                <a class="menu-link" href="#">
                    <span class="menu-icon">▤</span><span>Consultar notas</span>
                </a>
                <a class="menu-link" href="#">
                    <span class="menu-icon">▧</span><span>Solicitar certificado</span>
                </a>
                <a class="menu-link" href="#">
                    <span class="menu-icon">＋</span><span>Matricular materias</span>
                </a>
            </nav>

            <div class="sidebar-footer">
                <span class="status-dot"></span>
                Portal académico
                <small>Acceso de Administrador</small>
            </div>
        </aside>

        <!-- Área de contenido -->
        <main class="main-content">
            <header class="topbar">
                <div>
                    <p class="eyebrow">PORTAL ACADÉMICO</p>
                    <h1>Panel de Administrador</h1>
                </div>
                <div class="user-profile">
                    <div class="avatar">AD</div>
                    <div class="user-details">
                        <strong>Bienvenido(a)</strong>
                        <span><%= usuarioLogueado.getNombre() %></h1>
        <a href="<%= request.getContextPath() %></span>
                    </div>
                </div>
            </header>

            <section class="welcome">
                <div>
                    <p class="welcome-label">TU ESPACIO ACADÉMICO</p>
                    <h2>¡Hola, Mariana!</h2>
                    <p>Consulta tu información académica y mantente al día con tu proceso de formación.</p>
                </div>
                <div class="welcome-decoration" aria-hidden="true">SIA</div>
            </section>

            <!-- Resumen académico -->
            <section class="summary-grid" aria-label="Resumen académico">
                <article class="summary-card">
                    <div class="summary-icon icon-blue">▤</div>
                    <div>
                        <span class="summary-label">Materias inscritas</span>
                        <strong class="summary-value">2</strong>
                        <span class="summary-note">Periodo académico actual</span>
                    </div>
                </article>
                <article class="summary-card">
                    <div class="summary-icon icon-green">✓</div>
                    <div>
                        <span class="summary-label">Promedio general</span>
                        <strong class="summary-value">4.1 <small>/ 5.0</small></strong>
                        <span class="summary-note">Según las notas registradas</span>
                    </div>
                </article>
                <article class="summary-card">
                    <div class="summary-icon icon-orange">▧</div>
                    <div>
                        <span class="summary-label">Certificados</span>
                        <strong class="summary-value">Disponible</strong>
                        <span class="summary-note">Puedes realizar una solicitud</span>
                    </div>
                </article>
            </section>

            <div class="content-grid">
                <!-- Calificaciones -->
                <section class="panel grades-panel" id="notas">
                    <div class="panel-heading">
                        <div>
                            <p class="eyebrow">RENDIMIENTO</p>
                            <h3>Mis calificaciones</h3>
                        </div>
                        <a class="text-link" href="#">Ver todas</a>
                    </div>
                    <p class="panel-description">Consulta las notas registradas para tus materias.</p>

                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Materia</th>
                                    <th>Nota 1</th>
                                    <th>Nota 2</th>
                                    <th>Promedio</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Matemáticas</strong></td>
                                    <td>4.5</td>
                                    <td>4.0</td>
                                    <td><span class="grade-pill">4.3</span></td>
                                </tr>
                                <tr>
                                    <td><strong>Historia</strong></td>
                                    <td>3.8</td>
                                    <td>4.2</td>
                                    <td><span class="grade-pill">4.0</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p class="table-footnote">Las calificaciones son datos de ejemplo para la interfaz.</p>
                </section>

                <!-- Solicitud de certificados -->
                <section class="panel certificate-panel" id="certificados">
                    <div class="certificate-icon">▧</div>
                    <p class="eyebrow">TRÁMITES ACADÉMICOS</p>
                    <h3>Solicitud de certificados</h3>
                    <p>Solicita tus certificados académicos y consulta el estado de tus trámites desde el portal.</p>
                    <a class="primary-button" href="#">Solicitar certificado <span>→</span></a>
                    <span class="certificate-note">El documento estará disponible en formato PDF.</span>
                </section>
            </div>

            <footer class="footer">
                <span>SIA · Sistema de Información Académico</span>
                <span>Portal del estudiante</span>
            </footer>
        </main>
    </div>
</body>
</html>
