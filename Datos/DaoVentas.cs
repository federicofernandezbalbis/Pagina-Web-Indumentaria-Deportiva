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
    public class DaoVentas
    {
        AccesoDatos ds = new AccesoDatos();

        public DataTable getTablaVenta()
        {
            DataTable tabla = ds.ObtenerTabla("VENTAS", "SELECT * FROM VENTAS");
            return tabla;
        }

        public Ventas getVenta(Ventas ven)
        {
            DataTable tabla = ds.ObtenerTabla("VENTA", "SELECT * FROM VENTA WHERE IDVenta_VE = " + ven.IdVenta);
            ven.IdVenta = Convert.ToInt32(tabla.Rows[0][1].ToString());
            ven.Usuario.IdUsuario = Convert.ToInt32(tabla.Rows[0][2].ToString());
            ven.Usuario.Dni = tabla.Rows[0][3].ToString();
            ven.Usuario.Telefono = tabla.Rows[0][4].ToString();
            ven.Total = Convert.ToInt32(tabla.Rows[0][5]);
            ven.Fecha = Convert.ToDateTime(tabla.Rows[0][6]);
            return ven;
        }

        public int EliminarVenta(Ventas ven)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosVentaEliminar(ref cmd, ven);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarVenta");
        }

        public int AgregarVenta(Ventas ven)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosVentaAgregar(ref cmd, ven);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarVenta");
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarVenta]
        (
            @IDVENTA int
        )
        AS
        DELETE FROM VENTAS WHERE IDVenta_VE = @IDVENTA
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarVenta]
        (
            @IDVENTA int, @IDUSUARIO char(10), @DNI varchar(10), @TELEFONO varchar(20), @TOTAL money, @FECHA datetime
        )
        AS
        INSERT INTO VENTAS (IDVenta_VE, IDUsuario_VE, DNI_US, Telefono_US, Total_US, Fecha_US)
        SELECT @IDVENTA, @IDUSUARIO, @DNI, @TELEFONO, @TOTAL, @FECHA
        RETURN
        */

        private void ArmarParametrosVentaEliminar(ref SqlCommand cmd, Ventas ven)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDVENTA", SqlDbType.Int);
            sqlParametros.Value = ven.IdVenta;
        }
        private void ArmarParametrosVentaAgregar(ref SqlCommand cmd, Ventas ven)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDUSUARIO", SqlDbType.Char);
            sqlParametros.Value = ven.Usuario.IdUsuario;
            sqlParametros = cmd.Parameters.Add("@DNI", SqlDbType.Char);
            sqlParametros.Value = ven.Usuario.Dni;
            sqlParametros = cmd.Parameters.Add("@TELEFONO", SqlDbType.Char);
            sqlParametros.Value = ven.Usuario.Telefono;
            sqlParametros = cmd.Parameters.Add("@TOTAL", SqlDbType.Char);
            sqlParametros.Value = ven.Total;
        }
    }
}
