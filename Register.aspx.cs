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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            NegocioUsuarios negUsu = new NegocioUsuarios();
            if (negUsu.existeNombreUsuario(txtNombreUsuario.Text))
            {
                lblNombreUsuario.Visible = true;
            }
            if (negUsu.existeDNIUsuario(txtDNI.Text))
            {
                lblDNI.Visible = true;
            }
            if (negUsu.existeMailUsuario(txtEmail.Text))
            {
                lblMail.Visible = true;
            }
            else
            {
                DateTime dt = DateTime.Parse(txtFecha.Text);
                negUsu.agregarNuevoUsuario(txtNombre.Text, txtApellido.Text, txtNombreUsuario.Text, txtDNI.Text, txtDireccion.Text, txtLocalidad.Text, ddlProvincias.SelectedItem.ToString(), txtEmail.Text, txtPass.Text, txtTelefono.Text, dt);
                lblAviso.Visible = true;
                limpiarTextBox();
            }
        }
        
        public void limpiarTextBox()
        {
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtNombreUsuario.Text = "";
            txtDNI.Text = "";
            txtDireccion.Text = "";
            txtLocalidad.Text = "";
            txtEmail.Text = "";
            txtPass.Text = "";
            txtRepetirContraseña.Text = "";
            txtTelefono.Text = "";
            ddlProvincias.SelectedIndex = 0;
            txtFecha.Text = "";
        }
    }
}