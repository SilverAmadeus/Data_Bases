--Empleando natural join, generar un reporte que muestre el id, 
--nombre, precio inicial, precio de venta,tipo de articulo, 
--nombre y fecha inicio de la subasta de todos los artículos 
--que compró el cliente MARICELA PAEZ MARTINEZ durante las subastas 
--realizadas en el 2010. Nota: Un artículo se considera comprado 
--cuando se registra el cliente que que lo adquirió y se registra 
--el precio de venta.

select articulo_id, a.nombre, precio_inicial,precio_venta, tipo_articulo,
s.nombre, fecha_inicio
from articulo a
join subasta_venta using (articulo_id)
join cliente c using (cliente_id)
join subasta s using (subasta_id)
where c.nombre ='MARICELA' 
and c.apellido_paterno = 'PAEZ' 
and c.apellido_materno='MARTINEZ'
and s.fecha_inicio>=to_date('01/01/10','DD/MM/YY')
and s.fecha_fin<=to_date('31/12/10','DD/MM/YY');
