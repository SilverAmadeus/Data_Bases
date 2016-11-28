--11. Se desea generar un reporte estadístico que contenga la cantidad de artículos que hayan sido vendidos
--o entregados para cada uno de los tipos existentes. Genere una sentencia SQL que genere el reporte
--solicitado mostrando el número de artículos, la clave del status y el tipo de artículo.
--R: Se deben obtener 6 registros.


select count(*) as num_articulos, clave, tipo_articulo 
from articulo a
join status_articulo sa on a.status_articulo_id=sa.status_articulo_id
group by (clave,tipo_articulo)
having clave in ('VENDIDO','ENTREGADO');
