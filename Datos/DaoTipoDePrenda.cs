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
    public class DaoTipoDePrenda
    {
        AccesoDatos ds = new AccesoDatos();

        public DataTable getTablaTipoPrenda()
        {
            DataTable tabla = ds.ObtenerTabla("TIPODEPRENDA", "SELECT * FROM TIPODEPRENDA WHERE [Estado_TDP] = 1");
            return tabla;
        }

        public TipoDePrenda getTipoPrenda(TipoDePrenda tdp)
        {
            DataTable tabla = ds.ObtenerTabla("TIPODEPRENDA", "SELECT * FROM TIPODEPRENDA WHERE IDTipo_TDP = " + tdp.IdTipoPrenda + " AND [Estado_TDP] = 1");
            tdp.IdTipoPrenda = Convert.ToInt32(tabla.Rows[0][0].ToString());
            tdp.Descripcion= tabla.Rows[0][1].ToString();
            return tdp;
        }

        public int EliminarTipoDePrenda(TipoDePrenda tdp)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosTipoDePrendaEliminar(ref cmd, tdp);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarTipoDePrenda");
        }

        public int AgregarTipoDePrenda(TipoDePrenda tdp)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosTipoDePrendaAgregar(ref cmd, tdp);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarTipoDePrenda");
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarTipoDePrenda]
        (
            @IDTIPODEPRENDA int
        )
        AS
        DELETE FROM TIPODEPRENDA WHERE IDTipo_TDP = @IDTIPODEPRENDA
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarTipoDePrenda]
        (
            @IDTIPODEPRENDA int, @DESCRIPCION varchar(50)
        )
        AS
        INSERT INTO TIPODEPRENDA (IDTipo_TDP, Descripcion_TDP)
        SELECT @IDTIPODEPRENDA, @DESCRIPCION
        RETURN
        */

        private void ArmarParametrosTipoDePrendaEliminar(ref SqlCommand cmd, TipoDePrenda tdp)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDTIPODEPRENDA", SqlDbType.Int);
            sqlParametros.Value = tdp.IdTipoPrenda;
        }
        private void ArmarParametrosTipoDePrendaAgregar(ref SqlCommand cmd, TipoDePrenda tdp)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDTIPODEPRENDA", SqlDbType.Int);
            sqlParametros.Value = tdp.IdTipoPrenda;
            sqlParametros = cmd.Parameters.Add("@DESCRIPCION", SqlDbType.Char);
            sqlParametros.Value = tdp.Descripcion;
        }
    }
}
