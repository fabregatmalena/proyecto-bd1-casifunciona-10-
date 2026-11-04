# Etapa III: Implementación Física y Pruebas de Validación

* **Base de Datos:** `NegocioIndumentariaDtf`
* **Motor:** Microsoft SQL Server
* **Alcance:** Documentación técnica de scripts DDL, DML y validación de integridad.

---

## 1. Implementación del Esquema Físico (DDL)

El esquema físico se implementó en SQL Server mediante 15 tablas vinculadas, organizadas en cuatro módulos funcionales:

* **Geografía y Clientes:** `PROVINCIA`, `CIUDAD`, `CLIENTE` y `METODO_PAGO`.
* **Catálogo y Producción:** `PRODUCTO` (superclase), `DISENO`, `PRENDA` y `ESTAMPA` (subtipos).
* **Proveedores e Insumos:** `PROVEEDOR`, `INSUMO`, `COMPRA` y `DETALLE_COMPRA`.
* **Elaboración y Ventas:** `PRODUCTO_INSUMO` (relación $N:M$), `FACTURA` y `DETALLE_FACTURA`.

### Decisiones de Tipado y Restricciones Técnicas

* **Tipos de Datos:** Claves y cantidades enteras (`INT`); textos con longitud controlada (`VARCHAR`); fechas (`DATE`); e importes monetarios exactos (`DECIMAL(10,2)` y `DECIMAL(12,2)`) para evitar pérdidas de precisión por redondeo.
* **Integridad Referencial:** 
  * Se configuró `ON DELETE NO ACTION` en tablas maestras para proteger el histórico transaccional (clientes, productos, proveedores).
  * Se habilitó `ON DELETE CASCADE` únicamente en detalles dependientes (`COMPRA` $\rightarrow$ `DETALLE_COMPRA` y `FACTURA` $\rightarrow$ `DETALLE_FACTURA`).
* **Unicidad (`UNIQUE`):** Restricción de duplicados en DNI y correos electrónicos, nombres de provincia, pares `(nombre_ciudad, id_provincia)` y renglones de detalle `(id_factura, id_producto)`.
* **Reglas de Dominio (`CHECK` y `DEFAULT`):** Precios, tarifas y totales con valor $\ge 0$; cantidades estrictamente $> 0$; stock inicial con `DEFAULT 0`. En `DISENO`, se obliga a registrar ancho y alto conjuntamente (ambos mayores a cero o ambos nulos).

---

## 2. Poblado Inicial de la Base de Datos (DML)

Para asegurar pruebas representativas, se cargaron **10 registros coherentes por tabla** siguiendo un orden estricto de precedencia para respetar las claves foráneas:

1. **Maestros independientes:** `PROVINCIA`, `METODO_PAGO`, `PRODUCTO`, `DISENO`, `PROVEEDOR`.
2. **Entidades con dependencia simple:** `CIUDAD`, `INSUMO`, `PRENDA`, `ESTAMPA`.
3. **Entidades compuestas y operativas:** `CLIENTE`, `COMPRA`, `PRODUCTO_INSUMO`.
4. **Cabeceras transaccionales:** `FACTURA`.
5. **Líneas de detalle:** `DETALLE_COMPRA`, `DETALLE_FACTURA`.

El set de datos contempla el flujo real del taller: abastecimiento de materia prima (tintas DTF, telas, films), catálogo variado de indumentaria y ventas registradas con distintos métodos de pago.

---

## 3. Pruebas de Validación y Consultas

La validación del modelo físico se realizó sobre dos ejes:

### 3.1. Pruebas de Restricción e Integridad (Comportamiento Defensivo)
* **Rechazo de Duplicados:** Intentos de registrar correos o DNI repetidos fueron bloqueados por la restricción `UNIQUE`.
* **Bloqueo de Rangos Negativos:** Inserciones con precios o existencias menores a cero fueron canceladas por validación `CHECK`.
* **Consistencia Referencial:** El motor impidió registrar ventas o compras asociadas a clientes, insumos o productos inexistentes, así como borrar clientes con comprobantes emitidos.

### 3.2. Consultas de Verificación Operativa
* **Auditoría de Comprobantes:** Mediante uniones (`INNER JOIN`) y funciones de ventana (`SUM(...) OVER(PARTITION BY...)`), se contrastó renglón por renglón que la columna calculada coincida con el total acumulado de cada factura.
* **Consolidación por Período:** Se ejecutaron reportes de ventas mensuales agrupando por producto para auditar cantidades despachadas e ingresos totales.
* **Segmentación de Clientes:** Consultas agregadas con cláusulas `GROUP BY` y `HAVING` para identificar clientes con facturación acumulada superior a determinados umbrales de compra.

---

## 4. Conclusión

La implementación física en SQL Server traduce fielmente las 31 reglas de negocio del dominio. La combinación de claves primarias, foráneas, restricciones de dominio y columnas calculadas proporciona una base sólida, íntegra y preparada para la incorporación de lógica procedimental (vistas, triggers y procedimientos almacenados).
