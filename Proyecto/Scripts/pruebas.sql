insert into autor
(ocupacion, institucion, nombre, apellido_paterno, apellido_materno)
VALUES ('Escritor', 'UK COLLEGE', 'Erick', 'Lecarde', 'Belmont');

insert into area_de_interes
(descripcion, nombre, clave)
VALUES ('Filosofia moderna', 'Filosofia', 'FIL');

-- Tenemos que llenar la tabla status con todos los status posibles 
insert into status
(status_id, CLAVE ,nombre)
VALUES (1,'REC', 'RECIBIDO');

insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, status_id)
values(6969, 'Simulacra and Simulation', 'What is real?', 10, 1);


insert into autor_articulo (autor_id)
VALUES (1);

-- Para probar el trigger
insert into status
(status_id, CLAVE ,nombre)
VALUES (2,'REV', 'REVISADO');

UPDATE articulo
SET status_id = 2
WHERE articulo_id = 7;

EXECUTE logonInformation;
