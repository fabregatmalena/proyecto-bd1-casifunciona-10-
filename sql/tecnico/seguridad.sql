USE NegocioIndumentariaDtf;
GO

SELECT name
FROM sys.tables
ORDER BY name;

USE NegocioIndumentariaDtf;
GO

SELECT COUNT(*) AS CantidadTablas
FROM sys.tables;
GO

USE master;
GO

CREATE LOGIN admin_indumentaria
WITH PASSWORD = 'Admin2026*';
GO

CREATE LOGIN empleado_ventas
WITH PASSWORD = 'Ventas2026*';
GO

CREATE LOGIN empleado_stock
WITH PASSWORD = 'Stock2026*';
GO

SELECT name
FROM sys.server_principals
WHERE name IN (
    'admin_indumentaria',
    'empleado_ventas',
    'empleado_stock'
);

USE NegocioIndumentariaDtf;
GO

CREATE USER admin_indumentaria
FOR LOGIN admin_indumentaria;
GO

CREATE USER empleado_ventas
FOR LOGIN empleado_ventas;
GO

CREATE USER empleado_stock
FOR LOGIN empleado_stock;
GO

USE NegocioIndumentariaDtf;
GO

ALTER ROLE db_owner
ADD MEMBER admin_indumentaria;
GO

USE NegocioIndumentariaDtf;
GO

GRANT SELECT ON dbo.CLIENTE TO empleado_ventas;
GRANT SELECT ON dbo.FACTURA TO empleado_ventas;
GRANT SELECT ON dbo.DETALLE_FACTURA TO empleado_ventas;
GRANT SELECT ON dbo.PRENDA TO empleado_ventas;
GRANT SELECT ON dbo.DISENO TO empleado_ventas;
GRANT SELECT ON dbo.METODO_PAGO TO empleado_ventas;
GO


USE NegocioIndumentariaDtf;
GO

CREATE ROLE rol_ventas;
GO

CREATE ROLE rol_stock;
GO

USE NegocioIndumentariaDtf;
GO

ALTER ROLE rol_ventas
ADD MEMBER empleado_ventas;
GO

ALTER ROLE rol_stock
ADD MEMBER empleado_stock;
GO

USE NegocioIndumentariaDtf;
GO

EXECUTE AS USER = 'empleado_ventas';
GO

SELECT * FROM CLIENTE;
GO

REVERT;
GO
USE NegocioIndumentariaDtf;
GO

GRANT SELECT ON dbo.CLIENTE TO rol_ventas;
GRANT SELECT ON dbo.FACTURA TO rol_ventas;
GRANT SELECT ON dbo.DETALLE_FACTURA TO rol_ventas;
GRANT SELECT ON dbo.PRENDA TO rol_ventas;
GRANT SELECT ON dbo.DISENO TO rol_ventas;
GRANT SELECT ON dbo.METODO_PAGO TO rol_ventas;
GO

GRANT SELECT ON dbo.PRODUCTO TO rol_stock;
GRANT SELECT ON dbo.INSUMO TO rol_stock;
GRANT SELECT ON dbo.PRENDA TO rol_stock;
GRANT SELECT ON dbo.ESTAMPA TO rol_stock;
GRANT SELECT ON dbo.PROVEEDOR TO rol_stock;
GO
USE NegocioIndumentariaDtf;
GO

REVOKE SELECT ON dbo.CLIENTE FROM empleado_ventas;
REVOKE SELECT ON dbo.FACTURA FROM empleado_ventas;
REVOKE SELECT ON dbo.DETALLE_FACTURA FROM empleado_ventas;
REVOKE SELECT ON dbo.PRENDA FROM empleado_ventas;
REVOKE SELECT ON dbo.DISENO FROM empleado_ventas;
REVOKE SELECT ON dbo.METODO_PAGO FROM empleado_ventas;
GO

USE NegocioIndumentariaDtf;
GO

EXECUTE AS USER = 'empleado_stock';
GO

SELECT * FROM INSUMO;
GO

REVERT;
GO

USE NegocioIndumentariaDtf;
GO

EXECUTE AS USER = 'empleado_ventas';
GO

DELETE FROM CLIENTE
WHERE 1 = 0;
GO

REVERT;
GO

USE NegocioIndumentariaDtf;
GO

SELECT
    USER_NAME(role_principal_id) AS Rol,
    USER_NAME(member_principal_id) AS Usuario
FROM sys.database_role_members
WHERE USER_NAME(member_principal_id) IN (
    'admin_indumentaria',
    'empleado_ventas',
    'empleado_stock'
);
GO

USE NegocioIndumentariaDtf;
GO

SELECT
    R.name AS Nombre_Rol,
    U.name AS Nombre_Usuario
FROM sys.database_role_members RM
INNER JOIN sys.database_principals R
    ON RM.role_principal_id = R.principal_id
INNER JOIN sys.database_principals U
    ON RM.member_principal_id = U.principal_id
WHERE U.name IN (
    'admin_indumentaria',
    'empleado_ventas',
    'empleado_stock'
);
GO