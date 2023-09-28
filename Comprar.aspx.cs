using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Entidades;
using Negocio;

namespace Proyecto2
{
    public partial class Comprar : System.Web.UI.Page
    {
        NegocioUsuarios usuarios = new NegocioUsuarios();
        NegocioVentas negVentas = new NegocioVentas();
        NegocioDetalleVentas negDetVentas = new NegocioDetalleVentas();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                Dictionary<int, string> valoresTalle = new Dictionary<int, string>();
                Dictionary<int, string> valoresCantidad = new Dictionary<int, string>();

                Session["ValoresTalle"] = valoresTalle;
                Session["ValoresCantidad"] = valoresCantidad;

                if (Session["idUsuario"] != null)
                {
                    string idUsuario = Session["idUsuario"].ToString();
                    if (Request.Cookies["Carrito" + idUsuario] != null)
                    {
                        HttpCookie ck = Request.Cookies["Carrito" + idUsuario];
                        string[] valores = ck.Value.Split('|');
                        DataTable dt = new DataTable();
                        dt = negVentas.crearTabla();
                        negVentas.agregarFila(dt, valores);
                        lvCarrito.DataSource = dt;
                        lvCarrito.DataBind();
                    }
                }
            }
        }

        protected void lvCarrito_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                Label lblID = (Label)e.Item.FindControl("IDArt");
                Label lblNombre = (Label)e.Item.FindControl("NombreArt");
                Label lblDescripcion = (Label)e.Item.FindControl("DescArt");
                Label lblPrecio = (Label)e.Item.FindControl("PrecioArt");
                ImageButton imgArt = (ImageButton)e.Item.FindControl("ImagenArt");
                DropDownList ddlTalle = (DropDownList)e.Item.FindControl("TalleArt");
                DropDownList ddlCantidad = (DropDownList)e.Item.FindControl("CantArt");

                string id = rowView["ID ARTICULO"].ToString();
                string nombre = rowView["NOMBRE"].ToString();
                string descripcion = rowView["DESCRIPCION"].ToString();
                string precio = rowView["PRECIO"].ToString();
                string img = rowView["IMAGEN"].ToString();
                string talle = rowView["TALLE"].ToString();
                string cantidad = rowView["CANTIDAD"].ToString();
                lblID.Text = id;
                lblNombre.Text = nombre;
                lblDescripcion.Text = descripcion;
                lblPrecio.Text = precio;
                imgArt.ImageUrl = img;
                ddlTalle.SelectedValue = talle;
                ddlCantidad.SelectedValue = cantidad;

                int tdp = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "TIPO DE PRENDA").ToString());

                ddlTalle.Items.Add(new ListItem("--Seleccione talle--", "--Seleccione talle--"));
                if (tdp == 5)
                {
                    ddlTalle.Items.Add(new ListItem("38", "38"));
                    ddlTalle.Items.Add(new ListItem("40", "40"));
                    ddlTalle.Items.Add(new ListItem("42", "42"));
                    ddlTalle.Items.Add(new ListItem("44", "44"));
                }
                else if (tdp == 6)
                {
                    ddlTalle.Items.Add(new ListItem("L", "L"));
                }
                else
                {
                    ddlTalle.Items.Add(new ListItem("S", "S"));
                    ddlTalle.Items.Add(new ListItem("M", "M"));
                    ddlTalle.Items.Add(new ListItem("L", "L"));
                    ddlTalle.Items.Add(new ListItem("XL", "XL"));
                }
                ddlCantidad.Items.Add(new ListItem("--Seleccione cantidad--", "--Seleccione cantidad--"));
                ddlCantidad.Items.Add(new ListItem("1", "1"));
                ddlCantidad.Items.Add(new ListItem("2", "2"));
                ddlCantidad.Items.Add(new ListItem("3", "3"));
                ddlCantidad.Items.Add(new ListItem("4", "4"));
                ddlCantidad.Items.Add(new ListItem("5", "5"));
            }
        }

        protected void BtnEliminarCarrito_Click(object sender, EventArgs e)
        {

        }

        protected void btnEliminar_Click(object sender, ImageClickEventArgs e)
        {

        }

        public void BtnBuscar_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim() != "")
            {
                Server.Transfer("Artículos.aspx");
            }
        }

        public Boolean esAdministrador()
        {
            int idUser;
            if (String.IsNullOrEmpty((string)Session["Username"]))
            {
                return false;
            }
            else
            {
                idUser = (int)Session["idUsuario"];
            }
            if (usuarios.esAdmin(idUser) == true)
            {
                return true;
            }
            return false;

        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Remove("Username");
            Session.Remove("idUsuario");
            Response.Redirect("Home.aspx");
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            bool compra = false;
            /*DECLARO LO QUE NECESITO*/
            NegocioUsuarios negUsu = new NegocioUsuarios();
            Usuarios usuario = new Usuarios();
            Articulos articulos = new Articulos();
            Sexo sexo = new Sexo();
            string idUsuario = Session["idUsuario"].ToString();
            if (Request.Cookies["Carrito" + idUsuario] != null)
            {
                HttpCookie ck = Request.Cookies["Carrito" + idUsuario];

                if (ck.Value != string.Empty)
                {
                    /*AGREGO VENTA*/
                    usuario = negUsu.cargarInfoUsuario(Convert.ToInt32(Session["idUsuario"]));
                    negVentas.agregarNuevaVenta(usuario, negVentas.getTotal(lvCarrito));


                    /*AGREGO DETALLE DE VENTA*/
                    int idVenta = negDetVentas.getLastIdVenta();
                    Dictionary<int, string> valoresTalle = (Dictionary<int, string>)Session["ValoresTalle"];
                    Dictionary<int, string> valoresCantidad = (Dictionary<int, string>)Session["ValoresCantidad"];

                    foreach (ListViewItem item in lvCarrito.Items)
                    {

                        Label lblPrecio = (Label)item.FindControl("PrecioArt");
                        int precio = int.Parse(lblPrecio.Text.ToString());

                        int itemIndex = item.DataItemIndex;
                        string talle = valoresTalle[itemIndex];
                        string cantidad = valoresCantidad[itemIndex];

                        Label lblIdArticulo = (Label)item.FindControl("IDArt");
                        string idArticulo = lblIdArticulo.Text.ToString();

                        Label lblNombre = (Label)item.FindControl("NombreArt");
                        string nombre = lblNombre.Text.ToString();

                        if (nombre.Contains("Hombre"))
                        {
                            sexo.IdSexo = "H";
                        }
                        else if (nombre.Contains("Mujer"))
                        {
                            sexo.IdSexo = "M";
                        }
                        else
                        {
                            sexo.IdSexo = "U";
                        }
                        articulos = negDetVentas.cargarArticuloDetalleVenta(idArticulo, talle, precio);
                        if (negDetVentas.agregarNuevoDetalleVenta(idVenta, articulos, sexo, int.Parse(cantidad)))
                        {
                            ck.Value = string.Empty;
                            Response.Cookies.Add(ck);
                            Session["ValoresTalle"] = null;
                            Session["ValoresCantidad"] = null;
                            compra = true;

                        }
                        else
                        {
                            compra = false;

                        }
                    }
                    Response.Redirect(Request.RawUrl);
                    if (compra)
                    {
                        Label1.Text = "COMPRA REALIZADA";
                    }
                    else
                    {
                        Label1.Text = "NO SE PUDO REALIZAR LA COMPRA";
                    }
                }
            }
        }

        protected void TalleArt_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlTalle = (DropDownList)sender;
            ListViewItem listViewItem = (ListViewItem)ddlTalle.NamingContainer;

            int itemIndex = listViewItem.DataItemIndex;
            string talle = ddlTalle.SelectedValue;

            Dictionary<int, string> valoresTalle = (Dictionary<int, string>)Session["ValoresTalle"];
            valoresTalle[itemIndex] = talle;
        }

        protected void CantArt_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlCantidad = (DropDownList)sender;
            ListViewItem listViewItem = (ListViewItem)ddlCantidad.NamingContainer;

            int itemIndex = listViewItem.DataItemIndex;
            string cantidad = ddlCantidad.SelectedValue;

            Dictionary<int, string> valoresCantidad = (Dictionary<int, string>)Session["ValoresCantidad"];
            valoresCantidad[itemIndex] = cantidad;
        }

        protected void btnBorrarCarrito_Click(object sender, EventArgs e)
        {
            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                HttpCookie ck = Request.Cookies["Carrito" + idUsuario];
                if (ck.Value != null)
                {
                    ck.Value = string.Empty;
                    Response.Cookies.Add(ck);
                    Response.Redirect(Request.RawUrl);
                }
            }
        }
    }
}