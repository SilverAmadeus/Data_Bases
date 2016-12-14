/*
Obtener titulo, nombres y apellidos de autores de todos los articulo que sean
de PROGRAMACION y los autores deben pertenecer a la UNAM
*/
select a.articulo_id, a.titulo, au.nombre, au.apellido_paterno, au.apellido_materno
, ai.nombre
from articulo a
JOIN autor_articulo aa ON aa.articulo_id = a.articulo_id
JOIN autor au ON au.autor_id = aa.autor_id
JOIN area_de_interes ai ON ai.area_de_interes_id = a.area_de_interes_id
WHERE au.institucion = 'UNAM' AND ai.nombre = 'Programacion'
ORDER BY Au.autor_ID;

/*Obtener los registros de los empleados que no son editores ni revisores y que
hayan ingresado a la empresa antes del 2016*/

select nombre, apellido_paterno, apellido_materno, fecha_ingreso from empleado
WHERE es_revisor = 0 AND es_editor = 0 
INTERSECT
select nombre, apellido_paterno, apellido_materno, fecha_ingreso from empleado
WHERE fecha_ingreso < TO_DATE('01/01/2016', 'dd/mm/yyyy');


/* Obtener el ID, nombre, apellidos y numero de articulos registrados
del autor con mas articulos registrados
*/
select a.autor_id, a.nombre, a.apellido_paterno, a.apellido_materno, 
count(*) as NUMERO_ARTICULOS from autor a
JOIN autor_articulo aa ON aa.autor_id = a.autor_id
JOIN articulo ar ON ar.articulo_id = aa.articulo_id
HAVING count(*) =( 
select max(num_articulos) from 
(
select autor_id, count(*) as num_articulos from autor_articulo
GROUP BY autor_id
ORDER BY count(*)
) q1)
GROUP BY a.autor_id, a.nombre, a.apellido_paterno, a.apellido_materno;
