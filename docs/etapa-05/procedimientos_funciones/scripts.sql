-- Creacion del procedimiento almacenado sp_ActualizarStockInsumo
USE NegocioIndumentariaDtf;
GO

CREATE PROCEDURE dbo.sp_ActualizarStockInsumo
    @id_insumo INT,
    @cantidad_agregada INT
AS
BEGIN
    UPDATE INSUMO
    SET stock_insumo = stock_insumo + @cantidad_agregada
    WHERE id_insumo = @id_insumo;
END;
GO

-- Creacion de la función fn_TotalCompradoCliente
USE NegocioIndumentariaDtf;
GO

SELECT 
    nombre_cliente, 
    apellido_cliente, 
    dbo.fn_TotalCompradoCliente(id_cliente) AS Total_Gastado 
FROM CLIENTE;



-- Utilización de la función fn_TotalCompradoCliente para obtener el gasto histórico acumulado de cada cliente
SELECT 
    nombre_cliente, 
    apellido_cliente, 
    dbo.fn_TotalCompradoCliente(id_cliente) AS Gasto_Historico_Total
FROM CLIENTE
ORDER BY Gasto_Historico_Total DESC;


-- Utilización del procedimiento almacenado sp_ActualizarStockInsumo para actualizar el stock de un insumo específico
USE NegocioIndumentariaDtf;
GO

-- Consultar el stock actual antes de la operación
SELECT tipo_insumo, stock_insumo AS Stock_Antes 
FROM INSUMO 
WHERE id_insumo = 1;

-- Ejecutar el procedimiento para sumar 50 unidades
EXEC dbo.sp_ActualizarStockInsumo @id_insumo = 1, @cantidad_agregada = 50;

-- Consultar el nuevo stock para verificar el cambio
SELECT tipo_insumo, stock_insumo AS Stock_Despues 
FROM INSUMO 
WHERE id_insumo = 1;