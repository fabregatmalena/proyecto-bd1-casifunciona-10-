USE NegocioIndumentariaDtf;
GO


/* ========================================================================== */
/* UBICACIÓN, CLIENTES Y PAGOS                                             */
/* ========================================================================== */


/* PROVINCIA */

INSERT INTO PROVINCIA (nombre_provincia)
VALUES
    ('Corrientes'),
    ('Chaco'),
    ('Misiones'),
    ('Formosa'),
    ('Santa Fe'),
    ('Entre Rios'),
    ('Cordoba'),
    ('Buenos Aires'),
    ('Salta'),
    ('Jujuy');
GO


/* CIUDAD */

INSERT INTO CIUDAD (nombre_ciudad, id_provincia)
VALUES
    ('Corrientes Capital', 1),
    ('Resistencia', 2),
    ('Posadas', 3),
    ('Formosa Capital', 4),
    ('Santa Fe Capital', 5),
    ('Parana', 6),
    ('Cordoba Capital', 7),
    ('La Plata', 8),
    ('Salta Capital', 9),
    ('San Salvador de Jujuy', 10);
GO


/* CLIENTE */

INSERT INTO CLIENTE(nombre_cliente, apellido_cliente, dni_cliente, telefono_cliente, correo_cliente,
    codigo_postal,direccion,id_ciudad)
VALUES
    ('Lucia', 'Gomez', '40111222', '3794000001', 'lucia.gomez@gmail.com', '3400', 'San Martin 120', 1),

    ('Mateo', 'Fernandez', '41222333', '3624000002',  'mateo.fernandez@gmail.com', '3500', 'Belgrano 245', 2),
   
    ('Sofia', 'Martinez', '42333444', '3764000003', 'sofia.martinez@gmail.com', '3300', 'Colon 330', 3),

    ('Tomas', 'Ramirez', '43444555', '3704000004', 'tomas.ramirez@gmail.com', '3600', 'Mitre 415', 4),

    ('Valentina', 'Lopez', '44555666', '3424000005', 'valentina.lopez@gmail.com', '3000', 'Rivadavia 520', 5),

    ('Joaquin', 'Sosa', '45666777', '3434000006', 'joaquin.sosa@gmail.com', '3100', 'Urquiza 610', 6),

    ('Camila', 'Romero', '46777888', '3514000007', 'camila.romero@gmail.com', '5000', 'Independencia 720', 7),

    ('Benjamin', 'Acosta', '47888999', '2214000008', 'benjamin.acosta@gmail.com', '1900', 'Calle 7 830', 8),

    ('Martina', 'Ruiz', '48999000', '3874000009', 'martina.ruiz@gmail.com', '4400', 'España 940', 9),

    ('Thiago', 'Diaz', '39000111', '3884000010', 'thiago.diaz@gmail.com', '4600', 'Lavalle 1050', 10);
GO

/* ========================================================================== */
/* CATÁLOGO: PRODUCTOS, DISEÑOS, PRENDAS Y ESTAMPAS                        */
/* ========================================================================== */

/*  METODO_PAGO */

INSERT INTO METODO_PAGO (descripcion)
VALUES
    ('Efectivo'),
    ('Transferencia'),
    ('Tarjeta de debito'),
    ('Tarjeta de credito'),
    ('Billetera Virtual');
GO


/* PRODUCTO */

INSERT INTO PRODUCTO (nombre_producto, precio_producto, tipo_producto)
VALUES
    ('Remera Manga Corta', 15000.00, 'P'),
    ('Buzo Canguro', 28000.00, 'P'),
    ('Remera Deportiva', 18000.00, 'P'),
    ('Chomba', 22000.00, 'P'),
    ('Buzo Cuello Redondo', 25000.00, 'P'),
    ('Remera Oversize', 19000.00, 'P'),
    ('Remera Basica', 15000.00, 'P'),
    ('Buzo con Cierre', 28000.00, 'P'),
    ('Musculosa', 18000.00, 'P'),
    ('Chomba Premium', 22000.00, 'P'),
    ('Remera Cuello V', 14000.00, 'P'),
    ('Remera Manga Larga', 14000.00, 'P'),
    ('Buzo Liso', 24000.00, 'P'),
    ('Musculosa Deportiva', 17000.00, 'P'),
    ('Chomba Basica', 21000.00, 'P'),
    ('Estampa Standard', 15000.00, 'E'),
    ('Estampa Premium', 12000.00, 'E'),
    ('Estampa Full Color', 18000.00, 'E'),
    ('Estampa Basica', 14000.00, 'E'),
    ('Estampa Vinilo', 16000.00, 'E');
GO


/* DISENO */

INSERT INTO DISENO (color, logotipo, tarifa_base, ancho, alto)
VALUES
    ('Negro', 'Estrella', 3000.00, 20.00, 25.00),
    ('Blanco', 'Bandera', 2500.00, 15.00, 10.00),
    ('Multicolor', 'Escudo vintage', 3500.00, 25.00, 30.00),
    ('Azul', 'Corazon', 2000.00, 10.00, 6.00),
    ('Dorado', 'Logo empresa', 4000.00, 12.00, 15.00),
    ('Negro', 'Tipografia minimalista', 1500.00, 8.00, 8.00),
    ('Blanco', 'Calavera', 3200.00, 22.00, 28.00),
    ('Rojo', 'Numero 10', 2500.00, 18.00, 22.00),
    ('Verde', 'Hoja ecologica', 2800.00, 15.00, 15.00),
    ('Multicolor', 'Diseño abstracto', 3800.00, 25.00, 35.00),
    ('Negro', 'Nombre personalizado', 2200.00, 20.00, 12.00),
    ('Blanco', 'Logo banda de rock', 3000.00, 10.00, 10.00),
    ('Amarillo', 'Sol', 1800.00, 12.00, 12.00),
    ('Rojo', 'Fuego', 3500.00, 18.00, 24.00),
    ('Gris', 'Geometria', 2600.00, 20.00, 20.00);
GO


/* PRENDA*/

INSERT INTO PRENDA(id_producto, tipo_producto, id_diseno, tipo_de_tela, talle, color)
VALUES
   -- Prendas CON diseño
    (1, 'P', 1, 'Algodon', 'M', 'Blanca'),
    (2, 'P', 2, 'Frisa', 'L', 'Negro'),
    (3, 'P', 3, 'Poliester', 'S', 'Azul'),
    (4, 'P', 4, 'Pique', 'XL', 'Roja'),
    (5, 'P', 5, 'Frisa', 'M', 'Gris'),
    (6, 'P', 6, 'Algodon', 'XXL', 'Negra'),
    (7, 'P', 7, 'Algodon', 'L', 'Verde'),
    (8, 'P', 8, 'Frisa', 'S', 'Azul'),
    (9, 'P', 9, 'Poliester', 'M', 'Blanca'),
    (10, 'P', 10, 'Pique', 'L', 'Negra'),

    -- Prendas LISAS sin diseño 
    (11, 'P', NULL, 'Algodon', 'M', 'Negra'),
    (12, 'P', NULL, 'Algodon', 'L', 'Blanca'),
    (13, 'P', NULL, 'Frisa', 'XL', 'Gris'),
    (14, 'P', NULL, 'Poliester', 'S', 'Azul'),
    (15, 'P', NULL, 'Pique', 'XXL', 'Blanca');
GO


/*  ESTAMPA*/

INSERT INTO ESTAMPA (id_producto, tipo_producto, id_diseno)
VALUES
   (16, 'E', 11),
    (17, 'E', 12),
    (18, 'E', 13),
    (19, 'E', 14),
    (20, 'E', 15);
GO


/* PROVEEDOR */

INSERT INTO PROVEEDOR (nombre_proveedor, correo_proveedor, telefono_proveedor)
VALUES
    ('Textil Norte', 'ventas@textilnorte.com', '3794100001'),
    ('Insumos DTF', 'ventas@insumosdtf.com', '3794100002'),
    ('Grafica NEA', 'contacto@graficanea.com', '3794100003'),
    ('Textiles del Litoral', 'ventas@textileslitoral.com', '3794100004'),
    ('Distribuidora Print', 'info@distribuidoraprint.com', '3794100005'),
    ('Estampa Insumos', 'ventas@estampainsumos.com', '3794100006'),
    ('Mundo Textil', 'contacto@mundotextil.com', '3794100007'),
    ('Print Color', 'ventas@printcolor.com', '3794100008'),
    ('Insumos Creativos', 'info@insumoscreativos.com', '3794100009'),
    ('Grafica Total', 'ventas@graficatotal.com', '3794100010');
GO


/* INSUMO */

-- se omite el stock inicial porque entra por la compra

INSERT INTO INSUMO (tipo_insumo)
VALUES
    ('Tinta DTF negra'),
    ('Tinta DTF blanca'),
    ('Film DTF'),
    ('Polvo DTF'),
    ('Tela de algodon'),
    ('Tela de poliester'),
    ('Vinilo textil'),
    ('Papel transfer'),
    ('Tinta para dtf'),
    ('Tela pique');
GO


/*  PRODUCTO_INSUMO */

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

-- se omite la fecha porque tiene DEFAULT GETDATE(), se pone hoy automáticamente

INSERT INTO COMPRA (id_proveedor)
VALUES
    (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
GO


/* DETALLE_COMPRA*/

INSERT INTO DETALLE_COMPRA (id_compra, id_insumo, cantidad, precio_unitario_compra)
VALUES
    (1, 5, 100, 4500.00),
    (2, 1, 50, 6000.00),
    (3, 3, 80, 3500.00),
    (4, 6, 70, 5000.00),
    (5, 4, 60, 4000.00),
    (6, 7, 40, 5500.00),
    (7, 2, 50, 6500.00),
    (8, 9, 45, 7000.00),
    (9, 8, 75, 3000.00),
    (10, 10, 90, 4800.00);
GO


/* ========================================================================== */
/* 4. VENTAS / FACTURACIÓN                                                    */
/* ========================================================================== */

/* 14. FACTURA */

-- se omite la fecha porque tiene DEFAULT GETDATE() y el total se calcula después
INSERT INTO FACTURA(descripcion, id_cliente, id_metodopago)
VALUES
    ('Venta de Remera', 1, 1),
    ('Venta de Buzo personalizado', 2, 2),
    ('Venta de Remera', 3, 3),
    ('Venta de Remera personalizada', 4, 4),
    ('Venta de Buzo Negro', 5, 5),
    ('Venta de Estampa estrella', 6, 1),
    ('Venta de Estampa corazon', 7, 2),
    ('Venta de Estampa logo', 8, 3),
    ('Venta de Estampa', 9, 4),
    ('Venta de Estampa nombre', 10, 5);
GO


/* 15. DETALLE_FACTURA */

-- se omite precio_parcial porque es calculado/PERSISTED
INSERT INTO DETALLE_FACTURA(id_factura, id_producto, cantidad, precio_unitario)
VALUES
    (1, 1, 2, 15000.00),
    (2, 2, 1, 28000.00),
    (3, 3, 3, 18000.00),
    (4, 4, 2, 12000.00),
    (5, 5, 1, 35000.00),
    (6, 6, 2, 19000.00),
    (7, 7, 1, 30000.00),
    (8, 8, 2, 22000.00),
    (9, 9, 3, 17000.00),
    (10, 10, 1, 20000.00);
GO