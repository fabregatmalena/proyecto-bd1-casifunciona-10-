# Triggers de Auditoría

## Definición y Objetivo
Los *Triggers* (o disparadores) son un tipo especial de procedimiento almacenado que se ejecuta de forma automática y silenciosa en respuesta a eventos DML específicos (`INSERT`, `UPDATE` o `DELETE`) que ocurren en una tabla de la base de datos. 
Su objetivo principal es reaccionar en tiempo real a las modificaciones de los datos sin requerir la intervención de un usuario o de la aplicación cliente.

## Ventajas y Aplicaciones
Implementar triggers aporta un nivel extra de control y seguridad al sistema:
* **Trazabilidad (Auditoría):** Permiten registrar un historial exacto de los cambios: quién los hizo, cuándo ocurrieron, y qué valores existían antes y después de la modificación.
* **Seguridad:** Ayudan a prevenir modificaciones accidentales o malintencionadas al mantener un registro de las acciones.
* **Cumplimiento y Reglas de Negocio:** Aseguran que ciertas validaciones o acciones secundarias (como crear un registro en otra tabla) se realicen siempre, independientemente de qué usuario o aplicación esté manipulando los datos.
* **Automatización:** Ejecutan operaciones lógicas críticas sin que el sistema externo deba recordarlo.

## Implementación en SQL Server Express
En SQL, un disparador se crea utilizando la sentencia `CREATE TRIGGER` asociada a una tabla específica.
Se debe definir el momento de ejecución (por ejemplo, `AFTER UPDATE` para que ocurra después de que el dato original ya fue modificado en la tabla). 
Dentro del bloque `BEGIN...END`, SQL Server provee dos tablas virtuales temporales exclusivas de los triggers: `inserted` (que contiene los valores nuevos) y `deleted` (que contiene los valores originales antes de la modificación). Cruzando estas dos tablas temporales, podemos capturar el "antes" y el "después".

## Caso concreto aplicado al sistema
Para nuestro negocio **NegocioIndumentariaDtf**, implementamos el siguiente mecanismo de auditoría:

* **Trigger de Auditoría de Precios (`trg_AuditoriaCambioPrecio`):**
  * **Problema:** Los precios de las prendas y estampas cambian constantemente debido a la inflación o ajustes de costos. La administración necesita saber exactamente cuándo aumentó un producto, cuánto costaba antes y qué usuario del sistema realizó ese ajuste en la tabla `PRODUCTO`.
  * **Solución:** Se crea una tabla secundaria llamada `AUDITORIA_PRECIO_PRODUCTO`. Luego, se programa un trigger sobre la tabla `PRODUCTO` que "vigila" la columna `precio_producto`. Cada vez que detecta un `UPDATE` en esa columna, toma el ID del producto, el precio viejo, el precio nuevo, la hora exacta (`GETDATE()`) y el usuario de la sesión (`SUSER_SNAME()`), y guarda toda esa información como un renglón nuevo en la tabla de auditoría.
