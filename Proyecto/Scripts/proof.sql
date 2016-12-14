CREATE GLOBAL TEMPORARY TABLE suscriptor_tmp(
    suscriptor_id     NUMBER(30),
    nombre            VARCHAR2(40),
    apellido_paterno  VARCHAR2(40),
    apellido_materno  VARCHAR2(40),
    email             VARCHAR2(40)
);

INSERT INTO suscriptor_tmp SELECT suscriptor_id,nombre,apellido_paterno,apellido_materno,email 
from suscriptor where fecha_vigencia>=sysdate;


create or replace trigger TRG_PUBLICACION
AFTER INSERT ON publicacion
FOR EACH ROW
DECLARE 
	
	CURSOR cur_suscriptor_valido IS select suscriptor_id from suscriptor_tmp;
	v_suscriptor_id 	suscriptor_tmp.suscriptor_id%type;

BEGIN
	OPEN cur_suscriptor_valido;
	DBMS_OUTPUT.PUT_LINE('SUSCRIPTORES VALIDOS');
	DBMS_OUTPUT.PUT_LINE('|| SUSCRIPTOR ID ||');
	LOOP
		FETCH cur_suscriptor_valido INTO v_suscriptor_id;
		EXIT WHEN cur_suscriptor_valido%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' '||v_suscriptor_id||' ');
		INSERT INTO publicacion_suscriptor(publicacion_suscriptor_id,publicacion_id,fecha_envio)
		VALUES (publicacion_suscriptor_seq.NEXTVAL,v_suscriptor_id,:NEW.publicacion_id,sysdate+10);
	END LOOP; 
	CLOSE cur_suscriptor_valido;
END;
/
