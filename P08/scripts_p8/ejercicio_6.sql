--6. Generar un reporte que muestre nombre, apellidos, email, de todos los clientes cuya ocupación sea
--ABOGADO, y en caso de tener registrado una o más tarjetas de crédito, incluir el tipo de tarjeta. Emplear
--notación SQL anterior compatible con Oracle.

select nombre, apellido_paterno, apellido_materno, email,tipo_tarjeta
from cliente c, tarjeta_cliente tc where c.cliente_id=tc.cliente_id(+)
and ocupacion='ABOGADO';

select nombre, apellido_paterno, apellido_materno, email, tipo_tarjeta
from tarjeta_cliente tc, cliente c where tc.cliente_id(+)=c.cliente_id
and ocupacion='ABOGADO';
