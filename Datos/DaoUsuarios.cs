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
    public class DaoUsuarios
    {
        AccesoDatos ds = new AccesoDatos();

        public Usuarios getUsuario(Usuarios usu)
        {
            DataTable tabla = ds.ObtenerTabla("USUARIOS", "SELECT * FROM USUARIOS WHERE Mail_US = '" + usu.Mail + "' AND [Estado_US] = 1");
            usu.IdUsuario = Convert.ToInt32(tabla.Rows[0][0].ToString());
            usu.Nombre = tabla.Rows[0][1].ToString();
            usu.Apellido = tabla.Rows[0][2].ToString();
            usu.FechaNacimiento = Convert.ToDateTime(tabla.Rows[0][3]);
            usu.Dni = tabla.Rows[0][4].ToString();
            usu.Telefono = tabla.Rows[0][5].ToString();
            usu.Mail = tabla.Rows[0][6].ToString();
            usu.Direccion = tabla.Rows[0][7].ToString();
            usu.Localidad = tabla.Rows[0][8].ToString();
            usu.Provincia = tabla.Rows[0][9].ToString();
            usu.NombreUsuario = tabla.Rows[0][10].ToString();
            usu.Contrasenia = tabla.Rows[0][11].ToString();
            usu.Administrador = Convert.ToBoolean(tabla.Rows[0][12]);
            return usu;
        }

        public Usuarios getUsuarioConID(Usuarios usu)
        {
            DataTable tabla = ds.ObtenerTabla("USUARIOS", "SELECT * FROM USUARIOS WHERE IDUsuario_US = " + usu.IdUsuario + " AND [Estado_US] = 1");
            usu.IdUsuario = Convert.ToInt32(tabla.Rows[0][0].ToString());
            usu.Nombre = tabla.Rows[0][1].ToString();
            usu.Apellido = tabla.Rows[0][2].ToString();
            usu.FechaNacimiento = Convert.ToDateTime(tabla.Rows[0][3].ToString());
            usu.Dni = tabla.Rows[0][4].ToString();
            usu.Telefono = tabla.Rows[0][5].ToString();
            usu.Mail = tabla.Rows[0][6].ToString();
            usu.Direccion = tabla.Rows[0][7].ToString();
            usu.Localidad = tabla.Rows[0][8].ToString();
            usu.Provincia = tabla.Rows[0][9].ToString();
            usu.NombreUsuario = tabla.Rows[0][10].ToString();
            usu.Contrasenia = tabla.Rows[0][11].ToString();
            usu.Administrador = Convert.ToBoolean(tabla.Rows[0][12]);
            return usu;
        }

        public DataTable getTablaUsuarios()
        {
            string consulta = "SELECT IDUsuario_US AS ID, Nombre_US AS NOMBRE, DNI_US AS DNI, Telefono_US AS TELEFONO, Mail_US AS MAIL, Direccion_US AS DIRECCION, Localidad_US AS LOCALIDAD, Provincia_US AS PROVINCIA, NombreUsuario_US AS [NOMBRE USUARIO], Administrador_US AS ADMIN FROM USUARIOS where Estado_US=1";
            DataTable tabla = ds.ObtenerTabla("USUARIOS", consulta);
            return tabla;
        }

        public int EliminarUsuario(Usuarios usu)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosUsuarioEliminar(ref cmd, usu);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spEliminarUsuario");
        }

        public bool chequearUsuario(Usuarios usu)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosUsuarioChequear(ref cmd, usu);
            int resultado = ds.EXEC_SP(cmd, "SP_CheckUsuario");
            return resultado == 1;
        }


        public int AgregarUsuario(Usuarios usu)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosUsuarioAgregar(ref cmd, usu);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "spAgregarUsuario");
        }

        public int actualizarUsuario(Usuarios usu)
        {
            SqlCommand cmd = new SqlCommand();
            ArmarParametrosUsuarioActualizar(ref cmd, usu);
            return ds.ejecutarProcedimientoAlmacenado(cmd, "sp_ActualizarUsuario");
        }

        /*
        CREATE PROCEDURE [dbo].[spEliminarUsuario]
        (
            @IDUSUARIO char(10)
        )
        AS
        DELETE FROM USUARIOS WHERE IDUsuario_US = @IDUSUARIO
        RETURN 
        */

        /*
         CREATE PROCEDURE [dbo].[spAgregarUsuario]
        (
           @NOMBRE varchar(50), @APELLIDO varchar(50), @FECHA datetime, @DNI varchar(10), @TELEFONO varchar(20), @MAIL varchar(100), @DIRECCION varchar(70), @LOCALIDAD varchar(50), @PROVINCIA varchar(50), @NOMBREUSUARIO varchar(30), @CONTRASEÑA varchar(20), @ADMIN bit
        )
        AS
        INSERT INTO USUARIOS (Nombre_US, Apellido_US, FechaNacimiento_US, DNI_US, Telefono_US, Mail_US, Direccion_US, Localidad_US, Provincia_US, NombreUsuario_US, Contraseña_US, Administrador_US)
        SELECT @NOMBRE, @APELLIDO, @FECHA, @DNI, @TELEFONO, @MAIL, @DIRECCION, @LOCALIDAD, @PROVINCIA, @NOMBREUSUARIO, @CONTRASEÑA, @ADMIN
        RETURN 
		GO
        */

        private void ArmarParametrosUsuarioEliminar(ref SqlCommand cmd, Usuarios usu)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@IDUSUARIO", SqlDbType.Char);
            sqlParametros.Value = usu.IdUsuario;
        }

        private void ArmarParametrosUsuarioChequear(ref SqlCommand cmd, Usuarios usu)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@MAIL", SqlDbType.VarChar);
            sqlParametros.Value = usu.Mail;
            sqlParametros = cmd.Parameters.Add("@Password", SqlDbType.VarChar);
            sqlParametros.Value = usu.Contrasenia;
        }

        private void ArmarParametrosUsuarioAgregar(ref SqlCommand cmd, Usuarios usu)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@NOMBRE", SqlDbType.VarChar);
            sqlParametros.Value = usu.Nombre;
            sqlParametros = cmd.Parameters.Add("@APELLIDO", SqlDbType.VarChar);
            sqlParametros.Value = usu.Apellido;
            sqlParametros = cmd.Parameters.Add("@DNI", SqlDbType.VarChar);
            sqlParametros.Value = usu.Dni;
            sqlParametros = cmd.Parameters.Add("@TELEFONO", SqlDbType.VarChar);
            sqlParametros.Value = usu.Telefono;
            sqlParametros = cmd.Parameters.Add("@MAIL", SqlDbType.VarChar);
            sqlParametros.Value = usu.Mail;
            sqlParametros = cmd.Parameters.Add("@DIRECCION", SqlDbType.VarChar);
            sqlParametros.Value = usu.Direccion;
            sqlParametros = cmd.Parameters.Add("@LOCALIDAD", SqlDbType.VarChar);
            sqlParametros.Value = usu.Localidad;
            sqlParametros = cmd.Parameters.Add("@PROVINCIA", SqlDbType.VarChar);
            sqlParametros.Value = usu.Provincia;
            sqlParametros = cmd.Parameters.Add("@NOMBREUSUARIO", SqlDbType.VarChar);
            sqlParametros.Value = usu.NombreUsuario;
            sqlParametros = cmd.Parameters.Add("@FECHA", SqlDbType.DateTime);
            sqlParametros.Value = usu.FechaNacimiento;
            sqlParametros = cmd.Parameters.Add("@CONTRASEÑA", SqlDbType.VarChar);
            sqlParametros.Value = usu.Contrasenia;
        }

        private void ArmarParametrosUsuarioActualizar(ref SqlCommand cmd, Usuarios usu)
        {
            SqlParameter sqlParametros = new SqlParameter();
            sqlParametros = cmd.Parameters.Add("@ID", SqlDbType.VarChar);
            sqlParametros.Value = usu.IdUsuario;
        }
    }
}
