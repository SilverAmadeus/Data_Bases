/*20. Se ha detectado que en la base de datos existen compras realizadas por algunos clientes sin factura con
montos de mas de $1,000,000, ya que la empresa tiene como política, que toda compra igual o superior
a dicho monto, debe generar factura. Determine una sentencia SQL que muestre nombre, apellidos, y
el total del monto a cubrir, con la finalidad de notificarle al cliente la inexistencia de su factura.
R: Se deben obtener 6 registros.*/


select c.nombre, apellido_paterno, apellido_materno, sum(precio_venta) as monto
from subasta_venta sv
join cliente c on sv.cliente_id=c.cliente_id
where sv.factura_cliente_id is null
group by c.nombre,apellido_paterno, apellido_materno
having sum(precio_venta)>=1000000;
