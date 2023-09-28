using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using Negocio;

namespace Proyecto2
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        NegocioArticulos negArt = new NegocioArticulos();
        NegocioUsuarios usuarios = new NegocioUsuarios();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                if (Session["idUsuario"] != null)
                {
                    string idUsuario = Session["idUsuario"].ToString();
                    if (Request.Cookies["Favoritos" + idUsuario] != null)
                    {
                        HttpCookie ck = Request.Cookies["Favoritos" + idUsuario];
                        string[] valores = ck.Value.Split('|');
                        DataTable dt = new DataTable();
                        dt = negArt.crearTablaFavoritos();
                        negArt.agregarFilaFav(dt, valores);
                        lvFavoritos.DataSource = dt;
                        lvFavoritos.DataBind();
                    }
                }
            }
        }
        
        protected void lvFavoritos_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                Label lblID = (Label)e.Item.FindControl("IDArt");
                Label lblNombre = (Label)e.Item.FindControl("NombreArt");
                Label lblDescripcion = (Label)e.Item.FindControl("DescArt");
                Label lblPrecio = (Label)e.Item.FindControl("PrecioArt");
                ImageButton imgArt = (ImageButton)e.Item.FindControl("ImagenArt");

                string id = rowView["ID ARTICULO"].ToString();
                string nombre = rowView["NOMBRE"].ToString();
                string descripcion = rowView["DESCRIPCION"].ToString();
                string precio = rowView["PRECIO"].ToString();
                string img = rowView["IMAGEN"].ToString();
                lblID.Text = id;
                lblNombre.Text = nombre;
                lblDescripcion.Text = descripcion;
                lblPrecio.Text = precio;
                imgArt.ImageUrl = img;
            }
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

        protected void btnBorrarFavoritos_Click(object sender, EventArgs e)
        {
            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                HttpCookie ck = Request.Cookies["Favoritos" + idUsuario];
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