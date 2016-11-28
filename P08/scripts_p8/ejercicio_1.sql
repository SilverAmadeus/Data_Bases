--Genere un reporte que muestre nombre del artículo, clave, 
--clave del status de todos los artículos donados por el artista 
--‘William Harvey’. Emplear sintaxis estándar.
select a.nombre, a.clave_articulo, s.clave 
from articulo a
join articulo_famoso af on a.articulo_id=af.articulo_id
join status_articulo s on a.status_articulo_id=s.status_articulo_id
where af.nombre_completo='William Harvey';


