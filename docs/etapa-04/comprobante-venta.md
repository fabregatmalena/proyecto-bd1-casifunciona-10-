

# Necesidad de Información que Resuelve
Esta consulta resuelve la necesidad de **generar un comprobante de venta detallado y completo** para una transacción específica. Permite obtener en un solo informe toda la información clave que requiere un cliente o un sistema de facturación:
* Los datos generales de la venta (número de factura y fecha de emisión).
* La identidad del comprador (nombre y apellido unificados).
* La modalidad de pago utilizada.
* El desglose ítem por ítem de los productos adquiridos, incluyendo cantidades, precios unitarios, subtotales por renglón y el cálculo automático del monto total global a abonar.

---

# Estrategia SQL Utilizada
Para cumplir con su objetivo, la consulta implementa las siguientes estrategias de SQL y bases de datos relacionales:
* **Proyección y Concatenación**: Selección explícita de atributos específicos mediante la cláusula `SELECT` y unión de cadenas de texto (`+`) para formatear el nombre completo del cliente en una sola columna con alias (`AS Cliente`).
* **Combinación Multi-Tabla (`INNER JOIN`)**: Relaja las restricciones de almacenamiento normalizado uniendo 5 tablas distintas (`FACTURA`, `CLIENTE`, `METODO_PAGO`, `DETALLE_FACTURA` y `PRODUCTO`) a través de sus claves primarias y foráneas utilizando la cláusula `ON`, lo que evita productos cartesianos y asegura la integridad referencial.
* **Funciones de Ventana Avanzadas (`SUM() OVER`)**: Emplea particionamiento (`PARTITION BY F.id_factura`) para calcular acumulados globales (el total de la factura) sin necesidad de colapsar ni agrupar el detalle mediante un `GROUP BY` tradicional, permitiendo mostrar el total general repetido en cada línea de producto.
* **Filtrado Eficiente (`WHERE`)**: Acota el universo de datos procesados evaluando una condición exacta sobre la clave primaria de la cabecera (`F.id_factura = 1`), facilitando la parametrización dinámica según la factura que se desee consultar.

---

# Resultado Esperado
El resultado esperado es una **tabla o conjunto de resultados relacional en formato de lista detallada** que contenga tantas filas como productos tenga la factura consultada. 

* **Si la factura N° 1 tiene 3 productos comprados**, el resultado arrojará **3 filas**.
* En cada una de esas filas se mostrarán repetidos los datos fijos (número de factura, fecha, cliente, método de pago y el `Total_Acumulado` general), mientras que variarán los datos dinámicos correspondientes a cada renglón (`nombre_producto`, `cantidad`, `precio_unitario` y `Subtotal_Renglon`).