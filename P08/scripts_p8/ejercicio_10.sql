--10. Suponga que un cliente decide realizar una consulta en el catálogo de artículos, esta interesado por todos
--aquellos artículos cuyo nombre o descripción hagan referencia o hablen de la palabra “Colonial” que no
--han sido aún vendidos, y que el articulo este en proceso de ser subastado. 
--Generar la sentencia SQL que muestre el nombre y tipo de todos los artículos 
--que cumplan con los criterios de búsqueda.
--R: Se debe obtener 1 registro.

select nombre, tipo_articulo, clave from articulo a
join status_articulo sa on a.status_articulo_id = sa.status_articulo_id
where nombre like '%Colonial%'
and clave in ('REGISTRADO', 'EN SUBASTA');
