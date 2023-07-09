using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Proveedores
    {
        private String idProveedor;
        private String razonSocial;
        private String direccion;
        private String ciudad;
        private String provincia;
        private String telefono;
        private String contacto;
        private String mail;

        public Proveedores() {}

        public string IdProveedor { get => idProveedor; set => idProveedor = value; }
        public string RazonSocial { get => razonSocial; set => razonSocial = value; }
        public string Direccion { get => direccion; set => direccion = value; }
        public string Ciudad { get => ciudad; set => ciudad = value; }
        public string Provincia { get => provincia; set => provincia = value; }
        public string Telefono { get => telefono; set => telefono = value; }
        public string Contacto { get => contacto; set => contacto = value; }
        public string Mail { get => mail; set => mail = value; }
    }
}
