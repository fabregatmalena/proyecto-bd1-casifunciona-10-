USE NegocioIndumentariaDtf;
GO





/* 1. PROVINCIA */

INSERT INTO PROVINCIA(id_provincia, nombre_provincia)
VALUES
    (1, 'Corrientes'),
    (2, 'Chaco'),
    (3, 'Misiones'),
    (4, 'Formosa'),
    (5, 'Santa Fe'),
    (6, 'Entre Rios'),
    (7, 'Cordoba'),
    (8, 'Buenos Aires'),
    (9, 'Salta'),
    (10, 'Jujuy');
GO


/* 
   2. CIUDAD */

INSERT INTO CIUDAD(id_ciudad, nombre_ciudad, id_provincia)
VALUES
    (1, 'Corrientes Capital', 1),
    (2, 'Resistencia', 2),
    (3, 'Posadas', 3),
    (4, 'Formosa Capital', 4),
    (5, 'Santa Fe Capital', 5),
    (6, 'Parana', 6),
    (7, 'Cordoba Capital', 7),
    (8, 'La Plata', 8),
    (9, 'Salta Capital', 9),
    (10, 'San Salvador de Jujuy', 10);
GO


/* 3. CLIENTE */

INSERT INTO CLIENTE(id_cliente, nombre_cliente, apellido_cliente, dni_cliente, telefono_cliente, correo_cliente,
    codigo_postal,direccion,id_ciudad)
VALUES
    (1, 'Lucia', 'Gomez', '40111222', '3794000001',
     'lucia.gomez@gmail.com', '3400', 'San Martin 120', 1),

    (2, 'Mateo', 'Fernandez', '41222333', '3624000002',
     'mateo.fernandez@gmail.com', '3500', 'Belgrano 245', 2),

    (3, 'Sofia', 'Martinez', '42333444', '3764000003',
     'sofia.martinez@gmail.com', '3300', 'Colon 330', 3),

    (4, 'Tomas', 'Ramirez', '43444555', '3704000004',
     'tomas.ramirez@gmail.com', '3600', 'Mitre 415', 4),

    (5, 'Valentina', 'Lopez', '44555666', '3424000005',
     'valentina.lopez@gmail.com', '3000', 'Rivadavia 520', 5),

    (6, 'Joaquin', 'Sosa', '45666777', '3434000006',
     'joaquin.sosa@gmail.com', '3100', 'Urquiza 610', 6),

    (7, 'Camila', 'Romero', '46777888', '3514000007',
     'camila.romero@gmail.com', '5000', 'Independencia 720', 7),

    (8, 'Benjamin', 'Acosta', '47888999', '2214000008',
     'benjamin.acosta@gmail.com', '1900', 'Calle 7 830', 8),

    (9, 'Martina', 'Ruiz', '48999000', '3874000009',
     'martina.ruiz@gmail.com', '4400', 'España 940', 9),

    (10, 'Thiago', 'Diaz', '39000111', '3884000010',
     'thiago.diaz@gmail.com', '4600', 'Lavalle 1050', 10);
GO


/*  4. METODO_PAGO */

INSERT INTO METODO_PAGO (id_metodopago, descripcion)
VALUES
    (1, 'Efectivo'),
    (2, 'Transferencia'),
    (3, 'Tarjeta de debito'),
    (4, 'Tarjeta de credito'),
    (5, 'Tarjeta de credito'),
    (6, 'Efectivo'),
    (7, 'Tarjeta de debito'),
    (8, 'Transferencia'),
    (9, 'Transferencia '),
    (10, 'Tarjeta de debito');
GO


/* 5. PRODUCTO */

INSERT INTO PRODUCTO (id_producto, nombre_producto, precio_producto, stock_producto)
VALUES
    (1, 'Remera' 15000.00, 20),
    (2, 'Buzo perzonalizado', 28000.00, 15),
    (3, 'Remera', 18000.00, 12),
    (4, 'Remera personalizada', 12000.00, 18),
    (5, 'Remera personaliza', 35000.00, 10),
    (6, 'Estampa estrella', 19000.00, 14),
    (7, 'Estampa corazon', 30000.00, 11),
    (8, 'Remera personalizada', 22000.00, 16),
    (9, 'Remera ', 17000.00, 20),
    (10, 'Remera personalizada', 20000.00, 13);
GO


/*6. DISENO*/

INSERT INTO DISENO (id_diseno, color, logotipo, tarifa_base, ancho, alto)
VALUES
    (1, 'Negro', 'Logo empresa', 2000.00, 10.00, 10.00),
    (2, 'Blanco', 'Frase personalizada', 2500.00, 20.00, 15.00),
    (3, 'Rojo', 'Escudo deportivo', 3000.00, 15.00, 18.00),
    (4, 'Azul', 'Logo emprendimiento', 2200.00, 12.00, 12.00),
    (5, 'Verde', 'Diseno naturaleza', 2800.00, 20.00, 20.00),
    (6, 'Negro', 'Diseno minimalista', 1800.00, 8.00, 8.00),
    (7, 'Blanco', 'Logo grande', 3200.00, 25.00, 20.00),
    (8, 'Multicolor', 'Diseno personalizado', 3500.00, 20.00, 25.00),
    (9, 'Azul', 'Diseno deportivo', 2800.00, 18.00, 20.00),
    (10, 'Rojo', 'Nombre y numero', 2500.00, 20.00, 25.00);
GO


/*7. PRENDA*/

INSERT INTO PRENDA(id_prenda, id_producto, id_diseno, tipo_de_tela, talle, color)
VALUES
    (1, 1, 1, 'Algodon', 'S', 'Blanco'),
    (2, 2, 2, 'Frisa', 'M', 'Negro'),
    (3, 3, 3, 'Poliester', 'L', 'Azul'),
    (4, 4, 4, 'Algodon', 'M', 'Rojo'),
    (5, 5, 5, 'Frisa', 'XL', 'Negro'),
    (6, 6, 6, 'Algodon', 'L', 'Blanco'),
    (7, 7, 7, 'Frisa', 'S', 'Gris'),
    (8, 8, 8, 'Pique', 'M', 'Azul'),
    (9, 9, 9, 'Poliester', 'L', 'Negro'),
    (10, 10, 10, 'Algodon', 'XL', 'Rojo');
GO


/* 8. ESTAMPA*/

INSERT INTO ESTAMPA (id_estampa, id_producto, id_diseno)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);
GO


/*9. PROVEEDOR */

INSERT INTO PROVEEDOR (id_proveedor, nombre_proveedor, correo_proveedor, telefono_proveedor)
VALUES
    (1, 'Textil Norte', 'ventas@textilnorte.com', '3794100001'),
    (2, 'Insumos DTF', 'ventas@insumosdtf.com', '3794100002'),
    (3, 'Grafica NEA', 'contacto@graficanea.com', '3794100003'),
    (4, 'Textiles del Litoral', 'ventas@textileslitoral.com', '3794100004'),
    (5, 'Distribuidora Print', 'info@distribuidoraprint.com', '3794100005'),
    (6, 'Estampa Insumos', 'ventas@estampainsumos.com', '3794100006'),
    (7, 'Mundo Textil', 'contacto@mundotextil.com', '3794100007'),
    (8, 'Print Color', 'ventas@printcolor.com', '3794100008'),
    (9, 'Insumos Creativos', 'info@insumoscreativos.com', '3794100009'),
    (10, 'Grafica Total', 'ventas@graficatotal.com', '3794100010');
GO


/*10. INSUMO */

INSERT INTO INSUMO (id_insumo, tipo_insumo, stock_insumo)
VALUES
    (1, 'Tinta DTF negra', 50),
    (2, 'Tinta DTF blanca', 50),
    (3, 'Film DTF', 80),
    (4, 'Polvo DTF', 60),
    (5, 'Tela de algodon', 100),
    (6, 'Tela de poliester', 70),
    (7, 'Vinilo textil', 40),
    (8, 'Papel transfer', 75),
    (9, 'Tinta para dtf', 45),
    (10, 'Tela pique', 90);
GO


/* 11. PRODUCTO_INSUMO*/

INSERT INTO PRODUCTO_INSUMO (id_producto, id_insumo, cantidad_requerida)
VALUES
    (1, 5, 1),
    (1, 1, 1),
    (2, 4, 1),
    (3, 6, 1),
    (4, 5, 1),
    (5, 7, 2),
    (6, 3, 1),
    (7, 2, 2),
    (8, 10, 1),
    (9, 9, 1);
GO


/* 12. COMPRA*/

INSERT INTO COMPRA (id_compra, fecha_compra, id_proveedor)
VALUES
    (1, '2026-09-01', 1),
    (2, '2026-09-02', 2),
    (3, '2026-09-03', 3),
    (4, '2026-09-04', 4),
    (5, '2026-09-05', 5),
    (6, '2026-09-06', 6),
    (7, '2026-09-07', 7),
    (8, '2026-09-08', 8),
    (9, '2026-09-09', 9),
    (10, '2026-09-10', 10);
GO


/* 13. DETALLE_COMPRA*/

INSERT INTO DETALLE_COMPRA (id_detalle_compra, id_compra, id_insumo, cantidad, precio_unitario_compra)
VALUES
    (1, 1, 5, 100, 4500.00),
    (2, 2, 1, 50, 6000.00),
    (3, 3, 3, 80, 3500.00),
    (4, 4, 6, 70, 5000.00),
    (5, 5, 4, 60, 4000.00),
    (6, 6, 7, 40, 5500.00),
    (7, 7, 2, 50, 6500.00),
    (8, 8, 9, 45, 7000.00),
    (9, 9, 8, 75, 3000.00),
    (10, 10, 10, 90, 4800.00);
GO


/* 14. FACTURA */

INSERT INTO FACTURA( id_factura,  fecha_factura,  descripcion,  id_cliente, id_metodopago, importe_total)
VALUES
    (1, '2026-09-11', 'Venta de Remera', 1, 1, 30000.00),
    (2, '2026-09-12', 'Venta de Buzo perzonalizado', 2, 2, 28000.00),
    (3, '2026-09-13', 'Venta de Remera', 3, 3, 54000.00),
    (4, '2026-09-14', 'Venta de Remera personalizada ', 4, 4, 24000.00),
    (5, '2026-09-15', 'Venta de Remera personalizada', 5, 5, 35000.00),
    (6, '2026-09-16', 'Venta de Estampa estrella', 6, 6, 38000.00),
    (7, '2026-09-17', 'Venta de Estampa corazon', 7, 7, 30000.00),
    (8, '2026-09-18', 'Venta de Remera personalizada', 8, 8, 44000.00),
    (9, '2026-09-19', 'Venta de Remera', 9, 9, 51000.00),
    (10, '2026-09-20', 'Venta de Remera personalizada', 10, 10, 20000.00);
GO


/* 15. DETALLE_FACTURA */

INSERT INTO DETALLE_FACTURA(id_detalle_factura, id_factura, id_producto, cantidad, precio_unitario)
VALUES
    (1, 1, 1, 2, 15000.00),
    (2, 2, 2, 1, 28000.00),
    (3, 3, 3, 3, 18000.00),
    (4, 4, 4, 2, 12000.00),
    (5, 5, 5, 1, 35000.00),
    (6, 6, 6, 2, 19000.00),
    (7, 7, 7, 1, 30000.00),
    (8, 8, 8, 2, 22000.00),
    (9, 9, 9, 3, 17000.00),
    (10, 10, 10, 1, 20000.00);
GO
