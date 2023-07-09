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
    public class DaoProveedores
    {
        AccesoDatos ds = new AccesoDatos();

        public DaoProveedores()
        {

        }

        public Proveedores getProveedor(Proveedores prov)
        {
            DataTable tabla = ds.ObtenerTabla("PROVEEDORES", "SELECT * FROM PROVEEDORES WHERE IDProveedor_PR = '" + prov.IdProveedor+"'");
            prov.IdProveedor = tabla.Rows[0][0].ToString();
            prov.RazonSocial = tabla.Rows[0][1].ToString();
            prov.Direccion = tabla.Rows[0][2].ToString();
            prov.Ciudad = tabla.Rows[0][3].ToString();
            prov.Provincia = tabla.Rows[0][4].ToString();
            prov.Telefono = tabla.Rows[0][5].ToString();
            prov.Contacto = tabla.Rows[0][6].ToString();
            prov.Mail = tabla.Rows[0][7].ToString();
            return prov;
        }

        public DataTable getTablaProveedores()
        {
            string consulta = "SELECT IDProveedor_PR AS ID, RazonSocial_PR, Direccion_PR AS DIRECCIÓN, Ciudad_PR AS CIUDAD, Provincia_PR AS PROVINCIA, Telefono_PR AS TELÉFONO, Contacto_PR AS CONTACO, Mail_PR AS MAIL FROM PROVEEDORES";
            DataTable tabla = ds.ObtenerTabla("PROVEEDORES", consulta);
            return tabla;
        }

        public int EliminarProveedor(Proveedores prov)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosProveedorEliminar(ref cmd, prov);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarProveedor");
        }

        public int AgregarProveedor(Proveedores prov)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosProveedorAgregar(ref cmd, prov);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarProveedor");
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarProveedor]
        (
            @IDPROVEEDOR char(10)
        )
        AS
        DELETE FROM PROVEEDORES WHERE IDProveedor_PR = @IDPROVEEDOR
        RETURN 
        */

        /*
        CREATE PROCEDURE [dbo].[spAgregarProveedor]
        (
            @IDPROVEEDOR char(10), @RAZONSOCIAL varchar(70), @DIRECCION varchar(70), @CIUDAD varchar(50), @PROVINCIA varchar(50), @TELEFONO varchar(20), @CONTACO varchar(40), @MAIL varchar(100)
        )
        AS
        INSERT INTO PROVEEDORES (IDProveedor_PR, RazonSocial_PR, Direccion_PR, Ciudad_PR, Provincia_PR, Telefono_PR, Contacto_PR, Mail_PR)
        SELECT @IDPROVEEDOR, @RAZONSOCIAL, @DIRECCION, @CIUDAD, @PROVINCIA, @TELEFONO, @CONTACO, @MAIL
        RETURN 
        */

        private void ArmarParametrosProveedorEliminar(ref SqlCommand cmd, Proveedores prov)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDPROVEEDOR", SqlDbType.Char);
            sqlParametros.Value = prov.IdProveedor;
        }
        private void ArmarParametrosProveedorAgregar(ref SqlCommand cmd, Proveedores prov)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDPROVEEDOR", SqlDbType.Char);
            sqlParametros.Value = prov.IdProveedor;
            sqlParametros = cmd.Parameters.Add("@RAZONSOCIAL", SqlDbType.VarChar);
            sqlParametros.Value = prov.RazonSocial;
            sqlParametros = cmd.Parameters.Add("@DIRECCION", SqlDbType.VarChar);
            sqlParametros.Value = prov.Direccion;
            sqlParametros = cmd.Parameters.Add("@CIUDAD", SqlDbType.VarChar);
            sqlParametros.Value = prov.Ciudad;
            sqlParametros = cmd.Parameters.Add("@PROVINCIA", SqlDbType.VarChar);
            sqlParametros.Value = prov.Provincia;
            sqlParametros = cmd.Parameters.Add("@TELEFONO", SqlDbType.VarChar);
            sqlParametros.Value = prov.Telefono;
            sqlParametros = cmd.Parameters.Add("@CONTACO", SqlDbType.VarChar);
            sqlParametros.Value = prov.Contacto;
            sqlParametros = cmd.Parameters.Add("@MAIL", SqlDbType.VarChar);
            sqlParametros.Value = prov.Mail;
        }
    }
}
