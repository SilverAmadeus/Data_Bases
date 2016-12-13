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


create or replace PROCEDURE reg_empleado_Editor
	(
	v_nombre 		IN 	varchar2,
	v_ap_paterno	IN 	varchar2,
	v_ap_materno	IN 	varchar2,
	v_fecha_ingreso IN  date,
	v_grado			IN 	varchar2,
	v_email			IN 	varchar2,
	v_cedula		IN  number
	)
	AS
BEGIN
	insert into empleado (es_revisor, es_editor, nombre,
		apellido_paterno, apellido_materno, fecha_ingreso)
	values (0, 1, v_nombre, v_ap_paterno, 
		v_ap_materno, TO_DATE(v_fecha_ingreso,'DD/MM/YYYY'));
	insert into editor (empleado_id, grado, email, cedula)
	values (empleado_seq.CURRVAL, v_grado, v_email, v_cedula);
  DBMS_OUTPUT.PUT_LINE('-- EDITOR REGISTRADO -- ');
  DBMS_OUTPUT.PUT_LINE(' | Empleado ID:         ' || empleado_seq.CURRVAL);
  DBMS_OUTPUT.PUT_LINE(' | Nombre:              ' || v_nombre);
  DBMS_OUTPUT.PUT_LINE(' | Apellido Paterno:    ' || v_ap_paterno);
  DBMS_OUTPUT.PUT_LINE(' | Apellido Materno:    ' || v_ap_materno);
  DBMS_OUTPUT.PUT_LINE(' | Fecha de Ingreso:    ' || v_fecha_ingreso); 
  DBMS_OUTPUT.PUT_LINE(' | Grado:               ' || v_grado);
  DBMS_OUTPUT.PUT_LINE(' | Email:               ' || v_email);
  DBMS_OUTPUT.PUT_LINE(' | Cedula:              ' || v_cedula);
END reg_empleado_Editor;
/
Prompt Procedimiento_reg_empleado_Editor

create or replace PROCEDURE reg_empleado_Revisor
	(
	v_nombre 		IN 	varchar2,
	v_ap_paterno	IN 	varchar2,
	v_ap_materno	IN 	varchar2,
	v_fecha_ingreso IN  date,
	v_num_contrato	IN 	number,
	v_email			IN 	varchar2,
	v_fin_contrato	IN  date
	)
	AS
BEGIN
	insert into empleado (es_revisor, es_editor, nombre,
		apellido_paterno, apellido_materno, fecha_ingreso)
	values (1, 0, v_nombre, v_ap_paterno, 
		v_ap_materno,TO_DATE(v_fecha_ingreso,'DD/MM/YYYY'));
	insert into revisor (empleado_id, num_contrato, email, fin_contrato)
	values (empleado_seq.CURRVAL, v_num_contrato, v_email, 
		TO_DATE(v_fin_contrato, 'DD/MM/YYYY') );
  DBMS_OUTPUT.PUT_LINE('-- REVISOR REGISTRADO -- ');
  DBMS_OUTPUT.PUT_LINE(' | Empleado ID:         ' || empleado_seq.CURRVAL);
  DBMS_OUTPUT.PUT_LINE(' | Nombre:              ' || v_nombre);
  DBMS_OUTPUT.PUT_LINE(' | Apellido Paterno:    ' || v_ap_paterno);
  DBMS_OUTPUT.PUT_LINE(' | Apellido Materno:    ' || v_ap_materno);
  DBMS_OUTPUT.PUT_LINE(' | Fecha de Ingreso:    ' || v_fecha_ingreso);
  DBMS_OUTPUT.PUT_LINE(' | # Contrato:	        ' || v_num_contrato);
  DBMS_OUTPUT.PUT_LINE(' | Email:               ' || v_email);
  DBMS_OUTPUT.PUT_LINE(' | Fin de Contrato:     ' || v_fin_contrato);
END reg_empleado_Revisor;
/
Prompt Procedimiento_reg_empleado_Revisor

create or replace PROCEDURE reg_revisor_area
	(
	v_area_de_interes_id IN	varchar2,
	v_revisor_id		IN 	varchar2,
	v_anios_experiencia IN number
	)
	AS
BEGIN
	insert into area_revisor(anios_experiencia,revisor_id,area_de_interes_id)
	values (v_anios_experiencia,v_revisor_id,v_area_de_interes_id);
	
  DBMS_OUTPUT.PUT_LINE('-- AREA-REVISOR REGISTRADO -- ');
  DBMS_OUTPUT.PUT_LINE(' | Area-Revisor:        ' || area_revisor_seq.CURRVAL);
  DBMS_OUTPUT.PUT_LINE(' | Reviso ID:           ' || v_revisor_id);
  DBMS_OUTPUT.PUT_LINE(' | Area ID:    			' || v_area_de_interes_id);
  DBMS_OUTPUT.PUT_LINE(' | Experiencia:    		' || v_anios_experiencia);
END reg_revisor_area;
/
Prompt Procedimiento_reg_empleado_Revisor



