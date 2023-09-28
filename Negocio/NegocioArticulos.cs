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
    public class NegocioArticulos
    {
        DaoArticulos datosArt = new DaoArticulos();
        AccesoDatos datos = new AccesoDatos();
        public void cargarGrid(GridView grdEditar, GridView grdEliminar, NegocioArticulos articulos)
        {
            grdEditar.DataSource = articulos.obtenerArticulosEditar();
            grdEditar.DataBind();

            grdEliminar.DataSource = articulos.obtenerArticulos();
            grdEliminar.DataBind();
        }

        public void llenarDDLS(DropDownList ddlAgregar_SexoArt, DropDownList ddlAgregar_CatArt, DropDownList ddlAgregar_tdpArt, DropDownList ddlAgregar_ProvArt)
        {
            NegocioSexo negSexo = new NegocioSexo();
            DataTable dtSexo = negSexo.ObtenerSexo();

            ddlAgregar_SexoArt.DataSource = dtSexo;
            ddlAgregar_SexoArt.DataValueField = "IDSexo_SE";
            ddlAgregar_SexoArt.DataTextField = "Descripcion_SE";
            ddlAgregar_SexoArt.DataBind();

            NegocioCategoria negCat = new NegocioCategoria();
            DataTable dtCat = negCat.ObtenerCat();

            ddlAgregar_CatArt.DataSource = dtCat;
            ddlAgregar_CatArt.DataValueField = "IDCategoria_CAT";
            ddlAgregar_CatArt.DataTextField = "NombreDeporte_CAT";
            ddlAgregar_CatArt.DataBind();

            NegocioTDP negTPD = new NegocioTDP();
            DataTable dtTDP = negTPD.ObtenerTDP();

            ddlAgregar_tdpArt.DataSource = dtTDP;
            ddlAgregar_tdpArt.DataValueField = "IDTipo_TDP";
            ddlAgregar_tdpArt.DataTextField = "Descripcion_TDP";
            ddlAgregar_tdpArt.DataBind();

            NegocioProveedor negProv = new NegocioProveedor();
            DataTable dtProv = negProv.ObtenerProv();

            ddlAgregar_ProvArt.DataSource = dtProv;
            ddlAgregar_ProvArt.DataValueField = "ID";
            ddlAgregar_ProvArt.DataTextField = "RazonSocial_PR";
            ddlAgregar_ProvArt.DataBind();

        }

        public bool agregarArticulo(Articulos art)
        {
            int cantFilas = 0;

            Articulos cat = new Articulos();

            if (datosArt.existeArticulo(art) == false)
            {
                cantFilas = datosArt.AgregarArticulo(art);
            }

            if (cantFilas == 1)
                return true;
            else
                return false;
        }

        public bool agregarPrimerArticulo(Articulos art)
        {
            int cantFilas = 0;

            Articulos cat = new Articulos();

            if (datosArt.existePrimerArticulo(art) == false)
            {
                cantFilas = datosArt.AgregarArticulo(art);
            }

            if (cantFilas == 1)
                return true;
            else
                return false;
        }

        public DataTable obtenerArticulos()
        {
            DataTable tabla = datosArt.getTablaArticulos();
            return tabla;
        }

        public DataTable obtenerArticulosEditar()
        {
            DataTable tabla = datosArt.getTablaArticulosEditar();
            return tabla;

        }

        public int eliminarArticuloNegocio(Articulos art)
        {
            int FilasEliminadas = datosArt.EliminarArticulo(art);
            return FilasEliminadas;
        }

        public int editarArticuloNegocio(Articulos art)
        {
            int FilasEditadas = datosArt.actualizarArticulo(art);
            return FilasEditadas;
        }

        public string getID(Articulos Art)
        {
            DataTable tabla = datos.ObtenerTabla("ARTICULOS", "SELECT * FROM ARTICULOS WHERE IDArt_AR = '" + Art.IdArticulo + "'");
            Art.IdArticulo = tabla.Rows[0][1].ToString();
            return Art.IdArticulo;
        }

        public Articulos getArticulo(string id)
        {
            Articulos art = new Articulos();
            id = getID(art);
            DataTable tabla = datos.ObtenerTabla("ARTICULOS", "SELECT * FROM ARTICULOS WHERE IDArt_AR = '" + id + "'");
            art.IdArticulo = tabla.Rows[0][0].ToString();
            art.Nombre = tabla.Rows[0][6].ToString();
            art.Descripcion = tabla.Rows[0][7].ToString();
            art.Precio = Convert.ToInt32(tabla.Rows[0][8].ToString());
            art.ImgProducto = tabla.Rows[0][11].ToString();
            return art;
        }

        public Articulos getArticuloPorId(string id)
        {
            Articulos art = new Articulos();
            TipoDePrenda tdp = new TipoDePrenda();
            
            DataTable tabla = datos.ObtenerTabla("ARTICULOS", "SELECT * FROM ARTICULOS WHERE IDArt_AR = '" + id + "'");
            art.IdArticulo = tabla.Rows[0][0].ToString();
            tdp.idTipoPrenda = Convert.ToInt32(tabla.Rows[0][4].ToString());
            art.TipoPrenda = tdp;
            art.Nombre = tabla.Rows[0][6].ToString();
            art.Descripcion = tabla.Rows[0][7].ToString();
            art.Precio = Convert.ToInt32(tabla.Rows[0][8]);
            art.ImgProducto = tabla.Rows[0][11].ToString();
            return art;
        }

        public string precioMasAlto()
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [Estado_AR] = 1 ORDER BY Precio_AR DESC";
                return consulta;
        }
        
        public string precioMasBajo()
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [Estado_AR] = 1 ORDER BY Precio_AR ASC";
                return consulta;
        }

        public string restablecer()
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [Estado_AR] = 1";
            return consulta;
        }
        
        public string ordenarPorDeporte(string deporte)
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [IDCategoria_AR]=" + deporte + " AND [Estado_AR] = 1";
            return consulta;
        }
        
        public string RealizarConsultaTDP(string cat)
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [IDTipo_AR]=" + cat + " AND [Estado_AR] = 1";
            return consulta;
        }

        public string RealizarConsultaSexo(string sex)
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [IDSexo_AR]= '" + sex + "' AND [Estado_AR] = 1";
            return consulta;
        }

        public DataTable crearTablaFavoritos()
        {
            DataTable dt = new DataTable();
            DataColumn columna = new DataColumn();
            columna = new DataColumn("ID ARTICULO", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("NOMBRE", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("DESCRIPCION".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("PRECIO".ToUpper(), System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            columna = new DataColumn("IMAGEN", System.Type.GetType("System.String"));
            dt.Columns.Add(columna);
            return dt;
        }

        public void agregarFilaFav(DataTable TablaFavoritos, string[] valores)
        {
            for (int i = 0; i < valores.Length - 4; i += 5)
            {
                DataRow dr = TablaFavoritos.NewRow();
                dr["ID ARTICULO".ToUpper()] = valores[i];
                dr["NOMBRE".ToUpper()] = valores[i + 1];
                dr["DESCRIPCION".ToUpper()] = valores[i + 2];
                dr["PRECIO".ToUpper()] = valores[i + 3].ToString();
                dr["IMAGEN"] = valores[i + 4];
                TablaFavoritos.Rows.Add(dr);
            }
        }

    }
}
