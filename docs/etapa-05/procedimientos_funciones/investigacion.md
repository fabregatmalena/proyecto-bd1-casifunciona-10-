# Procedimientos y Funciones Almacenadas


## Definición y Objetivo
Las funciones almacenadas (*Functions*) y los procedimientos almacenados (*Stored Procedures*) son rutinas precompiladas de código SQL que se guardan de forma nativa dentro del motor de la base de datos.
* **Funciones:** Su objetivo principal es recibir parámetros, realizar un cálculo específico sin alterar el estado de la base de datos y devolver obligatoriamente un valor escalar o una tabla. Se pueden invocar dentro de sentencias `SELECT`, `WHERE` o `HAVING`.
* **Procedimientos:** Su objetivo es operar ejecutando operaciones lógicas complejas y secuenciales, agrupando instrucciones de manipulación de datos (DML) como `INSERT`, `UPDATE` o `DELETE`. No están obligados a devolver un valor, pero sí alteran el estado de las tablas. Existen para encapsular bloques de acciones que se ejecutan frecuentemente, favoreciendo la modularidad del código.

## Ventajas y Aplicaciones
Implementar rutinas almacenadas en un sistema de ventas aporta los siguientes beneficios:
* **Reutilización y Modularidad:** La lógica se escribe, prueba y guarda una sola vez, y puede ser invocada por diferentes aplicaciones o usuarios sin reescribir código.
* **Centralización de Reglas de Negocio:** Garantiza que operaciones como el descuento de stock se apliquen siempre bajo las mismas validaciones matemáticas, sin depender de la aplicación cliente.
* **Mantenibilidad:** Si cambian las políticas del negocio (ej. aumento de impuestos), solo se actualiza el procedimiento en el servidor y todas las aplicaciones clientes reflejan el cambio inmediatamente.
* **Seguridad:** Permiten otorgar permisos (`GRANT EXECUTE`) a los usuarios para que ejecuten el procedimiento, sin necesidad de darles acceso directo para modificar las tablas subyacentes (`GRANT UPDATE`).

## Implementación en SQL Server Express
En SQL Server (T-SQL), las rutinas se implementan utilizando sentencias DDL:
* **Funciones:** Se crean con `CREATE FUNCTION`, definiendo los parámetros de entrada y el tipo de dato de retorno (`RETURNS`). La lógica se envuelve en un bloque `BEGIN...END` finalizando obligatoriamente con `RETURN`.
* **Procedimientos:** Se crean con `CREATE PROCEDURE` seguido de los parámetros. Su cuerpo `BEGIN...END` ejecuta las transacciones y modificaciones, y se invocan explícitamente mediante el comando `EXEC`.

## Caso concreto aplicado al sistema de ventas
Para nuestro negocio **NegocioIndumentariaDtf**, implementamos dos casos que resuelven necesidades reales:

* **Función Almacenada (`fn_TotalCompradoCliente`):** 
  * **Problema:** El sector de ventas y marketing necesita conocer rápidamente cuánto dinero ha gastado históricamente cada cliente para asignar perfiles de fidelización.
  * **Solución:** Una función escalar que recibe el `id_cliente`, suma todos los importes de sus facturas y devuelve el gasto total.

* **Procedimiento Almacenado (`sp_ActualizarStockInsumo`):**
  * **Problema:** Cada vez que el depósito recibe nueva mercadería (Tintas, Telas), el usuario debe registrar la compra y manualmente actualizar el stock de la tabla de insumos, lo cual es propenso a errores humanos (olvidos o sumas incorrectas).
  * **Solución:** Un procedimiento que recibe el `id_insumo` y la `cantidad_agregada`, y automatiza el `UPDATE` sumando de manera segura el nuevo ingreso al stock actual.
