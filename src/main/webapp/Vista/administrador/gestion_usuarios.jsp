```jsp
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // VALIDAR SESIÓN Y ACCESO EXCLUSIVO DEL ADMINISTRADOR
    Usuario administrador =
        (Usuario) session.getAttribute("usuario");

    if (administrador == null || administrador.getRol() != 1) {
        response.sendRedirect(
            request.getContextPath() + "/index.jsp?error=acceso"
        );
        return;
    }

    List<Usuario> usuarios =
        (List<Usuario>) request.getAttribute("usuarios");

    String mensaje = request.getParameter("mensaje");

    String nombreAdministrador = administrador.getNombre();
    String inicialAdministrador =
        (nombreAdministrador != null && !nombreAdministrador.isEmpty())
        ? nombreAdministrador.substring(0, 1).toUpperCase()
        : "A";
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gestión de usuarios | SIA</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Public/css/dashboard_1.css">

    <style>

        /* ENCABEZADO Y BOTÓN CREAR */
        .users-welcome {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn-create {
            background: #2563eb;
            color: white;
            border: none;
            padding: 11px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            margin-top: 15px;
        }

        .btn-create:hover {
            background: #1d4ed8;
        }

        /* PAGINACIÓN */
        .users-pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 7px;
            flex-wrap: wrap;
            margin: 24px 0 10px;
        }

        .page-button {
            min-width: 36px;
            height: 36px;
            padding: 0 10px;
            border: 1px solid #e8edf4;
            border-radius: 7px;
            background: #ffffff;
            color: #172033;
            cursor: pointer;
            font-size: 14px;
            transition: 0.2s;
        }

        .page-button:hover {
            background: #eff6ff;
            border-color: #2563eb;
            color: #2563eb;
        }

        .page-button.active {
            background: #2563eb;
            border-color: #2563eb;
            color: #ffffff;
        }

        .page-button:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        .pagination-info {
            text-align: center;
            color: #718096;
            font-size: 13px;
            margin-top: 12px;
        }

        /* MODAL */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            inset: 0;
            background: rgba(15, 23, 42, 0.65);
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .modal-content {
            background: #ffffff;
            width: 100%;
            max-width: 500px;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.2);
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .modal-header h2 {
            margin: 0 0 6px;
            color: #172554;
        }

        .modal-header p {
            margin: 0;
            color: #64748b;
            font-size: 13px;
        }

        .btn-close {
            border: none;
            background: transparent;
            font-size: 28px;
            cursor: pointer;
            color: #64748b;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 11px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2563eb;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 22px;
        }

        .btn-cancel,
        .btn-save {
            padding: 10px 17px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-cancel {
            background: #e2e8f0;
            color: #334155;
        }

        .btn-save {
            background: #2563eb;
            color: white;
        }

        .btn-save:hover {
            background: #1d4ed8;
        }

    </style>
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

            <a href="${pageContext.request.contextPath}/Vista/administrador/dashboard.jsp"
               class="menu-link">
                <span class="menu-icon">⌂</span>
                Inicio
            </a>

            <a href="${pageContext.request.contextPath}/Vista/administrador/perfil.jsp"
               class="menu-link">
                <span class="menu-icon">◉</span>
                Mi perfil
            </a>

            <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=listar"
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
                    <%= inicialAdministrador %>
                </div>

                <div class="user-details">
                    <strong><%= administrador.getNombre() %></strong>
                    <span>Administrador</span>
                </div>

            </div>

        </header>

        <!-- BIENVENIDA -->
        <section class="users-welcome">

            <div>
                <span>ADMINISTRACIÓN DE CUENTAS</span>
                <h2>Usuarios registrados</h2>
                <p>
                    Consulta, actualiza y administra las cuentas del sistema.
                </p>

                <button type="button"
                        class="btn-create"
                        onclick="abrirModal()">
                    + Crear usuario
                </button>
            </div>

        </section>

        <!-- MENSAJES -->
        <% if ("creado".equals(mensaje)) { %>

            <div class="users-message success-message">
                Usuario creado correctamente.
            </div>

        <% } else if ("actualizado".equals(mensaje)) { %>

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

        <!-- TABLA DE USUARIOS -->
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

                            <tr class="user-row">

                                <!-- NOMBRE -->
                                <td>
                                    <input class="user-input"
                                           type="text"
                                           name="nombre"
                                           form="editar-<%= user.getId() %>"
                                           value="<%= user.getNombre() %>"
                                           required>
                                </td>

                                <!-- USUARIO -->
                                <td>
                                    <input class="user-input"
                                           type="text"
                                           name="usuario"
                                           form="editar-<%= user.getId() %>"
                                           value="<%= user.getUsuario() %>"
                                           required>
                                </td>

                                <!-- CORREO -->
                                <td>
                                    <input class="user-input"
                                           type="email"
                                           name="correo"
                                           form="editar-<%= user.getId() %>"
                                           value="<%= user.getCorreo() %>"
                                           required>
                                </td>

                                <!-- CONTRASEÑA -->
                                <td>
                                    <span class="password-hidden">
                                        ••••••••
                                    </span>

                                    <small class="password-note">
                                        No visible
                                    </small>
                                </td>

                                <!-- ROL -->
                                <td>

                                    <select name="rol"
                                            class="user-select"
                                            form="editar-<%= user.getId() %>"
                                            required>

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

                                <!-- ESTADO -->
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

                                <!-- ACCIONES -->
                                <td class="user-actions">

                                    <!-- FORMULARIO ACTUALIZAR -->
                                    <form id="editar-<%= user.getId() %>"
                                          action="${pageContext.request.contextPath}/UsuarioServlet"
                                          method="POST">

                                        <input type="hidden"
                                               name="accion"
                                               value="actualizar">

                                        <input type="hidden"
                                               name="id"
                                               value="<%= user.getId() %>">

                                        <button type="submit"
                                                class="user-action save-action">
                                            Guardar
                                        </button>

                                    </form>

                                    <!-- FORMULARIO CAMBIAR ESTADO -->
                                    <form action="${pageContext.request.contextPath}/UsuarioServlet"
                                          method="POST">

                                        <input type="hidden"
                                               name="accion"
                                               value="cambiarestado">

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

            <!-- PAGINACIÓN -->
            <div id="usersPagination"
                 class="users-pagination">
            </div>

            <div id="paginationInfo"
                 class="pagination-info">
            </div>

            <p class="users-footer">
                La contraseña no se muestra ni se recupera desde esta pantalla.
            </p>

        </section>

        <!-- PIE DE PÁGINA -->
        <footer class="footer">
            <span>Sistema de Información Académico SIA</span>
            <span>Gestión administrativa</span>
        </footer>

    </main>

</div>

<!-- ====================================== -->
<!-- MODAL CREAR USUARIO                    -->
<!-- ====================================== -->

<div id="modalCrearUsuario" class="modal">

    <div class="modal-content">

        <div class="modal-header">

            <div>
                <h2>Crear nuevo usuario</h2>
                <p>Completa los datos para registrar una cuenta.</p>
            </div>

            <button type="button"
                    class="btn-close"
                    onclick="cerrarModal()">
                &times;
            </button>

        </div>

        <form action="${pageContext.request.contextPath}/UsuarioServlet"
              method="POST">

            <input type="hidden"
                   name="accion"
                   value="nuevacuenta">

            <div class="form-group">

                <label>Nombre completo</label>

                <input type="text"
                       name="nombre"
                       placeholder="Ingrese el nombre completo"
                       required>

            </div>

            <div class="form-group">

                <label>Nombre de usuario</label>

                <input type="text"
                       name="usuario"
                       placeholder="Ingrese el usuario"
                       required>

            </div>

            <div class="form-group">

                <label>Correo electrónico</label>

                <input type="email"
                       name="correo"
                       placeholder="correo@ejemplo.com"
                       required>

            </div>

            <div class="form-group">

                <label>Contraseña</label>

                <input type="password"
                       name="clave"
                       placeholder="Ingrese una contraseña"
                       required>

            </div>

            <div class="form-group">

                <label>Rol del usuario</label>

                <select name="rol" required>

                    <option value="">
                        Seleccione un rol
                    </option>

                    <option value="1">
                        Administrador
                    </option>

                    <option value="2">
                        Estudiante
                    </option>

                    <option value="3">
                        Docente
                    </option>

                    <option value="4">
                        Funcionario
                    </option>

                </select>

            </div>

            <div class="modal-actions">

                <button type="button"
                        class="btn-cancel"
                        onclick="cerrarModal()">
                    Cancelar
                </button>

                <button type="submit"
                        class="btn-save">
                    Crear cuenta
                </button>

            </div>

        </form>

    </div>

</div>

<!-- ====================================== -->
<!-- JAVASCRIPT                             -->
<!-- ====================================== -->

<script>

    // PAGINACIÓN
    const filasPorPagina = 10;
    let paginaActual = 1;

    const filas = document.querySelectorAll(".user-row");

    const totalUsuarios = filas.length;

    const totalPaginas =
        Math.ceil(totalUsuarios / filasPorPagina);

    const contenedorPaginas =
        document.getElementById("usersPagination");

    const informacion =
        document.getElementById("paginationInfo");


    function mostrarPagina(pagina) {

        paginaActual = pagina;

        const inicio =
            (pagina - 1) * filasPorPagina;

        const fin =
            inicio + filasPorPagina;

        filas.forEach((fila, indice) => {

            if (indice >= inicio && indice < fin) {
                fila.style.display = "";
            } else {
                fila.style.display = "none";
            }

        });

        crearBotones();

        const primerUsuario =
            totalUsuarios === 0 ? 0 : inicio + 1;

        const ultimoUsuario =
            Math.min(fin, totalUsuarios);

        informacion.textContent =
            "Mostrando " + primerUsuario +
            " - " + ultimoUsuario +
            " de " + totalUsuarios + " usuarios";

    }


    function crearBotones() {

        contenedorPaginas.innerHTML = "";

        if (totalPaginas <= 1) {
            return;
        }

        // BOTÓN ANTERIOR
        const anterior =
            document.createElement("button");

        anterior.textContent = "Anterior";
        anterior.className = "page-button";
        anterior.disabled = paginaActual === 1;

        anterior.onclick = function() {
            mostrarPagina(paginaActual - 1);
        };

        contenedorPaginas.appendChild(anterior);


        // NÚMEROS DE PÁGINA
        for (let i = 1; i <= totalPaginas; i++) {

            const boton =
                document.createElement("button");

            boton.textContent = i;
            boton.className = "page-button";

            if (i === paginaActual) {
                boton.classList.add("active");
            }

            boton.onclick = function() {
                mostrarPagina(i);
            };

            contenedorPaginas.appendChild(boton);

        }


        // BOTÓN SIGUIENTE
        const siguiente =
            document.createElement("button");

        siguiente.textContent = "Siguiente";
        siguiente.className = "page-button";

        siguiente.disabled =
            paginaActual === totalPaginas;

        siguiente.onclick = function() {
            mostrarPagina(paginaActual + 1);
        };

        contenedorPaginas.appendChild(siguiente);

    }


    // ABRIR MODAL
    function abrirModal() {

        document.getElementById(
            "modalCrearUsuario"
        ).style.display = "flex";

    }


    // CERRAR MODAL
    function cerrarModal() {

        document.getElementById(
            "modalCrearUsuario"
        ).style.display = "none";

    }


    // CERRAR AL HACER CLIC FUERA DEL MODAL
    window.addEventListener("click", function(event) {

        const modal =
            document.getElementById("modalCrearUsuario");

        if (event.target === modal) {
            cerrarModal();
        }

    });


    // INICIAR PAGINACIÓN
    mostrarPagina(1);

</script>

</body>
</html>
```