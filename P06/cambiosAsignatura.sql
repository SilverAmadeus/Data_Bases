--Cambios a tabla ASIGNATURA

ALTER TABLE asignatura RENAME COLUMN clave to clave_asignatura;

ALTER TABLE oyente_asignatura RENAME TO oyente_adeudo;
--Llave primaria artificial para OYENTE ADEDUEDO

--Se eliminan el constraint de llave primaria
ALTER TABLE oyente_adeudo DROP CONSTRAINT EST_OYE_ASIG_PK;

--Se crea el nuevo campo
ALTER TABLE oyente_adeudo ADD (oyente_adeudo_id NUMBER (10,0));

ALTER TABLE oyente_adeudo ADD CONSTRAINT oye_adeudo_pk PRIMARY KEY (oyente_adeudo_id);

ALTER TABLE oyente MODIFY (num_extraordinarios number(3,0));

