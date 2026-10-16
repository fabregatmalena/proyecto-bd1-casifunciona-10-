SELECT 
    C.id_cliente,
    C.nombre_cliente,
    C.apellido_cliente,
    C.correo_cliente,
    CI.nombre_ciudad,
    COUNT(F.id_factura) AS Total_Facturas,
    SUM(F.importe_total) AS Gasto_Total
FROM CLIENTE C
INNER JOIN CIUDAD CI ON C.id_ciudad = CI.id_ciudad
INNER JOIN FACTURA F ON C.id_cliente = F.id_cliente
GROUP BY 
    C.id_cliente, 
    C.nombre_cliente, 
    C.apellido_cliente, 
    C.correo_cliente, 
    CI.nombre_ciudad
HAVING SUM(F.importe_total) > 40000.00
ORDER BY Gasto_Total DESC;