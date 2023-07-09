using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace Proyecto2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        NegocioUsuarios usuarios = new NegocioUsuarios();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            //catch (Exception ex)
            //{
            //    // Manejo de la excepción
            //    // Redireccionar a la página Login.aspx
            //    Session.Remove("Username");
            //    Session.Remove("idUsuario");
            //    Response.Redirect("Login.aspx");
            //}
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
            } else {
                idUser = (int) Session["idUsuario"];
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
    }
}