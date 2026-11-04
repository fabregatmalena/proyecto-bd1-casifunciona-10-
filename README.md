<div align="center">

# NegocioIndumentariaDtf

### Sistema de gestión para una fábrica textil de impresiones DTF y prendas personalizadas

![UNNE](https://img.shields.io/badge/UNNE-FaCENA-003366?style=flat-square)
![Base de Datos](https://img.shields.io/badge/Base%20de%20Datos-I-007acc?style=flat-square)
![Proyecto Integrador](https://img.shields.io/badge/Proyecto%20Integrador-2026-e65100?style=flat-square)
![Equipo](https://img.shields.io/badge/Equipo-10-2e7d32?style=flat-square)
![SQL Server](https://img.shields.io/badge/SGBD-SQL%20Server-CC292B?style=flat-square)

**Universidad Nacional del Nordeste — FaCENA**  
**Base de Datos I — Proyecto Integrador 2026**  
**Equipo 10 — CasiFunciona**

</div>

---

# 📑 Índice

1. [Presentación del proyecto](#1-presentación-del-proyecto)
2. [Problemática y solución propuesta](#2-problemática-y-solución-propuesta)
3. [Objetivos del proyecto](#3-objetivos-del-proyecto)
4. [Alcance del sistema](#4-alcance-del-sistema)
5. [Diseño y modelado de la base de datos](#5-diseño-y-modelado-de-la-base-de-datos)
6. [Reglas de negocio](#6-reglas-de-negocio)
7. [Documentación por etapas](#7-documentación-por-etapas)
8. [Estructura del repositorio](#8-estructura-del-repositorio)
9. [Implementación en SQL Server](#9-implementación-en-sql-server)
10. [Consultas SQL y reportes](#10-consultas-sql-y-reportes)
11. [Seguridad y optimización](#11-seguridad-y-optimización)
12. [Tecnologías utilizadas](#12-tecnologías-utilizadas)
13. [Integrantes del equipo](#13-integrantes-del-equipo)
14. [Conclusión](#14-conclusión)

---

# 1. Presentación del proyecto

**NegocioIndumentariaDtf** es un proyecto de base de datos relacional desarrollado para gestionar las operaciones de un emprendimiento dedicado a la producción y comercialización de prendas personalizadas y estampados mediante la técnica DTF (*Direct to Film*).

El proyecto fue realizado como parte de la asignatura **Base de Datos I**, correspondiente a la Facultad de Ciencias Exactas y Naturales y Agrimensura (FaCENA) de la Universidad Nacional del Nordeste (UNNE).

Su finalidad es diseñar e implementar una base de datos que permita organizar la información del negocio, relacionar sus diferentes áreas y facilitar la administración de las operaciones comerciales.

El sistema contempla la gestión de clientes, productos, prendas, estampas, diseños, proveedores, insumos, compras, facturas y métodos de pago.

Para su desarrollo se utilizó Microsoft SQL Server como sistema gestor de bases de datos y SQL Server Management Studio (SSMS) como herramienta de implementación y administración.

---

# 2. Problemática y solución propuesta

## 2.1. Problemática

En un negocio dedicado a la fabricación y venta de indumentaria personalizada es necesario administrar una gran cantidad de información relacionada con productos, materiales, proveedores, clientes y operaciones comerciales.

Cuando estos datos se registran de manera independiente o desorganizada, pueden presentarse dificultades como:

- Duplicación de información.
- Errores en el registro de ventas.
- Falta de control sobre los productos disponibles.
- Dificultad para identificar proveedores.
- Inconsistencias entre las compras y las existencias de insumos.
- Pérdida de información sobre operaciones anteriores.
- Problemas para obtener informes de ventas.

Estas situaciones pueden afectar la organización del negocio y dificultar la toma de decisiones.

## 2.2. Solución propuesta

Para resolver estas dificultades se propone implementar una base de datos relacional que permita centralizar la información.

Mediante esta solución se busca:

- Registrar y administrar clientes.
- Organizar el catálogo de productos.
- Identificar prendas, estampas y diseños.
- Registrar proveedores e insumos.
- Administrar compras y ventas.
- Mantener la integridad de los datos.
- Consultar información comercial.
- Controlar los permisos de acceso.
- Optimizar el rendimiento de las consultas.

---

# 3. Objetivos del proyecto

## Objetivo general

Diseñar e implementar una base de datos relacional para administrar la información de un negocio de indumentaria personalizada y estampados DTF, aplicando los conocimientos adquiridos durante el cursado de Base de Datos I.

## Objetivos específicos

- Analizar los requerimientos del negocio.
- Identificar las entidades y relaciones necesarias.
- Definir reglas de negocio.
- Elaborar el Diagrama Entidad-Relación.
- Transformar el modelo conceptual en un modelo relacional.
- Aplicar las formas normales correspondientes.
- Implementar la base de datos mediante scripts SQL.
- Definir claves primarias y foráneas.
- Aplicar restricciones de integridad.
- Insertar datos de prueba.
- Desarrollar consultas SQL.
- Implementar mecanismos de seguridad.
- Analizar estrategias de optimización mediante índices.
- Documentar las etapas del proyecto.

---

# 4. Alcance del sistema

La base de datos contempla las siguientes áreas:

| Área | Descripción |
|---|---|
| Clientes | Registro de información personal y datos de contacto. |
| Ubicación | Organización de ciudades y provincias. |
| Productos | Administración del catálogo de productos comercializados. |
| Prendas | Registro de características como talle, color y tipo de tela. |
| Estampas | Administración de productos correspondientes a estampados. |
| Diseños | Registro de diseños utilizados para personalizar productos. |
| Facturación | Registro de facturas y sus detalles. |
| Métodos de pago | Identificación del medio de pago utilizado. |
| Proveedores | Administración de los proveedores del negocio. |
| Insumos | Registro de materiales utilizados en la producción. |
| Compras | Registro de adquisiciones realizadas a proveedores. |
| Consultas | Obtención de información comercial y reportes. |
| Seguridad | Administración de usuarios, roles y permisos. |
| Optimización | Evaluación del rendimiento de consultas mediante índices. |

---

# 5. Diseño y modelado de la base de datos

Durante el desarrollo se aplicaron los conceptos de modelado conceptual, lógico y físico.

## 5.1. Modelo conceptual

Se elaboró un Diagrama Entidad-Relación (DER) para representar las entidades del sistema, sus atributos y las relaciones existentes.

Se utilizó la notación de Peter Chen para identificar:

- Entidades.
- Atributos.
- Relaciones.
- Cardinalidades.
- Claves identificadoras.

El diagrama permitió representar el funcionamiento del negocio antes de implementar las tablas.

## 5.2. Modelo relacional

A partir del modelo conceptual se realizó la transformación al modelo relacional.

Se definieron las tablas, sus atributos y las claves necesarias para relacionar la información.

Entre las entidades principales se encuentran:

- `CLIENTE`
- `CIUDAD`
- `PROVINCIA`
- `PRODUCTO`
- `PRENDA`
- `ESTAMPA`
- `DISENO`
- `FACTURA`
- `DETALLE_FACTURA`
- `METODO_PAGO`
- `PROVEEDOR`
- `INSUMO`
- `COMPRA`
- `DETALLE_COMPRA`

También se contemplan las relaciones asociativas definidas durante el modelado.

## 5.3. Especialización de productos

Una de las decisiones de diseño fue utilizar `PRODUCTO` como entidad general.

A partir de esta entidad se organizaron las especializaciones correspondientes a prendas y estampas.

Esta decisión permite representar las características generales de los productos y, al mismo tiempo, almacenar los atributos específicos de cada categoría.

## 5.4. Normalización

El modelo fue analizado aplicando las tres primeras formas normales.

### Primera Forma Normal (1FN)

Se organizaron los atributos para almacenar valores atómicos y evitar grupos repetitivos.

### Segunda Forma Normal (2FN)

Se analizaron las dependencias funcionales para evitar dependencias parciales respecto de las claves.

### Tercera Forma Normal (3FN)

Se revisaron las dependencias transitivas y se separó la información en entidades relacionadas.

Un ejemplo es la organización de los datos geográficos mediante las tablas `CLIENTE`, `CIUDAD` y `PROVINCIA`.

La normalización contribuye a disminuir redundancias y mejorar la consistencia de la información.

---

# 6. Reglas de negocio

Las reglas de negocio establecen las condiciones que deben cumplirse para garantizar el correcto funcionamiento del sistema.

Durante el desarrollo se definieron **31 reglas de negocio**.

Entre las principales se encuentran:

1. Todo cliente debe registrarse con sus datos correspondientes.
2. Un cliente puede estar relacionado con varias facturas.
3. Cada factura debe identificar al cliente correspondiente.
4. Las facturas deben contener información de los productos vendidos.
5. Cada detalle debe registrar la cantidad y el precio unitario.
6. El importe parcial se obtiene multiplicando la cantidad por el precio unitario.
7. El importe total corresponde a la suma de los importes parciales.
8. Los productos deben contar con información que permita identificarlos.
9. Las prendas y estampas deben conservar sus características específicas.
10. Las compras deben estar relacionadas con sus proveedores.
11. Los insumos deben registrarse para permitir su administración.
12. Las relaciones entre las entidades deben respetar las restricciones de integridad.

La documentación completa se encuentra en:

📄 [Reglas de negocio](docs/etapa-01/reglas-negocio.md)

---

# 7. Documentación por etapas

La documentación del proyecto se encuentra organizada dentro de la carpeta `docs`.

Cada etapa contiene los documentos correspondientes a las actividades desarrolladas.

## ETAPA 1 — Requerimientos y dominio del negocio

Durante esta etapa se realizó el análisis inicial del negocio.

Se identificaron la problemática, los objetivos, el alcance y las reglas que determinan su funcionamiento.

### Archivos

| Documento | Descripción |
|---|---|
| [Requerimientos y dominio del negocio](docs/etapa-01/Requerimientos-y-dominio-del-negocio.md) | Presentación del problema, contexto y alcance del sistema. |
| [Reglas de negocio](docs/etapa-01/reglas-negocio.md) | Definición de las reglas que deben cumplirse. |

---

## ETAPA 2 — Modelado conceptual y lógico

En esta etapa se desarrolló el diseño conceptual y lógico de la base de datos.

Se elaboró el DER y posteriormente se transformó en un modelo relacional.

También se realizó el proceso de normalización.

### Archivos

| Documento | Descripción |
|---|---|
| [Diagrama Entidad-Relación](docs/etapa-02/DER/der.png) | Representación gráfica del modelo conceptual. |
| [Decisiones de diseño](docs/etapa-02/decisiones-diseno.md) | Justificación de las decisiones tomadas. |
| [Modelo relacional](docs/etapa-02/modelo-relacional.md) | Descripción de tablas, atributos y relaciones. |
| [Normalización](docs/etapa-02/normalizacion.md) | Aplicación de 1FN, 2FN y 3FN. |

---

## ETAPA 3 — Implementación física

En esta etapa se implementó la estructura de la base de datos utilizando SQL Server.

Se desarrollaron scripts DDL para crear las tablas y definir las restricciones.

También se utilizaron instrucciones DML para insertar datos de prueba.

### Actividades realizadas

- Creación de tablas.
- Definición de claves primarias.
- Definición de claves foráneas.
- Implementación de restricciones.
- Inserción de datos.
- Verificación de relaciones.
- Pruebas de integridad.

### Archivos

| Documento | Descripción |
|---|---|
| [Implementación](docs/etapa-03/implementacion.md) | Descripción de la implementación física. |
| [Restricciones de integridad](docs/etapa-03/restricciones-integridad.md) | Documentación de las restricciones utilizadas. |
| [Pruebas y validación](docs/etapa-03/pruebas-validacion.md) | Verificación del funcionamiento de la base de datos. |

### Scripts SQL

- [Creación de la base de datos](sql/ddl/crear_bd.sql)
- [Inserción de datos de prueba](sql/dml/datos_prueba.sql)

---

## ETAPA 4 — Consultas SQL y explotación de datos

En esta etapa se desarrollaron consultas destinadas a obtener información útil para la administración del negocio.

Se aplicaron operaciones de selección, combinación de tablas, agrupamiento y funciones de agregación.

### Casos desarrollados

**Caso 1: Comprobante de venta**

Permite obtener información detallada de una factura, incluyendo cliente, productos, cantidades, precios y subtotales.

**Caso 2: Consulta avanzada**

Permite identificar clientes que superan un importe determinado de compras.

**Caso 3: Informe de ventas**

Permite analizar los productos comercializados, las unidades vendidas y los ingresos obtenidos.

### Documentación

| Documento | Descripción |
|---|---|
| [Casos de uso](docs/etapa-04/Casos-uso.md) | Presentación de las consultas desarrolladas. |
| [Comprobante de venta](docs/etapa-04/comprobante-venta.md) | Explicación de la consulta del comprobante. |
| [Consulta avanzada](docs/etapa-04/consulta-avanzada.md) | Consulta de clientes según sus compras. |
| [Informe de ventas](docs/etapa-04/informe-ventas.md) | Análisis de las operaciones comerciales. |

### Scripts SQL

- [Comprobante de venta](sql/consultas/comprobante_venta.sql)
- [Consulta avanzada](sql/consultas/consulta_avanzada.sql)
- [Informe de ventas](sql/consultas/informe_ventas.sql)

---

## ETAPA 5 — Implementación de funcionalidades avanzadas

Esta etapa está orientada a incorporar y analizar funcionalidades avanzadas de SQL Server.

Los temas abordados comprenden:

- Procedimientos almacenados y funciones.
- Manejo de transacciones.
- Triggers de auditoría.
- Seguridad de la base de datos.
- Índices y optimización de consultas.

Para los trabajos prácticos se utiliza una organización que permite separar la investigación teórica, los scripts de demostración y las evidencias obtenidas.

### Procedimientos almacenados y funciones

Los procedimientos almacenados permiten agrupar instrucciones SQL que pueden ejecutarse cuando una operación lo requiere.

Las funciones permiten realizar operaciones y devolver valores o conjuntos de datos.

Su utilización contribuye a organizar y reutilizar instrucciones.

### Manejo de transacciones

Las transacciones permiten ejecutar varias operaciones como una unidad lógica de trabajo.

En SQL Server se utilizan instrucciones como:

- `BEGIN TRANSACTION`
- `COMMIT TRANSACTION`
- `ROLLBACK TRANSACTION`

Estas instrucciones permiten confirmar operaciones realizadas correctamente o deshacer cambios cuando es necesario.

En el sistema NegocioIndumentariaDtf, las transacciones pueden aplicarse al registro de facturas y sus correspondientes detalles.

### Triggers de auditoría

Los triggers son mecanismos que permiten ejecutar instrucciones automáticamente cuando se producen determinados eventos en una tabla.

Pueden utilizarse para registrar modificaciones y mantener información de auditoría.

### Seguridad

La seguridad permite administrar el acceso de los usuarios a la base de datos.

Se utilizan mecanismos como:

- Inicios de sesión.
- Usuarios.
- Roles.
- Permisos.
- `GRANT`
- `REVOKE`

### Índices y optimización

Los índices permiten mejorar el acceso a determinados datos y pueden reducir el costo de algunas consultas.

Durante las pruebas se analizan aspectos como:

- Índices agrupados.
- Índices no agrupados.
- Planes de ejecución.
- Lecturas lógicas.
- Tiempo de ejecución.

### Documentación y archivos de la etapa 5

| Tema | Documentación | Script |
|---|---|---|
| Procedimientos y funciones | `docs/etapa-05/procedimientos_funciones/investigacion.md` | `docs/etapa-05/procedimientos_funciones/scripts.sql` |
| Transacciones | [Investigación](docs/etapa-05/transacciones/investigacion.md) | [Script](docs/etapa-05/transacciones/scripts.sql) |
| Triggers de auditoría | `docs/etapa-05/triggers_auditoria/investigacion.md` | `docs/etapa-05/triggers_auditoria/scripts.sql` |
| Seguridad | [Documentación](docs/etapa-05/seguridad.md) | [Script SQL](sql/tecnico/seguridad.sql) |
| Índices y optimización | [Documentación](docs/etapa-05/indices-optimizacion.md) | [Script SQL](sql/tecnico/indices.sql) |

**Nota:** los trabajos de procedimientos, funciones y triggers deben vincularse cuando se encuentren incorporados al repositorio.

---

# 8. Estructura del repositorio

El repositorio está organizado para separar la documentación académica de los scripts SQL utilizados en la implementación.

La estructura general es la siguiente:

```text
proyecto-bd1-casifunciona-10-/
│
├── docs/
│   │
│   ├── etapa-01/
│   │   ├── Requerimientos-y-dominio-del-negocio.md
│   │   └── reglas-negocio.md
│   │
│   ├── etapa-02/
│   │   ├── DER/
│   │   ├── decisiones-diseno.md
│   │   ├── modelo-relacional.md
│   │   └── normalizacion.md
│   │
│   ├── etapa-03/
│   │   ├── implementacion.md
│   │   ├── restricciones-integridad.md
│   │   └── pruebas-validacion.md
│   │
│   ├── etapa-04/
│   │   ├── Casos-uso.md
│   │   ├── comprobante-venta.md
│   │   ├── consulta-avanzada.md
│   │   └── informe-ventas.md
│   │
│   └── etapa-05/
│       │
│       ├── procedimientos_funciones/
│       │   ├── investigacion.md
│       │   ├── scripts.sql
│       │   └── evidencias/
│       │
│       ├── transacciones/
│       │   ├── investigacion.md
│       │   ├── scripts.sql
│       │   └── evidencias/
│       │
│       ├── triggers_auditoria/
│       │   ├── investigacion.md
│       │   ├── scripts.sql
│       │   └── evidencias/
│       │
│       ├── seguridad.md
│       └── indices-optimizacion.md
│
├── sql/
│   │
│   ├── ddl/
│   │   └── crear_bd.sql
│   │
│   ├── dml/
│   │   └── datos_prueba.sql
│   │
│   ├── consultas/
│   │   ├── comprobante_venta.sql
│   │   ├── consulta_avanzada.sql
│   │   └── informe_ventas.sql
│   │
│   └── tecnico/
│       ├── seguridad.sql
│       └── indices.sql
│
├── .gitignore
└── README.md
```

**Observación:** la estructura de la etapa 5 representa la organización prevista. Algunos archivos pueden encontrarse pendientes de incorporación.

---

# 9. Implementación en SQL Server

La implementación física se realizó utilizando Microsoft SQL Server y el lenguaje T-SQL.

## 9.1. Requisitos

Para ejecutar el proyecto se requiere:

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS).
- Acceso a una instancia de SQL Server.
- Scripts SQL incluidos en el repositorio.

## 9.2. Creación de la base de datos

La base de datos del proyecto se denomina:

`NegocioIndumentariaDtf`

El archivo principal de creación se encuentra en:

[sql/ddl/crear_bd.sql](sql/ddl/crear_bd.sql)

Antes de ejecutarlo, se debe revisar si el script crea la base de datos o si requiere que esta exista previamente.

En caso de que sea necesario crearla manualmente, se puede utilizar:

```sql
CREATE DATABASE NegocioIndumentariaDtf;
GO

USE NegocioIndumentariaDtf;
GO
```

## 9.3. Creación de tablas

Mediante instrucciones DDL se definen:

- Tablas.
- Columnas.
- Tipos de datos.
- Claves primarias.
- Claves foráneas.
- Restricciones de integridad.

## 9.4. Carga de datos

Una vez creada la estructura se ejecuta el archivo:

[sql/dml/datos_prueba.sql](sql/dml/datos_prueba.sql)

Este script permite incorporar datos de prueba para verificar el funcionamiento del modelo.

## 9.5. Ejecución de consultas

Después de cargar los datos se pueden ejecutar los scripts ubicados en:

[sql/consultas/](sql/consultas/)

Las consultas permiten obtener comprobantes, identificar clientes y generar informes comerciales.

## 9.6. Ejecución de scripts técnicos

Los scripts técnicos de seguridad y optimización se encuentran en:

[sql/tecnico/](sql/tecnico/)

Se recomienda ejecutarlos en un entorno de prueba y revisar previamente los permisos requeridos.

---

# 10. Consultas SQL y reportes

Las consultas desarrolladas durante la etapa 4 permiten obtener información relevante para el funcionamiento del negocio.

## 10.1. Comprobante de venta

Esta consulta permite visualizar el detalle de una factura.

Se relacionan las tablas correspondientes a:

- Factura.
- Cliente.
- Método de pago.
- Detalle de factura.
- Producto.

También se utilizan operaciones para obtener los importes correspondientes a la venta.

📄 [Ver documentación](docs/etapa-04/comprobante-venta.md)

💻 [Ver script SQL](sql/consultas/comprobante_venta.sql)

## 10.2. Consulta avanzada

Esta consulta permite identificar clientes cuyo importe acumulado de compras supera un valor determinado.

Se utilizan operaciones como:

- `INNER JOIN`
- `GROUP BY`
- `SUM`
- `HAVING`
- `ORDER BY`

📄 [Ver documentación](docs/etapa-04/consulta-avanzada.md)

💻 [Ver script SQL](sql/consultas/consulta_avanzada.sql)

## 10.3. Informe de ventas

Permite obtener información agrupada sobre los productos vendidos.

Entre los resultados que pueden analizarse se encuentran:

- Productos comercializados.
- Cantidad de operaciones.
- Unidades vendidas.
- Ingresos obtenidos.

📄 [Ver documentación](docs/etapa-04/informe-ventas.md)

💻 [Ver script SQL](sql/consultas/informe_ventas.sql)

---

# 11. Seguridad y optimización

Durante la etapa 5 se incorporaron actividades relacionadas con la administración de accesos y la evaluación del rendimiento.

## 11.1. Seguridad

La administración de seguridad permite establecer qué operaciones puede realizar cada usuario.

Para ello se utilizan:

- Usuarios de base de datos.
- Inicios de sesión.
- Roles.
- Permisos.
- Instrucciones de autorización.

La asignación de permisos permite organizar el acceso según las responsabilidades de cada usuario.

### Archivos

📄 [Documentación de seguridad](docs/etapa-05/seguridad.md)

💻 [Script de seguridad](sql/tecnico/seguridad.sql)

## 11.2. Índices y optimización

La optimización busca mejorar el rendimiento de las consultas.

Los índices pueden facilitar la localización de registros y reducir la cantidad de operaciones necesarias para obtener determinados resultados.

Para evaluar su comportamiento se pueden utilizar:

- Planes de ejecución.
- Estadísticas de tiempo.
- Estadísticas de entrada y salida.
- Comparaciones entre consultas con y sin índices.

### Archivos

📄 [Documentación de índices](docs/etapa-05/indices-optimizacion.md)

💻 [Script de índices](sql/tecnico/indices.sql)

---

# 12. Tecnologías utilizadas

| Tecnología | Utilización |
|---|---|
| Microsoft SQL Server | Gestión de la base de datos relacional. |
| SQL Server Management Studio | Creación, administración y ejecución de consultas. |
| T-SQL | Definición, manipulación y consulta de datos. |
| Git | Control de versiones del proyecto. |
| GitHub | Almacenamiento y organización del repositorio. |
| Markdown | Elaboración de la documentación técnica. |
| ERDPlus | Desarrollo del modelo conceptual y relacional. |

---

# 13. Integrantes del equipo

## Grupo 10 — CasiFunciona

**Universidad:** Universidad Nacional del Nordeste (UNNE)

**Facultad:** Facultad de Ciencias Exactas y Naturales y Agrimensura (FaCENA)

**Asignatura:** Base de Datos I

**Ciclo lectivo:** 2026

### Integrantes

| N.º | Apellido y nombre |
|:---:|---|
| 1 | Niveyro, Lucía |
| 2 | Pared Ifran, Maitena |
| 3 | Fernández, Lucía Belén |
| 4 | Fabregat, Malena Ayelén |

---

# 14. Conclusión

El desarrollo de **NegocioIndumentariaDtf** permitió aplicar de manera práctica los conocimientos adquiridos durante la asignatura Base de Datos I.

A lo largo del proyecto se trabajó en el análisis de requerimientos, la definición de reglas de negocio, el diseño conceptual y lógico, la normalización y la implementación física de una base de datos relacional.

Posteriormente, se desarrollaron consultas SQL para obtener información comercial y se incorporaron actividades relacionadas con la seguridad y la optimización del sistema.

El trabajo también permitió comprender la importancia de las restricciones de integridad, las relaciones entre entidades y la correcta organización de la información.

Finalmente, la utilización de GitHub facilitó la organización de los archivos, la documentación de las etapas y el trabajo colaborativo entre los integrantes del equipo.

El proyecto constituye una aplicación de los conceptos fundamentales de bases de datos a un caso de negocio relacionado con la producción y comercialización de indumentaria personalizada.

---

<div align="center">

###  NegocioIndumentariaDtf

**Proyecto Integrador — Base de Datos I**

**Equipo 10 — CasiFunciona**

**FaCENA — Universidad Nacional del Nordeste**

**2026**

</div>
