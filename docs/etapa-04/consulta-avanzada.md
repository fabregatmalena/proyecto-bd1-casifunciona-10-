# Consulta de Clientes con Gastos Superiores a $40.000

Esta consulta permite identificar a los clientes que realizaron compras por un importe acumulado superior a $40.000 dentro del negocio de indumentaria y estampados DTF.

La necesidad principal es conocer cuáles son los clientes que registran mayores gastos, cuántas facturas tienen asociadas y cuál es el importe total de sus compras.

Esta información puede resultar útil para llevar un mejor control de las ventas, conocer el comportamiento de compra de los clientes y analizar cuáles generan mayores ingresos para el negocio.

Además, permite visualizar información personal y de contacto de los clientes, como su nombre, apellido, correo electrónico y ciudad.

## Estrategia SQL utilizada

Para resolver esta necesidad se desarrolló una consulta SQL que relaciona información de tres tablas: CLIENTE, CIUDAD y FACTURA.

Se utilizaron las siguientes herramientas:

- *SELECT:* Permite seleccionar los datos que se desean mostrar en el resultado.

- *FROM:* Indica que la consulta comienza desde la tabla CLIENTE.

- *INNER JOIN:* Permite relacionar las tres tablas mediante sus claves primarias y foráneas, obteniendo los datos de los clientes, sus ciudades y las facturas asociadas.

- *COUNT:* Se utiliza para contar la cantidad de facturas registradas por cada cliente.

- *SUM:* Permite calcular el importe total gastado por cada cliente, sumando los valores de importe_total de sus facturas.

- *GROUP BY:* Agrupa los registros correspondientes a cada cliente para poder aplicar las funciones de agregación.

- *HAVING:* Permite filtrar los grupos obtenidos, mostrando solamente aquellos clientes cuyo gasto acumulado supera los $40.000.

- *ORDER BY:* Ordena los resultados de manera descendente, mostrando primero a los clientes que registran mayores gastos.

La estrategia principal consiste en relacionar las tablas mediante INNER JOIN, agrupar los datos por cliente con GROUP BY, calcular los importes mediante SUM y aplicar una condición sobre los grupos utilizando HAVING.

## Resultado esperado

Al ejecutar la consulta, se espera obtener un listado de los clientes que registran un gasto total superior a $40.000.

Para cada cliente se mostrará la siguiente información:

- *id_cliente:* Identificador único del cliente.
- *nombre_cliente:* Nombre del cliente.
- *apellido_cliente:* Apellido del cliente.
- *correo_cliente:* Correo electrónico registrado.
- *nombre_ciudad:* Ciudad a la que pertenece.
- *Total_Facturas:* Cantidad de facturas asociadas al cliente.
- *Gasto_Total:* Suma de los importes de todas sus facturas.

Los resultados estarán ordenados desde el cliente que realizó el mayor gasto hasta el que registró el menor, siempre que supere los $40.000 establecidos en la condición.

Por ejemplo, si un cliente tiene dos facturas, una de $30.000 y otra de $25.000, la consulta mostrará un gasto total de $55.000 y una cantidad de 2 facturas.

En cambio, si un cliente tiene un gasto acumulado de $35.000, no aparecerá en los resultados porque no cumple con la condición establecida mediante HAVING.

