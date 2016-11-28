--4. Generar un reporte que muestre los datos de los clientes (Nombre, apellidos) 
--y los datos de sus tarjetas (numero de tarjeta, mes de vigencia, año de vigencia) 
--que ya hayan expirado. Notas:
--a. para validar si ya la tarjeta expiró emplear el mes y año de vigencia.
--b. Considerar que la consulta se ejecuta en Noviembre del 2011
--c. Si una tarjeta tiene momo año y mes de expiración los valores 11/11, 
--la tarjeta aún se considera como vigente.

select nombre, apellido_paterno, apellido_materno,
numero_tarjeta,mes_vigencia, anio_vigencia
from cliente c 
inner join tarjeta_cliente t
on c.cliente_id=t.cliente_id
where mes_vigencia<'11'
and anio_vigencia='11'
or anio_vigencia <'11';
