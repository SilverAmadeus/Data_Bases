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



create or replace trigger TRG_PUBLICACION_ARTICULO
BEFORE UPDATE of status_id ON ARTICULO
FOR EACH ROW
DECLARE
  CURSOR cur_calificacion_articulo IS
    select calificacion from revisado_articulo
    WHERE articulo_id = :NEW.articulo_id;
  
  v_calificacion NUMBER(30, 0);
BEGIN
  OPEN cur_calificacion_articulo;
  FETCH cur_calificacion_articulo INTO v_calificacion;
  CASE :NEW.status_id
    WHEN 4 THEN
      IF (v_calificacion >= 8) THEN
        DBMS_OUTPUT.PUT_LINE('ARTICULO CON ID: ' || :new.ARTICULO_id ||
        ' TIENE STATUS PROGRAMADO, ASIGNE A UNA PUBLICACION');
      ELSE
        RAISE_APPLICATION_ERROR(-20020, 'ARTICULO NO TIENE CALIFICACION O ES MENOR A 8');
      END IF;
    WHEN 5 THEN
      IF (v_calificacion >= 8) THEN
        DBMS_OUTPUT.PUT_LINE('ARTICULO CON ID: ' || :new.ARTICULO_id ||
        ' TIENE STATUS PUBLICADO');
      ELSE
            RAISE_APPLICATION_ERROR(-20020, 'ARTICULO NO TIENE CALIFICACION O ES MENOR A 8');
      END IF;
     ELSE
     	NULL;
  END CASE;
  CLOSE cur_calificacion_articulo;
END;
/
Prompt TRG_PUBLICACION_ARTICULO

--Este trigger crea un registro nuevo en historico cada que se realiza
-- un UPDATE en el status de un articulo o INSERT en la tabla articulo
CREATE OR REPLACE TRIGGER TRG_HISTORICO_STATUS
AFTER INSERT OR UPDATE OF status_id ON ARTICULO
FOR EACH ROW
DECLARE
v_historico_id	NUMBER(30);
v_status_id 	NUMBER(30);
v_articulo_id	NUMBER(30);
v_fecha_status	DATE;
BEGIN
	SELECT historico_seq.nextval INTO v_historico_id FROM dual;--AWESOME!!
	v_status_id := :NEW.status_id;
	v_articulo_id := :NEW.articulo_id;
	v_fecha_status := :NEW.ultima_actualizacion; --Manejar como SYSDATE en la insercion, lo cambie porque abria conflicto al 

	DBMS_OUTPUT.PUT_LINE('STATUS ANTERIOR ' || :OLD.status_id);
	DBMS_OUTPUT.PUT_LINE('STATUS NUEVO ' || :NEW.status_id);
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

create or replace trigger TRG_EDITOR_TO_REVISOR
BEFORE UPDATE OF es_revisor ON EMPLEADO
FOR EACH ROW
DECLARE
	CURSOR cur_revisor_update IS
		select editor_id, folio, titulo from articulo
		WHERE editor_id = :NEW.empleado_id;
	v_editor_id		articulo.editor_id%type;
	v_folio 		articulo.folio%type;
	v_titulo		articulo.titulo%type;
BEGIN
	OPEN cur_revisor_update;
	DBMS_OUTPUT.PUT_LINE('ARTICULOS QUE HA EDITADO');
	DBMS_OUTPUT.PUT_LINE('|| EDITOR ID || FOLIO || TITULO ||');
	LOOP
		FETCH cur_revisor_update INTO v_editor_id, v_folio, v_titulo;
		EXIT WHEN cur_revisor_update%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('	'||v_editor_id || '	' ||
			v_folio || '	' || v_titulo);
	END LOOP;
	IF (cur_revisor_update%ROWCOUNT < 3) THEN
		CLOSE cur_revisor_update;
    RAISE_APPLICATION_ERROR(-20010, 'EDITOR ID: '||
    :new.empleado_id ||' HA EDITADO MENOS DE 3 ARTICULOS');
    rollback;
	ELSE
		CLOSE cur_revisor_update;
		DBMS_OUTPUT.PUT_LINE('EDITOR CON ID '|| :new.empleado_id
			||' AHORA ES REVISOR');
  END IF;
END;
/
Prompt TRG_EDITOR_TO_REVISOR

create or replace trigger TRG_PDF_AMOUNT
BEFORE INSERT on PDF
FOR EACH ROW
DECLARE
	CURSOR cur_pdf_amount IS
		select pdf_id from PDF
		WHERE articulo_id = :NEW.articulo_id;
	v_pdf_id	pdf.pdf_id%type;
BEGIN
	OPEN cur_pdf_amount;
	DBMS_OUTPUT.PUT_LINE('PDF IDs de ARTICULO ID '|| :NEW.articulo_id);
	LOOP
		FETCH cur_pdf_amount INTO v_pdf_id;
		EXIT WHEN cur_pdf_amount%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_pdf_id);
	END LOOP;

	IF (cur_pdf_amount%ROWCOUNT >= 5) THEN
		CLOSE cur_pdf_amount;
		RAISE_APPLICATION_ERROR(-20000, 'ARTICULO CON ID ' || :NEW.articulo_id || 
    ' CUENTA CON EL MAXIMO DE PDFs');
		rollback;
	ELSE
		CLOSE cur_pdf_amount;
		DBMS_OUTPUT.PUT_LINE('PDF REGISTRADO EXITOSAMENTE');
	END IF;
END;
/
Prompt TRG_PDF_AMOUNT

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
		INSERT INTO publicacion_suscriptor(suscriptor_id, publicacion_id, fecha_envio)
		VALUES (v_suscriptor_id, :NEW.publicacion_id, sysdate+10);
	END LOOP; 
	CLOSE cur_suscriptor_valido;
END;
/
