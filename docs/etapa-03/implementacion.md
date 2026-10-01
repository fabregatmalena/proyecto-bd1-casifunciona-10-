# Etapa 03 - Implementación

## Implementación física de la base de datos

En esta etapa se llevó el modelo lógico desarrollado anteriormente al Sistema Gestor de Bases de Datos (SGBD), utilizando SQL Server.

A partir del modelo relacional y de las reglas de negocio definidas, se implementaron las tablas, sus atributos, claves primarias, claves foráneas y diferentes restricciones de integridad.

La base de datos fue denominada `NegocioIndumentariaDtf` y está compuesta por 15 tablas:

- PROVINCIA
- CIUDAD
- CLIENTE
- METODO_PAGO
- PRODUCTO
- DISENO
- PRENDA
- ESTAMPA
- PROVEEDOR
- INSUMO
- COMPRA
- DETALLE_COMPRA
- PRODUCTO_INSUMO
- FACTURA
- DETALLE_FACTURA


## Implementación mediante DDL

Para crear la estructura de la base de datos se utilizaron sentencias DDL (Data Definition Language), principalmente `CREATE TABLE`.

En cada tabla se definieron los tipos de datos correspondientes, utilizando principalmente:

- `INT` para los identificadores y cantidades.
- `VARCHAR` para nombres, descripciones, correos, teléfonos y otros datos de texto.
- `DECIMAL` para precios, importes, tarifas y medidas.
- `DATE` para las fechas.

También se implementaron claves primarias (`PRIMARY KEY`) para identificar de manera única cada registro y claves foráneas (`FOREIGN KEY`) para mantener las relaciones entre las diferentes tablas.


## Restricciones de integridad

Para garantizar la consistencia de los datos se utilizaron distintas restricciones.

### NOT NULL

Se utilizó `NOT NULL` en aquellos atributos que son obligatorios según las reglas de negocio.

Por ejemplo, un producto debe tener obligatoriamente un nombre, precio y stock disponible.


### PRIMARY KEY

Cada entidad posee una clave primaria que permite identificar de manera única sus registros.

Por ejemplo:

- `id_cliente` identifica a cada cliente.
- `id_producto` identifica a cada producto.
- `id_proveedor` identifica a cada proveedor.
- `id_factura` identifica a cada factura.


### FOREIGN KEY

Las claves foráneas permiten representar las relaciones establecidas en el modelo lógico y mantener la integridad referencial.

Algunas de las relaciones implementadas son:

- PROVINCIA 1:N CIUDAD.
- CIUDAD 1:N CLIENTE.
- CLIENTE 1:N FACTURA.
- PROVEEDOR 1:N COMPRA.
- COMPRA 1:N DETALLE_COMPRA.
- FACTURA 1:N DETALLE_FACTURA.
- PRODUCTO N:M INSUMO mediante PRODUCTO_INSUMO.

También se relacionan PRODUCTO, PRENDA, ESTAMPA y DISENO mediante sus correspondientes claves foráneas.


### UNIQUE

Se utilizaron restricciones `UNIQUE` para evitar valores duplicados en aquellos atributos que deben ser únicos.

Por ejemplo:

- DNI del cliente.
- Correo electrónico del cliente.
- Correo electrónico del proveedor.
- Nombre de provincia.
- Descripción del método de pago.


### CHECK

Se utilizaron restricciones `CHECK` para impedir el ingreso de valores que no cumplan con las reglas establecidas.

Por ejemplo:

- El precio de un producto no puede ser negativo.
- El stock de un producto no puede ser negativo.
- El stock de un insumo no puede ser negativo.
- La cantidad registrada en un detalle debe ser mayor a cero.
- Los precios unitarios no pueden ser negativos.
- La tarifa base de un diseño no puede ser negativa.
- Las medidas de un diseño deben ser mayores a cero cuando se registren.


### DEFAULT

Se utilizaron valores `DEFAULT` para establecer valores iniciales cuando corresponda.

Por ejemplo, el stock de un producto o insumo puede comenzar en 0 y el importe total de una factura posee un valor inicial de 0.


## Implementación de las relaciones

Las cardinalidades definidas durante el modelado fueron llevadas al SGBD mediante claves foráneas.

Por ejemplo, una provincia puede contener varias ciudades, mientras que cada ciudad pertenece a una única provincia. Para implementar esta relación, `CIUDAD` contiene la clave foránea `id_provincia`.

De la misma manera, un cliente puede tener varias facturas, pero cada factura corresponde a un único cliente. Por esta razón, `FACTURA` contiene la clave foránea `id_cliente`.

La relación entre PRODUCTO e INSUMO es de muchos a muchos (N:M), por lo que fue implementada mediante la tabla intermedia `PRODUCTO_INSUMO`.

La relación entre PROVEEDOR e INSUMO puede conocerse mediante las compras realizadas:

PROVEEDOR → COMPRA → DETALLE_COMPRA → INSUMO.

De esta manera es posible determinar qué proveedor suministró un determinado insumo, además de conocer la compra, la cantidad adquirida y su precio unitario.


## Productos, prendas, estampas y diseños

PRODUCTO representa la información general de los productos comercializados por el negocio.

PRENDA y ESTAMPA permiten registrar información específica de los distintos tipos de productos.

PRENDA almacena datos como:

- Tipo de tela.
- Talle.
- Color.

ESTAMPA permite identificar las estampas y relacionarlas con un producto y un diseño.

Por su parte, DISENO registra información como color, logotipo, tarifa base, ancho y alto.

Las claves foráneas permiten mantener las relaciones entre estas tablas y evitan que se registre una prenda o estampa asociada a productos o diseños inexistentes.


## Implementación mediante DML

Luego de crear la estructura de la base de datos se realizó la carga de datos de prueba mediante sentencias DML (Data Manipulation Language).

Se utilizaron principalmente sentencias `INSERT INTO`.

Los datos fueron cargados respetando el orden de dependencia de las claves foráneas.

Por ejemplo, primero se registraron las provincias y posteriormente las ciudades, debido a que CIUDAD necesita que exista previamente la provincia a la que pertenece.

De la misma manera, PRODUCTO y DISENO fueron cargados antes que PRENDA y ESTAMPA.

La carga de datos permitió comprobar el funcionamiento de las relaciones y restricciones implementadas.


## Cálculo del precio parcial

En DETALLE_FACTURA se implementó el atributo `precio_parcial` como una columna calculada.

Su valor se obtiene mediante:

`cantidad * precio_unitario`

De esta manera, el precio parcial no necesita ser ingresado manualmente, sino que es calculado por SQL Server a partir de los datos almacenados en cada detalle.


## Verificación de restricciones e integridad

Luego de la implementación se realizaron pruebas para comprobar que las restricciones funcionaran correctamente.

Entre las verificaciones realizadas se encuentran:

- Intentar registrar un producto con precio negativo.
- Intentar registrar un producto o insumo con stock negativo.
- Intentar registrar cantidades menores o iguales a cero.
- Intentar utilizar una clave primaria repetida.
- Intentar registrar una prenda asociada a un producto inexistente.
- Intentar registrar una estampa asociada a un diseño inexistente.
- Intentar registrar una ciudad asociada a una provincia inexistente.
- Intentar registrar una factura asociada a un cliente inexistente.

En estos casos, el SGBD debe rechazar las operaciones debido a las restricciones `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` y `CHECK` implementadas.

También se realizaron consultas `SELECT` sobre las tablas para comprobar que los datos válidos fueran almacenados correctamente.


## Integridad referencial

Para mantener la integridad referencial se utilizaron principalmente las opciones `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

Esto evita eliminar o modificar registros que estén siendo utilizados como referencia por otras tablas.

En DETALLE_FACTURA y DETALLE_COMPRA se utilizó `ON DELETE CASCADE` respecto de sus respectivas cabeceras.

De esta manera, si se elimina una factura, también se eliminan sus detalles asociados. De forma similar, si se elimina una compra, se eliminan sus detalles correspondientes.


## Resultado de la implementación

La implementación permitió transformar el modelo lógico en una base de datos funcional dentro de SQL Server.

Las tablas fueron relacionadas mediante claves primarias y foráneas, mientras que las restricciones `NOT NULL`, `UNIQUE`, `CHECK` y `DEFAULT` permiten controlar la validez de los datos ingresados.

Finalmente, mediante la carga de datos de prueba y las pruebas de restricciones se pudo verificar el funcionamiento de las relaciones y la integridad de la base de datos.
