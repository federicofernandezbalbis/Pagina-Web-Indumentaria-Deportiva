using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;


namespace Datos
{
    public class AccesoDatos
    {
        String ruta = "Data Source=localhost\\sqlexpress; Initial Catalog=TIRO_LIBRE; Integrated Security=True";

        public AccesoDatos() { }

        public SqlConnection ObtenerConexion()
        {
            SqlConnection cn = new SqlConnection(ruta);
            try
            {
                cn.Open();
                return cn;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private SqlDataAdapter ObtenerAdaptador(String consultaSql, SqlConnection cn)
        {
            SqlDataAdapter adaptador;
            try
            {
                adaptador = new SqlDataAdapter(consultaSql, cn);
                return adaptador;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable ObtenerTabla(String NombreTabla, String Sql)
        {
            DataSet ds = new DataSet();
            SqlConnection Conexion = ObtenerConexion();
            SqlDataAdapter adp = ObtenerAdaptador(Sql, Conexion);
            adp.Fill(ds, NombreTabla);
            Conexion.Close();
            return ds.Tables[NombreTabla];
        }

        public int ejecutarProcedimiento(string consulta)
        {
            SqlConnection Conexion = ObtenerConexion();
            SqlCommand cmd = new SqlCommand(consulta, Conexion);
            int filas = cmd.ExecuteNonQuery();
            Conexion.Close();
            return filas;
        }

        public int ejecutarProcedimientoIdVenta(string consulta)
        {
            SqlConnection Conexion = ObtenerConexion();
            SqlCommand cmd = new SqlCommand(consulta, Conexion);
            int id = (int)cmd.ExecuteScalar();
            Conexion.Close();
            return id;
        }
        public int ejecutarProcedimientoAlmacenado(SqlCommand comando, string sp)
        {
            SqlConnection Conexion = ObtenerConexion();
            SqlCommand cmd = new SqlCommand();
            cmd = comando;
            cmd.Connection = Conexion;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = sp;
            int filas = cmd.ExecuteNonQuery();
            Conexion.Close();
            return filas;
        }
        public int EXEC_SP(SqlCommand comando, string sp)
        {
            SqlConnection Conexion = ObtenerConexion();
            SqlCommand cmd = new SqlCommand();
            cmd = comando;
            cmd.Connection = Conexion;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = sp;

            int resultado;
            try
            {
                object result = cmd.ExecuteScalar();
                resultado = Convert.ToInt32(result);
            }
            catch (Exception ex)
            {
                resultado = 0;
            }
            finally
            {
                Conexion.Close();
            }
            return resultado;
        }


        public Boolean existe(String consulta)
        {
            Boolean estado = false;
            SqlConnection Conexion = ObtenerConexion();
            SqlCommand cmd = new SqlCommand(consulta, Conexion);
            SqlDataReader datos = cmd.ExecuteReader();
            if (datos.Read())
            {
                estado = true;
            }
            return estado;
        }
    }
}
