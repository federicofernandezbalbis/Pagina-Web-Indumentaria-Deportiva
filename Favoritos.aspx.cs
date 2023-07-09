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

        NegocioUsuarios usuarios = new NegocioUsuarios();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                if (Request.Cookies["Favoritos" + idUsuario] != null)
                {
                    HttpCookie ck = Request.Cookies["Favoritos" + idUsuario];
                    string[] valores = ck.Value.Split('|');
                    DataTable dt = new DataTable();
                    dt = crearTablaFavoritos();
                    filaFav(dt, valores);
                    lvFavoritos.DataSource = dt;
                    lvFavoritos.DataBind();
                }
            }
        }

        public DataTable crearTablaFavoritos()
        {
            DataTable dt = new DataTable();
            DataColumn columna = new DataColumn();
            columna = new DataColumn("ID ARTICULO", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("NOMBRE", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("DESCRIPCION".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("PRECIO".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("IMAGEN", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            return dt;
        }

        public void filaFav(DataTable TablaFavoritos, string[] valores)
        {
            for (int i = 0; i < valores.Length - 3; i += 5)
            {
                DataRow dr = TablaFavoritos.NewRow();
                dr["ID ARTICULO".ToUpper()] = valores[i];
                dr["NOMBRE".ToUpper()] = valores[i + 1];
                dr["DESCRIPCION".ToUpper()] = valores[i + 2];
                dr["PRECIO".ToUpper()] = valores[i + 3].ToString();
                dr["IMAGEN"] = valores[i+4];
                TablaFavoritos.Rows.Add(dr);
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

        protected void BtnEliminarFav_Click(object sender, EventArgs e)
        {
           
        }

    }
}