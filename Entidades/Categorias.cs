using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Categorias
    {
        private int idCategoria;
        private String nombreDeporte;

        public Categorias() {}

        public int IdCategoria { get => idCategoria; set => idCategoria = value; }
        public string NombreDeporte { get => nombreDeporte; set => nombreDeporte = value; }
    }
}
