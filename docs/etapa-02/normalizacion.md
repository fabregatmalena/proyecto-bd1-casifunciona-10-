# Justificación de la normalización

El proceso de normalización se aplicó para garantizar que la base de datos de nuestro proyecto sea robusta, eliminando redundancias innecesarias y previniendo errores al insertar, actualizar o eliminar datos.

## Primera forma normal 
> Todos los atributos tienen que ser atómicos/indivisibles y no tienen que existir grupos repetitivos.

* Atomicidad: Se aseguró que ningún campo contenga varios valores. Por ejemplo, en la tabla `CLIENTE`, en lugar de usar un único campo "nombre_completo", lo separamos en `nombre_cliente` y `apellido_cliente` para facilitar su búsqueda y ordenamiento.
* Sin grupos: Un cliente puede comprar varios productos en una sola compra. En lugar de guardar una lista separada por comas de los productos dentro de la tabla `COMPRA`, creamos la tabla `DETALLE_COMPRA` para que cada celda de la base de datos contenga un único valor.

Asimismo, tenemos también el caso de la tabla asociativa `PRODUCTO_INSUMO`  para resolver la relación de muchos a muchos (N:M) entre productos e insumos. Si esta tabla no existiera, se tendrían que almacenar muchos IDs de insumos dentro de un solo campo en la tabla `PRODUCTO`, es decir sería una lista separada por comas, lo cual crearía un grupo repetitivo y violaría la atomicidad de los datos. Al crear esta tabla y asignarle una PK compuesta (`id_producto` e `id_insumo`), se garantiza que cada celda de la base de datos contenga un único valor. Además, al estar compuesta solo por claves, cumple con la segunda y tercera forma normal también, sacando dependencias parciales y transitivas.


##  Segunda forma normal 
> Tiene que cumplir la 1FN y todos los atributos que no son clave tienen que depender totalmente de la clave primaria (sin dependencias parciales).

Esto se ve en las tablas creadas para resolver relaciones de muchos a muchos. Por ejemplo, en una de esas tablas, `DETALLE_COMPRA`, el atributo `cantidad` depende específica y totalmente de esa línea de compra, y no parcialmente del `id_producto` o del `id_compra` por separado. No hay datos del producto (como el precio) mezclados en la tabla de detalle, ya que esos dependen únicamente de `id_producto` en su respectiva tabla.

##  Tercera forma normal
> Tiene que cumplir la 2FN y no tienen que existir dependencias transitivas (es decir, un atributo no clave no puede depender de otro atributo no clave).

La normalización de las dependencias transitivas se ve en el manejo de las localidades. Si la provincia y la ciudad se hubieran guardado como texto dentro de la tabla `CLIENTE`, el nombre de la provincia dependería de la ciudad y no directamente del `id_cliente`. Por lo tanto, para solucionarlo, se separaron estas entidades jerárquicamente en tablas. La tabla `CLIENTE` solo guarda el `id_ciudad` (FK) y la tabla `CIUDAD` guarda el `id_provincia` (FK), y `PROVINCIA` almacena su nombre. Esto evita problemas, por ejemplo si el nombre de una provincia cambia, solo se actualiza en un único registro.