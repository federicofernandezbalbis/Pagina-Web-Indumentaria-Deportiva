using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using Entidades;
using Negocio;

namespace Proyecto2
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        NegocioVentas ventas = new NegocioVentas();
        NegocioUsuarios usuarios = new NegocioUsuarios();
        

        public int returnIdUsuario()
        {
            if (Session["idUsuario"] != null)
            {
                int id = (int)Session["idUsuario"];
                return id;
            }
            return -1;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                int id = returnIdUsuario();
                SqlDataSource1.SelectParameters["Param1"].DefaultValue = id.ToString();
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
        protected void VerDetalle_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                string[] valores = e.CommandArgument.ToString().Split('-');
                if (valores.Length == 2)
                {
                    string IdUser = valores[0];
                    string IdDv = valores[1];
                    SqlDataSource2.SelectParameters["Param1"].DefaultValue = IdUser;
                    SqlDataSource2.SelectParameters["Param2"].DefaultValue = IdDv;
                    ListView1.DataSourceID = "SqlDataSource2";
                    ListView1.DataBind();
                }
                else
                {
                }
            }
        }



    }
}