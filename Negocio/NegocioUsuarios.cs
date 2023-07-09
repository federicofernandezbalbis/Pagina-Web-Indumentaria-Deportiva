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
    public class NegocioUsuarios
    {
        DaoUsuarios dus = new DaoUsuarios();
        AccesoDatos ds = new AccesoDatos();

        public DataTable obtenerUsuarios()
        {
            return dus.getTablaUsuarios();
        }
        public int getIDUsuario(string mail)
        {
            Usuarios usu = new Usuarios();
            usu.Mail = mail;
            dus.getUsuario(usu);
            int ID = usu.IdUsuario;
            return ID;
        }

        public string getUsername(string mail)
        {
            Usuarios usu = new Usuarios();
            usu.Mail = mail;
            dus.getUsuario(usu);
            string user = usu.NombreUsuario;
            return user;
        }

        public Boolean esAdmin(int idUser)
        {
            Usuarios usu = new Usuarios();
            usu.IdUsuario = idUser;
            if (dus.getUsuarioConID(usu).Administrador == true)
            {
                return true;
            }
            return false;
        }

        public Boolean existeMailUsuario(string mail)
        {
            if (ds.existe("SELECT Mail_US FROM USUARIOS WHERE Mail_US = '" + mail + "'") == true)
            {
                return true;
            }
            return false;
        }

        public Boolean existeDNIUsuario(string DNI)
        {
            if (ds.existe("SELECT DNI_US FROM USUARIOS WHERE DNI_US = '" + DNI + "'") == true)
            {
                return true;
            }
            return false;
        }

        public Boolean existeNombreUsuario(string NombreUsuario)
        {
            if (ds.existe("SELECT NombreUsuario_US FROM USUARIOS WHERE NombreUsuario_US = '" + NombreUsuario + "'") == true)
            {
                return true;
            }
            return false;
        }

        public Boolean existeContraseñaUsuario(string contraseña)
        {
            if (ds.existe("SELECT * FROM USUARIOS WHERE Contraseña_US = '" + contraseña + "'") == true)
            {
                return true;
            }
            return false;
        }

        public void agregarNuevoUsuario(string Nombre, string Apellido, string NombreUsuario, string DNI, string Direccion, string Localidad, string Provincia, string Mail, string Contraseña, string Telefono, DateTime FechaNacimiento)
        {
            Usuarios newUs = new Usuarios();
            newUs.Nombre = Nombre;
            newUs.Apellido = Apellido;
            newUs.NombreUsuario = NombreUsuario;
            newUs.Dni = DNI;
            newUs.Direccion = Direccion;
            newUs.Localidad = Localidad;
            newUs.Provincia = Provincia;
            newUs.Mail = Mail;
            newUs.Contrasenia = Contraseña;
            newUs.Telefono = Telefono;
            newUs.FechaNacimiento = FechaNacimiento;
            dus.AgregarUsuario(newUs);
        }
        
        public Usuarios cargarInfoUsuario(int Session)
        {
            Usuarios usuID = new Usuarios();
            usuID.IdUsuario = Session;
            DaoUsuarios usuario = new DaoUsuarios();
            usuario.getUsuarioConID(usuID);
            return usuID;
        }

        public int eliminarUsuario(Usuarios usuario)
        {
            int FilasEliminadas = dus.EliminarUsuario(usuario);
            return FilasEliminadas;
        }

        public int editarUsuario(Usuarios usuario)
        {
            int FilasEditadas = dus.actualizarUsuario(usuario);
            return FilasEditadas;
        }

        public Boolean checkUsuario(Usuarios usuario)
        {
            bool check = dus.chequearUsuario(usuario);
            return check;
        }
    }
}
