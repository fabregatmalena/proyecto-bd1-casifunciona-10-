-- Creacion de la función fn_TotalCompradoCliente
USE NegocioIndumentariaDtf;
GO

SELECT 
    nombre_cliente, 
    apellido_cliente, 
    dbo.fn_TotalCompradoCliente(id_cliente) AS Total_Gastado 
FROM CLIENTE;



-- Utilización de la función para obtener el gasto histórico acumulado de cada cliente
SELECT 
    nombre_cliente, 
    apellido_cliente, 
    dbo.fn_TotalCompradoCliente(id_cliente) AS Gasto_Historico_Total
FROM CLIENTE
ORDER BY Gasto_Historico_Total DESC;
