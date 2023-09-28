using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Datos;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;

namespace Negocio
{
    public class NegocioVentas
    {
        AccesoDatos datos = new AccesoDatos();
        DaoVentas ventas = new DaoVentas();
        DaoDetalleVentas DV = new DaoDetalleVentas();

        public void cargarGridVentas(GridView grdHistorial, GridView grdEditar, NegocioVentas negVentas)
        {
            grdHistorial.DataSource = negVentas.ObtenerVentas();
            grdEditar.DataBind();
        }

        public NegocioVentas()
        {

        }

        public DataTable ObtenerVentas()
        {
            return ventas.getTablaVenta();
        }

        public void agregarNuevaVenta(Usuarios IdDniTelUsuario, int Total)
        {
            Ventas ve = new Ventas();
            ve.Usuario = IdDniTelUsuario;
            ve.Dni = IdDniTelUsuario;
            ve.Telefono = IdDniTelUsuario;
            ve.Total = Total;
            ventas.AgregarVenta(ve);
        }
        
        public string getDetalle(string idU, string idDV)
        {
            string consulta = DV.ObtenerConsulta(idU, idDV);
            return consulta;

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
            columna = new DataColumn("TALLE".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("CANTIDAD".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("PRECIO".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("IMAGEN", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            return dt;
        }

        public int getTotal(ListView listview)
        {
            int total = 0;

            foreach (ListViewItem item in listview.Items)
            {
                DropDownList ddl = (DropDownList)item.FindControl("CantArt");
                int cantidad = int.Parse(ddl.SelectedValue);
                Label lbl = (Label)item.FindControl("PrecioArt");
                int precio = Int32.Parse(lbl.Text.ToString());

                int valor = precio * cantidad;

                total += valor;
            }
            return total;
        }

        public void agregarFila(DataTable TablaCarrito, string[] valores)
        {

            DropDownList ddlTalle = new DropDownList();
            DropDownList ddlSexo = new DropDownList();
            DropDownList ddlCant = new DropDownList();

            ddlTalle.Items.Add(new ListItem("S", "S"));
            ddlTalle.Items.Add(new ListItem("M", "M"));
            ddlTalle.Items.Add(new ListItem("L", "L"));
            ddlTalle.Items.Add(new ListItem("XL", "XL"));

            ddlCant.Items.Add(new ListItem("1", "1"));
            ddlCant.Items.Add(new ListItem("2", "2"));
            ddlCant.Items.Add(new ListItem("3", "3"));
            ddlCant.Items.Add(new ListItem("4", "4"));
            ddlCant.Items.Add(new ListItem("5", "5"));

            for (int i = 0; i < valores.Length - 5; i += 6)
            {
                DataRow dr = TablaCarrito.NewRow();
                dr["ID ARTICULO".ToUpper()] = valores[i];
                dr["NOMBRE".ToUpper()] = valores[i + 1];
                dr["DESCRIPCION".ToUpper()] = valores[i + 2];
                dr["PRECIO"] = valores[i + 3];
                dr["IMAGEN"] = valores[i + 4];
                dr["TIPO DE PRENDA".ToUpper()] = valores[i + 5];
                dr["TALLE".ToUpper()] = ddlTalle.SelectedValue;
                dr["CANTIDAD".ToUpper()] = ddlCant.SelectedValue;
                TablaCarrito.Rows.Add(dr);
            }
        }
    }
}
