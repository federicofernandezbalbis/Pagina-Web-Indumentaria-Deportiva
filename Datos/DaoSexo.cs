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
    public class DaoSexo
    {
        AccesoDatos ds = new AccesoDatos();



        public DataTable getTablaSexo()
        {
            DataTable tabla = ds.ObtenerTabla("SEXO", "SELECT * FROM SEXO");
            return tabla;
        }

        public Sexo getSexo(Sexo sex)
        {
            DataTable tabla = ds.ObtenerTabla("SEXO", "SELECT * FROM SEXO WHERE IDSexo_SE = '" + sex.IdSexo+"'");
            sex.IdSexo = tabla.Rows[0][0].ToString();
            sex.Descripcion= tabla.Rows[0][1].ToString();
            return sex;
        }
    }
}
