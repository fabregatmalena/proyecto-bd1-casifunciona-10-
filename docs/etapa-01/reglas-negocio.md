# **Reglas de Negocio**


**RN.01** Todo cliente debe estar registrado con sus datos personales y de contacto.



**RN.02** Un cliente puede tener una o varias facturas, pero cada factura pertenece a un solo cliente.



**RN.03** Cada factura debe registrar un código, fecha, descripción, método de pago e importe total.



**RN.04** Cada factura debe contener uno o varios detalles de factura.



**RN.05** Cada detalle de factura debe registrar el producto, cantidad y precio unitario.



**RN.06** El precio parcial de un detalle de factura se obtiene multiplicando la cantidad por el precio unitario.



**RN.07** El total de la factura corresponde a la suma de los precios parciales de sus detalles.



**RN.08** Cada producto debe identificarse con un código, nombre, precio y stock disponible.



**RN.09** Un producto puede corresponder a una prenda o a una estampa, o ambas según su tipo.



**RN.10** Cada prenda debe registrar código, tipo de tela, talle y color.



**RN.11** Cada estampa debe identificarse mediante un código.



**RN.12** Cada diseño debe identificarse mediante un código y registrar color, logotipo, tarifa base y medidas cuando corresponda.



**RN.13** Un diseño puede estar asociado a una o varias prendas y estampas, según corresponda.



**RN.14** Las medidas de un diseño deben registrar ancho y alto cuando sean necesarias.



**RN.15** Cada insumo debe identificarse mediante un código, tipo y cantidad disponible en stock.



**RN.16** Un producto puede requerir uno o varios insumos para su elaboración.



**RN.17** Un insumo puede utilizarse en uno o varios productos.



**RN.18** Al registrar el consumo de un insumo, su cantidad disponible debe disminuir según la cantidad utilizada.



**RN.19** Cada proveedor debe registrarse con código, nombre, correo electrónico y teléfono.



 **RN.20** Un proveedor puede suministrar uno o varios insumos, y un insumo puede ser suministrado por uno o varios proveedores.


 
**RN.21** Cada compra debe registrarse con un código identificador y una fecha.



**RN.22** Cada compra corresponde a un único proveedor, mientras que un proveedor puede realizar una o varias compras.



**RN.23** Cada compra debe contener uno o varios detalles de compra.



**RN.24** Cada detalle de compra debe registrar el insumo adquirido, la cantidad y el precio unitario de compra.



**RN.25** Un insumo puede aparecer en uno o varios detalles de compra.



**RN.26** Al registrar una compra de insumos, el stock disponible debe aumentar según la cantidad adquirida.



**RN.27** Cada cliente debe estar asociado a una ciudad.



**RN.28** Cada ciudad debe pertenecer a una única provincia.



**RN.29** Una provincia puede contener una o varias ciudades.



**RN.30** Cada ciudad debe identificarse mediante un código y registrar su nombre.



**RN.31** Cada provincia debe identificarse mediante un código y registrar su nombre.








