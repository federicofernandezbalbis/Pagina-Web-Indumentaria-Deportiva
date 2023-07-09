using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Sexo
    {
        private String idSexo;
        private String descripcion;
        
        public Sexo() {}

        public string IdSexo { get => idSexo; set => idSexo = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
    }
}
