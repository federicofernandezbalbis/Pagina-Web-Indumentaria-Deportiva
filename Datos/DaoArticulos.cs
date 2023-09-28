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
    public class DaoArticulos
    {
        AccesoDatos ds = new AccesoDatos();

        public Articulos getArticulo(Articulos art)
        {
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", "SELECT * FROM ARTICULOS WHERE IDArt_AR = " + art.IdArticulo + " AND [Estado_AR] = 1");
            art.IdArticulo = tabla.Rows[0][1].ToString();
            art.Nombre = tabla.Rows[0][7].ToString();
            art.Descripcion = tabla.Rows[0][8].ToString();
            art.Precio = Convert.ToInt32(tabla.Rows[0][9].ToString());
            art.ImgProducto = tabla.Rows[0][12].ToString();
            return art;
        }
        public string getID(Articulos Art)
        {
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", "SELECT * FROM ARTICULOS WHERE IDArt_AR = " + Art.IdArticulo + " AND [Estado_AR] = 1");
            Art.IdArticulo = tabla.Rows[0][1].ToString();
            return Art.IdArticulo;
        }

        public DataTable getSexo()
        {
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", "SELECT IDSexo_AR FROM ARTICULOS WHERE [Estado_AR] = 1");
            return tabla;
        }
        public DataTable getCategoria()
        {
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", "SELECT IDCategoria_AR FROM ARTICULOS WHERE [Estado_AR] = 1");
            return tabla;
        }
        public DataTable getTipoPrenda()
        {
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", "SELECT IDTipo_AR FROM ARTICULOS WHERE [Estado_AR] = 1");
            return tabla;
        }

        public DataTable getTablaArticulos()
        {
            string consulta = "SELECT IDArt_AR AS ID, Nombre_AR AS NOMBRE, Descripcion_AR AS DESCRIPCION, Precio_AR AS PRECIO, Talle_AR AS TALLE, IDSexo_AR AS SEXO, URL_Imagen_Producto FROM ARTICULOS WHERE [Estado_AR] = 1";
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", consulta);
            return tabla;
        }

        public DataTable getTablaArticulosEditar()
        {
            string consulta = "SELECT IDArt_AR AS ID, Nombre_AR AS NOMBRE, Descripcion_AR AS DESCRIPCION, Precio_AR AS PRECIO, Talle_AR AS TALLE, IDSexo_AR AS SEXO, URL_Imagen_Producto, Stock_AR AS STOCK, IDCategoria_AR AS Categoria, IDTipo_AR AS TIPOPRENDA, IDProveedor_AR AS Proveedor, Estado_AR as Estado FROM ARTICULOS WHERE [Estado_AR] = 1";
            DataTable tabla = ds.ObtenerTabla("ARTICULOS", consulta);
            return tabla;
        }

        public DataTable filtrarTablaArticulos(string consulta)
        {
            DataTable tabla = ds.ObtenerTabla("Articulos", consulta);
            return tabla;
        }

        public int EliminarArticulo(Articulos art)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosArticuloEliminar(ref cmd, art);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarArticulo");
        }

        public int AgregarArticulo(Articulos art)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosArticuloAgregar(ref cmd, art);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarArticulo");
        }

        public int actualizarArticulo(Articulos art)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosArticuloAgregar(ref cmd, art);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spActualizarArticulo");
        }

        public Boolean existeArticulo(Articulos art)
        {
            String consulta = "select * from ARTICULOS where IDArt_AR='" + art.IdArticulo +"' and Talle_AR = '" + art.Talle + "' AND [Estado_AR] = 1";
            return ds.existe(consulta);
        }

        public Boolean existePrimerArticulo(Articulos art)
        {
            String consulta = "select * from ARTICULOS where IDArt_AR='" + art.IdArticulo + "' AND [Estado_AR] = 1";
            return ds.existe(consulta);
        }


        /*
        CREATE PROCEDURE [dbo].[spEliminarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4)
        )
        AS
        DELETE FROM ARTICULOS WHERE IDArt_AR = @IDARTICULO AND IdSexo_AR = @IDSEXO AND Talle_AR = @TALLE
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4), @IDCATEGORIA int, @TIPOPRENDA int, @IDPROVEEDOR char(10), @NOMBRE char(500), @DESCRIPCION varchar(500), @PRECIO money, @STOCK int, @ESTADO bit, @URLIMAGEN varchar(100)
        )
        AS
        INSERT INTO ARTICULOS (IDArt_AR, IDSexo_AR,	Talle_AR, IDCategoria_AR, IDTipo_AR, IDProveedor_AR, Nombre_AR,	Descripcion_AR,	Precio_AR, Stock_AR, Estado_AR, URL_Imagen_Producto)
        SELECT @IDARTICULO, @IDSEXO, @TALLE, @IDCATEGORIA, @TIPOPRENDA, @IDPROVEEDOR, @NOMBRE, @DESCRIPCION, @PRECIO, @STOCK, @ESTADO, @URLIMAGEN
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spActualizarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4), @IDCATEGORIA int, @TIPOPRENDA int, @IDPROVEEDOR char(10), @NOMBRE char(500), @DESCRIPCION varchar(500), @PRECIO money, @STOCK int, @ESTADO bit, @URLIMAGEN varchar(100)
        )
        AS
        UPDATE ARTICULOS SET IDArticulo_AR = @IDARTICULO, IDSexo_AR = @IDSEXO, Talle_AR = @TALLE, Nombre_AR = @NOMBRE, Descripcion_AR = @DESCRIPCION, Precio_AR = @PRECIO, Stock_AR = @STOCK, IDCategoria_AR = @IDCATEGORIA, IDTipo_AR = @TIPOPRENDA, IDProveedor_AR = @IDPROVEEDOR, Estado_AR = @ESTADO, URL_Imagen_Producto = @URLIMAGEN
        WHERE IDArticulo_AR = @IDARTICULO AND IDSexo_AR = @IDSEXO AND Talle_AR = @TALLE
        RETURN 
        */

        private void ArmarParametrosArticuloEliminar(ref SqlCommand cmd, Articulos art)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDARTICULO", SqlDbType.Char);
            sqlParametros.Value = art.IdArticulo;
            sqlParametros = cmd.Parameters.Add("@IDSEXO", SqlDbType.Char);
            sqlParametros.Value = art.Sexo.IdSexo;
            sqlParametros = cmd.Parameters.Add("@TALLE", SqlDbType.Char);
            sqlParametros.Value = art.Talle;
        }
        private void ArmarParametrosArticuloAgregar(ref SqlCommand cmd, Articulos art)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDARTICULO", SqlDbType.Char);
            sqlParametros.Value = art.IdArticulo;
            sqlParametros = cmd.Parameters.Add("@IDSEXO", SqlDbType.Char);
            sqlParametros.Value = art.Sexo.IdSexo;
            sqlParametros = cmd.Parameters.Add("@TALLE", SqlDbType.Char);
            sqlParametros.Value = art.Talle;
            sqlParametros = cmd.Parameters.Add("@IDCATEGORIA", SqlDbType.Int);
            sqlParametros.Value = art.Categoria.IdCategoria;
            sqlParametros = cmd.Parameters.Add("@TIPOPRENDA", SqlDbType.Int);
            sqlParametros.Value = art.TipoPrenda.IdTipoPrenda;
            sqlParametros = cmd.Parameters.Add("@IDPROVEEDOR", SqlDbType.Char);
            sqlParametros.Value = art.Proveedor.IdProveedor;
            sqlParametros = cmd.Parameters.Add("@NOMBRE", SqlDbType.Char);
            sqlParametros.Value = art.Nombre;
            sqlParametros = cmd.Parameters.Add("@DESCRIPCION", SqlDbType.VarChar);
            sqlParametros.Value = art.Descripcion;
            sqlParametros = cmd.Parameters.Add("@PRECIO", SqlDbType.Int);
            sqlParametros.Value = art.Precio;
            sqlParametros = cmd.Parameters.Add("@STOCK", SqlDbType.Int);
            sqlParametros.Value = art.Stock;
            sqlParametros = cmd.Parameters.Add("@ESTADO", SqlDbType.Bit);
            sqlParametros.Value = art.Estado;
            sqlParametros = cmd.Parameters.Add("@URLIMAGEN", SqlDbType.VarChar);
            sqlParametros.Value = art.ImgProducto;
        }


    }
}
