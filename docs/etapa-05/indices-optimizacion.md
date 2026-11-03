# Optimización de Consultas a través de Índices

## 1. Definición y objetivo

* **Definición:** Un índice en SQL Server Express es una estructura física auxiliar (organizada habitualmente en forma de árbol B/B+) asociada a una tabla o vista. Su funcionamiento es análogo al índice temático de un libro técnico: en lugar de recorrer todas las páginas secuencialmente de principio a fin, el motor utiliza los nodos del índice como un mapa jerárquico para saltar directamente a las filas buscadas.
* **Objetivo:** Optimizar los tiempos de respuesta de las consultas del sistema y reducir el uso intensivo de recursos de Entrada/Salida (I/O) en disco y memoria RAM, evitando escaneos completos (*Table Scans*) sobre tablas con grandes volúmenes de datos.

---

## 2. Ventajas y aplicaciones

* **Reducción de lecturas lógicas:** Minimiza la cantidad de páginas de datos de 8 KB que el motor de base de datos debe cargar e inspeccionar en la memoria caché (*Buffer Pool*).
* **Optimización de operadores de acceso:** Transforma operaciones costosas de escaneo secuencial (*Table Scan* / *Clustered Index Scan*) en búsquedas puntuales logarítmicas (*Index Seek*).
* **Aceleración de operaciones relacionales:** Incrementa sensiblemente la velocidad en cláusulas de filtrado (`WHERE`), emparejamiento de claves en uniones (`JOIN`), ordenamientos (`ORDER BY`) y agrupaciones (`GROUP BY`).
* **Escalabilidad:** Permite que la aplicación mantenga tiempos de respuesta estables a medida que la empresa acumula cientos de miles o millones de transacciones comerciales.
* **Compromiso y consideraciones (*Trade-off*):** Los índices consumen almacenamiento físico adicional en disco y generan una sobrecarga de procesamiento en las operaciones de escritura (`INSERT`, `UPDATE` y `DELETE`), dado que cada modificación de registros exige que SQL Server mantenga y reorganice la estructura de los árboles de índices asociados.

---

## 3. Implementación en SQL Server Express

En SQL Server Express se destacan tres tipos de arquitecturas de índices fundamentales:

1. **Índice Agrupado (*Clustered Index*):** Define el orden físico en que los datos se almacenan en las páginas de disco. Los nodos hoja del árbol contienen las páginas de datos reales de la tabla. Solo puede existir un único índice agrupado por tabla (por defecto se genera automáticamente al declarar la clave primaria / *Primary Key*).
2. **Índice No Agrupado (*Nonclustered Index*):** Estructura completamente independiente de los datos físicos de la tabla. Almacena las columnas clave indexadas y un puntero hacia la fila de datos real (un RID o localizador de fila en una tabla *Heap*, o la clave agrupada si la tabla cuenta con *Clustered Index*).
3. **Índice con Cobertura (*Covering Index* / Cláusula `INCLUDE`):** Es un índice no agrupado en el cual se incorporan columnas complementarias a los nodos hoja mediante la cláusula `INCLUDE`. Esto permite resolver la totalidad de la consulta accediendo exclusivamente al índice, evitando saltos adicionales a la tabla base (*Lookups* / *Key Lookups*).

---

## 4. Caso concreto aplicado al sistema de ventas (`NegocioIndumentariaDtf`)

En el sistema comercial de indumentaria DTF, el módulo de facturación requiere emitir con frecuencia reportes de ingresos y auditorías de ventas en rangos de fechas determinados (por ejemplo, balances de ventas trimestrales):

```sql
SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
```

Dado que las tablas iniciales del prototipo cuentan con pocos registros de prueba, el optimizador siempre optaría por un recorrido secuencial sin saturar la máquina. Por esta razón, y siguiendo los lineamientos de la cátedra, se modeló una tabla histórica denominada `FACTURA_HISTORICA` poblada con **1.000.000 de registros**, simulando un escenario empresarial de alto volumen para comprobar de manera empírica la eficiencia de los índices.

---

## 5. Script de demostración y resultados obtenidos

### 5.1. Script de creación y carga masiva de datos

```sql
USE NegocioIndumentariaDtf;
GO

IF OBJECT_ID('dbo.FACTURA_HISTORICA', 'U') IS NOT NULL    
    DROP TABLE dbo.FACTURA_HISTORICA;
GO

CREATE TABLE dbo.FACTURA_HISTORICA (    
    id_factura BIGINT IDENTITY(1,1),    
    fecha_factura DATE NOT NULL,    
    descripcion VARCHAR(150) NOT NULL,    
    id_cliente INT NOT NULL,    
    id_metodopago INT NOT NULL,    
    importe_total DECIMAL(12,2) NOT NULL
);
GO

SET NOCOUNT ON;
GO

WITH Numeros AS (    
    SELECT TOP (1000000)        
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n    
    FROM sys.objects a    
    CROSS JOIN sys.objects b    
    CROSS JOIN sys.objects c
)
INSERT INTO dbo.FACTURA_HISTORICA (fecha_factura, descripcion, id_cliente, id_metodopago, importe_total)
SELECT     
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1825, '2022-01-01'),    
    'Venta masiva indumentaria',    
    (ABS(CHECKSUM(NEWID())) % 10) + 1,    
    (ABS(CHECKSUM(NEWID())) % 10) + 1,    
    ROUND(RAND(CHECKSUM(NEWID())) * 50000, 2)
FROM Numeros;
GO
```

---

### 5.2. Escenario 1: Consulta sin índices (*Table Scan*)

```sql
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO
```

#### Métricas Obtenidas en el Entorno de Prueba:
* **Tiempo de CPU:** 312 ms
* **Tiempo Total Transcurrido:** 447 ms
* **Lecturas Lógicas:** 8.197 páginas
* **Operador Principal:** Recorrido de tabla (*Table Scan*) con 96% de costo de consulta

<img width="800" height="200" alt="img1" src="https://github.com/user-attachments/assets/a2c582cb-89bd-4a15-b236-5d3873acd0fd" />
<img width="800" height="200" alt="img2" src="https://github.com/user-attachments/assets/2525aee0-170c-4066-b54f-18bd3d5d7e7c" />



---

### 5.3. Escenario 2: Creación de índice agrupado por fecha

```sql
CREATE CLUSTERED INDEX IX_FacturaHistorica_Fecha
ON dbo.FACTURA_HISTORICA (fecha_factura);
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO
```

#### Métricas Obtenidas en el Entorno de Prueba:
* **Tiempo de CPU:** 16 ms
* **Tiempo Total Transcurrido:** 308 ms
* **Lecturas Lógicas:** 450 páginas
* **Operador Principal:** Búsqueda en índice clúster (*Clustered Index Seek*)

<img width="800" height="200" alt="img3" src="https://github.com/user-attachments/assets/cba4023f-4800-4264-854d-7ad809e42cd4" />
<img width="800" height="220" alt="img4" src="https://github.com/user-attachments/assets/303c6bfe-2dda-430e-b699-00eecf605eb0" />


---

### 5.4. Escenario 3: Creación de índice no agrupado con cobertura (`INCLUDE`)

```sql
DROP INDEX IX_FacturaHistorica_Fecha ON dbo.FACTURA_HISTORICA;
GO

CREATE NONCLUSTERED INDEX IX_FacturaHistorica_Fecha_Cobertura
ON dbo.FACTURA_HISTORICA (fecha_factura)
INCLUDE (id_factura, importe_total);
GO

SELECT id_factura, fecha_factura, importe_total
FROM dbo.FACTURA_HISTORICA
WHERE fecha_factura BETWEEN '2024-01-01' AND '2024-03-31';
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
```

#### Métricas Obtenidas en el Entorno de Prueba:
* **Tiempo de CPU:** 47 ms
* **Tiempo Total Transcurrido:** 550 ms
* **Lecturas Lógicas:** 214 páginas
* **Operador Principal:** Búsqueda en índice no clúster (*Index Seek NonClustered* puro sin *Lookups*)

<img width="800" height="200" alt="img5" src="https://github.com/user-attachments/assets/28e2587e-9aea-402e-8add-f95111635a2b" />
<img width="800" height="230" alt="img6" src="https://github.com/user-attachments/assets/e3a4afd1-ae68-4bd6-8c1e-6ae7fb682642" />


---

### 5.5. Cuadro comparativo final de rendimiento

| Escenario de Evaluación | Tiempo CPU | Tiempo Total | Lecturas Lógicas (I/O) | Operación Principal |
| :--- | :---: | :---: | :---: | :--- |
| **1. Sin índice (Heap)** | 312 ms | 447 ms | 8.197 páginas | Table Scan (Recorrido de tabla) |
| **2. Índice agrupado por fecha** | 16 ms | 308 ms | 450 páginas | Clustered Index Seek |
| **3. Índice con cobertura (`INCLUDE`)** | 47 ms | 550 ms | 214 páginas | Index Seek (NonClustered) |

---

### 5.6. Conclusiones técnicas del análisis comparativo

1. **Eficiencia en Entrada/Salida (I/O):** En la consulta sobre la tabla sin índice (*Heap*), el motor debió recorrer 8.197 páginas de datos para evaluar las fechas de 1.000.000 de registros. La implementación del índice agrupado redujo esta métrica a 450 páginas (94,5% de ahorro). Por su parte, el índice no agrupado con cobertura logró el mínimo absoluto con solo 214 páginas leídas, lo que representa una reducción drástica del **97,4%** en el trabajo de I/O respecto al estado original.
2. **Transformación en el Plan de Ejecución:** Se constató de forma visible la evolución desde un operador costoso de recorrido completo (*Table Scan*, con 96% de costo) hacia operadores de búsqueda directa en árbol (*Index Seek*). Asimismo, en el primer escenario el propio optimizador de SQL Server reportó una advertencia de *Missing Index* con impacto estimado de mejora superior al 84%, recomendando la estructura con cobertura.
3. **Relevancia de la Cláusula `INCLUDE`:** Al contener las columnas solicitadas (`id_factura` e `importe_total`) en el nivel hoja del índice, se eliminó completamente la necesidad de recurrir a operaciones de *Lookup* (búsquedas secundarias a la tabla base). En sistemas transaccionales de venta con consultas frecuentes de reportes por fecha, el índice de cobertura constituye la técnica de optimización más efectiva en relación costo-rendimiento.
