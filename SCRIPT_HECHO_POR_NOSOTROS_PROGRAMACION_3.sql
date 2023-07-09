USE MASTER
GO

create DATABASE [TIRO_LIBRE]
GO

USE [TIRO_LIBRE]
GO

CREATE TABLE CATEGORIAS 
(
IDCategoria_CAT int NOT NULL,
NombreDeporte_CAT varchar(50) NOT NULL,
CONSTRAINT PK_CATEGORIA PRIMARY KEY (IDCategoria_CAT)
)

CREATE TABLE SEXO
(
IDSexo_SE char(1) NOT NULL,
Descripcion_SE varchar(6) NOT NULL CHECK (Descripcion_SE = 'Hombre' OR Descripcion_SE = 'Mujer' OR Descripcion_SE = 'Unisex'),
CONSTRAINT PK_SEXO PRIMARY KEY (IDSexo_SE)
)

CREATE TABLE TIPODEPRENDA
(
IDTipo_TDP int NOT NULL,
Descripcion_TDP varchar(50) NOT NULL,
CONSTRAINT PK_TIPODEPRENDA PRIMARY KEY (IDTipo_TDP)
)

CREATE TABLE PROVEEDORES
(
IDProveedor_PR char(10) NOT NULL,
RazonSocial_PR varchar(70) NOT NULL,
Direccion_PR varchar (70) NOT NULL,
Ciudad_PR varchar(50) NOT NULL,
Provincia_PR varchar(50) NOT NULL,
Telefono_PR varchar(20) NOT NULL,
Contacto_PR varchar(40) NOT NULL,
Mail_PR varchar (100) NOT NULL,
CONSTRAINT PK_PROVEEDORES PRIMARY KEY (IDProveedor_PR)
)

CREATE TABLE ARTICULOS
(
IDArt_AR char (10) NOT NULL,
IDSexo_AR char(1) NOT NULL CHECK (IDSexo_AR = 'H' OR IDSexo_AR = 'M' OR IDSexo_AR = 'U'),
Talle_AR char(4) NOT NULL,
IDCategoria_AR int NOT NULL,
IDTipo_AR int NOT NULL,
IDProveedor_AR char(10) NOT NULL,
Nombre_AR char(500) NOT NULL,
Descripcion_AR varchar(500) NOT NULL,
Precio_AR money NOT NULL DEFAULT 0,
Stock_AR int NOT NULL DEFAULT 0,
Estado_AR bit NOT NULL DEFAULT 0,
URL_Imagen_Producto varchar(100) not null, 

CONSTRAINT PK_ARTICULOS PRIMARY KEY (IDArt_AR, IDSexo_AR, Talle_AR),
CONSTRAINT FK_ARTICULOS_SEXO FOREIGN KEY (IDSexo_AR) REFERENCES SEXO (IDSexo_SE),
CONSTRAINT FK_ARTICULOS_CATEGORIAS FOREIGN KEY (IDCategoria_AR) REFERENCES CATEGORIAS (IDCategoria_CAT),
CONSTRAINT FK_ARTICULOS_TIPODEPRENDA FOREIGN KEY (IDTipo_AR) REFERENCES TIPODEPRENDA (IDTipo_TDP),
CONSTRAINT FK_ARTICULOS_PROVEEDORES FOREIGN KEY (IDProveedor_AR) REFERENCES PROVEEDORES (IDProveedor_PR)
)

CREATE TABLE USUARIOS
(
IDUsuario_US int NOT NULL identity(1,1),
Nombre_US varchar(50) NOT NULL,
Apellido_US varchar(50) NOT NULL,
FechaNacimiento_US datetime NOT NULL,
DNI_US varchar(10) NOT NULL,
Telefono_US varchar(20) NOT NULL,
Mail_US varchar(100) NOT NULL,
Direccion_US varchar(70) NOT NULL,
Localidad_US varchar(50) NOT NULL,
Provincia_US varchar(50) NOT NULL,
NombreUsuario_US varchar (30) NOT NULL,
Contraseña_US varchar(20) NOT NULL,
Administrador_US bit NOT NULL DEFAULT 0,
CONSTRAINT PK_USUARIOS PRIMARY KEY (IDUsuario_US),
CONSTRAINT UK_USUARIOS UNIQUE (DNI_US, Telefono_US, NombreUsuario_US)
)

CREATE TABLE VENTAS
(
IDVenta_VE int identity(1,1) NOT NULL,
IDUsuario_VE int NOT NULL,
DNI_VE varchar(10) NOT NULL,
Telefono_VE varchar(20) NOT NULL,
Total_VE money NOT NULL,
Fecha_VE datetime NOT NULL,
CONSTRAINT PK_VENTAS PRIMARY KEY (IDVenta_VE),
CONSTRAINT FK_VENTAS_USUARIOS FOREIGN KEY (IDUsuario_VE) REFERENCES USUARIOS (IDUsuario_US)
)

CREATE TABLE DETALLEVENTAS
(
IDVenta_DV int NOT NULL,
IDArt_DV char (10) NOT NULL,
IDSexo_DV char(1) NOT NULL CHECK (IDSexo_DV = 'H' OR IDSexo_DV = 'M' OR IDSexo_DV = 'U'),
Talle_DV char(4) NOT NULL,
Cantidad_DV int NOT NULL,
PrecioUnitario_DV money NOT NULL,
CONSTRAINT PK_DETALLEVENTAS PRIMARY KEY (IDVenta_DV, IDArt_DV, IDSexo_DV, Talle_DV),
CONSTRAINT FK_DETALLEVENTAS_VENTAS FOREIGN KEY (IDVenta_DV) REFERENCES VENTAS (IDVenta_VE),
CONSTRAINT FK_DETALLEVENTAS_ARTICULOS FOREIGN KEY (IDArt_DV, IDSexo_DV, Talle_DV) REFERENCES ARTICULOS (IDArt_AR, IDSexo_AR, Talle_AR)
)

INSERT INTO CATEGORIAS (IDCategoria_CAT, NombreDeporte_CAT)
SELECT 1, 'Futbol' UNION 
SELECT 2, 'Tenis' UNION 
SELECT 3, 'Basquet' UNION 
SELECT 4, 'Rugby' UNION 
SELECT 5, 'Running' UNION 
SELECT 6, 'Otro' 
GO

INSERT INTO SEXO(IDSexo_SE, Descripcion_SE)
SELECT 'H', 'Hombre' UNION
SELECT 'M','Mujer' UNION
SELECT 'U', 'Unisex'
GO

INSERT INTO TIPODEPRENDA(IDTipo_TDP, Descripcion_TDP)
SELECT 1, 'Camiseta' UNION
SELECT 2, 'Pantalon' UNION
SELECT 3, 'Short' UNION
SELECT 4, 'Buzo' UNION
SELECT 5, 'Calzado' UNION
SELECT 6, 'Accesorios'
GO

INSERT INTO PROVEEDORES(IDProveedor_PR, RazonSocial_PR, Direccion_PR, Ciudad_PR, Provincia_PR, Telefono_PR, Contacto_PR, Mail_PR)
SELECT 'Adidas', 'Adidas SA', 'Von Wernicke 3023', 'Martínez', 'Buenos Aires', '0800-666-0206', '(11) 6842-0923', 'Adidas@gmail.com' UNION
SELECT 'Nike', 'Nike SRL', 'Av del Libertador 2442', 'Lomas de Zamora', 'Buenos Aires', '541148516664', 'www.nike.com', 'Nike@gmail.com' UNION
SELECT 'Puma', 'Puma Store', 'Ramal Pilar Km 36.5,', 'Tortuguitas', 'Buenos Aires', '03327424249', 'www.instagram.com/Pumaargentina', 'Puma@gmail.com' UNION
SELECT 'Kappa','Kappa SRL', 'Av. Pres. Hipólito Yrigoyen 1851', 'Jose C. Paz','Buenos Aires', '01123574878', 'www.kappastore.com.ar', 'Kappa@gmail.com' UNION
SELECT 'Fila','Fila SRL', 'Paraná 3745', 'Martínez','Buenos Aires', '01147185831', 'www.fila.com.ar', 'Fila@gmail.com'
GO

INSERT INTO ARTICULOS
(
	IDArt_AR, 
	IDSexo_AR, 
	Talle_AR, 
	IDCategoria_AR, 
	IDTipo_AR, 
	IDProveedor_AR, 
	Nombre_AR,
	Descripcion_AR,
	Precio_AR,
	Stock_AR,
	Estado_AR,
	URL_Imagen_Producto
)


/***********************************************CAMISETAS***********************************************/


SELECT 'ART0000001', 'H', 'S', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Hombre', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'H', 'M', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Hombre', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'H', 'L', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Hombre', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'H', 'XL', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Hombre', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'M', 'S', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Mujer', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'M', 'M', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Mujer', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'M', 'L', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Mujer', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
SELECT 'ART0000001', 'M', 'XL', '1', '1', 'Nike', 'Camiseta Titular Barcelona FC Mujer', 'Temporada 22/23', 23500, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBarcelona.jpeg' UNION 
--
SELECT 'ART0000002', 'H', 'S', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION
SELECT 'ART0000002', 'H', 'M', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'H', 'L', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'H', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'M', 'S', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'M', 'M', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'M', 'L', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
SELECT 'ART0000002', 'M', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Bayern Munich Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBayern.jpeg' UNION 
--
SELECT 'ART0000003', 'H', 'S', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Hombre', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'H', 'M', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Hombre', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'H', 'L', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Hombre', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'H', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Hombre', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'M', 'S', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Mujer', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'M', 'M', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Mujer', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'M', 'L', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Mujer', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
SELECT 'ART0000003', 'M', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Boca Jrs Mujer', 'Temporada 22/23', 24000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBoca.jpeg' UNION 
--
SELECT 'ART0000004', 'H', 'S', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Hombre', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'H', 'M', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Hombre', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'H', 'L', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Hombre', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'H', 'XL', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Hombre', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'M', 'S', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Mujer', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'M', 'M', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Mujer', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'M', 'L', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Mujer', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
SELECT 'ART0000004', 'M', 'XL', '1', '1', 'Puma', 'Camiseta Titular Borussia Dormund Mujer', 'Temporada 22/23', 16900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaBorussia.jpeg' UNION 
--
SELECT 'ART0000005', 'H', 'S', '1', '1', 'Puma', 'Camiseta Titular Manchester City Hombre', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'H', 'M', '1', '1', 'Puma', 'Camiseta Titular Manchester City Hombre', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'H', 'L', '1', '1', 'Puma', 'Camiseta Titular Manchester City Hombre', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'H', 'XL', '1', '1', 'Puma', 'Camiseta Titular Manchester City Hombre', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'M', 'S', '1', '1', 'Puma', 'Camiseta Titular Manchester City Mujer', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'M', 'M', '1', '1', 'Puma', 'Camiseta Titular Manchester City Mujer', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'M', 'L', '1', '1', 'Puma', 'Camiseta Titular Manchester City Mujer', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
SELECT 'ART0000005', 'M', 'XL', '1', '1', 'Puma', 'Camiseta Titular Manchester City Mujer', 'Temporada 22/23', 26000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaCity.jpeg' UNION 
--
SELECT 'ART0000006', 'H', 'S', '1', '1', 'Puma', 'Camiseta Titular Independiente Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION
SELECT 'ART0000006', 'H', 'M', '1', '1', 'Puma', 'Camiseta Titular Independiente Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'H', 'L', '1', '1', 'Puma', 'Camiseta Titular Independiente Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'H', 'XL', '1', '1', 'Puma', 'Camiseta Titular Independiente Hombre', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'M', 'S', '1', '1', 'Puma', 'Camiseta Titular Independiente Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'M', 'M', '1', '1', 'Puma', 'Camiseta Titular Independiente Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'M', 'L', '1', '1', 'Puma', 'Camiseta Titular Independiente Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
SELECT 'ART0000006', 'M', 'XL', '1', '1', 'Puma', 'Camiseta Titular Independiente Mujer', 'Temporada 22/23', 18900, 50, 1, '~/Imagenes/CAMISETAS/CamisetaIndependiente.jpeg' UNION 
--
SELECT 'ART0000007', 'H', 'S', '1', '1', 'Nike', 'Camiseta Titular Inter FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION
SELECT 'ART0000007', 'H', 'M', '1', '1', 'Nike', 'Camiseta Titular Inter FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'H', 'L', '1', '1', 'Nike', 'Camiseta Titular Inter FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'H', 'XL', '1', '1', 'Nike', 'Camiseta Titular Inter FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'M', 'S', '1', '1', 'Nike', 'Camiseta Titular Inter FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'M', 'M', '1', '1', 'Nike', 'Camiseta Titular Inter FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'M', 'L', '1', '1', 'Nike', 'Camiseta Titular Inter FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
SELECT 'ART0000007', 'M', 'XL', '1', '1', 'Nike', 'Camiseta Titular Inter FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaInter.jpeg' UNION 
--
SELECT 'ART0000008', 'H', 'S', '1', '1', 'Puma', 'Camiseta Titular Milan FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION
SELECT 'ART0000008', 'H', 'M', '1', '1', 'Puma', 'Camiseta Titular Milan FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'H', 'L', '1', '1', 'Puma', 'Camiseta Titular Milan FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'H', 'XL', '1', '1', 'Puma', 'Camiseta Titular Milan FC Hombre', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'M', 'S', '1', '1', 'Puma', 'Camiseta Titular Milan FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'M', 'M', '1', '1', 'Puma', 'Camiseta Titular Milan FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'M', 'L', '1', '1', 'Puma', 'Camiseta Titular Milan FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
SELECT 'ART0000008', 'M', 'XL', '1', '1', 'Puma', 'Camiseta Titular Milan FC Mujer', 'Temporada 22/23', 23000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaMilan.jpeg' UNION 
--
SELECT 'ART0000009', 'H', 'S', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION
SELECT 'ART0000009', 'H', 'M', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'H', 'L', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'H', 'XL', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'M', 'S', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'M', 'M', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'M', 'L', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
SELECT 'ART0000009', 'M', 'XL', '1', '1', 'Nike', 'Camiseta Titular Paris Saint Germain Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaPSG.jpeg' UNION 
--
SELECT 'ART0000010', 'H', 'S', '1', '1', 'Kappa', 'Camiseta Titular Racing Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION
SELECT 'ART0000010', 'H', 'M', '1', '1', 'Kappa', 'Camiseta Titular Racing Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'H', 'L', '1', '1', 'Kappa', 'Camiseta Titular Racing Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'H', 'XL', '1', '1', 'Kappa', 'Camiseta Titular Racing Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'M', 'S', '1', '1', 'Kappa', 'Camiseta Titular Racing Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'M', 'M', '1', '1', 'Kappa', 'Camiseta Titular Racing Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'M', 'L', '1', '1', 'Kappa', 'Camiseta Titular Racing Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
SELECT 'ART0000010', 'M', 'XL', '1', '1', 'Kappa', 'Camiseta Titular Racing Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRacing.jpeg' UNION 
--
SELECT 'ART0000012', 'H', 'S', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION
SELECT 'ART0000012', 'H', 'M', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'H', 'L', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'H', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Hombre', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'M', 'S', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'M', 'M', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'M', 'L', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
SELECT 'ART0000012', 'M', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Real Madrid Mujer', 'Temporada 22/23', 15000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRealMadrid.jpeg' UNION 
--
SELECT 'ART0000013', 'H', 'S', '1', '1', 'Adidas', 'Camiseta Titular River Plate Hombre', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION
SELECT 'ART0000013', 'H', 'M', '1', '1', 'Adidas', 'Camiseta Titular River Plate Hombre', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'H', 'L', '1', '1', 'Adidas', 'Camiseta Titular River Plate Hombre', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'H', 'XL', '1', '1', 'Adidas', 'Camiseta Titular River Plate Hombre', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'M', 'S', '1', '1', 'Adidas', 'Camiseta Titular River Plate Mujer', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'M', 'M', '1', '1', 'Adidas', 'Camiseta Titular River Plate Mujer', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'M', 'L', '1', '1', 'Adidas', 'Camiseta Titular River Plate Mujer', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
SELECT 'ART0000013', 'M', 'XL', '1', '1', 'Adidas', 'Camiseta Titular River Plate Mujer', 'Temporada 22/23', 20000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaRiver.jpeg' UNION 
--
SELECT 'ART0000014', 'H', 'S', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Hombre', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION
SELECT 'ART0000014', 'H', 'M', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Hombre', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION 
SELECT 'ART0000014', 'H', 'L', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Hombre', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION 
SELECT 'ART0000014', 'H', 'XL', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Hombre', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION
SELECT 'ART0000014', 'M', 'S', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Mujer', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION
SELECT 'ART0000014', 'M', 'M', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Mujer', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION 
SELECT 'ART0000014', 'M', 'L', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Mujer', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION 
SELECT 'ART0000014', 'M', 'XL', '1', '1', 'Nike', 'Camiseta Titular San Lorenzo Mujer', 'Temporada 22/23', 14000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaSanLorenzo.jpeg' UNION
--
SELECT 'ART0000015', 'H', 'S', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Hombre', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'H', 'M', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Hombre', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'H', 'L', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Hombre', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'H', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Hombre', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'M', 'S', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Mujer', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'M', 'M', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Mujer', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'M', 'L', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Mujer', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION
SELECT 'ART0000015', 'M', 'XL', '1', '1', 'Adidas', 'Camiseta Titular Manchester United Mujer', 'Temporada 22/23', 22000, 50, 1, '~/Imagenes/CAMISETAS/CamisetaUnited.jpeg' UNION


/*************************************************PANTALONES**********************************************/


SELECT 'ART0000016', 'H', 'S', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Hombre', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'H', 'M', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Hombre', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'H', 'L', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Hombre', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'H', 'XL', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Hombre', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'M', 'S', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Mujer', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'M', 'M', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Mujer', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'M', 'L', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Mujer', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
SELECT 'ART0000016', 'M', 'XL', '6', '2', 'Adidas', 'Pantalon Adicolor Classic Cutline Mujer', 'Temporada 2023', 27500, 50, 1, '~/Imagenes/PANTALONES/PantalonAdicolorClassicCutline.jpeg' UNION
--
SELECT 'ART0000017', 'H', 'S', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Hombre', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'H', 'M', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Hombre', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'H', 'L', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Hombre', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'H', 'XL', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Hombre', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'M', 'S', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Mujer', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'M', 'M', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Mujer', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'M', 'L', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Mujer', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
SELECT 'ART0000017', 'M', 'XL', '1', '2', 'Adidas', 'Pantalon Condivo River Plate Mujer', 'Temporada 22/23', 32500, 50, 1, '~/Imagenes/PANTALONES/PantalonCondivoRiverPlate.jpeg' UNION
--
SELECT 'ART0000018', 'H', 'S', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Hombre', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'H', 'M', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Hombre', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'H', 'L', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Hombre', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'H', 'XL', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Hombre', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'M', 'S', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Mujer', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'M', 'M', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Mujer', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'M', 'L', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Mujer', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
SELECT 'ART0000018', 'M', 'XL', '1', '2', 'Adidas', 'Pantalon Entrenamiento Argentina Tiro 23 Mujer', 'Temporada 22/23', 35000, 75, 1, '~/Imagenes/PANTALONES/PantalonEntrenamientoArgentinaTiro23.jpeg' UNION
--
SELECT 'ART0000019', 'H', 'S', '6', '2', 'Adidas', 'Pantalon Essentials Tapered Hombre', 'Temporada 2023', 20500, 50, 1, '~/Imagenes/PANTALONES/PantalonEssentialsTapered.jpeg' UNION
SELECT 'ART0000019', 'H', 'M', '6', '2', 'Adidas', 'Pantalon Essentials Tapered Hombre', 'Temporada 2023', 20500, 50, 1, '~/Imagenes/PANTALONES/PantalonEssentialsTapered.jpeg' UNION
SELECT 'ART0000019', 'H', 'L', '6', '2', 'Adidas', 'Pantalon Essentials Tapered Hombre', 'Temporada 2023', 20500, 50, 1, '~/Imagenes/PANTALONES/PantalonEssentialsTapered.jpeg' UNION
SELECT 'ART0000019', 'H', 'XL', '6', '2', 'Adidas', 'Pantalon Essentials Tapered Hombre', 'Temporada 2023', 20500, 50, 1, '~/Imagenes/PANTALONES/PantalonEssentialsTapered.jpeg' UNION
--
SELECT 'ART0000020', 'H', 'S', '2', '2', 'Fila', 'Pantalon Fila Aat 22 Tenis Hombre', 'Temporada 2022', 21700, 50, 1, '~/Imagenes/PANTALONES/PantalonFilaAat22Tenis.jpeg' UNION
SELECT 'ART0000020', 'H', 'M', '2', '2', 'Fila', 'Pantalon Fila Aat 22 Tenis Hombre', 'Temporada 2022', 21700, 50, 1, '~/Imagenes/PANTALONES/PantalonFilaAat22Tenis.jpeg' UNION
SELECT 'ART0000020', 'H', 'L', '2', '2', 'Fila', 'Pantalon Fila Aat 22 Tenis Hombre', 'Temporada 2022', 21700, 50, 1, '~/Imagenes/PANTALONES/PantalonFilaAat22Tenis.jpeg' UNION
SELECT 'ART0000020', 'H', 'XL', '2', '2', 'Fila', 'Pantalon Fila Aat 22 Tenis Hombre', 'Temporada 2022', 21700, 50, 1, '~/Imagenes/PANTALONES/PantalonFilaAat22Tenis.jpeg' UNION
--
SELECT 'ART0000021', 'H', 'S', '1', '2', 'Nike', 'Pantalon Liverpool Strike Hombre', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'H', 'M', '1', '2', 'Nike', 'Pantalon Liverpool Strike Hombre', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'H', 'L', '1', '2', 'Nike', 'Pantalon Liverpool Strike Hombre', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'H', 'XL', '1', '2', 'Nike', 'Pantalon Liverpool Strike Hombre', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'M', 'S', '1', '2', 'Nike', 'Pantalon Liverpool Strik Mujer', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'M', 'M', '1', '2', 'Nike', 'Pantalon Liverpool Strike Mujer', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'M', 'L', '1', '2', 'Nike', 'Pantalon Liverpool Strike Mujer', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
SELECT 'ART0000021', 'M', 'XL', '1', '2', 'Nike', 'Pantalon Liverpool Strike Mujer', 'Temporada 22/23', 32600, 50, 1, '~/Imagenes/PANTALONES/PantalonLiverpoolStrike.jpeg' UNION
--
SELECT 'ART0000022', 'H', 'S', '1', '2', 'Puma', 'Pantalon Manchester City Hombre', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'H', 'M', '1', '2', 'Puma', 'Pantalon Manchester City Hombre', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'H', 'L', '1', '2', 'Puma', 'Pantalon Manchester City Hombre', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'H', 'XL', '1', '2', 'Puma', 'Pantalon Manchester City Hombre', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'M', 'S', '1', '2', 'Puma', 'Pantalon Manchester City Mujer', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'M', 'M', '1', '2', 'Puma', 'Pantalon Manchester City Mujer', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'M', 'L', '1', '2', 'Puma', 'Pantalon Manchester City Mujer', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
SELECT 'ART0000022', 'M', 'XL', '1', '2', 'Puma', 'Pantalon Manchester City Mujer', 'Temporada 22/23', 29500, 50, 1, '~/Imagenes/PANTALONES/PantalonManchesterCity.jpeg' UNION
--
SELECT 'ART0000023', 'H', 'S', '5', '2', 'Nike', 'Pantalon Nike FIT Hombre', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'H', 'M', '5', '2', 'Nike', 'Pantalon Nike FIT Hombre', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'H', 'L', '5', '2', 'Nike', 'Pantalon Nike FIT Hombre', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'H', 'XL', '5', '2', 'Nike', 'Pantalon Nike FIT Hombre', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'M', 'S', '5', '2', 'Nike', 'Pantalon Nike FIT Mujer', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'M', 'M', '5', '2', 'Nike', 'Pantalon Nike FIT Mujer', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'M', 'L', '5', '2', 'Nike', 'Pantalon Nike FIT Mujer', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
SELECT 'ART0000023', 'M', 'XL', '5', '2', 'Nike', 'Pantalon Nike FIT Mujer', 'Temporada 2023', 26000, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeFIT.jpeg' UNION
--
SELECT 'ART0000024', 'H', 'S', '3', '2', 'Nike', 'Pantalon Nike Therma Starting 5 Basquet Hombre', 'Temporada 22/23', 25500, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeThermaStarting5Basquet.jpeg' UNION
SELECT 'ART0000024', 'H', 'M', '3', '2', 'Nike', 'Pantalon Nike Therma Starting 5 Basquet Hombre', 'Temporada 22/23', 25500, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeThermaStarting5Basquet.jpeg' UNION
SELECT 'ART0000024', 'H', 'L', '3', '2', 'Nike', 'Pantalon Nike Therma Starting 5 Basquet Hombre', 'Temporada 22/23', 25500, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeThermaStarting5Basquet.jpeg' UNION
SELECT 'ART0000024', 'H', 'XL', '3', '2', 'Nike', 'Pantalon Nike Therma Starting 5 Basquet Hombre', 'Temporada 22/23', 25500, 50, 1, '~/Imagenes/PANTALONES/PantalonNikeThermaStarting5Basquet.jpeg' UNION
--
SELECT 'ART0000025', 'M', 'S', '5', '2', 'Adidas', 'Pantalon OTR Astro Mujer', 'Temporada 2023', 23500, 50, 1, '~/Imagenes/PANTALONES/PantalonOTRAstro.jpeg' UNION
SELECT 'ART0000025', 'M', 'M', '5', '2', 'Adidas', 'Pantalon OTR Astro Mujer', 'Temporada 2023', 23500, 50, 1, '~/Imagenes/PANTALONES/PantalonOTRAstro.jpeg' UNION
SELECT 'ART0000025', 'M', 'L', '5', '2', 'Adidas', 'Pantalon OTR Astro Mujer', 'Temporada 2023', 23500, 50, 1, '~/Imagenes/PANTALONES/PantalonOTRAstro.jpeg' UNION
SELECT 'ART0000025', 'M', 'XL', '5', '2', 'Adidas', 'Pantalon OTR Astro Mujer', 'Temporada 2023', 23500, 50, 1, '~/Imagenes/PANTALONES/PantalonOTRAstro.jpeg' UNION
--
SELECT 'ART0000026', 'H', 'S', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Hombre', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'H', 'M', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Hombre', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'H', 'L', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Hombre', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'H', 'XL', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Hombre', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'M', 'S', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Mujer', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'M', 'M', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Mujer', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'M', 'L', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Mujer', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
SELECT 'ART0000026', 'M', 'XL', '1', '2', 'Adidas', 'Pantalon Teamgeist Boca Juniors Tejido Mujer', 'Temporada 22/23', 34000, 50, 1, '~/Imagenes/PANTALONES/PantalonTeamgeistBocaJuniorsTejido.jpeg' UNION
--
SELECT 'ART0000027', 'H', 'S', '5', '2', 'Adidas', 'Pantalon Training Hombre', 'Temporada 2023', 19800, 50, 1, '~/Imagenes/PANTALONES/PantalonTraining.jpeg' UNION
SELECT 'ART0000027', 'H', 'M', '5', '2', 'Adidas', 'Pantalon Training Hombre', 'Temporada 2023', 19800, 50, 1, '~/Imagenes/PANTALONES/PantalonTraining.jpeg' UNION
SELECT 'ART0000027', 'H', 'L', '5', '2', 'Adidas', 'Pantalon Training Hombre', 'Temporada 2023', 19800, 50, 1, '~/Imagenes/PANTALONES/PantalonTraining.jpeg' UNION
SELECT 'ART0000027', 'H', 'XL', '5', '2', 'Adidas', 'Pantalon Training Hombre', 'Temporada 2023', 19800, 50, 1, '~/Imagenes/PANTALONES/PantalonTraining.jpeg' UNION


/***********************************************CALZADO***************************************************/


SELECT 'ART0000028', 'H', '38', '1', '5', 'Adidas', 'BOTINES NEMEZIZ 19+ TERRENO BLANDO Hombre', 'Temporada 2023', 35800, 50, 1, '~/Imagenes/CALZADO/BOTINESNEMEZIZ19+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000028', 'H', '40', '1', '5', 'Adidas', 'BOTINES NEMEZIZ 19+ TERRENO BLANDO Hombre', 'Temporada 2023', 35800, 50, 1, '~/Imagenes/CALZADO/BOTINESNEMEZIZ19+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000028', 'H', '42', '1', '5', 'Adidas', 'BOTINES NEMEZIZ 19+ TERRENO BLANDO Hombre', 'Temporada 2023', 35800, 50, 1, '~/Imagenes/CALZADO/BOTINESNEMEZIZ19+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000028', 'H', '44', '1', '5', 'Adidas', 'BOTINES NEMEZIZ 19+ TERRENO BLANDO Hombre', 'Temporada 2023', 35800, 50, 1, '~/Imagenes/CALZADO/BOTINESNEMEZIZ19+TERRENOBLANDO.jpeg' UNION
--
SELECT 'ART0000029', 'H', '38', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE.1 TERRENO BLANDO Hombre', 'Temporada 2023', 32000, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE.1TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000029', 'H', '40', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE.1 TERRENO BLANDO Hombre', 'Temporada 2023', 32000, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE.1TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000029', 'H', '42', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE.1 TERRENO BLANDO Hombre', 'Temporada 2023', 32000, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE.1TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000029', 'H', '44', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE.1 TERRENO BLANDO Hombre', 'Temporada 2023', 32000, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE.1TERRENOBLANDO.jpeg' UNION
--
SELECT 'ART0000030', 'H', '38', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Hombre', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'H', '40', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Hombre', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'H', '42', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Hombre', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'H', '44', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Hombre', 'Temporada 2023', 296000, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'M', '38', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Mujer', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'M', '40', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Mujer', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'M', '42', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Mujer', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
SELECT 'ART0000030', 'M', '44', '1', '5', 'Adidas', 'BOTINES PREDATOR EDGE+ TERRENO BLANDO Mujer', 'Temporada 2023', 29600, 50, 1, '~/Imagenes/CALZADO/BOTINESPREDATOREDGE+TERRENOBLANDO.jpeg' UNION
--
SELECT 'ART0000031', 'H', '38', '1', '5', 'Nike', 'Botines Tiempo Legend 9 Hombre', 'Temporada 2023', 37000, 50, 1, '~/Imagenes/CALZADO/BotinesTiempoLegend9.jpeg' UNION
SELECT 'ART0000031', 'H', '40', '1', '5', 'Nike', 'Botines Tiempo Legend 9 Hombre', 'Temporada 2023', 37000, 50, 1, '~/Imagenes/CALZADO/BotinesTiempoLegend9.jpeg' UNION
SELECT 'ART0000031', 'H', '42', '1', '5', 'Nike', 'Botines Tiempo Legend 9 Hombre', 'Temporada 2023', 37000, 50, 1, '~/Imagenes/CALZADO/BotinesTiempoLegend9.jpeg' UNION
SELECT 'ART0000031', 'H', '44', '1', '5', 'Nike', 'Botines Tiempo Legend 9 Hombre', 'Temporada 2023', 37000, 50, 1, '~/Imagenes/CALZADO/BotinesTiempoLegend9.jpeg' UNION

--
SELECT 'ART0000032', 'H', '38', '1', '5', 'Nike', 'Nike Phantom GT2 Elite FG Hombre', 'Temporada 2023', 34300, 50, 1, '~/Imagenes/CALZADO/NikePhantomGT2EliteFG.jpeg' UNION
SELECT 'ART0000032', 'H', '40', '1', '5', 'Nike', 'Nike Phantom GT2 Elite FG Hombre', 'Temporada 2023', 34300, 50, 1, '~/Imagenes/CALZADO/NikePhantomGT2EliteFG.jpeg' UNION
SELECT 'ART0000032', 'H', '42', '1', '5', 'Nike', 'Nike Phantom GT2 Elite FG Hombre', 'Temporada 2023', 34300, 50, 1, '~/Imagenes/CALZADO/NikePhantomGT2EliteFG.jpeg' UNION
SELECT 'ART0000032', 'H', '44', '1', '5', 'Nike', 'Nike Phantom GT2 Elite FG Hombre', 'Temporada 2023', 34300, 50, 1, '~/Imagenes/CALZADO/NikePhantomGT2EliteFG.jpeg' UNION

--
SELECT 'ART0000033', 'H', '38', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Academy IC Hombre', 'Temporada 2023', 33000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9AcademyIC.jpeg' UNION
SELECT 'ART0000033', 'H', '40', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Academy IC Hombre', 'Temporada 2023', 33000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9AcademyIC.jpeg' UNION
SELECT 'ART0000033', 'H', '42', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Academy IC Hombre', 'Temporada 2023', 33000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9AcademyIC.jpeg' UNION
SELECT 'ART0000033', 'H', '44', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Academy IC Hombre', 'Temporada 2023', 33000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9AcademyIC.jpeg' UNION
--
SELECT 'ART0000034', 'H', '38', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Hombre', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'H', '40', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Hombre', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'H', '42', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Hombre', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'H', '44', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Hombre', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'M', '38', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Mujer', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'M', '40', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Mujer', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'M', '42', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Mujer', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
SELECT 'ART0000034', 'M', '44', '1', '5', 'Nike', 'Nike Zoom Mercurial Superfly 9 Elite CR7 FG Mujer', 'Temporada 2023', 47000, 50, 1, '~/Imagenes/CALZADO/NikeZoomMercurialSuperfly9EliteCR7FG.jpeg' UNION
--
SELECT 'ART0000035', 'H', '38', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Hombre', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'H', '40', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Hombre', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'H', '42', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Hombre', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'H', '44', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Hombre', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'M', '38', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Mujer', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'M', '40', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Mujer', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'M', '42', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Mujer', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
SELECT 'ART0000035', 'M', '44', '5', '5', 'Adidas', 'ZAPATILLA ADIZERO ADI OS PRO3.0', 'Temporada 2023 Mujer', 19800, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAADIZEROADIOSPRO3.0.jpeg' UNION
--
SELECT 'ART0000036', 'H', '38', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Hombre', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'H', '40', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Hombre', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'H', '42', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Hombre', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'H', '44', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Hombre', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'M', '38', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Mujer', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'M', '40', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Mujer', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'M', '42', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Mujer', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
SELECT 'ART0000036', 'M', '44', '5', '5', 'Adidas', 'ZAPATILLA ULTRA BOOST LIGHT', 'Temporada 2023 Mujer', 20000, 50, 1, '~/Imagenes/CALZADO/ZAPATILLAULTRABOOSTLIGHT.jpeg' UNION
--
SELECT 'ART0000037', 'H', '38', '5', '5', 'Nike', 'Zapatilla Nike Air Zoom Pegasus 39', 'Temporada 2023 Hombre', 23000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeAirZoomPegasus39.jpeg' UNION
SELECT 'ART0000037', 'H', '40', '5', '5', 'Nike', 'Zapatilla Nike Air Zoom Pegasus 39', 'Temporada 2023 Hombre', 23000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeAirZoomPegasus39.jpeg' UNION
SELECT 'ART0000037', 'H', '42', '5', '5', 'Nike', 'Zapatilla Nike Air Zoom Pegasus 39', 'Temporada 2023 Hombre', 23000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeAirZoomPegasus39.jpeg' UNION
SELECT 'ART0000037', 'H', '44', '5', '5', 'Nike', 'Zapatilla Nike Air Zoom Pegasus 39', 'Temporada 2023 Hombre', 23000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeAirZoomPegasus39.jpeg' UNION
--
SELECT 'ART0000038', 'H', '38', '5', '5', 'Nike', 'Zapatilla Nike Downshifter 12', 'Temporada 2023 Hombre', 22000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeDownshifter12.jpeg' UNION
SELECT 'ART0000038', 'H', '40', '5', '5', 'Nike', 'Zapatilla Nike Downshifter 12', 'Temporada 2023 Hombre', 22000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeDownshifter12.jpeg' UNION
SELECT 'ART0000038', 'H', '42', '5', '5', 'Nike', 'Zapatilla Nike Downshifter 12', 'Temporada 2023 Hombre', 22000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeDownshifter12.jpeg' UNION
SELECT 'ART0000038', 'H', '44', '5', '5', 'Nike', 'Zapatilla Nike Downshifter 12', 'Temporada 2023 Hombre', 22000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeDownshifter12.jpeg' UNION
--
SELECT 'ART0000039', 'M', '38', '5', '5', 'Nike', 'Zapatilla Nike React Infinity Run Flyknit 3 Mujer', 'Temporada 2023', 27000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeReactInfinityRunFlyknit3.jpeg' UNION
SELECT 'ART0000039', 'M', '40', '5', '5', 'Nike', 'Zapatilla Nike React Infinity Run Flyknit 3 Mujer', 'Temporada 2023', 27000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeReactInfinityRunFlyknit3.jpeg' UNION
SELECT 'ART0000039', 'M', '42', '5', '5', 'Nike', 'Zapatilla Nike React Infinity Run Flyknit 3 Mujer', 'Temporada 2023', 27000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeReactInfinityRunFlyknit3.jpeg' UNION
SELECT 'ART0000039', 'M', '44', '5', '5', 'Nike', 'Zapatilla Nike React Infinity Run Flyknit 3 Mujer', 'Temporada 2023', 27000, 50, 1, '~/Imagenes/CALZADO/ZapatillaNikeReactInfinityRunFlyknit3.jpeg' UNION
--
SELECT 'ART0000040', 'M', '38', '5', '5', 'Adidas', 'ZAPATILLAS RUNNING ADIDAS ADIZERO SL Mujer', 'Temporada 2023', 26500, 50, 1, '~/Imagenes/CALZADO/ZAPATILLASRUNNINGADIDASADIZEROSL.jpeg' UNION
SELECT 'ART0000040', 'M', '40', '5', '5', 'Adidas', 'ZAPATILLAS RUNNING ADIDAS ADIZERO SL Mujer', 'Temporada 2023', 26500, 50, 1, '~/Imagenes/CALZADO/ZAPATILLASRUNNINGADIDASADIZEROSL.jpeg' UNION
SELECT 'ART0000040', 'M', '42', '5', '5', 'Adidas', 'ZAPATILLAS RUNNING ADIDAS ADIZERO SL Mujer', 'Temporada 2023', 26500, 50, 1, '~/Imagenes/CALZADO/ZAPATILLASRUNNINGADIDASADIZEROSL.jpeg' UNION
SELECT 'ART0000040', 'M', '44', '5', '5', 'Adidas', 'ZAPATILLAS RUNNING ADIDAS ADIZERO SL Mujer', 'Temporada 2023', 26500, 50, 1, '~/Imagenes/CALZADO/ZAPATILLASRUNNINGADIDASADIZEROSL.jpeg' UNION

/*****************************************************ACCESORIOS********************************/

SELECT 'ART0000041', 'U', 'L', '6', '6', 'Adidas', 'BOLSO AIRLINE R ADICOLOR 70S VINTAGE', 'Temporada 2023', 20000, 50, 1, '~/Imagenes/ACCESORIOS/BOLSOAIRLINERADICOLOR70SVINTAGE.jpeg' UNION
--
SELECT 'ART0000042', 'U', 'L', '6', '6', 'Adidas', 'GORRA ADICOLOR 70S BASEBALL', 'Temporada 2023', 10000, 50, 1, '~/Imagenes/ACCESORIOS/GORRAADICOLOR70SBASEBALL.jpeg' UNION
--
SELECT 'ART0000043', 'U', 'L', '6', '6', 'Nike', 'Gorra Nike Sportswear Heritage 86 Futura Washed', 'Temporada 2023', 9500, 50, 1, '~/Imagenes/ACCESORIOS/GorraNikeSportswearHeritage86FuturaWashed.jpeg' UNION
--
SELECT 'ART0000044', 'U', 'L', '5', '6', 'Nike', 'Gorro Nike Sportswear', 'Temporada 2023', 8700, 50, 1, '~/Imagenes/ACCESORIOS/GorroNikeSportswear.jpeg' UNION
--
SELECT 'ART0000045', 'U', 'L', '1', '6', 'Nike', 'Medias Nike Academy', 'Temporada 2023', 5000, 50, 1, '~/Imagenes/ACCESORIOS/MediasNikeAcademy.jpeg' UNION
--
SELECT 'ART0000046', 'U', 'L', '6', '6', 'Adidas', 'Mochila Essentials', 'Temporada 2023', 23000, 50, 1, '~/Imagenes/ACCESORIOS/MochilaEssentials.jpeg' UNION
--
SELECT 'ART0000047', 'U', 'L', '6', '6', 'Nike', 'Mochila Nike Academy Team', 'Temporada 2023', 21500, 50, 1, '~/Imagenes/ACCESORIOS/MochilaNikeAcademyTeam.jpeg' UNION
--
SELECT 'ART0000048', 'U', 'L', '6', '6', 'Nike', 'Riñonera Nike SB Heritage', 'Temporada 2023', 14000, 50, 1, '~/Imagenes/ACCESORIOS/RiñoneraNikeSBHeritage.jpeg' 
GO

INSERT INTO USUARIOS (Nombre_US, Apellido_US, FechaNacimiento_US, DNI_US, Telefono_US, Mail_US, Direccion_US, Localidad_US, Provincia_US, NombreUsuario_US, Contraseña_US)
SELECT 'Alberto', 'Morales', '2000-10-03', '34652764', '64732564', 'Albertomorales@gmail.com', 'Laprida 1500', 'Berazategui', 'Buenos Aires', 'AlbertoMorales', 'Contraseña123' UNION
SELECT 'Nahuel', 'Molina', '1980-11-12', '63789926', '26745163', 'Nahuelmolina@gmail.com', 'Castor 240', 'Ituzaingó', 'Buenos Aires', 'NahuelMolina', 'Contraseña1234' UNION
SELECT 'Maia', 'García', '1993-05-08', '44837926', '11627354', 'Maiagarcia@gmail.com', 'Libertador', 'Almafuerte', 'Córdoba', 'MaiaGarcia', 'Contraseña12345' 
GO

INSERT INTO VENTAS (IDUsuario_VE, DNI_VE, Telefono_VE, Total_VE, Fecha_VE)
SELECT  1, '34652764', '64732564', 10000, getdate() UNION
SELECT  2, '63789926', '26745163', 47000, getdate() UNION
SELECT  3, '44837926', '11627354', 54000, getdate() UNION
SELECT  1, '34652764', '64732564', 24000, getdate() 
GO

INSERT INTO DETALLEVENTAS (IDVenta_DV, IDArt_DV, IDSexo_DV, Talle_DV, Cantidad_DV, PrecioUnitario_DV)
SELECT 1, 'ART0000045', 'U', 'L', 2, 5000 UNION
SELECT 2, 'ART0000001', 'H', 'L', 1, 23500 UNION
SELECT 2, 'ART0000001', 'H', 'M', 1, 23500 UNION
SELECT 3, 'ART0000039', 'M', '38', 2, 27000 UNION
SELECT 4, 'ART0000003', 'H', 'L', 1, 24000
GO


/*Procedimientos almacenados*/

USE TIRO_LIBRE
GO

        CREATE PROCEDURE [dbo].[spAgregarCategoria]
        (
            @IDCATEGORIA int, @NOMBREDEPORTE varchar(50)
        )
        AS
        INSERT INTO CATEGORIAS (IDCategoria_CAT, NombreDeporte_CAT)
        SELECT @IDCATEGORIA, @NOMBREDEPORTE
        RETURN
		GO

		CREATE PROCEDURE [dbo].[spEliminarCategoria]
        (
            @IDCategoria int
        )
        AS
        DELETE FROM CATEGORIAS WHERE IDCategoria_CAT = @IDCategoria
        RETURN 
		GO

        CREATE PROCEDURE [dbo].[spAgregarTipoDePrenda]
        (
            @IDTIPODEPRENDA int, @DESCRIPCION varchar(50)
        )
        AS
        INSERT INTO TIPODEPRENDA (IDTipo_TDP, Descripcion_TDP)
        SELECT @IDTIPODEPRENDA, @DESCRIPCION
        RETURN
		GO

		CREATE PROCEDURE [dbo].[spEliminarTipoDePrenda]
        (
            @IDTIPODEPRENDA int
        )
        AS
        DELETE FROM TIPODEPRENDA WHERE IDTipo_TDP = @IDTIPODEPRENDA
        RETURN 
		GO

		CREATE PROCEDURE [dbo].[spAgregarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4), @IDCATEGORIA int, @TIPOPRENDA int, @IDPROVEEDOR char(10), @NOMBRE char(500), @DESCRIPCION varchar(500), @PRECIO money, @STOCK int, @ESTADO bit, @URLIMAGEN varchar(100)
        )
        AS
        INSERT INTO ARTICULOS (IDArt_AR, IDSexo_AR,	Talle_AR, IDCategoria_AR, IDTipo_AR, IDProveedor_AR, Nombre_AR,	Descripcion_AR,	Precio_AR, Stock_AR, Estado_AR, URL_Imagen_Producto)
        SELECT @IDARTICULO, @IDSEXO, @TALLE, @IDCATEGORIA, @TIPOPRENDA, @IDPROVEEDOR, @NOMBRE, @DESCRIPCION, @PRECIO, @STOCK, @ESTADO, @URLIMAGEN
        RETURN 
		GO


        CREATE PROCEDURE [dbo].[spEliminarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4)
        )
        AS
        DELETE FROM ARTICULOS WHERE IDArt_AR = @IDARTICULO AND IdSexo_AR = @IDSEXO AND Talle_AR = @TALLE
        RETURN 
		GO


        CREATE PROCEDURE [dbo].[spActualizarArticulo]
        (
            @IDARTICULO char(10), @IDSEXO char(1), @TALLE char(4), @IDCATEGORIA int, @TIPOPRENDA int, @IDPROVEEDOR char(10), @NOMBRE char(500), @DESCRIPCION varchar(500), @PRECIO money, @STOCK int, @ESTADO bit, @URLIMAGEN varchar(100)
        )
        AS
        UPDATE ARTICULOS SET IDArt_AR = @IDARTICULO, IDSexo_AR = @IDSEXO, Talle_AR = @TALLE, Nombre_AR = @NOMBRE, Descripcion_AR = @DESCRIPCION, Precio_AR = @PRECIO, Stock_AR = @STOCK, IDCategoria_AR = @IDCATEGORIA, IDTipo_AR = @TIPOPRENDA, IDProveedor_AR = @IDPROVEEDOR, Estado_AR = @ESTADO, URL_Imagen_Producto = @URLIMAGEN
        WHERE IDArt_AR = @IDARTICULO AND IDSexo_AR = @IDSEXO AND Talle_AR = @TALLE
        RETURN 
		GO

		CREATE PROCEDURE [dbo].[spEliminarDetalleVenta]
        (
            @IDVENTA int
        )
        AS
        DELETE FROM DETALLEVENTAS WHERE IDVenta_DV = @IDVENTA
        RETURN 
		GO

        CREATE PROCEDURE [dbo].[spAgregarDetalleVenta]
        (
            @IDVENTA int, @IDART char(10), @IDSEXO char(1), @TALLE char(4), @CANTIDAD int, @PRECIOUNITARIO money
        )
        AS
        INSERT INTO DetalleVentaS (IDVenta_DV, IDArt_DV, IDSexo_DV, Talle_DV, Cantidad_DV, PrecioUnitario_DV)
        SELECT @IDVENTA, @IDART, @IDSEXO, @TALLE, @CANTIDAD, @PRECIOUNITARIO
        RETURN
		GO

		CREATE PROCEDURE [dbo].[spEliminarProveedor]
        (
            @IDPROVEEDOR char(10)
        )
        AS
        DELETE FROM PROVEEDORES WHERE IDProveedor_PR = @IDPROVEEDOR
        RETURN 
		GO

        CREATE PROCEDURE [dbo].[spAgregarProveedor]
        (
            @IDPROVEEDOR char(10), @RAZONSOCIAL varchar(70), @DIRECCION varchar(70), @CIUDAD varchar(50), @PROVINCIA varchar(50), @TELEFONO varchar(20), @CONTACO varchar(40), @MAIL varchar(100)
        )
        AS
        INSERT INTO PROVEEDORES (IDProveedor_PR, RazonSocial_PR, Direccion_PR, Ciudad_PR, Provincia_PR, Telefono_PR, Contacto_PR, Mail_PR)
        SELECT @IDPROVEEDOR, @RAZONSOCIAL, @DIRECCION, @CIUDAD, @PROVINCIA, @TELEFONO, @CONTACO, @MAIL
        RETURN 
		GO


		CREATE PROCEDURE [dbo].[spEliminarUsuario]
        (
            @IDUSUARIO char(10)
        )
        AS
        DELETE FROM USUARIOS WHERE IDUsuario_US = @IDUSUARIO
        RETURN 
		GO

        CREATE PROCEDURE [dbo].[spAgregarUsuario]
        (
           @NOMBRE varchar(50), @APELLIDO varchar(50), @FECHA datetime, @DNI varchar(10), @TELEFONO varchar(20), @MAIL varchar(100), @DIRECCION varchar(70), @LOCALIDAD varchar(50), @PROVINCIA varchar(50), @NOMBREUSUARIO varchar(30), @CONTRASEÑA varchar(20)
        )
        AS
        INSERT INTO USUARIOS (Nombre_US, Apellido_US, FechaNacimiento_US, DNI_US, Telefono_US, Mail_US, Direccion_US, Localidad_US, Provincia_US, NombreUsuario_US, Contraseña_US)
        SELECT @NOMBRE, @APELLIDO, @FECHA, @DNI, @TELEFONO, @MAIL, @DIRECCION, @LOCALIDAD, @PROVINCIA, @NOMBREUSUARIO, @CONTRASEÑA
        RETURN 
		GO


		CREATE PROCEDURE [dbo].[spEliminarVenta]
        (
            @IDVENTA int
        )
        AS
        DELETE FROM VENTAS WHERE IDVenta_VE = @IDVENTA
        RETURN 
		GO

        CREATE PROCEDURE [dbo].[spAgregarVenta]
        (
            @IDUSUARIO int, @DNI varchar(10), @TELEFONO varchar(20), @TOTAL money
        )
        AS
        INSERT INTO VENTAS (IDUsuario_VE, DNI_VE, Telefono_VE, Total_VE, Fecha_VE)
        SELECT @IDUSUARIO, @DNI, @TELEFONO, @TOTAL, getdate()
        RETURN
		GO

		CREATE PROCEDURE [dbo].[SP_ArmarGrafico]
		AS
		BEGIN
		SELECT SUM(Total_VE), NombreUsuario_US
		FROM VENTAS 
		INNER JOIN USUARIOS 
		ON IDUsuario_US= IDUsuario_VE
		GROUP BY NombreUsuario_US 
		END
		GO

		CREATE PROCEDURE SP_CheckUsuario
			@Username VARCHAR(30), @Password VARCHAR(50)
		AS
		BEGIN
			DECLARE @ExisteUsuario BIT;
			SELECT @ExisteUsuario = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
			FROM USUARIOS
		WHERE NombreUsuario_US = @Username AND Contraseña_US = @Password;
			SELECT CAST(@ExisteUsuario AS BIT) AS Result;
		END
		GO

		CREATE PROCEDURE SP_ActualizarUsuario
			@ID INT
		AS
		BEGIN
			UPDATE USUARIOS
			SET Administrador_US = CASE WHEN Administrador_US = 0 THEN 1 ELSE 0 END
			WHERE IDUsuario_US = @ID;
		END
		GO

/*Triggers*/

		CREATE TRIGGER TR_BorrarArt
		ON CATEGORIAS
		INSTEAD OF DELETE
		AS
		BEGIN
			SET NOCOUNT ON;
			DELETE FROM ARTICULOS
			WHERE IDCategoria_AR IN (SELECT IDCategoria_Cat FROM DELETED);
			DELETE FROM CATEGORIAS
			WHERE IDCategoria_CAT IN (SELECT IDCategoria_Cat FROM DELETED);
		END
		GO

		CREATE TRIGGER TR_BorrarTDP
		ON TIPODEPRENDA
		INSTEAD OF DELETE
		AS
		BEGIN
			SET NOCOUNT ON;
			DELETE FROM ARTICULOS
			WHERE IDTipo_AR IN (SELECT IDTipo_TDP FROM DELETED);
			DELETE FROM TIPODEPRENDA
			WHERE IDTipo_TDP IN (SELECT IDTipo_TDP FROM DELETED);
		END
		GO