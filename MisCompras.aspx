<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisCompras.aspx.cs" Inherits="Proyecto2.WebForm4" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tiro Libre: Tu lugar de indumentaria deportiva</title>
    <link rel="stylesheet" type="text/css" href="CSS1.css?v=<%=DateTime.Now%>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="CSS/Bootstrap.css" />
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
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
                        <%if (Session["Username"] == null)
                            { %>
                        <li><a class="dropdown-item" href="Login.aspx">Iniciar Sesión</a></li>
                        <li><a class="dropdown-item" href="Register.aspx">Registrarse</a></li>
                        <% }
                        else
                        { %>
                        <li><a class="dropdown-item" href="InfoUsuario.aspx">Ver Perfil</a></li>
                        <li>
                            <asp:Button ID="btnCerrarSesion" CssClass="dropdown-item" runat="server" Text="Cerrar Sesión" OnClick="btnCerrarSesion_Click" /></li>
                        <% } %>
                        <%if (esAdministrador() == true)
                            { %>
                        <li><a class="dropdown-item" href="PanelAdmin.aspx">Panel Administrador</a></li>
                        <% } %>
                    </ul>
                </div>
            </nav>
        </header>
        <main class="main-misCompras">
            <h2 style="text-align: center; color: white; font-family: 'Consolas'">Historial de compras</h2>
            <div class="container-listview">
                <asp:ListView ID="ListView1" runat="server" DataKeyNames="Numero de venta,ID Usuario" DataSourceID="SqlDataSource1">
                    <EditItemTemplate>
                        <tr style="background-color: #008A8C; color: #FFFFFF;">
                            <td>
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                            </td>
                            <td>
                                <asp:Label ID="Numero_de_ventaLabel1" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="ID_UsuarioTextBox" runat="server" Text='<%# Bind("[ID Usuario]") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="DNITextBox" runat="server" Text='<%# Bind("DNI") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="TeléfonoTextBox" runat="server" Text='<%# Bind("Teléfono") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="TotalTextBox" runat="server" Text='<%# Bind("Total") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="FechaTextBox" runat="server" Text='<%# Bind("Fecha") %>' />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No se han devuelto datos.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" />
                            </td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:TextBox ID="ID_UsuarioTextBox" runat="server" Text='<%# Bind("[ID Usuario]") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="DNITextBox" runat="server" Text='<%# Bind("DNI") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="TeléfonoTextBox" runat="server" Text='<%# Bind("Teléfono") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="TotalTextBox" runat="server" Text='<%# Bind("Total") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="FechaTextBox" runat="server" Text='<%# Bind("Fecha") %>' />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #DCDCDC; color: #000000;">
                            <td>
                                <asp:Label ID="Numero_de_ventaLabel" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                            </td>
                            <td>
                                <asp:Label ID="ID_UsuarioLabel" runat="server" Text='<%# Eval("[ID Usuario]") %>' />
                            </td>
                            <td>
                                <asp:Label ID="DNILabel" runat="server" Text='<%# Eval("DNI") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TeléfonoLabel" runat="server" Text='<%# Eval("Teléfono") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                            </td>
                            <td>
                                <asp:Label ID="FechaLabel" runat="server" Text='<%# Eval("Fecha") %>' />
                            </td>
                            <td>
                                <asp:Button ID="VerDetalleButton" runat="server" Text="Ver detalle" CommandArgument='<%# Eval("[Numero de venta]") + "-" + Eval("[ID Usuario]") %>' CommandName="VerDetalle" OnCommand="VerDetalle_Command" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                            <th runat="server">Numero de venta</th>
                                            <th runat="server">ID Usuario</th>
                                            <th runat="server">DNI</th>
                                            <th runat="server">Teléfono</th>
                                            <th runat="server">Total</th>
                                            <th runat="server">Fecha</th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                            <td>
                                <asp:Label ID="Numero_de_ventaLabel" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                            </td>
                            <td>
                                <asp:Label ID="ID_UsuarioLabel" runat="server" Text='<%# Eval("[ID Usuario]") %>' />
                            </td>
                            <td>
                                <asp:Label ID="DNILabel" runat="server" Text='<%# Eval("DNI") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TeléfonoLabel" runat="server" Text='<%# Eval("Teléfono") %>' />
                            </td>
                            <td>
                                <asp:Label ID="TotalLabel" runat="server" Text='<%# Eval("Total") %>' />
                            </td>
                            <td>
                                <asp:Label ID="FechaLabel" runat="server" Text='<%# Eval("Fecha") %>' />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString1 %>" SelectCommand="SELECT [IDVenta_VE] AS [Numero de venta], [IDUsuario_VE] as [ID Usuario], [DNI_VE] AS [DNI], [Telefono_VE] AS [Teléfono], [Total_VE] AS [Total], [Fecha_VE] AS [Fecha] FROM [VENTAS] WHERE IDUsuario_VE = @Param1">
                    <SelectParameters>
                        <asp:Parameter Name="Param1" Type="Int32" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                        <asp:ListView ID="ListView2" runat="server" DataKeyNames="Numero de venta,ID del usuario,N° de artículo,Sexo,Talle" DataSourceID="SqlDataSource2">
            <AlternatingItemTemplate>
                <tr style="background-color: #FAFAD2;color: #284775;">
                    <td>
                        <asp:Label ID="Numero_de_ventaLabel" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ID_del_usuarioLabel" runat="server" Text='<%# Eval("[ID del usuario]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="N__de_artículoLabel" runat="server" Text='<%# Eval("[N° de artículo]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TalleLabel" runat="server" Text='<%# Eval("Talle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UnidadesLabel" runat="server" Text='<%# Eval("Unidades") %>' />
                    </td>
                    <td>
                        <asp:Label ID="Precio_unitarioLabel" runat="server" Text='<%# Eval("[Precio unitario]") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="background-color: #FFCC66;color: #000080;">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                    </td>
                    <td>
                        <asp:Label ID="Numero_de_ventaLabel1" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ID_del_usuarioLabel1" runat="server" Text='<%# Eval("[ID del usuario]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="N__de_artículoLabel1" runat="server" Text='<%# Eval("[N° de artículo]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="SexoLabel1" runat="server" Text='<%# Eval("Sexo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TalleLabel1" runat="server" Text='<%# Eval("Talle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="UnidadesTextBox" runat="server" Text='<%# Bind("Unidades") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="Precio_unitarioTextBox" runat="server" Text='<%# Bind("[Precio unitario]") %>' />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>No se han devuelto datos.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" />
                    </td>
                    <td>
                        <asp:TextBox ID="Numero_de_ventaTextBox" runat="server" Text='<%# Bind("[Numero de venta]") %>' />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="N__de_artículoTextBox" runat="server" Text='<%# Bind("[N° de artículo]") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="SexoTextBox" runat="server" Text='<%# Bind("Sexo") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="TalleTextBox" runat="server" Text='<%# Bind("Talle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="UnidadesTextBox" runat="server" Text='<%# Bind("Unidades") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="Precio_unitarioTextBox" runat="server" Text='<%# Bind("[Precio unitario]") %>' />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="background-color: #FFFBD6;color: #333333;">
                    <td>
                        <asp:Label ID="Numero_de_ventaLabel" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ID_del_usuarioLabel" runat="server" Text='<%# Eval("[ID del usuario]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="N__de_artículoLabel" runat="server" Text='<%# Eval("[N° de artículo]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TalleLabel" runat="server" Text='<%# Eval("Talle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UnidadesLabel" runat="server" Text='<%# Eval("Unidades") %>' />
                    </td>
                    <td>
                        <asp:Label ID="Precio_unitarioLabel" runat="server" Text='<%# Eval("[Precio unitario]") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color: #FFFBD6;color: #333333;">
                                    <th runat="server">Numero de venta</th>
                                    <th runat="server">ID del usuario</th>
                                    <th runat="server">N° de artículo</th>
                                    <th runat="server">Sexo</th>
                                    <th runat="server">Talle</th>
                                    <th runat="server">Unidades</th>
                                    <th runat="server">Precio unitario</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;"></td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="background-color: #FFCC66;font-weight: bold;color: #000080;">
                    <td>
                        <asp:Label ID="Numero_de_ventaLabel" runat="server" Text='<%# Eval("[Numero de venta]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ID_del_usuarioLabel" runat="server" Text='<%# Eval("[ID del usuario]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="N__de_artículoLabel" runat="server" Text='<%# Eval("[N° de artículo]") %>' />
                    </td>
                    <td>
                        <asp:Label ID="SexoLabel" runat="server" Text='<%# Eval("Sexo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TalleLabel" runat="server" Text='<%# Eval("Talle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UnidadesLabel" runat="server" Text='<%# Eval("Unidades") %>' />
                    </td>
                    <td>
                        <asp:Label ID="Precio_unitarioLabel" runat="server" Text='<%# Eval("[Precio unitario]") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString1 %>"
                    SelectCommand="SELECT DISTINCT [IDVENTA_DV] AS [Numero de venta], [IDUsuario_US] AS [ID del usuario], [IDART_DV] AS [N° de artículo], [IDSexo_DV] AS [Sexo], [TALLE_DV] AS [Talle], [CANTIDAD_DV] AS [Unidades], [PRECIOUNITARIO_DV] [Precio unitario] 
                   FROM DETALLEVENTAS 
                   INNER JOIN VENTAS ON IDVenta_DV = IDVenta_VE 
                   INNER JOIN USUARIOS ON IDUsuario_US = IDUsuario_VE 
                   WHERE IDUsuario_US = @Param1 AND IDVenta_DV = @Param2">
                    <SelectParameters>
                        <asp:Parameter Name="Param1" Type="String" DefaultValue="" />
                        <asp:Parameter Name="Param2" Type="String" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />

        </main>

            <br />
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
                        <li><i class="fas fa-map-marker-alt"></i>Av.Libertador 3351 CABA</li>
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
