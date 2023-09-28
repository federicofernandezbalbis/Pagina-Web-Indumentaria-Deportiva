using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using Datos;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;

namespace Negocio
{
    public class NegocioCategoria
    {
        private DaoCategoria daoCat = new DaoCategoria();
        AccesoDatos datos = new AccesoDatos();
        DaoCategoria cat = new DaoCategoria();

        public NegocioCategoria()
        {

        }

        public void cargarGridCategorias(GridView grdEliminarCat, NegocioCategoria categorias)
        {
            grdEliminarCat.DataSource = categorias.ObtenerCat();
            grdEliminarCat.DataBind();
        }

        public DataTable ObtenerCat()
        {
            return daoCat.getTablaCategoria();
        }

        public Categorias GetCatId(int id)
        {
            Categorias cat = new Categorias();
            cat.IdCategoria = id;

            return daoCat.getCategoria(cat);
        }

        public int agregarCategoria(Categorias CAT, int ID)
        {
            string consulta = $"SELECT COUNT(*) FROM CATEGORIAS WHERE IDCategoria_CAT =" + ID + "";
            if (datos.existe(consulta))
            {
                int SeModifico = cat.AgregarCategoria(CAT);
                return SeModifico;
            }
            else
            {
                return 0;
            }

        }

        public int eliminarCategoria(Categorias categoria)
        {
            int FilasEliminadas = cat.EliminarCategoria(categoria);
            return FilasEliminadas;
        }
    }
}
