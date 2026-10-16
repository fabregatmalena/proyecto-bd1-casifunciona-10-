
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