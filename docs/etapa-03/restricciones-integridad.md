Verificacion de Restricciones e Integridad de Datos
Base de Datos: NegocioIndumentariaDtf
Motor: Microsoft SQL Server
Lenguaje: T-SQL

Introduccion
Durante la implementacion fisica de la base de datos NegocioIndumentariaDtf se definieron distintas restricciones con el objetivo de mantener la consistencia y validez de los datos almacenados.
Las restricciones implementadas permiten controlar principalmente la integridad de entidad, la integridad referencial, la integridad de dominio y determinadas reglas de negocio.
Para ello se utilizaron claves primarias (PRIMARY KEY), claves foraneas (FOREIGN KEY), restricciones UNIQUE, NOT NULL, CHECK, valores DEFAULT y una columna calculada en DETALLE_FACTURA.

Integridad de Entidad
La integridad de entidad permite identificar de manera unica cada registro almacenado en las tablas.
Para implementarla se utilizaron claves primarias.
Las tablas PROVINCIA, CIUDAD, CLIENTE, METODO_PAGO, PRODUCTO, DISENO, PRENDA, ESTAMPA, PROVEEDOR, INSUMO, COMPRA y FACTURA poseen claves primarias simples.
Por ejemplo:

PROVINCIA: id_provincia

CLIENTE: id_cliente

PRODUCTO: id_producto

PRENDA: id_prenda

ESTAMPA: id_estampa

PROVEEDOR: id_proveedor

INSUMO: id_insumo

FACTURA: id_factura
Estas claves se definieron como INT NOT NULL y PRIMARY KEY, evitando identificadores duplicados o nulos.
Tambien existen claves primarias compuestas.
En DETALLE_COMPRA, la clave primaria esta formada por:
(id_detalle_compra, id_compra)
En DETALLE_FACTURA, la clave primaria esta formada por:
(id_detalle_factura, id_factura)
Por su parte, PRODUCTO_INSUMO utiliza:
(id_producto, id_insumo)
Esta ultima clave compuesta permite implementar la relacion muchos a muchos entre productos e insumos e impide repetir exactamente la misma combinacion de producto e insumo.

Restricciones de Unicidad
Ademas de las claves primarias, se utilizaron restricciones UNIQUE para atributos o combinaciones de atributos que no deben repetirse.
En PROVINCIA, nombre_provincia es unico, evitando registrar dos veces la misma provincia.
En CIUDAD, la combinacion:
(nombre_ciudad, id_provincia)
es unica. De esta forma, no puede registrarse dos veces una ciudad con el mismo nombre dentro de una misma provincia.
En CLIENTE, tanto dni_cliente como correo_cliente son unicos. Esto evita registrar distintos clientes utilizando el mismo DNI o el mismo correo electronico.
En PROVEEDOR, correo_proveedor tambien es unico.
En METODO_PAGO, la descripcion es unica, evitando registrar varias veces el mismo metodo de pago.
En DETALLE_COMPRA, la combinacion:
(id_compra, id_insumo)
es unica. Esto evita que el mismo insumo aparezca repetido en diferentes lineas de una misma compra. Si se adquieren varias unidades del mismo insumo, deben registrarse mediante el atributo cantidad.
De forma similar, en DETALLE_FACTURA la combinacion:
(id_factura, id_producto)
es unica, evitando repetir el mismo producto en varias lineas de una misma factura.
En PRENDA se definio id_producto como unico. Por lo tanto, un producto determinado puede aparecer como maximo una vez dentro de la tabla PRENDA.
En ESTAMPA tambien se definio id_producto como unico, por lo que un producto puede aparecer como maximo una vez dentro de ESTAMPA.
Estas dos ultimas restricciones no impiden que un mismo producto aparezca una vez en PRENDA y tambien una vez en ESTAMPA. Esto es coherente con la RN.09, que establece que un producto puede corresponder a una prenda, a una estampa o a ambas.

Integridad Referencial
La integridad referencial se implemento mediante claves foraneas (FOREIGN KEY).
Su finalidad es evitar referencias hacia registros que no existen.
Por ejemplo, cada ciudad debe pertenecer a una provincia existente. Para ello, CIUDAD.id_provincia referencia a PROVINCIA.id_provincia.
Cada cliente debe estar asociado a una ciudad existente mediante CLIENTE.id_ciudad.
Cada factura debe pertenecer a un cliente y utilizar un metodo de pago existente. Por esta razon, FACTURA contiene las claves foraneas id_cliente e id_metodopago.
Las prendas y estampas deben estar asociadas a productos existentes y pueden relacionarse con disenos mediante las correspondientes claves foraneas.
Las compras se relacionan con proveedores mediante COMPRA.id_proveedor.
Los detalles de compra relacionan una compra con los insumos adquiridos.
Los detalles de factura relacionan cada factura con los productos vendidos.
Finalmente, PRODUCTO_INSUMO relaciona productos e insumos, permitiendo representar la relacion N:M establecida por las reglas de negocio.

Politicas de eliminacion y actualizacion
En la mayoria de las claves foraneas se utilizaron:
ON DELETE NO ACTION
ON UPDATE NO ACTION
Esto evita eliminar o modificar un registro padre cuando existen otros registros que dependen de el.
Por ejemplo, SQL Server no permitira eliminar un cliente que todavia tenga facturas asociadas, ni eliminar un producto que se encuentre referenciado por otras tablas.
Esta decision ayuda a preservar la integridad y el historial de los datos.
En DETALLE_COMPRA se utilizo ON DELETE CASCADE respecto de COMPRA.
Esto significa que, si se elimina una compra, sus detalles asociados tambien son eliminados automaticamente.
De manera similar, DETALLE_FACTURA utiliza ON DELETE CASCADE respecto de FACTURA.
Por lo tanto, si se elimina una factura, tambien se eliminan sus detalles.
Esto evita que queden detalles sin su correspondiente registro principal.

Integridad de Dominio
La integridad de dominio permite controlar que valores pueden almacenarse en cada atributo.
Para ello se utilizaron tipos de datos apropiados, restricciones NOT NULL, CHECK y valores DEFAULT.
Los identificadores y cantidades utilizan principalmente INT.
Los atributos de texto utilizan VARCHAR con diferentes longitudes segun el dato almacenado.
Las fechas de compra y facturacion utilizan DATE.
Los valores monetarios utilizan DECIMAL, evitando utilizar tipos aproximados como FLOAT.
Por ejemplo, precios y tarifas utilizan principalmente:
DECIMAL(10,2)
mientras que el importe total y el precio parcial utilizan:
DECIMAL(12,2)
Las medidas ancho y alto de los disenos utilizan:
DECIMAL(6,2)
permitiendo almacenar valores con dos posiciones decimales.

Restricciones NOT NULL
Los atributos obligatorios fueron definidos mediante NOT NULL.
Por ejemplo, un cliente debe registrar obligatoriamente nombre, apellido, DNI, telefono, correo, direccion y ciudad.
Un producto debe registrar nombre, precio y stock.
Un proveedor debe registrar nombre, correo y telefono.
Una compra debe registrar una fecha y un proveedor.
Una factura debe registrar fecha, descripcion, cliente, metodo de pago e importe total.
Esto evita que se almacenen registros incompletos en atributos considerados obligatorios por el modelo.

Valores DEFAULT
Se utilizaron valores predeterminados para algunos atributos.
En PRODUCTO, stock_producto posee:
DEFAULT 0
En INSUMO, stock_insumo tambien posee:
DEFAULT 0
Esto permite que, cuando no se indique un stock inicial, SQL Server utilice automaticamente cero.
En FACTURA, importe_total posee:
DEFAULT 0
permitiendo inicializar una factura con un importe igual a cero.
El DEFAULT, sin embargo, solamente proporciona un valor inicial. No realiza por si mismo el calculo posterior del total de la factura.

Restricciones CHECK
Las restricciones CHECK se utilizaron para controlar valores numericos y evitar datos invalidos.
En PRODUCTO, precio_producto debe ser mayor o igual que cero:
precio_producto >= 0
Tambien se controla:
stock_producto >= 0
De esta manera no se permiten precios ni existencias negativas.
En INSUMO se establecio:
stock_insumo >= 0
En DISENO, la tarifa base debe cumplir:
tarifa_base >= 0
En FACTURA:
importe_total >= 0
En DETALLE_COMPRA, la cantidad debe ser estrictamente positiva:
cantidad > 0
y el precio unitario de compra debe ser mayor o igual que cero.
En DETALLE_FACTURA tambien se exige una cantidad mayor que cero y un precio unitario mayor o igual que cero.
Finalmente, en PRODUCTO_INSUMO, cantidad_requerida debe ser mayor que cero.
Estas restricciones permiten que SQL Server rechace automaticamente valores que no respeten las condiciones definidas.

Validacion de las medidas del diseno
La tabla DISENO posee controles adicionales sobre los atributos ancho y alto.
Se establecio que el ancho, cuando se registre, debe ser mayor que cero:
ancho IS NULL OR ancho > 0
La misma condicion se utiliza para el alto:
alto IS NULL OR alto > 0
Ademas, se implemento una restriccion para que ambas medidas sean ingresadas conjuntamente.
Se permite:

que ancho y alto sean nulos;

o que ancho y alto tengan valores.
No se permite registrar solamente una de las dos medidas.
De esta manera se evita, por ejemplo, almacenar un diseno con ancho definido pero sin altura.
Esto es coherente con las reglas RN.12 y RN.14, que indican que las medidas deben registrarse cuando correspondan.

Calculo del precio parcial
La RN.06 establece que el precio parcial de un detalle de factura se obtiene multiplicando la cantidad por el precio unitario.
Esta regla fue implementada directamente en DETALLE_FACTURA mediante una columna calculada:
precio_parcial AS (
CONVERT(
DECIMAL(12,2),
cantidad * precio_unitario
)
) PERSISTED

Por lo tanto, el usuario no necesita ingresar manualmente el precio parcial.
Por ejemplo, si se registran 2 unidades con un precio unitario de $15.000, SQL Server obtiene automaticamente:
2 x 15.000 = 30.000
Esto evita inconsistencias entre la cantidad, el precio unitario y el precio parcial.
La opcion PERSISTED indica que SQL Server almacena fisicamente el resultado calculado y lo actualiza cuando cambian los valores de los cuales depende.

Reglas que requieren implementacion adicional
No todas las reglas de negocio pueden garantizarse unicamente mediante las restricciones incluidas actualmente en el DDL.
La RN.07 establece que el importe total de una factura debe corresponder a la suma de los precios parciales de sus detalles.
Actualmente FACTURA.importe_total posee un CHECK que impide valores negativos y un DEFAULT 0, pero estas restricciones no garantizan que el importe total sea igual a la suma de DETALLE_FACTURA.precio_parcial.
Para automatizar completamente esta regla seria necesario implementar, por ejemplo, un trigger o procedimiento que actualice el total de la factura cuando se modifiquen sus detalles.
La RN.18 establece que el stock de un insumo debe disminuir cuando se registra su consumo.
La RN.26 establece que el stock de un insumo debe aumentar cuando se registra una compra.
El DDL actual garantiza que stock_insumo nunca sea negativo mediante CK_INSUMO_STOCK, pero no realiza automaticamente estos movimientos de stock. Para implementar completamente estas reglas se requiere logica adicional, como triggers o procedimientos almacenados.
Esta distincion es importante porque permite diferenciar las reglas que ya estan garantizadas estructuralmente por el SGBD de aquellas que requieren mecanismos adicionales.

Verificacion de las restricciones
Una vez creada la estructura de la base de datos y cargados los datos de prueba mediante DML, las restricciones pueden verificarse realizando operaciones validas e invalidas.
Entre las pruebas se pueden realizar:

intentar registrar dos provincias con el mismo nombre;

intentar registrar dos clientes con el mismo DNI;

intentar registrar dos clientes con el mismo correo;

intentar registrar un producto con precio negativo;

intentar registrar un producto o insumo con stock negativo;

intentar registrar una cantidad igual a cero en un detalle;

intentar registrar una ciudad perteneciente a una provincia inexistente;

intentar registrar una prenda asociada a un producto inexistente;

intentar registrar una estampa asociada a un diseno inexistente;

intentar registrar una factura para un cliente inexistente;

intentar repetir un producto dentro de una misma factura;

intentar eliminar un registro que este siendo referenciado mediante una FK configurada con NO ACTION.
Si las restricciones fueron implementadas correctamente, SQL Server debe rechazar estas operaciones.
Tambien se pueden ejecutar consultas SELECT para verificar que los datos validos hayan sido almacenados correctamente y que las relaciones entre las tablas coincidan con el modelo disenado.

Conclusion
La implementacion fisica de NegocioIndumentariaDtf permite mantener la consistencia de los datos mediante diferentes mecanismos proporcionados por SQL Server.
Las claves primarias garantizan la identificacion unica de los registros, mientras que las claves foraneas mantienen la integridad de las relaciones entre las tablas.
Las restricciones UNIQUE, NOT NULL, CHECK y DEFAULT permiten controlar duplicados, obligatoriedad, rangos validos y valores iniciales.
Ademas, la columna calculada precio_parcial implementa directamente el calculo establecido en la RN.06.
La carga de datos mediante DML y la realizacion de pruebas validas e invalidas permiten verificar que las restricciones definidas funcionan correctamente.
Finalmente, se identificaron reglas como la actualizacion automatica del total de factura y los movimientos de stock que requieren mecanismos adicionales para quedar completamente automatizadas dentro del SGBD.
