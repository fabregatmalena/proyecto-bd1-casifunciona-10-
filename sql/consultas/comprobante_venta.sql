
SELECT 
    F.id_factura,
    F.fecha_factura,
    C.nombre_cliente + ' ' + C.apellido_cliente AS Cliente,
    MP.descripcion AS Metodo_Pago,
    P.nombre_producto,
    DF.cantidad,
    DF.precio_unitario,
    DF.precio_parcial AS Subtotal_Renglon,
    SUM(DF.precio_parcial) OVER(PARTITION BY F.id_factura) AS Total_Acumulado
FROM FACTURA F
INNER JOIN CLIENTE C ON F.id_cliente = C.id_cliente
INNER JOIN METODO_PAGO MP ON F.id_metodopago = MP.id_metodopago
INNER JOIN DETALLE_FACTURA DF ON F.id_factura = DF.id_factura
INNER JOIN PRODUCTO P ON DF.id_producto = P.id_producto
WHERE F.id_factura = 1; 