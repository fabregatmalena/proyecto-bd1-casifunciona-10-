# Modelo Relacional (original, sin modificar)

> Extraído tal cual del archivo `modelo-relacional__1_.erdplus`. Todos los tipos de datos están como aparecen en el diagrama original (mayormente `INT`).

## CLIENTE

| Columna | Tipo | Clave |
|---|---|---|
| id_cliente | INT | PK |
| nombre_cliente | INT | |
| apellido_cliente | INT | |
| dni_cliente | INT | |
| telefono_cliente | INT | |
| correo_cliente | INT | UNIQUE |
| codigo_postal | INT | |
| direccion | INT | |
| fk_CIUDAD (id_ciudad) | INT | FK → CIUDAD |

## PROVEEDOR

| Columna | Tipo | Clave |
|---|---|---|
| id_proveedor | INT | PK |
| telefono_proveedor | INT | |
| nombre_proveedor | INT | |
| correo_proveedor | INT | UNIQUE |

## CIUDAD

| Columna | Tipo | Clave |
|---|---|---|
| id_ciudad | INT | PK |
| nombre_ciudad | INT | |
| fk_PROVINCIA (id_provincia) | INT | FK → PROVINCIA |

## PROVINCIA

| Columna | Tipo | Clave |
|---|---|---|
| id_provincia | INT | PK |
| nombre_provincia | INT | |

## PRODUCTO

| Columna | Tipo | Clave |
|---|---|---|
| id_producto | INT | PK |
| precio_producto | INT | |
| nombre_producto | INT | |

## PRENDA

| Columna | Tipo | Clave |
|---|---|---|
| id_prenda | INT | PK |
| talle | INT | |
| tipo_de_tela | INT | |
| tipo_de_prenda | INT | |
| fk_PRODUCTO (id_producto) | INT | PK, FK → PRODUCTO |

## DISEÑO

| Columna | Tipo | Clave |
|---|---|---|
| id_diseño | INT | PK |
| logotipo | INT | |
| alto | INT | |
| ancho | INT | |
| fk_PRODUCTO (id_producto) | INT | PK, FK → PRODUCTO |

## INSUMO

| Columna | Tipo | Clave |
|---|---|---|
| id_insumo | INT | PK |
| fk_PROVEEDOR (id_proveedor) | INT | FK → PROVEEDOR |
| tipo_insumo | INT | |

## PRODUCTO_INSUMO

| Columna | Tipo | Clave |
|---|---|---|
| fk_INSUMO (id_insumo) | INT | FK → INSUMO |
| fk_PRODUCTO (id_producto) | INT | FK → PRODUCTO |

## metodo_pago

| Columna | Tipo | Clave |
|---|---|---|
| id_metodopago | INT | PK |
| descripcion | INT | |

## FACTURA

| Columna | Tipo | Clave |
|---|---|---|
| id_factura | INT | PK |
| fk_CLIENTE (id_cliente) | INT | FK → CLIENTE |
| fecha_factura | INT | |
| fk_metodo_pago (id_metodopago) | INT | FK → metodo_pago |

## detalle_factura

| Columna | Tipo | Clave |
|---|---|---|
| id_detalle_factura | INT | PK |
| fk_PRODUCTO (id_producto) | INT | FK → PRODUCTO |
| fk_COMPRA (id_factura) | INT | PK, FK → FACTURA |
| cantidad | INT | |
| precio_unitariofactura | INT | |

## COMPRA

| Columna | Tipo | Clave |
|---|---|---|
| id_compra | INT | PK |
| fecha_compra | INT | |
| fk_PROVEEDOR (id_proveedor) | INT | FK → PROVEEDOR |

## detalle_compra

| Columna | Tipo | Clave |
|---|---|---|
| id_detallecompra | INT | PK |
| fk_COMPRA (id_compra) | INT | FK → COMPRA |
| fk_INSUMO (id_insumo) | INT | FK → INSUMO |
| cantidad | INT | |
| precio_unitariocompra | INT | |
