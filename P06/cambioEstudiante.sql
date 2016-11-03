--Modificaciones tabla ESTUDIANTE

ALTER TABLE estudiante ADD (num_cuenta number(10,0));

ALTER TABLE oyente ADD CONSTRAINT num_ext_chk CHECK(num_extraordinarios>=10);

ALTER TABLE estudiante DISABLE CONSTRAINT TIPO_ESTUDIANTE_CHK;



