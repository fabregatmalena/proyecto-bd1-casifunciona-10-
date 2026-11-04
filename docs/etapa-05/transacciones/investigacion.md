# Manejo de transacciones

**Proyecto:** NegocioIndumentariaDtf  
**Equipo:** 10 — CasiFunciona  
**Responsable:** Pared Ifran Maitena  
**Materia:** Base de Datos I — 2026

## Definición y objetivo

En esta parte del proyecto trabajamos con transacciones de SQL Server. Una transacción agrupa varias instrucciones como una sola operación: podemos confirmar todos sus cambios o cancelarlos si ocurre un error. Esto es importante para mantener la información correcta cuando trabajamos con tablas relacionadas, como `FACTURA` y `DETALLE_FACTURA`.

Las instrucciones que utilizamos son `BEGIN TRANSACTION` (inicia), `COMMIT TRANSACTION` (confirma) y `ROLLBACK TRANSACTION` (cancela). También utilizamos `TRY...CATCH` para controlar errores.

Las transacciones cumplen las propiedades ACID: **atomicidad** (todo o nada), **consistencia** (respeto de las reglas), **aislamiento** (control de operaciones simultáneas) y **durabilidad** (conservación de los cambios confirmados).

## Ventajas y aplicaciones

Nos permiten evitar ventas incompletas, proteger la integridad referencial, controlar errores y confirmar varias modificaciones juntas. También se utilizan en pagos, compras, actualización de existencias y otras operaciones sobre distintas tablas.

## Implementación en SQL Server

La estructura que usamos es:

```sql
BEGIN TRY
    BEGIN TRANSACTION;
    -- Operaciones relacionadas
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
```

## Caso aplicado a nuestro sistema de ventas

Para las demostraciones utilizamos **`NegocioEstampadosEtapa3`**, una base de práctica con tablas de facturas y detalles. **No ejecutamos estas pruebas en la base oficial `NegocioIndumentariaDtf`**; por eso, los nombres de columnas del script corresponden a la base de práctica.

Registramos una venta de ejemplo con la factura **9001**: dos remeras a $15.000 cada una ($30.000) y un buzo a $28.000, para un **total calculado de $58.000**. La factura y los detalles deben guardarse como una operación conjunta.

## Pruebas y resultados

### Prueba 1 — COMMIT

Iniciamos una transacción, insertamos la factura 9001 y dos detalles y confirmamos con `COMMIT`. Después consultamos ambas tablas y comprobamos que los registros quedaron guardados. El importe de $58.000 se calculó a partir de cantidades y precios; no se almacenó como total en la factura de práctica.

### Prueba 2 — ROLLBACK voluntario

Modificamos temporalmente la fecha de la factura 9001 a `2020-01-01` y cancelamos con `ROLLBACK`. Al consultar nuevamente la factura, conservaba su fecha original del **02/11/2026**.

### Prueba 3 — ROLLBACK por error de clave foránea

Intentamos insertar la factura **9002** y luego un detalle con el producto inexistente **-999**. SQL Server mostró un conflicto con la restricción **`FK_DETALLE_FACTURA_PRODUCTO`**. En el bloque `CATCH` se ejecutó `ROLLBACK`, y al consultar las tablas no aparecieron ni la factura 9002 ni sus detalles.

En las capturas de la carpeta `evidencias/` se ve el mensaje de error y que las consultas posteriores no devolvieron registros. Esto confirma que se canceló la operación completa.

## Conclusión

Con estas pruebas pudimos comprobar cómo se utiliza `COMMIT` para guardar una venta y `ROLLBACK` para deshacer cambios, tanto de manera voluntaria como ante un error. Nos permitió entender por qué es importante agrupar las operaciones de facturación para evitar registros incompletos y mantener la integridad de la base de datos.

## Archivos

- [`scripts.sql`](scripts.sql): código de las tres pruebas sobre la base de práctica.
- [`evidencias/`](evidencias/): capturas de la tercera prueba. Las capturas de las pruebas 1 y 2 pueden incorporarse aquí si se conservan.
