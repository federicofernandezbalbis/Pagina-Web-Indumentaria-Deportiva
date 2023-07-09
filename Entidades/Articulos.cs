using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Articulos
    {
        private String idArticulo;
        private Sexo sexo;
        private String talle;
        private Categorias categoria;
        private TipoDePrenda tipoPrenda;
        private Proveedores proveedor;
        private String nombre;
        private String descripcion;
        private decimal precio;
        private int stock;
        private bool estado;
        private String imgProducto;

        public Articulos() {}


        public string IdArticulo { get => idArticulo; set => idArticulo = value; }
        public Sexo Sexo {get => sexo; set => sexo = value; }
        public string Talle { get => talle; set => talle = value; }
        public Categorias Categoria { get => categoria; set => categoria = value; }
        public TipoDePrenda TipoPrenda { get => tipoPrenda; set => tipoPrenda = value; }
        public Proveedores Proveedor { get => proveedor; set => proveedor = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public decimal Precio { get => precio; set => precio = value; }
        public int Stock { get => stock; set => stock = value; }
        public bool Estado { get => estado; set => estado = value; }
        public string ImgProducto { get => imgProducto; set => imgProducto = value; }
    }
}
