-- Estos triggers se encargan de insertar los valores
-- indicados a las tablas que requieran del ID de un registro 
-- reciente por ejemplo:
-- Cuando se registra un nuevo articulo se debe relacionar con la 
-- tabla intermedia autor_articulo, revisado articulo y se debe 
-- generar su nueva entrada en el historico tomando el valor actual
-- de la secuencia


CREATE OR REPLACE TRIGGER TRG_AUTOR_ARTICULO 
BEFORE INSERT ON AUTOR_ARTICULO 
FOR EACH ROW
BEGIN
  :NEW.ARTICULO_ID := articulo_seq.currval;
END;
/
Prompt TRG_AUTOR_ARTICULO

CREATE OR REPLACE TRIGGER TRG_REVISADO_ARTICULO 
BEFORE INSERT ON REVISADO_ARTICULO 
FOR EACH ROW
BEGIN
  :NEW.ARTICULO_ID := articulo_seq.currval;
END;
/

Prompt TRG_REVISADO_ARTICULO
-- Para publicacion suscriptor se debe tomar el valor 
-- del registro de publicacion
-- mas reciente por lo que se debe de insertar el valor actual 
-- de la secuencia de publicacion cuando se crea un nuevo registro
-- en la tabla intermedia

CREATE OR REPLACE TRIGGER TRG_PUBLICACION_SUSCRIPTOR 
BEFORE INSERT ON PUBLICACION_SUSCRIPTOR 
FOR EACH ROW
BEGIN
  :NEW.PUBLICACION_ID := PUBLICACION_SEQ.currval;
END;
/

Prompt TRG_PUBLICACION_SUSCRIPTOR

-- Lo mismo para la publicacion articulo, el ID del articulo se tiene
-- que relacionar con el ID de la publicacion mas reciente una vez
-- que es aceptado

CREATE OR REPLACE TRIGGER TRG_PUBLICACION_ARTICULO
BEFORE INSERT ON PUBLICACION_ARTICULO
FOR EACH ROW
BEGIN
  :NEW.PUBLICACION_ID := PUBLICACION_SEQ.currval;
END;
/

Prompt TRG_PUBLICACION_ARTICULO
--Este trigger crea un registro nuevo en historico cada que se realiza
-- un UPDATE en el status de un articulo o INSERT en la tabla articulo
CREATE OR REPLACE TRIGGER TRG_HISTORICO_STATUS
BEFORE INSERT OR UPDATE OF status_id ON ARTICULO
FOR EACH ROW
DECLARE
v_historico_id	NUMBER(30);
v_status_id 	NUMBER(30);
v_articulo_id	NUMBER(30);
v_fecha_status	DATE;
BEGIN
	SELECT historico_seq.nextval INTO v_historico_id FROM dual;
	v_status_id := :NEW.status_id;
	v_articulo_id := :NEW.articulo_id;
	v_fecha_status := SYSDATE;

	DBMS_OUTPUT.PUT_LINE('STATUS ANTERIOR' || :OLD.status_id);
	DBMS_OUTPUT.PUT_LINE('STATUS NUEVO' || :NEW.status_id);
	DBMS_OUTPUT.PUT_LINE('INSERTANDO EN HISTORICO, HISTORICO ID: ' 
		|| v_historico_id || ' STATUS ID: ' || v_status_id
		|| ' FECHA: ' || v_fecha_status || ' ARTICULO ID: '
		|| v_articulo_id);

	-- Insertando el registro en el historico
	INSERT into historico 
	(historico_id, status_id, articulo_id, fecha)
	VALUES 
	(v_historico_id, v_status_id, v_articulo_id, v_fecha_status);
END;
/
Prompt TRG_HISTORICO_STATUS
