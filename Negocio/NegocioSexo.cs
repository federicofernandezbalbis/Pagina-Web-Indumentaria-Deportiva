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
    public class NegocioSexo
    {
        private DaoSexo daoSex = new DaoSexo();

        public NegocioSexo()
        {

        }

        public DataTable ObtenerSexo()
        {
            return daoSex.getTablaSexo();
        }

        public Sexo GetSexoId(String id)
        {
            Sexo sexo = new Sexo();
            sexo.IdSexo = id;

            return daoSex.getSexo(sexo);

        }
    }
}
