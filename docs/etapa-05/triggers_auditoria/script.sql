-- Implementacion en sql del trigger y auditoria de cambios en el precio de los productos
USE NegocioIndumentariaDtf;
GO

-- Se crea tabla de auditoría
CREATE TABLE AUDITORIA_PRECIO_PRODUCTO (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME DEFAULT GETDATE(),
    usuario VARCHAR(50) DEFAULT SUSER_SNAME(),
    id_producto INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2)
);
GO

-- Se crea el Trigger sobre la tabla PRODUCTO
CREATE TRIGGER trg_AuditoriaCambioPrecio
ON PRODUCTO
AFTER UPDATE
AS
BEGIN
    -- Solo auditamos si efectivamente se modificó la columna precio_producto
    IF UPDATE(precio_producto)
    BEGIN
        INSERT INTO AUDITORIA_PRECIO_PRODUCTO (id_producto, precio_anterior, precio_nuevo)
        SELECT 
            d.id_producto, 
            d.precio_producto, 
            i.precio_producto
        FROM deleted d
        INNER JOIN inserted i ON d.id_producto = i.id_producto;
    END
END;
GO


--Demostración del disparador automático

-- Verificamos el precio actual del Producto 1 (Remera Manga Corta)
SELECT id_producto, nombre_producto, precio_producto FROM PRODUCTO WHERE id_producto = 1;

-- Ejecutamos un UPDATE normal, subiendo el precio a $18,500
UPDATE PRODUCTO SET precio_producto = 18500.00 WHERE id_producto = 1;

-- Consultamos la tabla fantasma de auditoría para comprobar que el Trigger hizo su trabajo solo
SELECT * FROM AUDITORIA_PRECIO_PRODUCTO;