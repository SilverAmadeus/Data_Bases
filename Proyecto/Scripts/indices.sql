CREATE UNIQUE INDEX idx_articulo_folio ON articulo (folio);

CREATE UNIQUE INDEX idx_publicacion_titulo ON publicacion(LOWER(titulo));

CREATE UNIQUE INDEX idx_autor_apellido_paterno ON autor (LOWER(apellido_paterno));

CREATE UNIQUE INDEX idx_empleado_apellido_paterno ON empleado (LOWER(apellido_paterno));
