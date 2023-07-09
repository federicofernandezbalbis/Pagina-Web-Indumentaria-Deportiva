using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Entidades;
using Negocio;

namespace Proyecto2
{
    public partial class InfoUsuario : System.Web.UI.Page
    {
        NegocioUsuarios negUsu = new NegocioUsuarios();
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
            try
            {
                if(Session["idUsuario"]!=null && !String.IsNullOrEmpty((string)Session["Username"]))
                {
                    if (IsPostBack == false)
                    {
                        int id = returnIdUsuario();
                        Usuarios usu = new Usuarios();
                        usu = negUsu.cargarInfoUsuario(id);
                        cargarLabel(usu);
                    }
                }
            }
            catch(Exception ex)
            {
                Response.Redirect("Login.aspx");
            }

        }
        public void cargarLabel(Usuarios usuID)
        {
            lblNombre.Text = usuID.Nombre;
            lblApellido.Text = usuID.Apellido;
            lblNombreUsuario.Text = usuID.NombreUsuario;
            lblDNI.Text = usuID.Dni;
            lblEmail.Text = usuID.Mail;
            lblDireccion.Text = usuID.Direccion;
            lblTelefono.Text = usuID.Telefono;
            lblFechaNacimiento.Text = usuID.FechaNacimiento.ToString();
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
            if (negUsu.esAdmin(idUser) == true)
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