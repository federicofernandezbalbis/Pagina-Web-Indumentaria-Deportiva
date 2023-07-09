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
            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                if (Request.Cookies["Carrito" + idUsuario] != null)
                {
                    HttpCookie ck = Request.Cookies["Carrito" + idUsuario];
                    string[] valores = ck.Value.Split('|');
                    DataTable dt = new DataTable();
                    dt = crearTabla();
                    agregarFila(dt, valores);
                    grdCarrito.DataSource = dt;
                    grdCarrito.DataBind();
                }
            }
        }

        public DataTable crearTabla()
        {
            DataTable dt = new DataTable();
            DataColumn columna = new DataColumn();



            columna = new DataColumn("ID ARTICULO", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("NOMBRE", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("DESCRIPCION".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("TIPO DE PRENDA".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("TALLE".ToUpper(), typeof(DropDownList));
            dt.Columns.Add(columna);
            columna = new DataColumn("SEXO".ToUpper(), typeof(DropDownList));
            dt.Columns.Add(columna);
            columna = new DataColumn("CANTIDAD".ToUpper(), typeof(DropDownList));
            dt.Columns.Add(columna);
            columna = new DataColumn("PRECIO".ToUpper(), typeof(double));
            dt.Columns.Add(columna);

            return dt;
        }

        public void agregarFila(DataTable TablaCarrito, string[] valores)
        {

            DropDownList ddlTalle = new DropDownList();
            DropDownList ddlSexo = new DropDownList();
            DropDownList ddlCant = new DropDownList();

            ddlTalle.Items.Add(new ListItem("Talle S", "S"));
            ddlTalle.Items.Add(new ListItem("Talle M", "M"));
            ddlTalle.Items.Add(new ListItem("Talle L", "L"));
            ddlTalle.Items.Add(new ListItem("Talle XL", "XL"));

            ddlSexo.Items.Add(new ListItem("Opcion Hombre", "H"));
            ddlSexo.Items.Add(new ListItem("Opcion Hombre", "M"));

            ddlCant.Items.Add(new ListItem("cant 1", "1"));
            ddlCant.Items.Add(new ListItem("cant 2", "2"));
            ddlCant.Items.Add(new ListItem("cant 3", "3"));
            ddlCant.Items.Add(new ListItem("cant 4", "4"));
            ddlCant.Items.Add(new ListItem("cant 5", "5"));

            for (int i = 0; i < valores.Length - 4; i += 5)
            {
                DataRow dr = TablaCarrito.NewRow();
                dr["ID ARTICULO".ToUpper()] = valores[i];
                dr["NOMBRE".ToUpper()] = valores[i+1];
                dr["DESCRIPCION".ToUpper()] = valores[i+2];
                dr["TIPO DE PRENDA".ToUpper()] = valores[i + 3];
                dr["TALLE".ToUpper()] = ddlTalle;
                dr["SEXO".ToUpper()] = ddlSexo;
                dr["CANTIDAD".ToUpper()] = ddlCant;
                dr["PRECIO".ToUpper()] = valores[i+4];
                TablaCarrito.Rows.Add(dr);
            }
        }

        protected void grdCarrito_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                DropDownList ddlTalle = (DropDownList)e.Row.FindControl("ddlTalle");
                DropDownList ddlSexo = (DropDownList)e.Row.FindControl("ddlSexo");
                DropDownList ddlCantidad = (DropDownList)e.Row.FindControl("ddlCantidad");

                // Configura los valores para los DropDownList
                Articulos art = new Articulos();
                NegocioArticulos negArt = new NegocioArticulos();
                int tdp= Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TIPO DE PRENDA").ToString());

                

                if(tdp==5)
                {
                    ddlTalle.Items.Add(new ListItem("38", "38"));
                    ddlTalle.Items.Add(new ListItem("40", "40"));
                    ddlTalle.Items.Add(new ListItem("42", "42"));
                    ddlTalle.Items.Add(new ListItem("44", "44"));
                }
                else if(tdp == 6)
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

                ddlCantidad.Items.Add(new ListItem("1", "1"));
                ddlCantidad.Items.Add(new ListItem("2", "2"));
                ddlCantidad.Items.Add(new ListItem("3", "3"));
                ddlCantidad.Items.Add(new ListItem("4", "4"));
                ddlCantidad.Items.Add(new ListItem("5", "5"));
            }
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
            /*DECLARO LO QUE NECESITO*/
            NegocioUsuarios negUsu = new NegocioUsuarios();
            Usuarios usuario = new Usuarios();
            NegocioArticulos negArticulos = new NegocioArticulos();
            Articulos articulos = new Articulos();
            Sexo sexo = new Sexo();
            DataTable dt = (DataTable)grdCarrito.DataSource;


            /*AGREGO VENTA*/
            string idUsuario = Session["idUsuario"].ToString();
            usuario = negUsu.cargarInfoUsuario(Convert.ToInt32(Session["idUsuario"]));
            negVentas.agregarNuevaVenta(usuario, getTotal(dt));


            /*AGREGO DETALLE DE VENTA*/
            int aux = dt.Rows.Count;
            int idVenta = negDetVentas.getLastIdVenta();
            for (int i = 0; i < aux; i++)
            { 
                DropDownList ddlCantidad = (DropDownList)dt.Rows[i]["CANTIDAD"];
                DropDownList ddlTalle = (DropDownList)dt.Rows[i]["TALLE"];
                if (dt.Rows[Convert.ToInt32(i)]["NOMBRE"].ToString().Contains("Hombre"))
                {
                    sexo.IdSexo = "H";
                }
                else if (dt.Rows[i]["NOMBRE"].ToString().Contains("Mujer"))
                {
                    sexo.IdSexo = "M";
                }
                else
                {
                    sexo.IdSexo = "U";
                }
                articulos = negDetVentas.cargarArticuloDetalleVenta(dt.Rows[i]["ID ARTICULO"].ToString(), ddlTalle.SelectedValue.ToString(), Convert.ToInt32(dt.Rows[i]["PRECIO"]));
                if (negDetVentas.agregarNuevoDetalleVenta(idVenta, articulos, sexo, int.Parse(ddlCantidad.SelectedValue)))
                {
                    Label1.Text = "COMPRA REALIZADA";
                }
                else
                {
                    Label1.Text = "NO SE PUDO REALIZAR LA COMPRA";
                }
            }
        }

        public int getTotal(DataTable dt)
        {
            int total = 0;

            foreach (DataRow row in dt.Rows)
            {
                DropDownList ddl = (DropDownList)row["CANTIDAD"];
                int cantidad = Convert.ToInt32(ddl.SelectedValue);
                int precio = Convert.ToInt32(row["PRECIO"]);

                int valor = precio * cantidad;

                total += valor;
            }
            return total;
        }
    }
}