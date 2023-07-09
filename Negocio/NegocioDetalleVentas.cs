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
    public class NegocioDetalleVentas
    {
        private DaoDetalleVentas daoDV = new DaoDetalleVentas();
        AccesoDatos datos = new AccesoDatos();

        public NegocioDetalleVentas()
        {

        }

        public DataTable ObtenerDetalle(int id)
        {
            DataTable tabla = datos.ObtenerTabla("DETALLEVENTAS", "SELECT * FROM DETALLEVENTAS WHERE IDVenta_DV =" + id + "");
            return tabla;
        }

        public DetalleVentas GetVentaId(int id)
        {
            DetalleVentas detalle = new DetalleVentas();
            detalle.IdVenta = id;

            return daoDV.getDetalleVenta(detalle);
        }

        public Articulos cargarArticuloDetalleVenta(string idArticulo, string talle, int precio)
        {
            Articulos art = new Articulos();
            art.IdArticulo = idArticulo;
            art.Talle = talle;
            art.Precio = precio;
            return art;
        }

        public Boolean agregarNuevoDetalleVenta(int idVenta, Articulos articulo, Sexo sexo, int cantidad)
        {
            DetalleVentas detVentas = new DetalleVentas();
            DaoDetalleVentas daoDetVentas = new DaoDetalleVentas();
            detVentas.IdVenta = idVenta;
            detVentas.IdArticulo = articulo;
            detVentas.IdSexo = sexo;
            detVentas.Talle = articulo;
            detVentas.Cantidad = cantidad;
            detVentas.PrecioUnitario = articulo;
            int Filas = daoDetVentas.AgregarDetalleVenta(detVentas);
            if (Filas != 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public int getLastIdVenta()
        {
            DaoDetalleVentas daoDetVentas = new DaoDetalleVentas();
            int id = daoDetVentas.getLastIdVenta();
            return id;
        }
    }
}
