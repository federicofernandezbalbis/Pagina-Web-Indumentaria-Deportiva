<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PanelAdmin.aspx.cs" Inherits="Proyecto2.PanelAdmin" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html>
<head>
    <title>Tiro Libre: Tu lugar de indumentaria deportiva</title>
    <link rel="stylesheet" type="text/css" href="CSS1.css">
    <link rel="stylesheet" href="CSS/Bootstrap.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Graduate&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <a href="Home.aspx">
                <img src="Imagenes/Tiro Libre 3.png" alt="Logo de la tienda" style="width: 100px; height: 100px;"></a>
            <nav class="category-bar">
                <div class="lista">
                    <ul>
                        <li>
                            <asp:Button ID="btnAgregar" runat="server" Text="Nuevo Articulo" OnClick="btnAgregar_Click" /></li>
                        <li>
                            <asp:Button ID="btnEditar" runat="server" Text="Editar Articulos" OnClick="btnEditar_Click" /></li>
                        <li>
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar Articulos" OnClick="btnEliminar_Click" /></li>
                        <li>
                            <asp:Button ID="HistorialVentas" runat="server" Text="Mostrar historial de ventas" OnClick="btnHistorial_Click" /></li>
                        <li>
                            <asp:Button ID="AgregarCat" runat="server" Text="Agregar Categoria y TDP" OnClick="btnNuevaCat_Click" /></li>
                        <li>
                            <asp:Button ID="btnEliminarCategoria" runat="server" Text="Eliminar Categoria y TDP" OnClick="btnEliminarCategoria_Click" /></li>
                        <li>
                            <asp:Button ID="btnUsuarios" runat="server" Text="Usuarios" OnClick="btnUsuarios_Click" /></li>
                    </ul>
                </div>
            </nav>
        </header>
        <main class="panelAdmin">
            <div class="capa"></div>
            <div class="form-panel-admin">
                <%if (grdEditar.Visible == true) { %>
                <div class="editarArticulo" style="overflow: scroll">
                    <asp:GridView ID="grdEditar" runat="server" isResponsive="true" BackColor="White" BorderColor="Black" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False" Visible="False" AllowPaging="True" AutoGenerateEditButton="True" OnPageIndexChanging="grdEditar_PageIndexChanging" PageSize="15" OnRowCancelingEdit="grdEditar_RowCancelingEdit" OnRowEditing="grdEditar_RowEditing" OnRowUpdating="grdEditar_RowUpdating" CssClass="gridview-custom" Font-Italic="False" Font-Names="consolas" ForeColor="#CCCCCC">
                        <Columns>
                            <asp:TemplateField HeaderText="ID">
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_eit_ID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_idArt" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NOMBRE">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Nombre" runat="server" Text='<%# Bind("Nombre") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_nombre" runat="server" Text='<%# Bind("NOMBRE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DESCRIPCION">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Descripcion" runat="server" Text='<%# Bind("Descripcion") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_descripcion" runat="server" Text='<%# Bind("DESCRIPCION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PRECIO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Precio" runat="server" Text='<%# Bind("Precio") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_precio" runat="server" Text='<%# Bind("PRECIO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IMAGEN">
                                <EditItemTemplate>
                                    &nbsp;<asp:Label ID="lbl_eit_Imagen" runat="server" Text='<%# Bind("URL_Imagen_Producto") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_imagen" runat="server" Text='<%# Bind("URL_Imagen_Producto") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SEXO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Sexo" runat="server" Text='<%# Bind("Sexo") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_SEXO" runat="server" Text='<%# Bind("SEXO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TALLE">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Talle" runat="server" Text='<%# Bind("Talle") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_talle" runat="server" Text='<%# Bind("TALLE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="STOCK">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Stock" runat="server" Text='<%# Bind("STOCK") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_Stock" runat="server" Text='<%# Bind("STOCK") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID CATEGORIA">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Categoria" runat="server" Text='<%# Bind("Categoria") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_Categoria" runat="server" Text='<%# Bind("Categoria") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID TIPO DE PRENDA">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_TipoPrenda" runat="server" Text='<%# Bind("TIPOPRENDA") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_TipoPrenda" runat="server" Text='<%# Bind("TIPOPRENDA") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID PROVEEDOR">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Proveedor" runat="server" Text='<%# Bind("Proveedor") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_Proveedor" runat="server" Text='<%# Bind("Proveedor") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ESTADO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_eit_Estado" runat="server" Text='<%# Bind("Estado") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_Estado" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#003300" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                </div>
                <% } %>
                <div class="eliminarArticulo">
                    <asp:GridView ID="grdEliminar" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False" Visible="False" AllowPaging="True" AutoGenerateDeleteButton="True" OnPageIndexChanging="grdEliminar_PageIndexChanging" PageSize="15" Font-Names="consolas" OnRowDataBound="grdEliminar_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="ID">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_idArt" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NOMBRE">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_nombre" runat="server" Text='<%# Bind("NOMBRE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DESCRIPCION">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_descripcion" runat="server" Text='<%# Bind("DESCRIPCION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PRECIO">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_precio" runat="server" Text='<%# Bind("PRECIO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IMAGEN">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_imagen" runat="server" Text='<%# Bind("URL_Imagen_Producto") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SEXO">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_SEXO" runat="server" Text='<%# Bind("SEXO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TALLE">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_talle" runat="server" Text='<%# Bind("TALLE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#003300" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                    <br />
                    <br />
                    <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="Blue" BorderWidth="2px" Style="margin-left: 20%"></asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConexionDetalleVentas %>" SelectCommand="SELECT IDVenta_DV, IDArt_DV, IDSexo_DV, Talle_DV, Cantidad_DV, PrecioUnitario_DV FROM DETALLEVENTAS WHERE (IDVenta_DV = @IDVenta)">
                        <SelectParameters>
                            <asp:Parameter Name="IDVenta" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="historialVentas">
                    <asp:GridView ID="grdHistorial" class="grd-historial" Caption="Historial de ventas" CssClass="gridview-custom" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="#FFFFCC" BorderColor="White" BorderWidth="4px" DataKeyNames="N° DE VENTA" DataSourceID="SqlDataSource1" display="flex" Style="margin-left: 20%" BorderStyle="Groove" Font-Bold="False" Font-Italic="False" Font-Names="Consolas" ForeColor="Black" OnRowCommand="grdHistorial_RowCommand">
                        <Columns>
                            <asp:ButtonField ButtonType="Button" HeaderText="VER DETALLE" Text="VER DETALLE" CommandName="VerDetalle"/>
                            <asp:BoundField DataField="N° DE VENTA" HeaderText="N° DE VENTA" InsertVisible="False" ReadOnly="True" SortExpression="N° DE VENTA" />
                            <asp:BoundField DataField="N° DE USUARIO" HeaderText="N° DE USUARIO" SortExpression="N° DE USUARIO" />
                            <asp:BoundField DataField="NOMBRE DE USUARIO" HeaderText="NOMBRE DE USUARIO" SortExpression="NOMBRE DE USUARIO" />
                            <asp:BoundField DataField="DNI" HeaderText="DNI" SortExpression="DNI" />
                            <asp:BoundField DataField="TOTAL" HeaderText="TOTAL" SortExpression="TOTAL" />
                            <asp:BoundField DataField="FECHA" HeaderText="FECHA" SortExpression="FECHA" />
                        </Columns>
                        <HeaderStyle BackColor="#003300" ForeColor="White" />
                    </asp:GridView>
                    <style>
                        .gridview-custom caption {
                            font-weight: bolder;
                            color: antiquewhite;
                            font-size: xx-large;
                        }
                    </style>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString %>" SelectCommand="SELECT [IDVenta_VE] AS [N° DE VENTA], [IDUsuario_VE] AS [N° DE USUARIO], [NombreUsuario_US] AS [NOMBRE DE USUARIO], [DNI_VE] AS [DNI], [Total_VE] AS [TOTAL], [Fecha_VE] AS [FECHA] FROM [VENTAS] INNER JOIN [USUARIOS] ON [IDUsuario_VE] = [IDUsuario_US]"></asp:SqlDataSource>
                </div>
                <div class="AgregarArticulo" runat="server" id="AgregarArticulo">
                    <asp:Panel runat="server" CssClass="formulario1">
                        <h2>ID</h2>
                        <asp:RequiredFieldValidator ID="RFV_ID" runat="server" ControlToValidate="txtAgregar_IdArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_IdArt" runat="server" CssClass="inputsAdmin" ValidationGroup="Grupo1" MaxLength="10"></asp:TextBox>
                        <h2>NOMBRE</h2>
                        <asp:RequiredFieldValidator ID="RFVNombre" runat="server" ControlToValidate="txtAgregar_NombreArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_NombreArt" CssClass="inputsAdmin" runat="server" ValidationGroup="Grupo1" MaxLength="500"></asp:TextBox>
                        <h2>DESCRIPCION</h2>
                        <asp:RequiredFieldValidator ID="RFV_Descripcion" runat="server" ControlToValidate="txtAgregar_DescArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_DescArt" CssClass="inputsAdmin" runat="server" ValidationGroup="Grupo1" MaxLength="500"></asp:TextBox>
                        <h2>PRECIO</h2>
                        <asp:RequiredFieldValidator ID="RFV_Precio" runat="server" ControlToValidate="txtAgregar_PrecioArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_PrecioArt" CssClass="inputsAdmin" runat="server" ValidationGroup="Grupo1"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="REV_Precio" runat="server" ControlToValidate="txtAgregar_PrecioArt" ValidationExpression="^\d+$" ValidationGroup="Grupo1">Debe ingresar un valor numérico</asp:RegularExpressionValidator>
                        <h2>IMAGEN</h2>
                        <asp:RequiredFieldValidator ID="RFV_Imagen" runat="server" ControlToValidate="txtAgregar_ImgArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_ImgArt" CssClass="inputsAdmin" runat="server" ValidationGroup="Grupo1" MaxLength="100"></asp:TextBox>
                        <h2>STOCK</h2>
                        <asp:RequiredFieldValidator ID="RFV_Stock" runat="server" ControlToValidate="txtAgregar_StockArt" Font-Size="XX-Large" ValidationGroup="Grupo1">*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAgregar_StockArt" runat="server" CssClass="inputsAdmin" ValidationGroup="Grupo1"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="REV_Stock" runat="server" ControlToValidate="txtAgregar_StockArt" ValidationExpression="^\d+$" ValidationGroup="Grupo1">Debe ingresar un valor numérico</asp:RegularExpressionValidator>
                    </asp:Panel>
                    <asp:Panel runat="server" CssClass="formulario2">
                        <h2>SEXO</h2>
                        <asp:DropDownList ID="ddlAgregar_SexoArt" runat="server" ValidationGroup="Grupo1"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFV_Sexo" runat="server" ControlToValidate="ddlAgregar_SexoArt" Font-Size="XX-Large">*</asp:RequiredFieldValidator>
                        <h2>CATEGORIA</h2>
                        <asp:DropDownList ID="ddlAgregar_CatArt" runat="server" ValidationGroup="Grupo1"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFV_Categoria" runat="server" ControlToValidate="ddlAgregar_CatArt" Font-Size="XX-Large">*</asp:RequiredFieldValidator>
                        <h2>TIPO DE PRENDA</h2>
                        <asp:DropDownList ID="ddlAgregar_tdpArt" runat="server" ValidationGroup="Grupo1"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFV_TDP" runat="server" ControlToValidate="ddlAgregar_tdpArt" Font-Size="XX-Large">*</asp:RequiredFieldValidator>
                        <h2>PROVEEDOR</h2>
                        <asp:DropDownList ID="ddlAgregar_ProvArt" runat="server" ValidationGroup="Grupo1"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFV_Proveedor" runat="server" ControlToValidate="ddlAgregar_ProvArt" Font-Size="XX-Large">*</asp:RequiredFieldValidator>
                        <h2>ESTADO</h2>
                        <asp:DropDownList ID="ddlAgregar_EstadoArt" runat="server" ValidationGroup="Grupo1">
                            <asp:ListItem Value="True">True</asp:ListItem>
                            <asp:ListItem Value="False">False</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFV_Estado" runat="server" ControlToValidate="ddlAgregar_EstadoArt" Font-Size="XX-Large">*</asp:RequiredFieldValidator>
                        <h2>---------</h2>
                        <div style="text-align: center;">
                            <asp:Button ID="btnAgregarArt" runat="server" OnClick="btnAgregarArt_Click" Text="Agregar" ValidationGroup="Grupo1" />
                        </div>
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                    </asp:Panel>
                </div>
                <div class="container-agregar" runat="server" id="containerAgregar">
                    <div class="agregar-categoria" runat="server">
                        <h3 style="color: whitesmoke">Agregar nueva categoría</h3>
                        <p style="color: whitesmoke">
                            <asp:TextBox ID="txtIDCat" runat="server" placeholder="Ingrese ID del deporte"></asp:TextBox>
                        </p>
                        <p style="color: whitesmoke">
                            <asp:TextBox ID="txtNombreDeporte" runat="server" placeholder="Nombre del deporte"></asp:TextBox>
                        </p>
                        <p style="color: whitesmoke">
                            <asp:Button ID="agregarCategoria" runat="server" Text="Agregar nuevo deporte" OnClick="agregarCategoria_Click" />
                        </p>
                        <p style="color: whitesmoke">
                            <asp:Label ID="txtCategoria" runat="server"></asp:Label>
                        </p>
                    </div>
                    <div class="agregar-tdp" runat="server">
                        <h3 style="color: whitesmoke">Agregar nuevo tipo de prenda</h3>
                        <p style="color: whitesmoke">
                            <asp:TextBox ID="txtIDTDP" runat="server" placeholder="Ingrese ID del TDP"></asp:TextBox>
                        </p>
                        <p style="color: whitesmoke">
                            <asp:TextBox ID="txtDescripcionPrenda" runat="server" placeholder="Ingrese descripción"></asp:TextBox>
                        </p>
                        <p style="color: whitesmoke">
                            <asp:Button ID="agregarTDP" runat="server" Text="Agregar nuevo tipo de prenda" OnClick="agregarTDP_Click" />
                        </p>
                        <p style="color: whitesmoke">
                            <asp:Label ID="txtTDP" runat="server"></asp:Label>
                        </p>
                    </div>
                </div>
                <div class="container-eliminar" runat="server">
                    <div class="eliminar-categoria">
                        <asp:GridView ID="grdEliminarCat" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Visible="False" AutoGenerateDeleteButton="True" OnRowDeleting="grdEliminarCat_RowDeleting" OnRowDataBound="grdEliminarCat_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_it_idCat" runat="server" Text='<%# Bind("IDCategoria_CAT") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre Deporte">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_it_nombreCat" runat="server" Text='<%# Bind("NombreDeporte_CAT") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                        </asp:GridView>
                    </div>
                    <div class="eliminar-tdp">
                        <asp:GridView ID="grdEliminarTdp" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Visible="False" AutoGenerateDeleteButton="True" OnRowDeleting="grdEliminarTDP_RowDeleting" OnRowDataBound="grdEliminarTdp_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_it_IDTipo" runat="server" Text='<%# Bind("IDTipo_TDP") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tipo de Prenda">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_it_nombreCat0" runat="server" Text='<%# Bind("Descripcion_TDP") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="container-usuarios">
                    <asp:GridView ID="grdUsuarios" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" Visible="False" Width="404px" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True" OnRowCancelingEdit="grdUsuarios_RowCancelingEdit" OnRowDeleting="grdUsuarios_RowDeleting" OnRowEditing="grdUsuarios_RowEditing" OnRowUpdating="grdUsuarios_RowUpdating" OnRowDataBound="grdUsuarios_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="IdUser">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_IdUser" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_mailUser" runat="server" Text='<%# Bind("MAIL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NombreUsuario">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_nombreUsuario" runat="server" Text='<%# Bind("[NOMBRE USUARIO]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Administrador">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddl_eit_admin" runat="server">
                                        <asp:ListItem>False</asp:ListItem>
                                        <asp:ListItem>True</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_it_admin" runat="server" Text='<%# Bind("ADMIN") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#333333" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="White" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#487575" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#275353" />
                    </asp:GridView>
                </div>
                <div class="containerGrafico" style="align-content: center">
                    <asp:Chart ID="Chart1" Style="margin-left: 20%" runat="server" DataSourceID="SqlDataSource3" BackColor="0, 0, 192" BackGradientStyle="DiagonalLeft" BorderlineColor="Red" BorderlineWidth="0" Palette="Chocolate" Visible="False" Width="600px" BackImageTransparentColor="Black" Height="500px">
                        <Series>
                            <asp:Series Name="Ventas en pesos por clientes" XValueMember="NombreUsuario_US" ChartType="StackedBar" YValueMembers="Column1"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Alignment="Center" BackGradientStyle="LeftRight" Docking="Top" Font="Consolas, 8.25pt" IsTextAutoFit="False" MaximumAutoSize="100" Name="Legend1"></asp:Legend>
                        </Legends>
                        <BorderSkin BackColor="0, 0, 192" BackImageAlignment="Center" PageColor="Transparent" SkinStyle="Emboss" />
                    </asp:Chart>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TIRO_LIBREConnectionString1 %>" SelectCommand="SP_ArmarGrafico" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>
            </div>
        </main>
    </form>
</body>
</html>
