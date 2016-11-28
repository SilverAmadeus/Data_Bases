--8. La empresa desea regalar un articulo a todos los clientes que cumplan con alguna de las siguientes
--condiciones:
--a. Que el cliente haya comprado más de 5 productos desde que se registro en la base de datos.
--b. Que el monto total de todos los productos que haya comprado supere a los $3,000,000.
--Generar la sentencia SQL empleando operadores del álgebra relacional. Determine id, nombre, apellidos,
--numero de productos comprados y monto total.
--R: Los montos totales y el número de artículos son:

select c.cliente_id, nombre, apellido_paterno, apellido_materno, sum (precio_venta) as total, count(*) as num_articulos 
from cliente c, subasta_venta sv
where c.cliente_id=sv.cliente_id
group by (c.cliente_id,nombre,apellido_paterno,apellido_materno)
having sum(precio_venta)>3000000 or count (*) > 5;
