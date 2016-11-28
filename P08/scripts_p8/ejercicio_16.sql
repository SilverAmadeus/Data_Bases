--16. En julio del 2010 la empresa lanzó una promoción de venta de Motocicletas en sus subastas. Se desea
--generar un reporte que muestre los siguientes datos:
--o Identificador de la subasta, fecha de inicio, identificador del artículo, nombre del artículo, precio
--inicial del artículo de todas las motocicletas que se vendieron o entregaron a un cliente en las
--subastas que iniciaron en el periodo que duró la promoción.
--o Agregar una columna más al reporte (columna de referencia), que indique el promedio del precio
--inicial de todas las motocicletas considerando todo el año 2010.

select s.subasta_id,s.fecha_inicio,a.articulo_id,a.nombre,a.precio_inicial,
(select avg(ar.precio_inicial) from articulo ar
  join subasta su on ar.subasta_id=su.subasta_id
  join status_articulo sta on ar.status_articulo_id=sta.status_articulo_id
  where to_char(su.fecha_inicio,'YYYY') = '2010'
  and sta.clave in('VENDIDO','ENTREGADO')
  and ar.nombre like '%Motocicleta%'
) as promedio
from articulo a
join subasta s on a.subasta_id=s.subasta_id
join status_articulo sa on a.status_articulo_id=sa.status_articulo_id
and to_char(s.fecha_inicio,'MM/YYYY') = '07/2010'
and sa.clave in ('VENDIDO','ENTREGADO')
and a.nombre like '%Motocicleta%';



