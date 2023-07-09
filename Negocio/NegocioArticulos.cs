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
    public class NegocioArticulos
    {
        DaoArticulos datosArt = new DaoArticulos();
        AccesoDatos datos = new AccesoDatos();

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
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] ORDER BY Precio_AR DESC";
                return consulta;
        }
        public string precioMasBajo()
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] ORDER BY Precio_AR ASC";
                return consulta;
        }

        public string restablecer()
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR],  [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS]";
            return consulta;
        }
        public string ordenarPorDeporte(string deporte)
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [IDCategoria_AR]=" + deporte;
            return consulta;
        }
        
        public string RealizarConsultaTDP(string cat)
        {
            string consulta = "SELECT DISTINCT [IDArt_AR], [Nombre_AR], [Descripcion_AR], [IDTipo_AR], [Precio_AR], [URL_Imagen_Producto] FROM [ARTICULOS] WHERE [IDTipo_AR]=" + cat;
            return consulta;
        }
    }
}
