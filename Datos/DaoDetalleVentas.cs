using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using System.Data.SqlClient;
using System.Data;

namespace Datos
{
    public class DaoDetalleVentas
    {
        AccesoDatos ds = new AccesoDatos();
        public DataTable getTablaDetalleVentas()
        {
            DataTable tabla = ds.ObtenerTabla("DETALLEVENTAS", "SELECT * FROM DETALLEVENTAS");
            return tabla;
        }

        public DetalleVentas getDetalleVenta(DetalleVentas dv)
        {
            DataTable tabla = ds.ObtenerTabla("DETALLEVENTAS", "SELECT * FROM DETALLEVENTAS WHERE IDVenta_DV = " + dv.IdVenta);
            dv.IdVenta = Convert.ToInt32(tabla.Rows[0][1]);
            dv.IdArticulo.IdArticulo = tabla.Rows[0][2].ToString();
            dv.IdSexo.IdSexo = tabla.Rows[0][3].ToString();
            dv.Talle.Talle = tabla.Rows[0][4].ToString();
            dv.Cantidad = Convert.ToInt32(tabla.Rows[0][5]);
            dv.PrecioUnitario.Precio = Convert.ToInt32(tabla.Rows[0][6]);
            return dv;
        }

        public int getLastIdVenta()
        {
            string consulta = "SELECT MAX (IDVenta_VE) FROM VENTAS";
            int id = ds.ejecutarProcedimientoIdVenta(consulta);
            return id;
        }
        public int EliminarDetalleVenta(DetalleVentas dv)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosDetalleVentaEliminar(ref cmd, dv);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarDetalleVenta");
        }

        public int AgregarDetalleVenta(DetalleVentas dv)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosDetalleVentaAgregar(ref cmd, dv);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarDetalleVenta");
        }
        public string ObtenerConsulta(string id, string idv)
        {
            string consulta = "SELECT DISTINCT [IDVENTA_DV] AS [Numero de venta], [IDART_DV] AS [ID Usuario], [IDSexo_DV], [TALLE_DV], [CANTIDAD_DV], [PRECIOUNITARIO_DV]" +
                "FROM DETALLEVENTAS INNER JOIN VENTAS ON IDVenta_DV = IDVenta_VE INNER JOIN USUARIOS ON IDUsuario_US = IDUsuario_VE" +
                " WHERE IDUsuario_US = '" + id + "' AND IDVenta_DV = '" + idv + "'";
            return consulta;
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarDetalleVenta]
        (
            @IDVENTA int
        )
        AS
        DELETE FROM DETALLEVENTAS WHERE IDVenta_DV = @IDVENTA
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarDetalleVenta]
        (
            @IDVENTA int, @IDART char(10), @IDSEXO char(1), @TALLE char(4), @CANTIDAD int, @PRECIOUNITARIO money
        )
        AS
        INSERT INTO DetalleVentaS (IDVenta_DV, IDArt_DV, IDSexo_DV, Talle_DV, Cantidad_DV, PrecioUnitario_DV)
        SELECT @IDVENTA, @IDART, @IDSEXO, @TALLE, @CANTIDAD, @PRECIOUNITARIO
        RETURN
        */

        private void ArmarParametrosDetalleVentaEliminar(ref SqlCommand cmd, DetalleVentas dv)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDVENTA", SqlDbType.Int);
            sqlParametros.Value = dv.IdVenta;
        }
        private void ArmarParametrosDetalleVentaAgregar(ref SqlCommand cmd, DetalleVentas dv)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDVENTA", SqlDbType.Int);
            sqlParametros.Value = dv.IdVenta;
            sqlParametros = cmd.Parameters.Add("@IDART", SqlDbType.Char);
            sqlParametros.Value = dv.IdArticulo.IdArticulo;
            sqlParametros = cmd.Parameters.Add("@IDSEXO", SqlDbType.Char);
            sqlParametros.Value = dv.IdSexo.IdSexo;
            sqlParametros = cmd.Parameters.Add("@TALLE", SqlDbType.Char);
            sqlParametros.Value = dv.Talle.Talle;
            sqlParametros = cmd.Parameters.Add("@CANTIDAD", SqlDbType.Int);
            sqlParametros.Value = dv.Cantidad;
            sqlParametros = cmd.Parameters.Add("@PRECIOUNITARIO", SqlDbType.Int);
            sqlParametros.Value = dv.PrecioUnitario.Precio;
        }
    }
}
