-- ============================================================================
-- TRABAJO PRÁCTICO: ETAPA V - SQL SERVER EXPRESS
-- TEMA: OPTIMIZACIÓN DE CONSULTAS A TRAVÉS DE ÍNDICES
-- BASE DE DATOS: NegocioIndumentariaDtf
-- ============================================================================

USE NegocioIndumentariaDtf;
GO

-- ----------------------------------------------------------------------------
-- 1. CREACIÓN DE LA TABLA HISTÓRICA DE PRUEBA
-- ----------------------------------------------------------------------------
IF OBJECT_ID('dbo.FACTURA_HISTORICA', 'U') IS NOT NULL
    DROP TABLE dbo.FACTURA_HISTORICA;
GO

CREATE TABLE dbo.FACTURA_HISTORICA (
    id_factura BIGINT IDENTITY(1,1),
    fecha_factura DATE NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    id_cliente INT NOT NULL,
    id_metodopago INT NOT NULL,
    importe_total DECIMAL(12,2) NOT NULL
);
GO

-- ----------------------------------------------------------------------------
-- 2. CARGA MASIVA DE DATOS (1.000.000 DE REGISTROS)
-- ----------------------------------------------------------------------------
SET NOCOUNT ON;
GO

WITH Numeros AS (
    SELECT TOP (1000000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
    CROSS JOIN sys.objects c
)
INSERT INTO dbo.FACTURA_HISTORICA (fecha_factura, descripcion, id_cliente, id_metodopago, importe_total)
SELECT 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1825, '2022-01-01'),
    'Venta masiva indumentaria',
    (ABS(CHECKSUM(NEWID())) % 10) + 1,
    (ABS(CHECKSUM(NEWID())) % 10) + 1,
    ROUND(RAND(CHECKSUM(NEWID())) * 50000, 2)
FROM Numeros;
GO

-- ----------------------------------------------------------------------------
-- 3. ESCENARIO 1: CONSULTA SIN ÍNDICES (HEAP / TABLE SCAN)
-- ----------------------------------------------------------------------------
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO

-- ----------------------------------------------------------------------------
-- 4. ESCENARIO 2: ÍNDICE AGRUPADO POR FECHA (CLUSTERED INDEX SEEK)
-- ----------------------------------------------------------------------------
CREATE CLUSTERED INDEX IX_FacturaHistorica_Fecha
ON dbo.FACTURA_HISTORICA (fecha_factura);
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO

-- ----------------------------------------------------------------------------
-- 5. ESCENARIO 3: ÍNDICE NO AGRUPADO CON COBERTURA (INDEX SEEK CON INCLUDE)
-- ----------------------------------------------------------------------------
DROP INDEX IX_FacturaHistorica_Fecha ON dbo.FACTURA_HISTORICA;
GO

CREATE NONCLUSTERED INDEX IX_FacturaHistorica_Fecha_Cobertura
ON dbo.FACTURA_HISTORICA (fecha_factura)
INCLUDE (id_factura, importe_total);
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
