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

--Area de interes de los articulos de la última publicación
CREATE OR REPLACE VIEW v_super(
	nombre, titulo, num_pagina)
	AS SELECT nombre, a.titulo, num_pagina
	FROM area_de_interes ai, articulo a, 
	publicacion_articulo pa
	WHERE ai.area_de_interes_id= a.area_de_interes_id
	and a.articulo_id=pa.articulo_id
	and pa.publicacion_id=(select publicacion_id from publicacion  
						where fecha=(
							select  max(fecha) from publicacion));
