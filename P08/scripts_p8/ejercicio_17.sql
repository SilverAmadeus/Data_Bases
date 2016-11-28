--17. La empresa decide reconocer a ciertos países por su buena participación: Generar un reporte con los
--datos de los países que han donado 3 o mas artículos con un precio de venta inicial mayor a $300,000
--R: Se deben obtener 2 países.


select p.descripcion, count(*) as num_articulos 
from articulo a
join articulo_donado ad on a.articulo_id=ad.articulo_id
join pais p on ad.pais_id=p.pais_id
where precio_inicial>=300000
group by p.descripcion
having count(*) >=3;