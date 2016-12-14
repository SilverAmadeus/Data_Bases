CREATE OR REPLACE VIEW v_editores(
	nombre, apellido_paterno,apellido_materno, cedula, email)
	AS SELECT nombre, apellido_paterno, apellido_materno,
	cedula, email FROM empleado e, editor ed 
	WHERE e.empleado_id=ed.empleado_id;

CREATE OR REPLACE VIEW v_revisores(
	nombre, apellido_paterno,apellido_materno, num_contrato, email)
	AS SELECT nombre, apellido_paterno, apellido_materno,
	num_contrato, email FROM empleado e, revisor r 
	WHERE e.empleado_id=r.empleado_id;

