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
    public class DaoCategoria
    {
        AccesoDatos ds = new AccesoDatos();

        public DataTable getTablaCategoria()
        {
            DataTable tabla = ds.ObtenerTabla("CATEGORIAS", "SELECT * FROM CATEGORIAS WHERE [Estado_CAT] = 1");
            return tabla;
        }

        public Categorias getCategoria(Categorias cat)
        {
            DataTable tabla = ds.ObtenerTabla("CATEGORIAS", "SELECT * FROM CATEGORIAS WHERE IDCategoria_CAT = " + cat.IdCategoria + " AND [Estado_CAT] = 1");
            cat.IdCategoria = Convert.ToInt32(tabla.Rows[0][0].ToString());
            cat.NombreDeporte = tabla.Rows[0][1].ToString();
            return cat;
        }

        public int EliminarCategoria(Categorias art)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosCategoriaEliminar(ref cmd, art);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarCategoria");
        }

        public int AgregarCategoria(Categorias art)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosCategoriaAgregar(ref cmd, art);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarCategoria");
        }
        public bool existeCat(string query, int ID)
        {
            using (SqlConnection cn = ds.ObtenerConexion())
            {
                using (SqlCommand command = new SqlCommand(query, cn))
                {
                    command.Parameters.AddWithValue("@ID", ID);
                    int count = Convert.ToInt32(command.ExecuteScalar());
                    return count == 0;
                }
            }  
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarCategoria]
        (
            @IDCategoria int
        )
        AS
        DELETE FROM CATEGORIAS WHERE IDCategoria_CAT = @IDCategoria
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarCategoria]
        (
            @IDCATEGORIA int, @NOMBREDEPORTE varchar(50)
        )
        AS
        INSERT INTO CATEGORIAS (IDCategoria_CAT, NombreDeporte_CAT)
        SELECT @IDCATEGORIA, @NOMBREDEPORTE
        RETURN
        */

        private void ArmarParametrosCategoriaEliminar(ref SqlCommand cmd, Categorias cat)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDCATEGORIA", SqlDbType.Int);
            sqlParametros.Value = cat.IdCategoria;
        }
        private void ArmarParametrosCategoriaAgregar(ref SqlCommand cmd, Categorias cat)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDCategoria", SqlDbType.Int);
            sqlParametros.Value = cat.IdCategoria;
            sqlParametros = cmd.Parameters.Add("@NOMBREDEPORTE", SqlDbType.Char);
            sqlParametros.Value = cat.NombreDeporte;
        }

    }
}
