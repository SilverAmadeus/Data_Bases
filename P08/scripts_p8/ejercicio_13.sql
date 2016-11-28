/*13. Para cada una de las subastas que se realizaron durante los meses enero, marzo y junio del 2010, mostrar
id, nombre, fecha inicio de la subasta, así como el nombre y clave del artículo más caro (precio venta)
que se haya vendido o entregado. Emplear un subquery correlacional.
R: Se deben obtener 11 registros.
*/
select a.subasta_id, s.nombre, fecha_inicio, a.nombre, clave_articulo, precio_venta
from articulo a
join subasta s on a.subasta_id=s.subasta_id
join subasta_venta sv on a.articulo_id=sv.articulo_id
where to_char(fecha_inicio,'MM/YYYY') in ('01/2010','03/2010','06/2010')
and precio_venta= (select max(precio_venta) as costo from articulo aa
  join subasta_venta su on aa.articulo_id=su.articulo_id
  join subasta ss on aa.subasta_id=ss.subasta_id
  where ss.subasta_id = a.subasta_id)
order by precio_venta DESC;
