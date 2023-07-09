<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InfoUsuario.aspx.cs" Inherits="Proyecto2.InfoUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Información Usuario</title>
    <link rel="stylesheet" type="text/css" href="CSS1.css?v=<%=DateTime.Now%>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="CSS/Bootstrap.css" />
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
    <form id="form1" runat="server">
    <header>
 <a href="Home.aspx"><img src="Imagenes/Tiro Libre 3.png" alt="Logo de la tienda" style="width:100px; height:100px;"></a>
    <div class="search-container">
      <div class="search-box">
        <button id="btnBuscar" runat="server" class="btn-search" onserverclick="BtnBuscar_Click">
            <i class="fas fa-search"></i>
        </button>
        <asp:TextBox ID="txtSearch" runat="server" CssClass="input-search" placeholder="Buscar..."></asp:TextBox>
      </div>
    </div>
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
    <div class="main-login">
        <div class="capa"></div>
            <div class="login" style="font-family:Consolas">
                <h1 id="informacion">Tú Información</h1>
                <h2 id="nombre">Nombre:</h2>
                <asp:Label ID="lblNombre" runat="server" CssClass="txtInputs"></asp:Label>
                <h2 id="apellido">Apellido:</h2>
                 <asp:Label ID="lblApellido" runat="server" CssClass="txtInputs"></asp:Label>
                <h2 id="NombreUsuario">NombreUsuario:</h2>
                 <asp:Label ID="lblNombreUsuario" runat="server" CssClass="txtInputs"></asp:Label>
                <h2 id="DNI">DNI:</h2>
                 <asp:Label ID="lblDNI" runat="server" CssClass="txtInputs"></asp:Label>
                 <h2 id="email">Email:</h2>
                 <asp:Label ID="lblEmail" runat="server" CssClass="txtInputs"></asp:Label>
                 <h2 id="direccion">Dirección:</h2>
                 <asp:Label ID="lblDireccion" runat="server" CssClass="txtInputs"></asp:Label>
                 <h2 id="telefono">Teléfono:</h2>
                 <asp:Label ID="lblTelefono" runat="server" CssClass="txtInputs"></asp:Label>
                 <h2 id="fechaNac">Fecha de Nacimiento:</h2>
                 <asp:Label ID="lblFechaNacimiento" runat="server" class="txtInputs"/>
              </div>
       </div>
    </main>
    <footer>
        <div class="main-footer">
        <div class="social-media">
            <i class="fab fa-facebook-f"></i>
            <i class="fab fa-instagram"></i>
            <i class="fab fa-twitter"></i>
            <i class="fab fa-whatsapp"></i>
            <i class="fab fa-pinterest-p"></i>
        </div>
        <div class="info-footer">
            <div class="seccion-footer">
            <h2><i class="fas fa-archive"></i>Productos</h2>
                <li>Destacados</li>
                <li>Remeras</li>
                <li>Pantalones</li>
                <li>Accesorios</li>
            </div>
            <div class="seccion-footer">
            <h2><i class="fas fa-info-circle"></i>Información</h2>
            <li>Política de seguridad</li>
            <li>Política de envíos</li>
            <li>Términos y condiciones</li>
            <li>Boton de arrepentimiento</li>
            </div>
            <div class="seccion-footer">
            <h2><i class="far fa-envelope"></i>Contacto</h2>
            <li><i class="fas fa-map-marker-alt"></i> Av.Libertador 3351 CABA</li>
            <li>Nosotros</li>
            <li>Contáctanos</li>
            </div>
            <div class="seccion-footer">
            <h2><i class="fas fa-concierge-bell"></i>Horarios de atención</h2>
            Lun a Sáb de 10 a 19hs.
            </div>
        </div>
        </div>
        <div class="derechos">
        <p style="padding-bottom: 10px; margin: 0px; font-weight: 600;">Copyright © 2023 - TiroLibre Argentina | Todos los derechos reservados.</p>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    </form>
</body>
</html>
