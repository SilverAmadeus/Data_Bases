--5.Generar un reporte que muestre nombre, clave, tipo, 
--año de hallazgo precio inicial y precio venta (para
--los que ya fueron vendidos o entregados) de todos los artículos 
--que sean de tipo arqueológico, y que tengan 
--un precio inicial mayor a $8000,000. Emplear notación SQL estándar.
select nombre, clave_articulo, tipo_articulo, anio_hallazgo,precio_inicial,precio_venta 
from articulo a
join articulo_arqueologico aa on a.articulo_id=aa.articulo_id
left outer join subasta_venta sv on a.articulo_id = sv.articulo_id
where precio_inicial>800000;
