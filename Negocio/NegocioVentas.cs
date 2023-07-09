using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Datos;
using System.Data.SqlClient;
using System.Data;

namespace Negocio
{
    public class NegocioVentas
    {
        AccesoDatos datos = new AccesoDatos();
        DaoVentas ventas = new DaoVentas();
        DaoDetalleVentas DV = new DaoDetalleVentas();

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
    }
}
