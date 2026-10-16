# Informe de Ventas Mensual

Acontinuación se detalla la consulta SQL desarrollada para generar el reporte agregado de ventas de la fábrica textil.

## Necesidad de información que resuelve
El negocio necesita analizar el rendimiento comercial de sus productos impresos (prendas y estampas) durante un período de tiempo específico (en este caso, el mes de septiembre de 2026). 

La consulta busca responder a las siguientes preguntas clave para la toma de decisiones:
* ¿Cuáles son los productos que generan mayores ingresos?
* ¿Cuántas unidades físicas de cada producto se vendieron en total?
* ¿En cuántas operaciones (facturas distintas) participó cada producto?

Esta información es vital para que la fábrica pueda ajustar su producción, gestionar el stock de insumos y evaluar qué diseños o prendas son los más rentables.

## Estrategia SQL utilizada
Para construir este reporte, se utilizó una estrategia de combinación de tablas y funciones de agregación (`GROUP BY`, `SUM`, `COUNT`):

* **Composición de datos (JOIN):** Se utilizaron sentencias `INNER JOIN` para vincular las tablas `FACTURA` (que contiene la fecha de la operación), `DETALLE_FACTURA` (que contiene las cantidades y precios parciales calculados) y `PRODUCTO` (para obtener el nombre descriptivo del artículo vendido).
* **Filtro temporal (WHERE):** Se aplicó la cláusula `BETWEEN` sobre el campo `fecha_factura` para limitar el análisis exclusivamente a las ventas realizadas entre el '2026-09-01' y el '2026-09-30'.
* **Agrupamiento (GROUP BY):** Se agruparon los registros utilizando el campo `nombre_producto` de la tabla `PRODUCTO`.
* **Funciones de Agregación:**
  * `COUNT(DF.id_detalle_factura)`: Cuenta en cuántas líneas de factura aparece el producto (Cantidad de Operaciones).
  * `SUM(DF.cantidad)`: Suma todas las unidades físicas vendidas de ese producto (Unidades Vendidas).
  * `SUM(DF.precio_parcial)`: Suma los ingresos generados por ese producto (Ingreso Total).
* **Ordenamiento (ORDER BY):** Se ordenaron los resultados de forma descendente (`DESC`) según el ingreso total, para que los productos más rentables aparezcan en los primeros lugares.


## Resultado esperado
Al ejecutar este script, el motor de SQL Server devolverá una tabla consolidada (Data Set) donde cada fila representará un producto único que haya tenido al menos una venta en septiembre de 2026.

Las columnas mostrarán el nombre del producto, la cantidad de veces que fue facturado, el total de unidades que salieron del stock y el dinero total recaudado por ese artículo. El primer registro de la lista será el producto "estrella" que más dinero le generó al negocio en ese mes.

<br>

## Código de la consulta

```sql
SELECT
    P.nombre_producto,
    COUNT(DF.id_detalle_factura) AS Cantidad_Operaciones,
    SUM(DF.cantidad) AS Unidades_Vendidas,
    SUM(DF.precio_parcial) AS Ingreso_Total
FROM FACTURA F
INNER JOIN DETALLE_FACTURA DF ON F.id_factura = DF.id_factura
INNER JOIN PRODUCTO P ON DF.id_producto = P.id_producto
WHERE F.fecha_factura BETWEEN '2026-09-01' AND '2026-09-30'
GROUP BY P.nombre_producto
ORDER BY Ingreso_Total DESC;

