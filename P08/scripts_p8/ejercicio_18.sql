--18. Generar una consulta que determine los datos de las subastas que durante el año 2010 hayan logrado
--obtener $3,000,000 o más en ventas.
--R: Se deben obtener 5 subastas.

select s.nombre, s.fecha_inicio, s.fecha_fin, s.lugar,s.cupo, 
sum(precio_venta) as ventas,count(*) as articulos 
from subasta s, articulo a, subasta_venta sv
where a.articulo_id=sv.articulo_id
and a.subasta_id=s.subasta_id
and to_char(fecha_inicio,'YYYY')='2010'
group by s.nombre,s.fecha_inicio,s.fecha_fin,s.lugar,s.cupo
having sum(precio_venta)>=3000000
order by ventas DESC;
