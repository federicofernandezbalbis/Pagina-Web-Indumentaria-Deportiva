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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        NegocioUsuarios negLog = new NegocioUsuarios();

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            String mail = txtMail.Text.ToString();
            String pass = txtClave.Text.ToString();
            Usuarios usuario = new Usuarios();
            usuario.Mail = mail;
            usuario.Contrasenia = pass;

            if ((bool)negLog.checkUsuario(usuario))
            {
                int id = negLog.getIDUsuario(mail);
                string username = negLog.getUsername(mail);
                Session["idUsuario"] = id;
                Session["Username"] = username;
                Response.Redirect("InfoUsuario.aspx");
            }
            else if (negLog.existeMailUsuario(txtMail.Text.ToString()) == true && negLog.existeContraseñaUsuario(txtClave.Text.ToString()) == false)
            {
                lblError2.Visible = true;
            }
            else if (negLog.existeMailUsuario(txtMail.Text.ToString()) == false && negLog.existeContraseñaUsuario(txtClave.Text.ToString()) == true)
            {
                lblError.Visible = true;
            }
            else
            {
                lblError.Visible = true;
                lblError2.Visible = true;
            }
        }
    }
}