 # Modelo Relacional 

## Esquema de Relaciones 


* **PROVINCIA** (id_provincia, nombre_provincia)
  * **PK:** id_provincia

  <br>

* **CIUDAD** (id_ciudad, nombre_ciudad, id_provincia)
  * **PK:** id_ciudad
  * **FK:** id_provincia
  **PROVINCIA** (id_provincia)

  <br>

* **CLIENTE** (id_cliente, nombre_cliente, apellido_cliente, dni_cliente, telefono_cliente, correo_cliente, codigo_postal, direccion, id_ciudad)
  * **PK:** id_cliente
  * **FK:** id_ciudad
   **CIUDAD** (id_ciudad)
   * **UNIQUE**(correo_cliente)

   <br> 

* **METODO_PAGO** (id_metodo_pago, descripcion)
  * **PK:** id_metodo_pago

<br>

* **FACTURA** (id_factura, fecha_factura, id_cliente, id_metodo_pago)
  * **PK:** id_factura
  * **FK:** id_cliente 
  **CLIENTE** (id_cliente)
  * **FK:** id_metodo_pago 
  **METODO_PAGO** (id_metodo_pago)

<br>

* **PRODUCTO** (id_producto, nombre_producto, precio_producto)
  * **PK:** id_producto

<br>

* **DETALLE_FACTURA** (id_detalle_factura, id_factura, id_producto, cantidad, precio_unitario_factura)
  * **PK:** id_detalle_factura, id_factura (Clave Compuesta)
  * **FK:** id_factura
   **FACTURA** (id_factura)
  * **FK:** id_producto
  **PRODUCTO** (id_producto)

  <br>

* **PROVEEDOR** (id_proveedor, nombre_proveedo, telefono_proveedor, correo_proveedor)
  * **PK:** id_proveedor
  * **UNIQUE** (correo_proveedor)
* **COMPRA** (id_compra, fecha_compra, id_proveedor)
  * **PK:** id_compra
  * **FK:** id_proveedor 
  **PROVEEDOR** (id_proveedor)

  <br>

* **INSUMO** (id_insumo, tipo_insumo, id_proveedor)
  * **PK:** id_insumo
  * **FK** id_proveedor

<br>

* **DETALLE_COMPRA** (id_detalle_compr, id_compra, id_insumo, cantidad, precio_unitario_compra)
  * **PK:** id_detalle_compra
  * **FK:** id_compra 
   **COMPRA** (id_compra)
  * **FK:** id_insumo 
   **INSUMO** (id_insumo)

   <br>

* **PRODUCTO_INSUMO** (id_insumo, id_producto)
  * **PK:** id_insumo, id_producto (Clave Compuesta)
  * **FK:** id_insumo 
   **INSUMO** (id_insumo)
  * **FK:** id_producto 
   **PRODUCTO** (id_producto)

<br>

* **DISENO** (id_diseño, logotipo, ancho, alto, tarifa_base)
  * **PK:** id_diseño

<br>

* **PRENDA** (id_prend, id_producto, color, tipo_de_tela, talle, id_diseño)
  * **PK:** id_prenda, id_producto
  * **FK:** id_producto 
   **PRODUCTO** (id_producto)
  * **FK:** id_diseño 
   **DISENO** (id_diseño)

<br>

* **ESTAMPA** (id_estampa, id_producto, id_diseño)
  * **PK:** id_estamp, id_producto
  * **FK:** id_producto 
   **PRODUCTO** (id_producto)
  * **FK:** id_diseño 
   **DISENO** (id_diseño)


<br><br>

## Tablas Detalladas
<br>

### CLIENTE


| Columna          |    Tipo      | Restricciones |           Descripcion           | 
| :--- | :---: | :---: | :--- |
| id_cliente       |     INT      |     **PK**    | Identificador unico del cliente |
| nombre_cliente   | VARCHAR(50)  |       -       |       Nombre del cliente        |
| apellido_cliente | VARCHAR(50)  |       -       |      Apellido del cliente       |
| dni_cliente      | VARCHAR(20)  |       -       |     Documento de identidad      |
| telefono_cliente | VARCHAR(25)  |       -       |      Telefono de contacto       |
| correo_cliente   | VARCHAR(100) |   **UNIQUE**  |       Correo electronico        |
| direccion        | VARCHAR(100) |       -       |        Direccion fisica         |
| codigo_posta     | VARCHAR(10)  |       -       |         Codigo postal           |
| id_ciudad        |     INT      |     **FK**    |     Referencia a la ciudad      |

<br>

#### FACTURA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_factura | INT | **PK** | Identificador de la factura |
| fecha_factura | DATE | - | Fecha de emision |
| id_cliente | INT | **FK** | Cliente que realiza la compra |
| id_metodo_pago| INT | **FK** | Metodo de pago utilizado |

<br>

### PRODUCTO
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_producto | INT | **PK** | Identificador del producto |
| nombre_producto | VARCHAR(50) | - | Nombre del producto |
| precio_producto | DECIMAL(10,2) | - | Precio base |

<br>

### DETALLE_FACTURA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_detalle_factura | INT | **PK** | Identificador del detalle |
| id_factura | INT | **PK**, **FK** | Relacion con la factura |
| id_producto | INT | **FK** | Producto adquirido |
| cantidad | INT | - | Cantidad de unidades |
| precio_unitario_factura| DECIMAL(10,2) | - | Precio unitario al facturar |

<br>

### PROVEEDOR
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_proveedor | INT | **PK** | Identificador del proveedor |
| nombre_proveedor| VARCHAR(60) | - | Razon social o nombre |
| telefono_proveedor | VARCHAR(25) | - | Telefono de contacto |
| correo_proveedor | VARCHAR(100) | **UNIQUE** | Correo electronico |

<br>

### COMPRA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_compra | INT | **PK** | Identificador de la compra a proveedor |
| fecha_compra| DATE | - | Fecha en que se realizo |
| id_proveedor | INT | **FK** | Proveedor de los insumos |

<br>

### INSUMO
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_insumo | INT | **PK** | Identificador del insumo |
| tipo_insumo | VARCHAR(50) | - | Descripcion o tipo de insumo |

<br>

### DETALLE_COMPRA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_detalle_compra | INT | **PK** | Identificador del detalle |
| id_compra | INT | **FK** | Relacion con la compra |
| id_insumo | INT | **FK** | Insumo comprado |
| cantidad | INT | - | Cantidad comprada |
| precio_unitario_compra | DECIMAL(10,2) | - | Costo unitario |

<br>

### PRODUCTO_INSUMO
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_insumo | INT | **PK**, **FK** | Insumo utilizado |
| id_producto | INT | **PK**, **FK** | Producto que requiere el insumo |

<br>

### DISENO
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_diseño | INT | **PK** | Identificador del diseño |
| logotipo | VARCHAR(100) | - | Detalle o ruta del archivo gráfico |
| ancho | DECIMAL(5,2) | - | Medida de ancho |
| alto | DECIMAL(5,2) | - | Medida de alto |
| tarifa_base | DECIMAL(10,2) | - | Costo base del diseño |

<br>

### PRENDA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_prenda | INT | **PK** | Identificador de la prenda |
| id_producto | INT | **PK**, **FK** | Producto base asociado |
| talle | VARCHAR(10) | - | Talle (ej. S, M, L, XL) |
| tipo_de_tela| VARCHAR(40) | - | Material o tela |
| color| VARCHAR(30) | - | Color de la prenda |
| id_diseño | INT | **FK** | Diseño aplicado |

<br>

### ESTAMPA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_estampa | INT | **PK** | Identificador de la estampa |
| id_producto | INT | **PK**, **FK** | Producto asociado |
| id_diseño | INT | **FK** | Diseño de la estampa |

<br>

### CIUDAD
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_ciudad | INT | **PK** | Identificador de la ciudad |
| nombre_ciudad | VARCHAR(50) | - | Nombre de la localidad |
| id_provincia | INT | **FK** | Provincia a la que pertenece |

<br>

### PROVINCIA
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_provincia | INT | **PK** | Identificador de la provincia |
| nombre_provincia | VARCHAR(50) | - | Nombre de la provincia |

<br>

### METODO_PAGO
| Columna | Tipo | Restricciones | Descripcion |
| :--- | :---: | :---: | :--- |
| id_metodo_pago| INT | **PK** | Identificador del metodo de pago |
| descripcion| VARCHAR(50) | - | Descripcion (ej. Efectivo, Tarjeta, Transferencia) |