using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Ventas
    {
        private int idVenta;
        private Usuarios usuario;
        private Usuarios dni;
        private Usuarios telefono;
        private int total;
        private DateTime fecha;

        public Ventas() {}

        public int IdVenta { get => idVenta; set => idVenta = value; }
        public Usuarios Usuario { get => usuario; set => usuario = value; }
        public Usuarios Dni { get => dni; set => dni = value; }
        public Usuarios Telefono { get => telefono; set => telefono = value; }
        public int Total { get => total; set => total = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
    }
}
