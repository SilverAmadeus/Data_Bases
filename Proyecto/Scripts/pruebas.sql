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

-- Para probar el procedimiento reg_empleado_Editor
EXECUTE reg_empleado_Editor('Alan', 'Rodriguez', 'Garcia', 'Licenciado', 'alan@something.com', 12345);

EXECUTE reg_empleado_Editor('Ivan', 'Moreno', 'Tagle', 'Licenciado', 'ivan@something.com', 0666);

EXECUTE reg_empleado_Editor('George', 'R', 'Martin', 'Licenciado', 'jon@something.com', 0101);

select * from empleado e
JOIN editor ed on ed.empleado_id = e.empleado_id;

-- Para probar el procedimiento reg_empleado_Revisor
EXECUTE reg_empleado_Revisor('Rafael', 'Diez', 'Gutierrez', 6789, 'jon@something.com', '02/04/2018');
EXECUTE reg_empleado_Revisor('Marlon', 'Ochoa', 'Hernandez', 0117, NULL, '21/12/2019');

select * from empleado e
JOIN revisor r on r.empleado_id = e.empleado_id;

--Mostrando todos los registros en empleado
select * from empleado;

-- Para probar trigger de EMPLEADO
insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, editor_id,  status_id)
values(1059, 'Postgres', 'BDD', 10, 1 , 1);

insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, editor_id,  status_id)
values(1424, 'Oracle', 'BDD', 10, 1 , 1);


insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, editor_id,  status_id)
values(1999, 'PLSQL', 'BDD', 10, 1 , 1);

insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, editor_id,  status_id)
values(2999, 'VHDL', 'BDD', 10, 2 , 1);

insert into articulo 
(FOLIO, TITULO, SINOPSIS, area_de_interes_id, editor_id,  status_id)
values(2399, 'SONY', 'BDD', 10, 2 , 1);


UPDATE empleado
SET es_revisor = 1
WHERE empleado_id = 1;

UPDATE empleado
SET es_revisor = 1
WHERE empleado_id = 2;
select * from empleado;

