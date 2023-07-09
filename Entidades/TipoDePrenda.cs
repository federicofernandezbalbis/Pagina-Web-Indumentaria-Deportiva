using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class TipoDePrenda
    {
        public int idTipoPrenda;
        public String descripcion;

        public TipoDePrenda() {}

        public int IdTipoPrenda { get => idTipoPrenda; set => idTipoPrenda = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
    }
}
