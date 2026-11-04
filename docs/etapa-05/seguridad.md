## 1. Introducción

En esta etapa se implementaron mecanismos de seguridad en la base de
datos `NegocioIndumentariaDtf`, correspondiente al sistema de un negocio
de indumentaria y estampado textil DTF.

El objetivo es controlar el acceso a la información y determinar qué
operaciones puede realizar cada usuario. Para ello, se crearon distintos
usuarios y roles, asignando permisos de acuerdo con las tareas que
desempeña cada persona dentro del negocio.

## 2. Definición y objetivo

La seguridad en una base de datos consiste en controlar quién puede
acceder a la información y qué acciones puede realizar sobre ella.

SQL Server permite administrar los accesos mediante inicios de sesión,
usuarios, roles y permisos.

El objetivo de esta implementación es proteger la información del
negocio, evitar modificaciones o eliminaciones no autorizadas y permitir
que cada empleado acceda únicamente a los datos necesarios para cumplir
sus funciones.

## 3. Ventajas y aplicaciones

La implementación de usuarios, roles y permisos ofrece las siguientes
ventajas:

-   Protege la información almacenada en la base de datos.
-   Evita modificaciones o eliminaciones realizadas por personas no
    autorizadas.
-   Permite separar las responsabilidades de administración, ventas y
    control de stock.
-   Facilita la administración de permisos mediante roles.
-   Aplica el principio de mínimo privilegio, otorgando a cada usuario
    solamente los permisos que necesita.
-   Reduce el riesgo de errores o cambios accidentales en los datos.

En el negocio de estampado DTF, estos mecanismos permiten diferenciar el
acceso del administrador, del personal de ventas y del personal
encargado del stock.

## 4. Caso concreto aplicado al negocio

Se definieron tres perfiles de acceso:

  -----------------------------------------------------------------------
  Usuario                 Función                 Permisos principales
  ----------------------- ----------------------- -----------------------
  `admin_indumentaria`    Administrador del       Pertenece al rol
                          negocio                 `db_owner`, con
                                                  permisos completos
                                                  sobre la base de datos.

  `empleado_ventas`       Empleado de ventas      Puede consultar
                                                  clientes, facturas,
                                                  detalles de facturas,
                                                  prendas, diseños y
                                                  métodos de pago.

  `empleado_stock`        Empleado de stock       Puede consultar
                                                  productos, insumos,
                                                  prendas, estampas y
                                                  proveedores.
  -----------------------------------------------------------------------

Los empleados de ventas y stock reciben sus permisos mediante roles
personalizados. De esta manera, los permisos se administran desde los
roles y no individualmente para cada empleado.
## 5. Implementación en SQL Server Express

### 5.1. Creación de inicios de sesión

Primero se crearon los inicios de sesión a nivel del servidor. Estos
permiten que los perfiles puedan autenticarse en SQL Server.
<img width="1366" height="768" alt="img1" src="https://github.com/user-attachments/assets/08e31d7c-9fc4-41ec-83b8-2d570066178c" />
### 5.2. Creación de usuarios dentro de la base de datos

Luego se vincularon los inicios de sesión con usuarios de la base
<img width="1366" height="768" alt="img2" src="https://github.com/user-attachments/assets/265917e7-3da9-455b-9c18-859706097f02" />
### 5.3. Asignación del rol de administrador

Al usuario administrador se lo incorporó al rol fijo `db_owner`, que
cuenta con permisos completos sobre la base de datos.
<img width="1366" height="768" alt="img3" src="https://github.com/user-attachments/assets/e4d6b657-c84e-4a99-8910-e3d5772f9a03" />
### 5.4. Creación de roles personalizados

Se crearon dos roles para organizar los permisos según las funciones del
negocio. 
<img width="1366" height="768" alt="img4" src="https://github.com/user-attachments/assets/8056e58c-0217-4a79-8a6b-880cbabf9fc3" />
-   `rol_ventas`: agrupa los permisos necesarios para consultar
    información relacionada con las ventas.
-   `rol_stock`: agrupa los permisos necesarios para consultar
    información relacionada con el inventario y los insumos.

### 5.5. Asignación de permisos a los roles

Al rol de ventas se le otorgó permiso de lectura sobre las tablas
utilizadas en las tareas de venta.
<img width="1366" height="768" alt="img5" src="https://github.com/user-attachments/assets/a031f9ab-26ac-48db-b7cb-ea1ed7120c4f" />
El permiso `SELECT` permite consultar los registros de una tabla, pero
por sí solo no autoriza a insertar, modificar ni eliminar información.
### 5.6. Incorporación de los usuarios a los roles

Se agregó cada empleado al rol que corresponde a sus tareas.
<img width="1366" height="768" alt="img6" src="https://github.com/user-attachments/assets/54a7b981-9dc2-4473-a49f-8779b433fb83" />
### 5.7. Eliminación de permisos individuales repetidos

Como inicialmente se habían otorgado permisos de lectura directamente a
los empleados, se revocaron esos permisos individuales para que el
acceso quedara administrado mediante los roles.
<img width="1366" height="768" alt="img_reemplazo1" src="https://github.com/user-attachments/assets/03d8e3c5-feea-47c8-862f-f76a548e528f" />

## 6. Pruebas realizadas y resultados obtenidos

Para comprobar la implementación se realizaron pruebas ejecutando
consultas bajo el contexto de cada usuario.

### 6.1. Prueba de consulta para el empleado de ventas

Se comprobó que el empleado de ventas puede consultar la tabla
`CLIENTE`.
``` sql
USE NegocioIndumentariaDtf;
GO

EXECUTE AS USER = 'empleado_ventas';
GO

SELECT * FROM CLIENTE;
GO

REVERT;
GO
```
### 6.2. Prueba de consulta para el empleado de stock

Se comprobó que el empleado de stock puede consultar la tabla `INSUMO`.

``` sql
USE NegocioIndumentariaDtf;
GO

EXECUTE AS USER = 'empleado_stock';
GO

SELECT * FROM INSUMO;
GO

REVERT;
GO
```
### 6.3. Prueba de operación no autorizada

Se intentó ejecutar una operación `DELETE` sobre la tabla `CLIENTE`
utilizando el contexto del empleado de ventas.

<img width="1366" height="768" alt="img8" src="https://github.com/user-attachments/assets/ff6a1296-9203-49a2-96ea-5539a752ac30" />

### 6.4. Verificación de usuarios y roles

Por último, se consultaron las relaciones entre los usuarios y los roles
de la base de datos.

<img width="1366" height="768" alt="img_reemplazo3" src="https://github.com/user-attachments/assets/cbf85bff-93a9-4b76-be75-29525a91c683" />

