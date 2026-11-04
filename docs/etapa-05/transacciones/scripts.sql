/* Proyecto: NegocioIndumentariaDtf — Equipo 10
   Etapa 5: Manejo de transacciones
   Responsable: Pared Ifran Maitena
   Estas pruebas se realizaron sobre la base de PRACTICA NegocioEstampadosEtapa3.
   Ejecutar cada prueba por separado, en orden, en un entorno de práctica.
   Requisitos: cliente 1, método de pago 1 y productos 1 y 2 existentes;
   facturas 9001 y 9002 libres antes de comenzar. */
USE NegocioEstampadosEtapa3;
GO

-- PRUEBA 1: Registramos una venta y confirmamos con COMMIT.
BEGIN TRY
    BEGIN TRANSACTION;
    IF EXISTS (SELECT 1 FROM FACTURA WHERE id_factura = 9001)
        THROW 50001, 'La factura 9001 ya existe.', 1;
    INSERT INTO FACTURA (id_factura, fecha_factura, id_cliente, id_metodopago)
    VALUES (9001, GETDATE(), 1, 1);
    INSERT INTO DETALLE_FACTURA
        (id_detalle_factura, id_factura, cantidad, precio_unitariofactura, id_producto)
    VALUES (1, 9001, 2, 15000.00, 1), (2, 9001, 1, 28000.00, 2);
    COMMIT TRANSACTION;
    PRINT 'La venta se registro correctamente.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH;
GO
SELECT * FROM FACTURA WHERE id_factura = 9001;
SELECT * FROM DETALLE_FACTURA WHERE id_factura = 9001;
GO

-- PRUEBA 2: Cambiamos una fecha y cancelamos la modificación.
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE FACTURA SET fecha_factura = '2020-01-01' WHERE id_factura = 9001;
    IF @@ROWCOUNT = 0 THROW 50002, 'No existe la factura 9001.', 1;
    SELECT id_factura, fecha_factura AS fecha_temporal FROM FACTURA WHERE id_factura = 9001;
    ROLLBACK TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH;
GO
SELECT id_factura, fecha_factura AS fecha_recuperada FROM FACTURA WHERE id_factura = 9001;
GO

-- PRUEBA 3: Provocamos un error de clave foránea y cancelamos la venta.
BEGIN TRY
    BEGIN TRANSACTION;
    IF EXISTS (SELECT 1 FROM FACTURA WHERE id_factura = 9002)
        THROW 50003, 'La factura 9002 ya existe.', 1;
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = -999)
        THROW 50004, 'El producto -999 existe; elegir otro inexistente.', 1;
    INSERT INTO FACTURA (id_factura, fecha_factura, id_cliente, id_metodopago)
    VALUES (9002, GETDATE(), 1, 1);
    INSERT INTO DETALLE_FACTURA
        (id_detalle_factura, id_factura, cantidad, precio_unitariofactura, id_producto)
    VALUES (90021, 9002, 1, 15000.00, -999);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    PRINT 'Se produjo un error durante la venta.';
    PRINT 'Los cambios fueron cancelados con ROLLBACK.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO
SELECT * FROM FACTURA WHERE id_factura = 9002;
SELECT * FROM DETALLE_FACTURA WHERE id_factura = 9002;
GO
