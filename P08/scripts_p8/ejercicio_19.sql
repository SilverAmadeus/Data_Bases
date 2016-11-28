--Estandar

select fc.fecha_factura,c.nombre,c.apellido_paterno,c.apellido_materno,
sv.precio_venta,a.precio_inicial, sv.precio_venta-a.precio_inicial as diferencia,
a.nombre as articulo, a.clave_articulo, a.tipo_articulo, af.nombre_completo,
aq.anio_hallazgo,p.descripcion
from cliente c
join tarjeta_cliente tc on c.cliente_id=tc.cliente_id
join factura_cliente fc on tc.tarjeta_cliente_id=fc.tarjeta_cliente_id
join subasta_venta sv on fc.factura_cliente_id=sv.factura_cliente_id
join articulo a on sv.articulo_id=a.articulo_id
left outer join articulo_famoso af on a.articulo_id=af.articulo_id
left outer join articulo_arqueologico aq on a.articulo_id=aq.articulo_id
left outer join articulo_donado ad on a.articulo_id=ad.articulo_id
left outer join pais p on ad.pais_id=p.pais_id
where tc.numero_tarjeta='5681375824866375';

--Anterior
select fc.fecha_factura,c.nombre,c.apellido_paterno,c.apellido_materno,
sv.precio_venta,a.precio_inicial, sv.precio_venta-a.precio_inicial as diferencia,
a.nombre as articulo, a.clave_articulo, a.tipo_articulo, af.nombre_completo,
aq.anio_hallazgo,p.descripcion
from cliente c, tarjeta_cliente tc,factura_cliente fc, subasta_venta sv,articulo a,
articulo_famoso af,articulo_arqueologico aq,articulo_donado ad,pais p
where c.cliente_id=tc.cliente_id
and tc.tarjeta_cliente_id=fc.tarjeta_cliente_id
and fc.factura_cliente_id=sv.factura_cliente_id
and sv.articulo_id=a.articulo_id
and af.articulo_id(+)=a.articulo_id
and aq.articulo_id(+)=a.articulo_id
and ad.articulo_id(+)=a.articulo_id
and p.pais_id(+)=ad.pais_id
and tc.numero_tarjeta='5681375824866375';









