# Verificación de Restricciones e Integridad de Datos

- **Base de Datos:** `NegocioIndumentariaDtf`
- **Motor:** Microsoft SQL Server
- **Lenguaje:** T-SQL

---

## 1. Introducción

Durante la implementación física de la base de datos **NegocioIndumentariaDtf** se definieron distintas restricciones con el objetivo de mantener la consistencia y validez de los datos almacenados. Las restricciones implementadas permiten controlar principalmente la integridad de entidad, la integridad referencial, la integridad de dominio y determinadas reglas de negocio.

Para ello se utilizaron claves primarias (`PRIMARY KEY`), claves foráneas (`FOREIGN KEY`), restricciones `UNIQUE`, `NOT NULL`, `CHECK`, valores `DEFAULT` y una columna calculada en `DETALLE_FACTURA`.

---

## 2. Integridad de Entidad

La integridad de entidad permite identificar de manera única cada registro almacenado en las tablas. Para implementarla se utilizaron claves primarias.

### Claves primarias simples
Las tablas `PROVINCIA`, `CIUDAD`, `CLIENTE`, `METODO_PAGO`, `PRODUCTO`, `DISENO`, `PRENDA`, `ESTAMPA`, `PROVEEDOR`, `INSUMO`, `COMPRA` y `FACTURA` poseen claves primarias simples. Por ejemplo:

- `PROVINCIA`: `id_provincia`
- `CLIENTE`: `id_cliente`
- `PRODUCTO`: `id_producto`
- `PRENDA`: `id_prenda`
- `ESTAMPA`: `id_estampa`
- `PROVEEDOR`: `id_proveedor`
- `INSUMO`: `id_insumo`
- `FACTURA`: `id_factura`

Estas claves se definieron como `INT NOT NULL` y `PRIMARY KEY`, evitando identificadores duplicados o nulos.

### Claves primarias compuestas
También existen claves primarias compuestas:
- En `DETALLE_COMPRA`, la clave primaria está formada por: `(id_detalle_compra, id_compra)`
- En `DETALLE_FACTURA`, la clave primaria está formada por: `(id_detalle_factura, id_factura)`
- En `PRODUCTO_INSUMO`, utiliza: `(id_producto, id_insumo)`

Esta última clave compuesta permite implementar la relación muchos a muchos ($N:M$) entre productos e insumos e impide repetir exactamente la misma combinación de producto e insumo.

---

## 3. Restricciones de Unicidad

Además de las claves primarias, se utilizaron restricciones `UNIQUE` para atributos o combinaciones de atributos que no deben repetirse:

- **PROVINCIA:** `nombre_provincia` es único, evitando registrar dos veces la misma provincia.
- **CIUDAD:** La combinación `(nombre_ciudad, id_provincia)` es única. De esta forma, no puede registrarse dos veces una ciudad con el mismo nombre dentro de una misma provincia.
- **CLIENTE:** Tanto `dni_cliente` como `correo_cliente` son únicos. Esto evita registrar distintos clientes utilizando el mismo DNI o el mismo correo electrónico.
- **PROVEEDOR:** `correo_proveedor` también es único.
- **METODO_PAGO:** La `descripcion` es única, evitando registrar varias veces el mismo método de pago.
- **DETALLE_COMPRA:** La combinación `(id_compra, id_insumo)` es única. Esto evita que el mismo insumo aparezca repetido en diferentes líneas de una misma compra. Si se adquieren varias unidades del mismo insumo, deben registrarse mediante el atributo `cantidad`.
- **DETALLE_FACTURA:** De forma similar, la combinación `(id_factura, id_producto)` es única, evitando repetir el mismo producto en varias líneas de una misma factura.
- **PRENDA:** Se definió `id_producto` como único. Por lo tanto, un producto determinado puede aparecer como máximo una vez dentro de la tabla `PRENDA`.
- **ESTAMPA:** También se definió `id_producto` como único, por lo que un producto puede aparecer como máximo una vez dentro de `ESTAMPA`.

> **Nota:** Estas dos últimas restricciones no impiden que un mismo producto aparezca una vez en `PRENDA` y también una vez en `ESTAMPA`. Esto es coherente con la **RN.09**, que establece que un producto puede corresponder a una prenda, a una estampa o a ambas.

---

## 4. Integridad Referencial

La integridad referencial se implementó mediante claves foráneas (`FOREIGN KEY`). Su finalidad es evitar referencias hacia registros que no existen:

- Cada ciudad debe pertenecer a una provincia existente (`CIUDAD.id_provincia` referencia a `PROVINCIA.id_provincia`).
- Cada cliente debe estar asociado a una ciudad existente mediante `CLIENTE.id_ciudad`.
- Cada factura debe pertenecer a un cliente y utilizar un método de pago existente (`FACTURA` contiene las claves foráneas `id_cliente` e `id_metodopago`).
- Las prendas y estampas deben estar asociadas a productos existentes y pueden relacionarse con diseños mediante las correspondientes claves foráneas.
- Las compras se relacionan con proveedores mediante `COMPRA.id_proveedor`.
- Los detalles de compra relacionan una compra con los insumos adquiridos.
- Los detalles de factura relacionan cada factura con los productos vendidos.
- `PRODUCTO_INSUMO` relaciona productos e insumos, permitiendo representar la relación $N:M$ establecida por las reglas de negocio.

---

## 5. Políticas de Eliminación y Actualización

En la mayoría de las claves foráneas se utilizaron:
- `ON DELETE NO ACTION`
- `ON UPDATE NO ACTION`

Esto evita eliminar o modificar un registro padre cuando existen otros registros que dependen de él. Por ejemplo, SQL Server no permitirá eliminar un cliente que todavía tenga facturas asociadas, ni eliminar un producto que se encuentre referenciado por otras tablas, preservando la integridad y el historial de los datos.

### Casos en Cascada
- En `DETALLE_COMPRA` se utilizó `ON DELETE CASCADE` respecto de `COMPRA`. Si se elimina una compra, sus detalles asociados también son eliminados automáticamente.
- De manera similar, `DETALLE_FACTURA` utiliza `ON DELETE CASCADE` respecto de `FACTURA`. Si se elimina una factura, se eliminan sus detalles correspondientes.

Esto evita que queden detalles huérfanos sin su registro principal.

---

## 6. Integridad de Dominio

La integridad de dominio permite controlar qué valores pueden almacenarse en cada atributo. Para ello se utilizaron tipos de datos apropiados, restricciones `NOT NULL`, `CHECK` y valores `DEFAULT`:

- **Identificadores y cantidades:** Utilizan principalmente `INT`.
- **Textos:** Utilizan `VARCHAR` con longitudes adaptadas según el dato.
- **Fechas:** `DATE` para compras y facturación.
- **Valores monetarios:** Utilizan `DECIMAL` (evitando tipos aproximados como `FLOAT`). Precios y tarifas utilizan `DECIMAL(10,2)`, mientras que el importe total y el precio parcial emplean `DECIMAL(12,2)`.
- **Medidas:** `ancho` y `alto` de los diseños utilizan `DECIMAL(6,2)`, admitiendo valores con dos posiciones decimales.

---

## 7. Restricciones NOT NULL

Los atributos obligatorios fueron definidos mediante `NOT NULL`:

- **CLIENTE:** Obligatorio nombre, apellido, DNI, teléfono, correo, dirección y ciudad.
- **PRODUCTO:** Obligatorio nombre, precio y stock.
- **PROVEEDOR:** Obligatorio nombre, correo y teléfono.
- **COMPRA:** Obligatorio fecha y proveedor.
- **FACTURA:** Obligatorio fecha, descripción, cliente, método de pago e importe total.

Esto evita que se almacenen registros incompletos en atributos esenciales para el modelo.

---

## 8. Valores DEFAULT

Se utilizaron valores predeterminados para inicializar ciertos atributos:

- En `PRODUCTO`: `stock_producto` posee `DEFAULT 0`.
- En `INSUMO`: `stock_insumo` posee `DEFAULT 0`.
- En `FACTURA`: `importe_total` posee `DEFAULT 0`.

> **Nota:** El `DEFAULT` solamente proporciona un valor inicial cuando no se especifica uno; no realiza por sí mismo el cálculo posterior del total acumulado.

---

## 9. Restricciones CHECK

Se emplearon restricciones `CHECK` para controlar valores numéricos y evitar datos inválidos:

- **PRODUCTO:** `precio_producto >= 0` y `stock_producto >= 0`. No se permiten precios ni existencias negativas.
- **INSUMO:** `stock_insumo >= 0`.
- **DISENO:** `tarifa_base >= 0`.
- **FACTURA:** `importe_total >= 0`.
- **DETALLE_COMPRA:** `cantidad > 0` (estrictamente positiva) y precio unitario $\ge 0$.
- **DETALLE_FACTURA:** `cantidad > 0` y precio unitario $\ge 0$.
- **PRODUCTO_INSUMO:** `cantidad_requerida > 0`.

SQL Server rechaza automáticamente cualquier inserción o actualización que no respete estas condiciones.

---

## 10. Validación de las Medidas del Diseño

La tabla `DISENO` posee controles adicionales sobre los atributos `ancho` y `alto`:

1. El ancho, cuando se registre, debe ser mayor que cero:  
   `ancho IS NULL OR ancho > 0`
2. El alto, cuando se registre, debe ser mayor que cero:  
   `alto IS NULL OR alto > 0`
3. Ambas medidas deben ingresarse conjuntamente: se permite que ambas sean nulas o que ambas tengan valor; **no se permite registrar solo una de ellas**.

Esto evita almacenar un diseño con ancho definido pero sin altura, cumpliendo con las reglas **RN.12** y **RN.14**.

---

## 11. Cálculo del Precio Parcial

La **RN.06** establece que el precio parcial de un detalle de factura se obtiene multiplicando la cantidad por el precio unitario. Esta regla fue implementada directamente en `DETALLE_FACTURA` mediante una **columna calculada**:

```sql
precio_parcial AS (
    CONVERT(
        DECIMAL(12,2),
        cantidad * precio_unitario
    )
) PERSISTED
```

- El usuario no necesita ingresar manualmente el precio parcial (ej. $2 \times \$15.000 = \$30.000$).
- Evita inconsistencias aritméticas entre cantidad, precio unitario y subtotal.
- La opción `PERSISTED` indica que SQL Server almacena físicamente el resultado y lo actualiza automáticamente ante cualquier cambio de los factores.

---

## 12. Reglas que Requieren Implementación Adicional

No todas las reglas de negocio pueden garantizarse únicamente mediante el DDL actual:

- **RN.07 (Importe total de factura):** Establece que el total debe ser la suma de los subtotales de sus detalles. Si bien `FACTURA.importe_total` tiene un `CHECK (>= 0)` y `DEFAULT 0`, no se recalcula solo por DDL. Se requerirá un *trigger* o procedimiento almacenado.
- **RN.18 y RN.26 (Movimientos de stock de insumos):** El consumo y la compra deben descontar e incrementar respectivamente el stock. El DDL actual asegura que no sea negativo (`CK_INSUMO_STOCK`), pero el movimiento automático requiere lógica procedimental (*triggers* o *stored procedures*).

Distinguir esto es clave para separar las reglas estructurales de las reglas operativas avanzadas.

---

## 13. Verificación de las Restricciones

Una vez creada la estructura y cargados los datos de prueba (DML), las restricciones se verifican ejecutando operaciones intencionalmente inválidas que el SGBD debe rechazar:

- Intentar registrar dos provincias con el mismo nombre.
- Intentar registrar dos clientes con el mismo DNI o correo.
- Intentar registrar un producto con precio negativo o stock negativo.
- Intentar registrar una cantidad igual o menor a cero en un detalle.
- Intentar registrar una ciudad en una provincia inexistente.
- Intentar registrar una prenda o estampa con referencias inexistentes.
- Intentar registrar una factura para un cliente inexistente.
- Intentar repetir un mismo producto dentro de una misma factura.
- Intentar eliminar un registro padre que esté referenciado con `NO ACTION`.

Complementariamente, se ejecutan consultas `SELECT` para confirmar que los datos válidos se guarden y relacionen correctamente.

---

## 14. Conclusión

La implementación física de **NegocioIndumentariaDtf** mantiene la consistencia de los datos mediante los mecanismos nativos de SQL Server:
- **Claves primarias y foráneas** aseguran la identidad y las relaciones.
- **Restricciones `UNIQUE`, `NOT NULL`, `CHECK` y `DEFAULT`** resguardan la validez y unicidad del dominio.
- La **columna calculada persistida** resuelve de manera desacoplada la **RN.06**.
- Se dejan identificadas con precisión las reglas transaccionales que requerirán automatización adicional por procedimientos o disparadores en etapas posteriores.
