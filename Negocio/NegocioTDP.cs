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
    public class NegocioTDP
    {
        private DaoTipoDePrenda daoTDP = new DaoTipoDePrenda();
        AccesoDatos datos = new AccesoDatos();


        public NegocioTDP()
        {

        }

        public void cargarGridTDP(GridView grdEliminarTdp, NegocioTDP tipodeprendas)
        {
            grdEliminarTdp.DataSource = tipodeprendas.ObtenerTDP();
            grdEliminarTdp.DataBind();
        }

        public DataTable ObtenerTDP()
        {
            return daoTDP.getTablaTipoPrenda();
        }

        public TipoDePrenda GetTDPId(int id)
        {
            TipoDePrenda TDP = new TipoDePrenda();
            TDP.IdTipoPrenda = id;

            return daoTDP.getTipoPrenda(TDP);
        }
        public int agregarTDP(TipoDePrenda tipo, int ID)
        {

            string consulta = $"SELECT COUNT(*) FROM TIPODEPRENDA WHERE IDTipo_TDP =" + ID + "";
            if (datos.existe(consulta))
            {
                int SeModifico = daoTDP.AgregarTipoDePrenda(tipo);
                return SeModifico;
            }
            else
            {
                return 0;
            }
        }

        public int eliminarTDP(TipoDePrenda tdp)
        {
            int FilasEliminadas = daoTDP.EliminarTipoDePrenda(tdp);
            return FilasEliminadas;
        }

    }
}
