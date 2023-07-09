using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Usuarios
    {
        private int idUsuario;
        private String nombre;
        private String apellido;
        private String dni;
        private String telefono;
        private String mail;
        private String direccion;
        private String localidad;
        private String provincia;
        private String pais;
        private String nombreUsuario;
        private String contrasenia;
        private DateTime fechanacimiento;
        private bool administrador;

        public Usuarios() {}

        public int IdUsuario { get => idUsuario; set => idUsuario = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Apellido { get => apellido; set => apellido = value; }
        public string Dni { get => dni; set => dni = value; }
        public string Telefono { get => telefono; set => telefono = value; }
        public string Mail { get => mail; set => mail = value; }
        public string Direccion { get => direccion; set => direccion = value; }
        public string Localidad { get => localidad; set => localidad = value; }
        public string Provincia { get => provincia; set => provincia = value; }
        public string Pais { get => pais; set => pais = value; }
        public string NombreUsuario { get => nombreUsuario; set => nombreUsuario = value; }
        public string Contrasenia { get => contrasenia; set => contrasenia = value; }
        public DateTime FechaNacimiento { get => fechanacimiento; set => fechanacimiento = value; }
        public bool Administrador { get => administrador; set => administrador = value; }
    }
}