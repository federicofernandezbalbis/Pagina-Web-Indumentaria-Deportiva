<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Artículos.aspx.cs" Inherits="Proyecto2.Artículos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Productos</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="CSS1.css?v=<%=DateTime.Now%>" />
    <link rel="stylesheet" type="text/css" href="CSS/Bootstrap.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
</head>
<body>
    <form runat="server" id="Form1">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <header>
            <a href="Home.aspx">
                <img src="Imagenes/Tiro Libre 3.png" alt="Logo de la tienda" style="width: 100px; height: 100px;"></a>
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
        <main id="mainArt">
            <div class="main-articulos">
                <div class="divDeportes">
                    <div class="filtroDeportes">
                        <asp:ImageButton ID="btnFutbol" runat="server" CssClass="imgDeportes" ImageUrl="~/Imagenes/PelotaFutbol.png" OnClick="btnFutbol_Click" />
                    </div>
                    <div class="filtroDeportes">
                        <asp:ImageButton ID="btnTenis" runat="server" CssClass="imgDeportes" ImageUrl="~/Imagenes/pelotaTenis.png" OnClick="btnTenis_Click" />
                    </div>
                    <div class="filtroDeportes">
                        <asp:ImageButton ID="btnBasquet" runat="server" CssClass="imgDeportes" ImageUrl="~/Imagenes/pelotaB.png" OnClick="btnBasquet_Click" />
                    </div>
                    <div class="filtroDeportes">
                        <asp:ImageButton ID="btnRugby" runat="server" CssClass="imgDeportes" ImageUrl="~/Imagenes/pelotaR.png" OnClick="btnRugby_Click" />
                    </div>
                    <div class="filtroDeportes">
                        <asp:ImageButton ID="btnAccesorios" runat="server" CssClass="imgDeportes" ImageUrl="~/Imagenes/accesorio.png" OnClick="btnAccesorios_Click" />
                    </div>
                </div>
                <div class="divOrdenar">
                    <asp:DropDownList runat="server" ID="ddlOrdenarPor" DataTextField="Ordenar Por" OnSelectedIndexChanged="ddlOrdenarPor_SelectedIndexChanged" AutoPostBack="True">
                        <asp:ListItem>Ordenar por</asp:ListItem>
                        <asp:ListItem>Precio más bajo</asp:ListItem>
                        <asp:ListItem>Precio más alto</asp:ListItem>
                        <asp:ListItem>Restablecer</asp:ListItem>
                    </asp:DropDownList>
                    <ul>
                        <li>
                            <h2 style="font-family: 'Consolas'; color: white; position: center; text-align: center; margin-right: 35px">Filtrar</h2>
                            <asp:RadioButtonList runat="server" ID="rblCategorias" OnSelectedIndexChanged="rblCategorias_SelectedIndexChanged" AutoPostBack="True" CssClass="custom-radio-list">
                                <asp:ListItem Text="Camisetas"></asp:ListItem>
                                <asp:ListItem Text="Pantalones"></asp:ListItem>
                                <asp:ListItem Text="Short"></asp:ListItem>
                                <asp:ListItem Text="Buzo"></asp:ListItem>
                                <asp:ListItem Text="Calzado"></asp:ListItem>
                                <asp:ListItem Text="Hombre"></asp:ListItem>
                                <asp:ListItem Text="Mujer"></asp:ListItem>
                            </asp:RadioButtonList>
                        </li>
                    </ul>
                    <style>
                        .custom-radio-list label {
                            color: white;
                        }
                    </style>
                </div>
                <div class="articulos">
            <asp:UpdatePanel runat="server" ID="UpdatePanelListView" UpdateMode="Conditional">
                 <ContentTemplate>
                    <br />
                    <asp:ListView ID="lvArticulos" runat="server" DataSourceID="SqlDataSource1" GroupItemCount="3" EnableModelValidation="False" ViewStateMode="Enabled">
                        <EditItemTemplate>
                            <td runat="server" style="background-color: #999999;">Nombre_AR:
                                <asp:TextBox ID="Nombre_ARTextBox" runat="server" Text='<%# Bind("Nombre_AR") %>' />
                                <br />
                                URL_Imagen_Producto:
                                <asp:TextBox ID="URL_Imagen_ProductoTextBox" runat="server" Text='<%# Bind("URL_Imagen_Producto") %>' />
                                <br />
                                Descripcion_AR:
                                <asp:TextBox ID="Descripcion_ARTextBox" runat="server" Text='<%# Bind("Descripcion_AR") %>' />
                                <br />
                                Talle_AR:
                                <asp:Label ID="Talle_ARLabel1" runat="server" Text='<%# Eval("Talle_AR") %>' />
                                <br />
                                Precio_AR:
                                <asp:TextBox ID="Precio_ARTextBox" runat="server" Text='<%# Bind("Precio_AR") %>' />
                                <br />
                                IDArt_AR:
                                <asp:Label ID="IDArt_ARLabel1" runat="server" Text='<%# Eval("IDArt_AR") %>' />
                                <br />
                                IDSexo_AR:
                                <asp:Label ID="IDSexo_ARLabel1" runat="server" Text='<%# Eval("IDSexo_AR") %>' />
                                <br />
                                IDCategoria_AR:
                                <asp:TextBox ID="IDCategoria_ARTextBox" runat="server" Text='<%# Bind("IDCategoria_AR") %>' />
                                <br />
                                IDTipo_AR:
                                <asp:TextBox ID="IDTipo_ARTextBox" runat="server" Text='<%# Bind("IDTipo_AR") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                                <br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                                <br />
                            </td>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>No se han devuelto datos.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <EmptyItemTemplate>
                            <td runat="server" />
                        </EmptyItemTemplate>
                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>
                        <InsertItemTemplate>
                            <td runat="server" style="">Nombre_AR:
                                <asp:TextBox ID="Nombre_ARTextBox" runat="server" Text='<%# Bind("Nombre_AR") %>' />
                                <br />
                                URL_Imagen_Producto:
                                <asp:TextBox ID="URL_Imagen_ProductoTextBox" runat="server" Text='<%# Bind("URL_Imagen_Producto") %>' />
                                <br />
                                Descripcion_AR:
                                <asp:TextBox ID="Descripcion_ARTextBox" runat="server" Text='<%# Bind("Descripcion_AR") %>' />
                                <br />
                                Talle_AR:
                                <asp:TextBox ID="Talle_ARTextBox" runat="server" Text='<%# Bind("Talle_AR") %>' />
                                <br />
                                Precio_AR:
                                <asp:TextBox ID="Precio_ARTextBox" runat="server" Text='<%# Bind("Precio_AR") %>' />
                                <br />
                                IDArt_AR:
                                <asp:TextBox ID="IDArt_ARTextBox" runat="server" Text='<%# Bind("IDArt_AR") %>' />
                                <br />
                                IDSexo_AR:
                                <asp:TextBox ID="IDSexo_ARTextBox" runat="server" Text='<%# Bind("IDSexo_AR") %>' />
                                <br />
                                IDCategoria_AR:
                                <asp:TextBox ID="IDCategoria_ARTextBox" runat="server" Text='<%# Bind("IDCategoria_AR") %>' />
                                <br />
                                IDTipo_AR:
                                <asp:TextBox ID="IDTipo_ARTextBox" runat="server" Text='<%# Bind("IDTipo_AR") %>' />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                                <br />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" />
                                <br />
                            </td>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <td runat="server" class="tdit">
                                <asp:Label ID="Nombre_ARLabel" runat="server" Text='<%# Eval("Nombre_AR") %>' />
                                <br />
                                <asp:Label ID="Descripcion_ARLabel" runat="server" Text='<%# Eval("Descripcion_AR") %>' />
                                <br />
                                <br />
                                <div class="imagenes">
                                    <asp:ImageButton ID="imgProducto" runat="server" ImageUrl='<%# Eval("URL_Imagen_Producto") %>' Height="250px" ImageAlign="Middle" Width="250px" />
                                </div>
                                <br />
                                <br />
                                $<asp:Label ID="Precio_ARLabel" runat="server" Text='<%# Eval("Precio_AR", "{0:N}") %>' />
                                <br />
                                <asp:Button ID="btnAgregarCarrito" runat="server" Text="Agregar al carrito" CommandArgument='<%# Eval("IDArt_AR") + "-" + Eval("Nombre_AR")+ "-" +Eval("Descripcion_AR")+ "-" +Eval("IDTipo_AR")+ "-" + Eval("Precio_AR") %>' CommandName="eventoAgregarCarrito" OnCommand="btnAgregarCarrito_Command" BackColor="Blue" BorderColor="White" Font-Bold="True" ForeColor="White" />

                                <asp:Button ID="AgregarFavoritos" runat="server" BackColor="Blue" BorderColor="White" Font-Bold="True" ForeColor="White" Text="Favoritos" CommandArgument='<%# Eval("IDArt_AR") + "-" + Eval("Nombre_AR")+ "-" +Eval("Descripcion_AR")+ "-" + Eval("Precio_AR") + "-" + Eval("URL_Imagen_Producto") %>' CommandName="eventoAgregarFavoritos" OnCommand="btnAgregarFavoritos_Command" />

                            </td>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="groupPlaceholderContainer" runat="server" border="1" style="backdrop-filter: blur(6px); border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; box-shadow: 0px 0px 25px rgb(255, 255, 255);">
                                            <tr id="groupPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <td runat="server" style="background-color: #E2DED6; font-weight: bold; color: #333333;">Nombre_AR:
                                <asp:Label ID="Nombre_ARLabel" runat="server" Text='<%# Eval("Nombre_AR") %>' />
                                <br />
                                URL_Imagen_Producto:
                                <asp:Label ID="URL_Imagen_ProductoLabel" runat="server" Text='<%# Eval("URL_Imagen_Producto") %>' />
                                <br />
                                Descripcion_AR:
                                <asp:Label ID="Descripcion_ARLabel" runat="server" Text='<%# Eval("Descripcion_AR") %>' />
                                <br />
                                Talle_AR:
                                <asp:Label ID="Talle_ARLabel" runat="server" Text='<%# Eval("Talle_AR") %>' />
                                <br />
                                Precio_AR:
                                <asp:Label ID="Precio_ARLabel" runat="server" Text='<%# Eval("Precio_AR") %>' />
                                <br />
                                IDArt_AR:
                                <asp:Label ID="IDArt_ARLabel" runat="server" Text='<%# Eval("IDArt_AR") %>' />
                                <br />
                                IDSexo_AR:
                                <asp:Label ID="IDSexo_ARLabel" runat="server" Text='<%# Eval("IDSexo_AR") %>' />
                                <br />
                                IDCategoria_AR:
                                <asp:Label ID="IDCategoria_ARLabel" runat="server" Text='<%# Eval("IDCategoria_AR") %>' />
                                <br />
                                IDTipo_AR:
                                <asp:Label ID="IDTipo_ARLabel" runat="server" Text='<%# Eval("IDTipo_AR") %>' />
                                <br />
                            </td>
                        </SelectedItemTemplate>
                    </asp:ListView>
                    </ContentTemplate>
                 </asp:UpdatePanel>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString %>" SelectCommand="SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString %>" SelectCommand="SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto]
                        FROM [ARTICULOS] WHERE [Nombre_AR] LIKE '%' + @Param1 + '%'">
                        <SelectParameters>
                            <asp:Parameter Name="Param1" Type="String" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
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
