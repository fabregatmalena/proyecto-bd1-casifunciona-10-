# Casos de Uso 

## Introducción

Se realizaron tres consultas SQL para obtener información 
de las facturas, los clientes y losproductos
 vendidos por el negocio.
Estas consultas permiten recuperar información de diferentes
tablas relacionadas, aplicar filtros y realizar cálculos
sobre los datos almacenados.


## Caso de Uso 01: Consulta del detalle de una factura

### Objetivo
Consultar la información de una factura específica para conocer
los productos vendidos, las cantidades, los precios y el
importe total calculado.

### Descripción
Esta consulta permite obtener los datos correspondientes
a una factura registrada en el sistema.

Se relacionan las tablas FACTURA, CLIENTE, METODO_PAGO,
DETALLE_FACTURA y PRODUCTO para mostrar la información
de la venta.

En este caso, se consulta la factura con identificador 1.

### Consulta SQL

```sql
SELECT 
    F.id_factura,
    F.fecha_factura,
    C.nombre_cliente + ' ' + C.apellido_cliente AS Cliente,
    MP.descripcion AS Metodo_Pago,
    P.nombre_producto,
    DF.cantidad,
    DF.precio_unitario,
    DF.precio_parcial AS Subtotal_Renglon,
    SUM(DF.precio_parcial) OVER(
        PARTITION BY F.id_factura
    ) AS Total_Acumulado
FROM FACTURA F
INNER JOIN CLIENTE C
    ON F.id_cliente = C.id_cliente
INNER JOIN METODO_PAGO MP
    ON F.id_metodopago = MP.id_metodopago
INNER JOIN DETALLE_FACTURA DF
    ON F.id_factura = DF.id_factura
INNER JOIN PRODUCTO P
    ON DF.id_producto = P.id_producto
WHERE F.id_factura = 1;
```

### Resultado esperado
La consulta muestra el identificador y fecha de la factura,
el nombre del cliente, el método de pago, los productos,
las cantidades, los precios unitarios y los subtotales.
También muestra el total calculado de la factura.
La función de ventana permite conservar cada renglón
de la factura y mostrar el total correspondiente.


## Caso de Uso 02: Clientes con gastos superiores a $40.000

### Objetivo
Identificar los clientes que realizaron compras por un
importe acumulado superior a $40.000.

### Descripción

Esta consulta permite conocer cuánto gastó cada cliente
en el negocio y cuántas facturas tiene registradas.

Para ello se relacionan las tablas CLIENTE, CIUDAD
y FACTURA.

Los resultados se agrupan por cliente y se muestran
únicamente aquellos cuyo gasto total supera los $40.000.

### Consulta SQL

```sql
SELECT 
    C.id_cliente,
    C.nombre_cliente,
    C.apellido_cliente,
    C.correo_cliente,
    CI.nombre_ciudad,
    COUNT(F.id_factura) AS Total_Facturas,
    SUM(F.importe_total) AS Gasto_Total
FROM CLIENTE C
INNER JOIN CIUDAD CI
    ON C.id_ciudad = CI.id_ciudad
INNER JOIN FACTURA F
    ON C.id_cliente = F.id_cliente
GROUP BY 
    C.id_cliente,
    C.nombre_cliente,
    C.apellido_cliente,
    C.correo_cliente,
    CI.nombre_ciudad
HAVING SUM(F.importe_total) > 40000.00
ORDER BY Gasto_Total DESC;
```

### Resultado esperado
La consulta muestra el identificador, nombre, apellido,
correo electrónico y ciudad de cada cliente.
También informa la cantidad de facturas registradas
y el gasto total acumulado.
Solamente aparecen los clientes que superan los $40.000
en compras, ordenados desde el mayor gasto hasta el menor.

## Caso de Uso 03: Reporte de productos vendidos

### Objetivo
Consultar los productos vendidos durante un período
determinado para conocer las unidades vendidas
y los ingresos generados.

### Descripción

Esta consulta permite obtener información sobre las ventas
realizadas durante septiembre de 2026.

Se relacionan las tablas FACTURA, DETALLE_FACTURA
y PRODUCTO.

Los datos se agrupan por producto para calcular
la cantidad de renglones de venta registrados,
las unidades vendidas y los ingresos obtenidos.

### Consulta SQL

```sql
SELECT 
    P.nombre_producto,
    COUNT(DF.id_detalle_factura) AS Cantidad_Operaciones,
    SUM(DF.cantidad) AS Unidades_Vendidas,
    SUM(DF.precio_parcial) AS Ingreso_Total
FROM FACTURA F
INNER JOIN DETALLE_FACTURA DF
    ON F.id_factura = DF.id_factura
INNER JOIN PRODUCTO P
    ON DF.id_producto = P.id_producto
WHERE F.fecha_factura
    BETWEEN '2026-09-01' AND '2026-09-30'
GROUP BY P.nombre_producto
ORDER BY Ingreso_Total DESC;
```

### Resultado esperado

La consulta muestra el nombre de cada producto vendido,
la cantidad de renglones de venta registrados,
las unidades vendidas y el ingreso total generado.

Los resultados corresponden a las facturas emitidas
entre el 1 y el 30 de septiembre de 2026.

Finalmente, se ordenan los productos desde el que
generó mayores ingresos hasta el que generó menos.


