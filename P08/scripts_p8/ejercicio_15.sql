--15. Suponga que para el próximo año, la empresa va a repetir la misma ronda de subastas por el éxito que
--tuvieron durante el 2010 a excepto de todas aquellas que hayan vendido 3 o menos artículos. Determinar
--id de la subasta, nombre, numero de artículos vendidos de las subastas que podrán ser repetidas
--ordenadas por id.
--R: Se deben obtener 11 subastas.


select s.subasta_id,s.nombre,count(*) as num_articulos from subasta s
join articulo a on a.subasta_id=s.subasta_id
join subasta_venta sv on a.articulo_id=sv.articulo_id
where to_char(fecha_inicio,'YYYY')='2010'
group by (s.subasta_id,s.nombre)
having count(*)>3;



