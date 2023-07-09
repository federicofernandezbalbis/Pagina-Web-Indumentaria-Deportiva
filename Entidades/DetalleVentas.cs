using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class DetalleVentas
    {
        private int idVenta;
        private Articulos idArticulo;
        private Sexo idSexo;
        private Articulos talle;
        private int cantidad;
        private Articulos precioUnitario;

        public DetalleVentas() {}

        public int IdVenta { get => idVenta; set => idVenta = value; }
        public Articulos IdArticulo { get => idArticulo; set => idArticulo = value; }
        public Sexo IdSexo { get => idSexo; set => idSexo = value; }
        public Articulos Talle { get => talle; set => talle = value; }
        public int Cantidad { get => cantidad; set => cantidad = value; }
        public Articulos PrecioUnitario { get => precioUnitario; set => precioUnitario = value; }
    }
}
