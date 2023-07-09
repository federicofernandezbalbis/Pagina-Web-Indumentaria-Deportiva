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

    public partial class Artículos : System.Web.UI.Page
    {
        NegocioArticulos negArticulos = new NegocioArticulos();
        NegocioUsuarios usuarios = new NegocioUsuarios();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                if (PreviousPage != null)
                {
                    String search;
                    search = ((TextBox)PreviousPage.FindControl("txtSearch")).Text.Trim();
                    if (search != "")
                    {
                        SqlDataSource2.SelectParameters["Param1"].DefaultValue = search;
                        lvArticulos.DataSourceID = "SqlDataSource2";
                        txtSearch.Text = "";
                    }
                }
            }
            if (ViewState["SqlDataSource1SelectCommand"] != null)
            {
                SqlDataSource1.SelectCommand = ViewState["SqlDataSource1SelectCommand"].ToString();
            }
            txtSearch.Text = "";
        }

        public void BtnBuscar_Click(object sender, EventArgs e)
        {
            string inputValue = txtSearch.Text;
            if (inputValue.Trim() != "")
            {
                SqlDataSource2.SelectParameters["Param1"].DefaultValue = inputValue;
                lvArticulos.DataSourceID = "SqlDataSource2";
                inputValue = "";
            }
        }

    /*    public SqlDataSource buscarPorNombre(SqlDataSource sc, string consulta)
        {
            sc.SelectCommand = consulta;
            return sc;
        }*/

        protected void btnAgregarCarrito_Command(object sender, CommandEventArgs e)
        {
            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                if (Request.Cookies["Carrito" + idUsuario] == null)
                {
                    HttpCookie ck = new HttpCookie("Carrito" + idUsuario);
                    ck.Expires = DateTime.Now.AddYears(1);
                    ck.Value = "";
                    if (e.CommandName == "eventoAgregarCarrito")
                    {
                        string[] valores = e.CommandArgument.ToString().Split('-');
                        string id, tdp;
                        string des = null, nom = null;
                        string precio;
                        id = valores[0];
                        nom = valores[1];
                        des = valores[2];
                        tdp = valores[3];
                        precio = valores[4];
                        ck.Value += id + "|" + nom + "|" + des + "|" + tdp + "|" + precio + "|";
                        Response.Cookies.Add(ck);
                    }
                }
                else
                {
                    HttpCookie ck = Request.Cookies["Carrito" + idUsuario];
                    if (e.CommandName == "eventoAgregarCarrito")
                    {
                        string[] valores = e.CommandArgument.ToString().Split('-');
                        string id, tdp;
                        string des = null, nom = null;
                        string precio;
                        id = valores[0];
                        nom = valores[1];
                        des = valores[2];
                        tdp = valores[3];
                        precio = valores[4];
                        ck.Value += id + "|" + nom + "|" + des + "|" + tdp + "|" + precio + "|";
                        Response.Cookies.Add(ck);
                    }
                }
            }
        }

        protected void btnAgregarFavoritos_Command(object sender, CommandEventArgs e)
        {
            if (Session["idUsuario"] != null)
            {
                string idUsuario = Session["idUsuario"].ToString();
                if (Request.Cookies["Favoritos" + idUsuario] == null)
                {
                    HttpCookie ck = new HttpCookie("Favoritos" + idUsuario);
                    ck.Expires = DateTime.Now.AddYears(1);
                    ck.Value = "";
                    if (e.CommandName == "eventoAgregarFavoritos")
                    {
                        string[] valores = e.CommandArgument.ToString().Split('-');
                        string img;
                        string id;
                        string des = null, nom = null;
                        string precio;
                        img = valores[0];
                        id = valores[1];
                        nom = valores[2];
                        des = valores[3];
                        precio = valores[4];
                        ck.Value += img + "|" + id + "|" + nom + "|" + des + "|" + precio + "|";
                        Response.Cookies.Add(ck);
                    }
                }
                else
                {
                    HttpCookie ck = Request.Cookies["Favoritos" + idUsuario];
                    if (e.CommandName == "eventoAgregarFavoritos")
                    {
                        string[] valores = e.CommandArgument.ToString().Split('-');
                        string img;
                        string id;
                        string des = null, nom = null;
                        string precio;
                        img = valores[0];
                        id = valores[1];
                        nom = valores[2];
                        des = valores[3];
                        precio = valores[4];
                        ck.Value += img + "|" + id + "|" + nom + "|" + des + "|" + precio + "|";
                        Response.Cookies.Add(ck);
                    }
                }
            }
        }
        protected void ddlOrdenarPor_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddlOrdenarPor.SelectedIndex)
            {
                case 1:
                        SqlDataSource1.SelectCommand = negArticulos.precioMasBajo();
                        lvArticulos.DataSourceID = "SqlDataSource1";
                        lvArticulos.DataBind();
                    break;
                case 2:
                        SqlDataSource1.SelectCommand = negArticulos.precioMasAlto();
                        lvArticulos.DataSourceID = "SqlDataSource1";
                        lvArticulos.DataBind();
                    break;
                case 3:
                    SqlDataSource1.SelectCommand = negArticulos.restablecer();
                    lvArticulos.DataSourceID = "SqlDataSource1";
                    lvArticulos.DataBind();
                    break;
                default:
                    break;
            }
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }

        protected void btnFutbol_Click(object sender, ImageClickEventArgs e)
        {
            string deporte = "1";
            SqlDataSource1.SelectCommand = negArticulos.ordenarPorDeporte(deporte);
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }

        protected void btnTenis_Click(object sender, ImageClickEventArgs e)
        {
            string deporte = "2";
            SqlDataSource1.SelectCommand = negArticulos.ordenarPorDeporte(deporte);
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }

        protected void btnBasquet_Click(object sender, ImageClickEventArgs e)
        {
            string deporte = "3";
            SqlDataSource1.SelectCommand = negArticulos.ordenarPorDeporte(deporte);
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }

        protected void btnRugby_Click(object sender, ImageClickEventArgs e)
        {
            string deporte = "4";
            SqlDataSource1.SelectCommand = negArticulos.ordenarPorDeporte(deporte);
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }

        protected void btnAccesorios_Click(object sender, ImageClickEventArgs e)
        {
            string deporte = "6";
            SqlDataSource1.SelectCommand = negArticulos.ordenarPorDeporte(deporte);
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
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

        protected void rblCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            int indice = rblCategorias.Items.IndexOf(rblCategorias.SelectedItem);
            switch (indice)
            {
                case 0:                  
                    SqlDataSource1.SelectCommand = negArticulos.RealizarConsultaTDP("1");
                    break;
                case 1:
                    SqlDataSource1.SelectCommand = negArticulos.RealizarConsultaTDP("2");
                    break;
                case 2:
                    SqlDataSource1.SelectCommand = negArticulos.RealizarConsultaTDP("3");
                    break;
                case 3:
                    SqlDataSource1.SelectCommand = negArticulos.RealizarConsultaTDP("4");
                    break;
                case 4:
                    SqlDataSource1.SelectCommand = negArticulos.RealizarConsultaTDP("5");
                    break;
            }
            lvArticulos.DataSourceID = "SqlDataSource1";
            lvArticulos.DataBind();
            ViewState["SqlDataSource1SelectCommand"] = SqlDataSource1.SelectCommand;
        }
    }
}
