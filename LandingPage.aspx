<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="Proyecto2.WebForm1" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tiro Libre: Tu lugar de indumentaria deportiva</title>
    <link rel="stylesheet" type="text/css" href="CSS1.css?v=<%=DateTime.Now%>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <nav class="category-bar">
            <div class="lista">
                <ul>
                    <li><a href="Artículos.aspx">Productos</a></li>
                    <% if (Session["Username"] != null) { %>
                        <li><a href="Favoritos.aspx" id="Favoritos" runat="server">Favoritos</a></li>
                        <li><a href="MisCompras.aspx" id="miscompras" runat="server">Mis Compras</a></li>
                        <li><a href="Comprar.aspx" id="comprar" runat="server">
                                <img src="Imagenes/Carrito.png" alt="Cart" style="width: 50px; height: 50px; position: center">
                            </a>
                            <a href="Favoritos.aspx"></a>
                        </li>
                    <% } %>
                </ul>
            </div>
            <div class="dropdown" id="DDL1" runat="server">
                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" title="<%= Session["Username"] %>">
                    <i class="fa fa-user-circle fa-3x" aria-hidden="true"></i>
                </button>
                <ul class="dropdown-menu">
                    <%if (Session["Username"] == null) { %>
                        <li><a class="dropdown-item" href="Login.aspx">Iniciar Sesión</a></li>
                        <li><a class="dropdown-item" href="Register.aspx">Registrarse</a></li>
                    <% } else { %>
                        <li><a class="dropdown-item" href="InfoUsuario.aspx">Ver Perfil</a></li>
                        <li><asp:Button ID="btnCerrarSesion" CssClass="dropdown-item" runat="server" Text="Cerrar Sesión" OnClick="btnCerrarSesion_Click" /></li>
                    <% } %>
                    <%if (esAdministrador() == true) { %>
                        <li><a class="dropdown-item" href="PanelAdmin.aspx">Panel Administrador</a></li>
                    <% } %>
                </ul>
            </div>
        </nav>
    </header>
    <main>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
