create or replace PROCEDURE logonInformation IS
	v_nombre	varchar2(30);
	v_fecha		dba_users.last_login%TYPE;
BEGIN
	SELECT username, last_login INTO v_nombre, v_fecha
	FROM dba_users 
	WHERE username='MORO_PROY_USER';
	DBMS_OUTPUT.PUT_LINE('ULTIMO INICIO DE SESION DE: ' || v_nombre);
	DBMS_OUTPUT.PUT_LINE('FECHA Y LUGAR: ' || v_fecha);
END logonInformation;
/
Prompt Procedimiento_logonInformation

