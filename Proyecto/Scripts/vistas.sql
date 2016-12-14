--Para ver los empleados que son revisores
CREATE OR REPLACE VIEW v_editores(
	nombre, apellido_paterno,apellido_materno, cedula, email)
	AS SELECT nombre, apellido_paterno, apellido_materno,
	cedula, email FROM empleado e, editor ed 
	WHERE e.empleado_id=ed.empleado_id;

--Para ver los empleados que son editores
CREATE OR REPLACE VIEW v_revisores(
	nombre, apellido_paterno,apellido_materno, num_contrato, email)
	AS SELECT nombre, apellido_paterno, apellido_materno,
	num_contrato, email FROM empleado e, revisor r 
	WHERE e.empleado_id=r.empleado_id;

--Para ver autor con sus respectivos folios de articulo
CREATE OR REPLACE VIEW v_autor_folio(nombre,apellido_paterno,folio)
	AS SELECT nombre,apellido_paterno,folio
	FROM autor au, autor_articulo aa, articulo art
	where a.autor_id=aa.autor_id
	and aa.articulo_id=art.articulo_id;