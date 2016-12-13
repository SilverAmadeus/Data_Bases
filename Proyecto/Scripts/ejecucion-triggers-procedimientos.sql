-- Probando Procedure reg_empleado_Revisor y reg_empleado_Editor
--Revisores
EXECUTE reg_empleado_Revisor('Eduardo','Carrasco','Garcia','02/02/2014',0256,'eduardo@something.com','20/03/2016');

EXECUTE reg_empleado_Revisor('Virgilio','Castro','Rendon','12/11/2016',9825,'virgilio@something.com','20/08/2016');

EXECUTE reg_empleado_Revisor('Miguel Angel','Esquivel','Hernandez','04/05/2014',4359,'miguel@something.com','20/01/2016');

EXECUTE reg_empleado_Revisor('Eric Ruben','Hernandez','Barrios','04/07/2016',2658,'eric@something.com','21/12/2016');

EXECUTE reg_empleado_Revisor('Carlos','Hernandez','Montes de OCA','04/08/2014',0468,null,'14/07/2016');

EXECUTE reg_empleado_Revisor('Isaias Abraham','Manzano','Cruz','20/12/2015',8798,null,'08/12/2016');

EXECUTE reg_empleado_Revisor('Victor','Martinez','Garcia','28/04/2015',2868,'victor@something.com','10/10/2016');

EXECUTE reg_empleado_Revisor('Rosa Maria','Munios','Alvarez','07/05/2016',6864,'rosa@something.com','20/07/2016');

EXECUTE reg_empleado_Revisor('Cesar Octavio','Ocampo','Garcia','09/09/2015',6884,'cesar@something.com','09/04/2016');

EXECUTE reg_empleado_Revisor('Jonatan','Pedroza','Buendia','07/05/2016',6826,'jonathan@something.com','19/04/2016');

--Editores
EXECUTE reg_empleado_Editor('Mauro Alejandro','Caballero','Sanchez','08/06/2014','Maestria','mauro@super.com',0123456789);

EXECUTE reg_empleado_Editor('Bruno','Jimenez','Gomez','04/05/2016','Maestria','burno@super.com',0654789351);

EXECUTE reg_empleado_Editor('Augusto','Mesa','Penia','20/11/2015','Doctorado','augusto@super.com',4589635487);

EXECUTE reg_empleado_Editor('Monserrat','Moreno','Diaz','27/03/2016','Doctorado','monserrat@super.com',6587569521);

EXECUTE reg_empleado_Editor('Marlon Octavio','Ochoa','Hernandez','25/02/2014','Doctorado','marlon@super.com',0684589632);

EXECUTE reg_empleado_Editor('Isaac','Rodriguez','Bribiesca','26/01/2015','Doctorado','isaac@super.com',9856321548);

EXECUTE reg_empleado_Editor('Alejandra','Vega','Lopez','05/09/2016','Maestria','alejandra@super.com',3689546985);

EXECUTE reg_empleado_Editor('Ivan Raphael','Moreno','Tagle','25/06/2015','Maestria','ivan@super.com',4599658423);

EXECUTE reg_empleado_Editor('Ulises','Viveros','Campos','17/08/2015','Doctorado','ulises@super.com',6356955215);

EXECUTE reg_empleado_Editor('Ricarno','Cano','Perez','13/02/2014','Maestria','ricardo@super.com',6985365245);

EXECUTE reg_empleado_Editor('Rafael','Diez Gutierrez','Gonzales','05/03/2016','Licenciatura','rafa@super.com',6985425698);

EXECUTE reg_empleado_Editor('Bernardo','ESteban','Coria','05/08/2015','Maestria','bernardo@super.com',9863540256);

EXECUTE reg_empleado_Editor('Juan Manuel','Garcia','Rodriguez','04/05/2014','Maestria','juan@super.com',6983654872);

EXECUTE reg_empleado_Editor('Jaime','Islas','Tolentino','04/06/2014','Doctorado','jaime@super.com',0965863215);

EXECUTE reg_empleado_Editor('Raul Rogelio','Limon','Hernandez','06/11/2015','Maestria','raul@super.com',6358965412);

select * from empleado e
JOIN editor ed ON ed.empleado_id = e.empleado_id;

select * from empleado e
JOIN revisor r ON r.empleado_id = e.empleado_id;

-- Probando Trigger TRG_PDF_AMOUT
INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A1');

INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A2');

INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A3');

INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A4');

INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A5');

--Levanta un error ya que ese articulo ya tiene 5 PDF
INSERT INTO PDF
(articulo_id, descripcion, clave)
values (1, 'Lejos del Fuego PDF', 'A1');

-- Probando trigger TRG_EDITOR_TO_REVISOR

UPDATE articulo
SET editor_id = 20
WHERE articulo_id = 1 OR
articulo_id = 2 OR
articulo_id = 3 OR 
articulo_id = 4 OR 
articulo_id = 5;

UPDATE articulo
SET editor_id = 22
WHERE articulo_id = 6 OR 
articulo_id = 7 OR 
articulo_id = 8;

UPDATE empleado
SET es_revisor = 1
WHERE empleado_id = 22;

UPDATE empleado
SET es_revisor = 1
WHERE empleado_id = 20;

-- LEVANTA ERROR ya que no ha editado 3 o mas articulo

UPDATE empleado
SET es_revisor = 1
WHERE empleado_id = 15;

-- Probando trigger_ TRG_HISTORICO_STATUS
UPDATE articulo
SET status_id = 2
WHERE articulo_id = 1;

--Probando procedimiento logonInformation
EXECUTE logonInformation;