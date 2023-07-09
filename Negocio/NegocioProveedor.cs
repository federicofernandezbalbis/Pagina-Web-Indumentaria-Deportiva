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
    public class NegocioProveedor
    {
        private DaoProveedores daoprov = new DaoProveedores();

        public NegocioProveedor()
        {

        }

        public DataTable ObtenerProv()
        {
            return daoprov.getTablaProveedores();
        }

        public Proveedores GetProvId(string id)
        {
            Proveedores Prov = new Proveedores();
            Prov.IdProveedor = id;

            return daoprov.getProveedor(Prov);

        }
    }
}
