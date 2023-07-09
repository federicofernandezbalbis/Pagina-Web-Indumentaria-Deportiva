using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Entidades;
using System.Data;
using System.Data.SqlClient;


/*
                     CONTRSEÑA MODO ADMINISTRADOR: 12345
*/

namespace Proyecto2
{
    public partial class PanelAdmin : System.Web.UI.Page
    {
        NegocioArticulos articulos = new NegocioArticulos();
        NegocioCategoria categorias = new NegocioCategoria();
        NegocioDetalleVentas detalle = new NegocioDetalleVentas();
        NegocioTDP tipodeprendas = new NegocioTDP();
        NegocioVentas ventas = new NegocioVentas();
        NegocioUsuarios usuarios = new NegocioUsuarios();

        /*--------------------------------MAIN----------------------------------------------------*/
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarDDLS();
                cargarGrid();
                cargarGridCategorias();
                cargarGridTDP();
                cargarGridUsuarios();

                AgregarArticulo.Visible = false;
                grdHistorial.Visible = false;

            }
            grdEliminar.RowDeleting += grdEliminar_RowDeleting;
        }
        public void cargarGrid()
        {
            grdEditar.DataSource = articulos.obtenerArticulosEditar();
            grdEditar.DataBind();

            grdEliminar.DataSource = articulos.obtenerArticulos();
            grdEliminar.DataBind();
        }

        public void cargarGridVentas()
        {
            grdHistorial.DataSource = ventas.ObtenerVentas();
            grdEditar.DataBind();
        }

        public void cargarGridCategorias()
        {
            grdEliminarCat.DataSource = categorias.ObtenerCat();
            grdEliminarCat.DataBind();
        }

        public void cargarGridTDP()
        {
            grdEliminarTdp.DataSource = tipodeprendas.ObtenerTDP();
            grdEliminarTdp.DataBind();
        }

        public void cargarGridUsuarios()
        {
            grdUsuarios.DataSource = usuarios.obtenerUsuarios();
            grdUsuarios.DataBind();
        }

        /*----------------------------------------------------------------------------------------*/
        /*-----------Botones que manejan que gridview aparece en pantalla (agregar, eliminar etc.)*/
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdEliminar.Visible = false;
            grdHistorial.Visible = false;
            containerAgregar.Visible = false;
            AgregarArticulo.Visible = true;
            GridView1.Visible = false;
            grdEliminarCat.Visible = false;
            grdEliminarTdp.Visible = false;
            grdUsuarios.Visible = false;
        }
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            grdEliminar.Visible = false;
            grdHistorial.Visible = false;
            containerAgregar.Visible = false;
            AgregarArticulo.Visible = false;
            grdEditar.Visible = true;
            GridView1.Visible = false;
            grdEliminarCat.Visible = false;
            grdEliminarTdp.Visible = false;
            grdUsuarios.Visible = false;
            grdEliminar.DataSource = articulos.obtenerArticulosEditar();
            grdEliminar.DataBind();
        }
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdHistorial.Visible = false;
            grdEliminar.Visible = true;
            containerAgregar.Visible = false;
            AgregarArticulo.Visible = false;
            GridView1.Visible = false;
            grdEliminarCat.Visible = false;
            grdEliminarTdp.Visible = false;
            grdUsuarios.Visible = false;
            grdEliminar.DataSource = articulos.obtenerArticulos();
            grdEliminar.DataBind();
        }
        protected void btnHistorial_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdEliminar.Visible = false;
            grdHistorial.Visible = true;
            AgregarArticulo.Visible = false;
            containerAgregar.Visible = false;
            GridView1.Visible = false;
            grdEliminarCat.Visible = false;
            grdEliminarTdp.Visible = false;
            Chart1.Visible = true;
            grdUsuarios.Visible = false;
        }
        protected void btnNuevaCat_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdEliminar.Visible = false;
            grdHistorial.Visible = false;
            AgregarArticulo.Visible = false;
            containerAgregar.Visible = true;
            grdEliminarCat.Visible = false;
            GridView1.Visible = false;
            grdEliminarTdp.Visible = false;
            grdUsuarios.Visible = false;
        }
        protected void btnEliminarCategoria_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdEliminar.Visible = false;
            grdHistorial.Visible = false;
            AgregarArticulo.Visible = false;
            GridView1.Visible = false;
            containerAgregar.Visible = false;
            grdEliminarCat.Visible = true;
            grdEliminarTdp.Visible = true;
            Chart1.Visible = false;
            grdUsuarios.Visible = false;
        }
        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            grdEditar.Visible = false;
            grdEliminar.Visible = false;
            grdHistorial.Visible = false;
            AgregarArticulo.Visible = false;
            GridView1.Visible = false;
            containerAgregar.Visible = false;
            grdEliminarCat.Visible = false;
            grdEliminarTdp.Visible = false;
            Chart1.Visible = false;
            grdUsuarios.Visible = true;
        }

        /*----------------------------------------------------------------------------------------*/
        /*------------------------Eventos de los gridview----------------------------------------*/
        protected void grdEditar_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdEditar.PageIndex = e.NewPageIndex;
            cargarGrid();
        }
        protected void grdEliminar_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdEliminar.PageIndex = e.NewPageIndex;
            cargarGrid();
        }
        protected void grdEliminar_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rowIndex = e.RowIndex;
            string idArticulo = null;
            string idSexo = null;
            string idTalle = null;
            Articulos art = new Articulos();
            if (rowIndex >= 0 && rowIndex < grdEliminar.Rows.Count)
            {
                GridViewRow row = grdEliminar.Rows[rowIndex];
                idArticulo = ((Label)row.FindControl("lbl_it_idArt")).Text;
                idSexo = ((Label)row.FindControl("lbl_it_SEXO")).Text;
                Sexo se = new Sexo();
                se.IdSexo = idSexo;
                idTalle = ((Label)row.FindControl("lbl_it_talle")).Text;

                art.IdArticulo = idArticulo;
                art.Sexo = se;
                art.Talle = idTalle;
            }

            articulos.eliminarArticuloNegocio(art);
            grdEliminar.DataSource = articulos.obtenerArticulos();
            grdEliminar.DataBind();
        }
        protected void grdEditar_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String s_idArticulo = ((Label)grdEditar.Rows[e.RowIndex].FindControl("lbl_eit_ID")).Text;
            String s_Nombre = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Nombre")).Text;
            String s_Descripcion = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Descripcion")).Text;
            String s_Precio = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Precio")).Text;
            String s_Imagen = ((Label)grdEditar.Rows[e.RowIndex].FindControl("lbl_eit_Imagen")).Text;
            String s_idSexo = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Sexo")).Text;
            Sexo se = new Sexo();
            se.IdSexo = s_idSexo;
            String s_idTalle = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Talle")).Text;
            String s_Stock = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Stock")).Text;
            String s_idCategoria = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Categoria")).Text;
            Categorias cat = new Categorias();
            cat.IdCategoria = Convert.ToInt32(s_idCategoria);
            String s_idTipo = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_TipoPrenda")).Text;
            TipoDePrenda tdp = new TipoDePrenda();
            tdp.IdTipoPrenda = Convert.ToInt32(s_idTipo);
            String s_idProveedor = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Proveedor")).Text;
            Proveedores prov = new Proveedores();
            prov.IdProveedor = s_idProveedor;
            String s_Estado = ((TextBox)grdEditar.Rows[e.RowIndex].FindControl("txt_eit_Estado")).Text;

            Articulos art = new Articulos();

            art.IdArticulo = s_idArticulo;
            art.Nombre = s_Nombre;
            art.Descripcion = s_Descripcion;
            art.Precio = Convert.ToDecimal(s_Precio);
            art.ImgProducto = s_Imagen;
            art.Sexo = se;
            art.Talle = s_idTalle;
            art.Stock = Convert.ToInt32(s_Stock);
            art.Categoria = cat;
            art.TipoPrenda = tdp;
            art.Proveedor = prov;
            art.Estado = Convert.ToBoolean(s_Estado);

            articulos.editarArticuloNegocio(art);
            grdEditar.EditIndex = -1;
            cargarGrid();
        }
        protected void grdEditar_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdEditar.EditIndex = e.NewEditIndex;
            cargarGrid();
        }
        protected void grdEditar_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdEditar.EditIndex = -1;
            cargarGrid();
        }
        public void llenarDDLS()
        {
            NegocioSexo negSexo = new NegocioSexo();
            DataTable dtSexo = negSexo.ObtenerSexo();

            ddlAgregar_SexoArt.DataSource = dtSexo;
            ddlAgregar_SexoArt.DataValueField = "IDSexo_SE";
            ddlAgregar_SexoArt.DataTextField = "Descripcion_SE";
            ddlAgregar_SexoArt.DataBind();

            NegocioCategoria negCat = new NegocioCategoria();
            DataTable dtCat = negCat.ObtenerCat();

            ddlAgregar_CatArt.DataSource = dtCat;
            ddlAgregar_CatArt.DataValueField = "IDCategoria_CAT";
            ddlAgregar_CatArt.DataTextField = "NombreDeporte_CAT";
            ddlAgregar_CatArt.DataBind();

            NegocioTDP negTPD = new NegocioTDP();
            DataTable dtTDP = negTPD.ObtenerTDP();

            ddlAgregar_tdpArt.DataSource = dtTDP;
            ddlAgregar_tdpArt.DataValueField = "IDTipo_TDP";
            ddlAgregar_tdpArt.DataTextField = "Descripcion_TDP";
            ddlAgregar_tdpArt.DataBind();

            NegocioProveedor negProv = new NegocioProveedor();
            DataTable dtProv = negProv.ObtenerProv();

            ddlAgregar_ProvArt.DataSource = dtProv;
            ddlAgregar_ProvArt.DataValueField = "ID";
            ddlAgregar_ProvArt.DataTextField = "RazonSocial_PR";
            ddlAgregar_ProvArt.DataBind();

        }
        protected void grdEliminarCat_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String s_IdCat = ((Label)grdEliminarCat.Rows[e.RowIndex].FindControl("lbl_it_idCat")).Text;

            Categorias cat = new Categorias();
            cat.IdCategoria = Convert.ToInt32(s_IdCat);

            categorias.eliminarCategoria(cat);

            cargarGridCategorias();
        }
        protected void grdEliminarTDP_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String s_IdTipo = ((Label)grdEliminarTdp.Rows[e.RowIndex].FindControl("lbl_it_IDTipo")).Text;

            TipoDePrenda tdp = new TipoDePrenda();
            tdp.IdTipoPrenda = Convert.ToInt32(s_IdTipo);

            tipodeprendas.eliminarTDP(tdp);

            cargarGridTDP();
        }
        protected void grdUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String s_IdUsuario = ((Label)grdUsuarios.Rows[e.RowIndex].FindControl("lbl_it_IdUser")).Text;

            Usuarios usuario = new Usuarios();

            usuario.IdUsuario = Convert.ToInt32(s_IdUsuario);
            usuarios.eliminarUsuario(usuario);

            cargarGridUsuarios();
        }
        protected void grdUsuarios_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String s_IdUsuario = ((Label)grdUsuarios.Rows[e.RowIndex].FindControl("lbl_it_IdUser")).Text;
            Usuarios usuario = new Usuarios();
            usuario.IdUsuario = Convert.ToInt32(s_IdUsuario);
            usuarios.editarUsuario(usuario);
            grdUsuarios.EditIndex = -1;
            cargarGridUsuarios();
        }

        protected void grdUsuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdUsuarios.EditIndex = e.NewEditIndex;
            cargarGridUsuarios();
        }

        protected void grdUsuarios_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdUsuarios.EditIndex = -1;
            cargarGridUsuarios();
        }

        /*----------------------Eventos de los botones principales en los gridview-------------------*/
        protected void agregarTDP_Click(object sender, EventArgs e)
        {
            TipoDePrenda TDP = new TipoDePrenda();
            TDP.IdTipoPrenda = Int32.Parse(txtIDTDP.Text);
            TDP.Descripcion = txtDescripcionPrenda.Text.ToString();
            int ID = Int32.Parse(txtIDTDP.Text);
            try
            {
                if (tipodeprendas.agregarTDP(TDP, ID) == 1)
                {
                    txtTDP.Text = "Agregado con éxito";
                }
                else
                {
                    txtTDP.Text = "Error en la carga (¿El ID ya existe en la base de datos?)";
                }
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    txtTDP.Text = "Error: El ID ya existe en la base de datos";
                }
                else
                {
                    txtTDP.Text = "Error inesperado: " + ex.Message;
                }
            }
            txtIDTDP.Text = "";
            txtDescripcionPrenda.Text = "";
        }
        protected void btnAgregarArt_Click(object sender, EventArgs e)
        {
            Articulos art = new Articulos();
            NegocioArticulos negArt = new NegocioArticulos();
            NegocioSexo negSexo = new NegocioSexo();
            NegocioCategoria negCat = new NegocioCategoria();
            NegocioTDP negTPD = new NegocioTDP();
            NegocioProveedor negProv = new NegocioProveedor();


            if (ddlAgregar_tdpArt.SelectedItem.ToString() == "Camiseta" || ddlAgregar_tdpArt.SelectedItem.ToString() == "Pantalon" || ddlAgregar_tdpArt.SelectedItem.ToString() == "Short" || ddlAgregar_tdpArt.SelectedItem.ToString() == "Buzo")
            {
                for (int i = 1; i <= 4; i++)
                {
                    switch (i)
                    {
                        case 1:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "S";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            if (negArt.agregarPrimerArticulo(art))
                            {
                                lblMensaje.Text = "Articulo agregado con exito.";
                            }
                            else
                            {
                                lblMensaje.Text = "Error al agregar Articulo";
                                i = 5;
                            }
                            break;
                        case 2:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "M";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                        case 3:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "L";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                        case 4:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "XL";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                    }
                }
            }
            else if (ddlAgregar_tdpArt.SelectedItem.ToString() == "Calzado")
            {
                for (int i = 1; i <= 4; i++)
                {
                    switch (i)
                    {
                        case 1:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "38";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            if (negArt.agregarPrimerArticulo(art))
                            {
                                lblMensaje.Text = "Articulo agregado con exito.";
                            }
                            else
                            {
                                lblMensaje.Text = "Error al agregar Articulo";
                                i = 5;
                            }
                            break;
                        case 2:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "40";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                        case 3:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "42";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                        case 4:
                            art.IdArticulo = txtAgregar_IdArt.Text;
                            art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                            art.Talle = "44";
                            art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                            art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                            art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                            art.Nombre = txtAgregar_NombreArt.Text;
                            art.Descripcion = txtAgregar_DescArt.Text;
                            art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                            art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                            art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                            art.ImgProducto = txtAgregar_ImgArt.Text;
                            negArt.agregarArticulo(art);
                            break;
                    }
                }
            }
            else if (ddlAgregar_tdpArt.SelectedItem.ToString() == "Accesorios")
            {
                art.IdArticulo = txtAgregar_IdArt.Text;
                art.Sexo = negSexo.GetSexoId(ddlAgregar_SexoArt.SelectedValue);
                art.Talle = "U";
                art.Categoria = negCat.GetCatId(Convert.ToInt32(ddlAgregar_CatArt.SelectedValue));
                art.TipoPrenda = negTPD.GetTDPId(Convert.ToInt32(ddlAgregar_tdpArt.SelectedValue));
                art.Proveedor = negProv.GetProvId(ddlAgregar_ProvArt.SelectedValue);
                art.Nombre = txtAgregar_NombreArt.Text;
                art.Descripcion = txtAgregar_DescArt.Text;
                art.Precio = Convert.ToDecimal(txtAgregar_PrecioArt.Text);
                art.Stock = Convert.ToInt32(txtAgregar_StockArt.Text);
                art.Estado = Convert.ToBoolean(ddlAgregar_EstadoArt.SelectedValue);
                art.ImgProducto = txtAgregar_ImgArt.Text;
                if (negArt.agregarPrimerArticulo(art))
                {
                    lblMensaje.Text = "Articulo agregado con exito.";
                }
                else
                {
                    lblMensaje.Text = "Error al agregar Articulo";
                }
            }

        }
        protected void agregarCategoria_Click(object sender, EventArgs e)
        {
            Categorias CAT = new Categorias();
            CAT.IdCategoria = Int32.Parse(txtIDCat.Text);
            CAT.NombreDeporte = txtNombreDeporte.Text.ToString();
            int idcat = Int32.Parse(txtIDCat.Text);
            try
            {
                if (categorias.agregarCategoria(CAT, idcat) == 1)
                {
                    txtCategoria.Text = "Agregado con éxito";
                }
                else
                {
                    txtNombreDeporte.Text = "Error en la carga (¿El deporte ya está cargado?)";
                }
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    txtCategoria.Text = "Error: El ID ya existe en la base de datos";
                }
                else
                {
                    txtNombreDeporte.Text = "Error inesperado: " + ex.Message;
                }
            }

            txtIDCat.Text = "";
            txtNombreDeporte.Text = "";
        }
        protected void grdHistorial_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                NegocioDetalleVentas N = new NegocioDetalleVentas();
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string idVenta = grdHistorial.DataKeys[rowIndex].Value.ToString();
                DetalleVentas detalle = new DetalleVentas();
                GridView1.DataSource = N.ObtenerDetalle(Convert.ToInt32(idVenta));
                GridView1.DataBind();
                GridView1.Visible = true;
                grdHistorial.Visible = false;
            }
        }


        protected void grdEliminar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnEliminar = (LinkButton)e.Row.Cells[0].Controls[0];
                btnEliminar.OnClientClick = "return confirm('¿Estás seguro de que deseas eliminar este Articulo?');";
            }
        }

        protected void grdEliminarCat_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnEliminar = (LinkButton)e.Row.Cells[0].Controls[0];
                btnEliminar.OnClientClick = "return confirm('¿Estás seguro de que deseas eliminar esta Categoria?');";
            }
        }

        protected void grdEliminarTdp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnEliminar = (LinkButton)e.Row.Cells[0].Controls[0];
                btnEliminar.OnClientClick = "return confirm('¿Estás seguro de que deseas eliminar este Tipo de Prenda?');";
            }
        }

        protected void grdUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                LinkButton btnEliminar = (LinkButton)e.Row.Cells[0].Controls[2]; // Índice 2 para el botón de eliminar

                if (btnEliminar.CommandName == "Delete")
                {
                    btnEliminar.OnClientClick = "return confirm('¿Estás seguro de que deseas eliminar este Usuario?');";
                }
            }
        }







        /*---------------------------------------------------------------------------------------------*/
    }


}