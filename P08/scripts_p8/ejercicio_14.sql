--14. Calcular el monto total de la última factura del cliente GALILEA GOMEZ GONZALEZ.
--R: Se debe obtener $ 1765264.89


select fc.factura_cliente_id, sum(precio_venta) as monto
from subasta_venta sv
join factura_cliente fc on sv.factura_cliente_id=fc.factura_cliente_id
join cliente c on sv.cliente_id=c.cliente_id
join (select max(fecha_factura) as maxi_date
  from factura_cliente fac
  join subasta_venta suv on fac.factura_cliente_id=suv.factura_cliente_id
  join cliente cli on cli.cliente_id=suv.cliente_id
  where cli.nombre='GALILEA' and cli.apellido_paterno='GOMEZ'
  and cli.apellido_materno='GONZALEZ') q1
on q1.maxi_date=fc.fecha_factura
group by (fc.factura_cliente_id);
