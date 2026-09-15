**DEL DOMINIO AL MODELO CONCEPTUAL**
---
## Identificación de entidades
 A partir del dominio del proyecto, se identificaron entidades que representan fuertemente el flujo y manejo de los datos del negocio, las cuales son: Proveedor, Insumo, Producto, Compra y Cliente.

## Jerarquía y especialización
La decisión de modelado más importante fue aplicar una generalización/especialización para la entidad Producto. Como la fábrica maneja dos tipos distintos de producto (diseños y prendas), se creó un supertipo Producto (con atributos comunes como el ID y el precio) y dos subtipos: Diseño (con alto, ancho y logotipo) y Prenda (con talle, color y tipo de tela).

## Manejo de localidades
Para evitar redundancia en la dirección de los clientes, se separó la ubicación geográfica en las entidades Ciudad y Provincia, vinculándolas jerárquicamente, y definiendo que Ciudad "conoce" a Provincia.

## Decisiones sobre atributos
* Se decidió incluir el atributo "nombre_producto" en la superclase "PRODUCTO". Por la herencia de nuestro modelo, tanto los diseños como las prendas van a tener una descripción legible para el usuario y útil para la facturación y visualización en el sistema sin necesidad de duplicar atributos en las subclases.

* Se presentó el problema de que en una compra hay muchos productos, por lo tanto la solución planteada fue crear la entidad/tabla "DETALLE_COMPRA" para registrar todos los campos (pertinentes) del producto en lo que sería una fila de la factura, por ejemplo, cantidad, precio unitario y nombre del producto (el total parcial es calculado en base a cantidad y precio unitario).


---
**DEL MODELO CONCEPTUAL AL MODELO LOGICO RELACIONAL**
---

## Mapping
  * Al traducir la estrategia del modelo conceptual, se creó la tabla principal "PRODUCTO" y tablas separadas para "DISEÑO" y "PRENDA". Estas últimas heredan la relación mediante la clave foránea (id_producto) que las vincula a la tabla principal.

* Se decidió no crear la columna "total_compra" en la tabla "COMPRA" (ni "precio_parcial" en "DETALLE_COMPRA"). Esto es porque estos valores se pueden calcular multiplicando cantidad por precio y sumando los resultados mediante consultas. Al omitirlos, evitamos redundancia y la inconsistencia de datos si algún precio cambia. 
De la misma manera, se omiten las columnas "stock_insumo" de la tabla "INSUMO" y "stock_producto" de la tabla "PRODUCTO", ya que, como su valor va decrementando dinámicamente en uno con cada adquisición o ventar respectivamente, tambien son atributos derivados/calculados.

* Se aplicaron restricciones de tipo unique a los correos electrónicos para que no puedan existir dos clientes o dos proveedores registrados con el mismo mail, siendo claves candidatas o alternativas además de sus respectivas Primary Keys.

* Para la tabla "DETALLE_COMPRA", en vez de usar una clave primaria compuesta solo por (id_compra, id_producto), se optó por crear una clave primaria subrogada a la que llamamos "id_detalle_compra". Esto se hizo con el fin de facilitar la identificación única de cada línea del ticket/factura de compra. También lo pensamos asi para anular la posible dependencia parcial de la columna "cantidad", haciendo que solo dependa de la clave "id_detalle_compra".
