--12. Suponga que se desea generar un reporte anual que muestre los totales recaudados en cada subasta
--realizada en el 2009, y por cada tipo de artículo. Genere un reporte que muestre, el nombre de la subasta,
--la fecha de inicio, el lugar en la que se realizó, el tipo de articulo y el monto total recaudado ordenadas
--del mayor al menor monto obtenido Emplear notación SQL estándar.
--R: Se deben obtener 18 registros.

--select s.nombre,fecha_inicio,fecha_fin,lugar, tipo_articulo, sum(precio_venta) as monto_total from articulo a 
--join subasta s on a.subasta_id=s.subasta_id
--right outer join subasta_venta sv on a.articulo_id=sv.articulo_id
--where to_char(fecha_fin,'YYYY')='2009'
--group by (s.nombre,fecha_inicio,fecha_fin,lugar,tipo_articulo)
--order by monto_total DESC;

select s.nombre,fecha_inicio,fecha_fin,lugar, tipo_articulo, sum(precio_venta) as monto_total from articulo a 
join subasta s on a.subasta_id=s.subasta_id
right outer join subasta_venta sv on a.articulo_id=sv.articulo_id
where to_char(fecha_inicio,'YYYY')='2009'
group by (s.nombre,fecha_inicio,fecha_fin,lugar,tipo_articulo)
order by monto_total DESC;
