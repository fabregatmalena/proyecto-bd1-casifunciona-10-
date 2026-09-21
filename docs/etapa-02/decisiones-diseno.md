**DEL DOMINIO AL MODELO CONCEPTUAL**
---
## Identificación de entidades
 A partir del dominio del proyecto, se identificaron entidades que representan fuertemente el flujo y manejo de los datos del negocio, las cuales son: Proveedor, Insumo, Producto, Prenda, Estampa, Diseño, Compra, Factura, Cliente y Método de pago.

## Jerarquía y especialización
La decisión de modelado más importante fue aplicar una generalización/especialización para la entidad Producto. Como la fábrica maneja dos formatos físicos distintos para la venta, se creó un supertipo Producto (con atributos comunes como el ID, el precio y el nombre) y dos subtipos: Estampa y Prenda. Además, se decidió extraer Diseño como un catálogo independiente (con alto, ancho, tarifa base y logotipo) que no se comercializa solo, sino que se asocia a las prendas o estampas mediante una relación.

## Manejo de localidades
Para evitar redundancia en la dirección de los clientes, se separó la ubicación geográfica en las entidades Ciudad y Provincia, vinculándolas jerárquicamente, y definiendo que Ciudad "conoce" a Provincia.

## Decisiones sobre atributos
* Se decidió incluir el atributo "nombre_producto" en la superclase "PRODUCTO". Por la herencia de nuestro modelo, tanto las estampas como las prendas van a tener una descripción legible para el usuario y útil para la facturación y visualización en el sistema sin necesidad de duplicar atributos en las subclases.

* Se presentó el problema de manejar de forma independiente las compras a proveedores y las ventas a clientes. La solución planteada fue bifurcar los circuitos: las ventas se registran en "FACTURA" (junto a "detalle_factura" para registrar cantidad y precio unitario del producto), y el abastecimiento se registra en "COMPRA" (junto a "detalle_compra" para registrar los insumos del proveedor).

---
**DEL MODELO CONCEPTUAL AL MODELO LOGICO RELACIONAL**
---

## Mapping
  * Al traducir la estrategia del modelo conceptual, se creó la tabla principal "PRODUCTO" y tablas separadas para "ESTAMPA" y "PRENDA". Estas últimas heredan la relación mediante la clave foránea (id_producto) que las vincula a la tabla principal. A su vez, se asocian al catálogo de diseños mediante la clave foránea (id_diseno).

* Se decidió no crear columnas de totales en la tabla "COMPRA" ni en "FACTURA". Esto es porque estos valores se pueden calcular multiplicando cantidad por precio y sumando los resultados mediante consultas. Al omitirlos, evitamos redundancia y la inconsistencia de datos si algún precio cambia. 
De la misma manera, se omiten las columnas "stock_insumo" de la tabla "INSUMO" y "stock_producto" de la tabla "PRODUCTO", ya que, como su valor va decrementando dinámicamente con cada adquisición o venta respectivamente, tambien son atributos derivados/calculados.

* Se aplicaron restricciones de tipo unique a los correos electrónicos para que no puedan existir dos clientes o dos proveedores registrados con el mismo mail, siendo claves candidatas o alternativas además de sus respectivas Primary Keys.

* Para las tablas "detalle_compra" y "detalle_factura", en vez de usar claves primarias compuestas, se optó por crear claves primarias subrogadas a las que llamamos "id_detalle_compra" e "id_detalle_factura". Esto se hizo con el fin de facilitar la identificación única de cada línea del ticket/factura. También lo pensamos asi para anular la posible dependencia parcial de la columna "cantidad", haciendo que solo dependa de la clave subrogada.


