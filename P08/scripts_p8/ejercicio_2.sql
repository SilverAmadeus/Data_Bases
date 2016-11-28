--Generar un reporte que muestre el id, nombre y clave de todos 
--los artículos que hayan sido entregados 
--al cliente (status= ENTREGADO, no emplear el id del status) 
--en cualquier subasta y que hayan sido
--donados por 'BELGICA'. Emplear natural join.

select articulo_id, nombre, clave_articulo from articulo
join status_articulo s  using (status_articulo_id) 
natural join articulo_donado
join pais p using (pais_id)
where s.clave='ENTREGADO'
and p.descripcion='BELGICA';

--Alias en columna clave y descripcion de tablas status_articulo y pais
--para evitar la ambiguedad
