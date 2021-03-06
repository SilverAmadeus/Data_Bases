
create table AREA_DE_INTERES(
    "AREA DE INT_ID"  NUMBER(40, 0)    NOT NULL,
    DESCRIPCION       VARCHAR2(40)     NOT NULL,
    NOMBRE            VARCHAR2(40)     NOT NULL,
    CLAVE             VARCHAR2(40)     NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY ("AREA DE INT_ID")
)
;



-- 
-- TABLE: AREA_REVISOR 
--

create table AREA_REVISOR(
    AREA_REVISOR_ID    NUMBER(40, 0)    NOT NULL,
    A�OS_EXP           NUMBER(40, 0)    NOT NULL,
    EMPLEADO_ID        NUMBER(40, 0)    NOT NULL,
    "AREA DE INT_ID"   NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK14 PRIMARY KEY (AREA_REVISOR_ID)
)
;



-- 
-- TABLE: ARTICULO 
--

create table ARTICULO(
    articulo_id       NUMBER(40, 0)    NOT NULL,
    FOLIO             VARCHAR2(18)     NOT NULL,
    TITULO            VARCHAR2(40)     NOT NULL,
    SINOPSIS          VARCHAR2(40)     NOT NULL,
    "AREA DE INT_ID"  NUMBER(40, 0)    NOT NULL,
    EDITOR_ID         NUMBER(40, 0),
    STATUS_ID         NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (articulo_id)
)
;



-- 
-- TABLE: AUTOR 
--

create table AUTOR(
    articulo_id            NUMBER(40, 0)    NOT NULL,
    OCUPACION           VARCHAR2(40)     NOT NULL,
    INSTITUCION         VARCHAR2(40)     NOT NULL,
    NOMBRE              VARCHAR2(40)     NOT NULL,
    APELLIDO_PATERNO    VARCHAR2(40)     NOT NULL,
    APELLIDO_MATERNO    VARCHAR2(40)     NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (articulo_id)
)
;



-- 
-- TABLE: AUTOR_ARTICULO 
--

create table AUTOR_ARTICULO(
    AUTOR_articulo_id    NUMBER(40, 0)    NOT NULL,
    articulo_id             NUMBER(40, 0)    NOT NULL,
    articulo_id          NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (AUTOR_articulo_id)
)
;



-- 
-- TABLE: EDITOR 
--

create table EDITOR(
    EMPLEADO_ID    NUMBER(40, 0)    NOT NULL,
    GRADO          VARCHAR2(40)     NOT NULL,
    EMAIL          VARCHAR2(40)     NOT NULL,
    #CEDULA        NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY (EMPLEADO_ID)
)
;



-- 
-- TABLE: EMPLEADO 
--

create table EMPLEADO(
    EMPLEADO_ID      NUMBER(40, 0)    NOT NULL,
    ES_REVISOR       NUMBER(1, 0)     NOT NULL,
    ES_EDITOR        NUMBER(1, 0)     NOT NULL,
    NOMBRE           VARCHAR2(40)     NOT NULL,
    APELLIDO_PAT     VARCHAR2(40)     NOT NULL,
    APELLIDO_MAT     VARCHAR2(40)     NOT NULL,
    FECHA_INGRESO    DATE             NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (EMPLEADO_ID)
);


--Historico
create table historico(
    historico_id   NUMBER(40, 0)    NOT NULL,
    status_id      NUMBER(40, 0)    NOT NULL,
    articulo_id    NUMBER(40, 0)    NOT NULL,
    CONSTRAINT historico_pk PRIMARY KEY (historico_id)
);

--Pdf
create table pdf(
    pdf_id        NUMBER(40, 0)    NOT NULL,
    archivo       BLOB             NOT NULL,
    descripcion   VARCHAR2(140)    NOT NULL,
    clave         VARCHAR2(40)     NOT NULL,
    articulo_id   NUMBER(40, 0)    NOT NULL,
    CONSTRAINT pdf_pk PRIMARY KEY (pdf_id)
);

--Publicaci�n
create table publicacion(
    publicacion_id  NUMBER(40, 0)    NOT NULL,
    bimestre        VARCHAR2(40)     NOT NULL,
    fecha           DATE             NOT NULL,
    titulo          VARCHAR2(40)     NOT NULL,
    num_vendidos    NUMBER(40, 0)    NOT NULL,
    anio            NUMBER(40, 0)    NOT NULL,
    num_generados   NUMBER(40, 0)    NOT NULL,
    CONSTRAINT publicacion_pk PRIMARY KEY (publicacion_id)
);


--Publicaci�n-Art�culo
create table publicacion_articulo(
    publicacion_articulo_id     NUMBER(40, 0)    NOT NULL,
    articulo_id       NUMBER(40, 0)    NOT NULL,
    publicacion_id    NUMBER(40, 0)    NOT NULL,
    num_paginas        NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (publicacion_articulo_id)
)
;



-- 
-- TABLE: PUBLICACION_SUSCRIPTOR 
--

create table publicacion_suscriptor(
    publicacion_suscriptor_id    CHAR(40)         NOT NULL,
    SUSCRIPTOR_ID                NUMBER(40, 0)    NOT NULL,
    publicacion_id               NUMBER(40, 0)    NOT NULL,
    FECHA_ENVIO                  DATE             NOT NULL,
    CONSTRAINT PK18 PRIMARY KEY (publicacion_suscriptor_id)
)
;



-- 
-- TABLE: REVISADO_ARTICULO 
--

create table REVISADO_ARTICULO(
    REVISADO_articulo_id    NUMBER(40, 0)    NOT NULL,
    NOTIFICACION            BLOB,
    CALIFICACION            NUMBER(40, 0),
    REVISOR_ID              NUMBER(40, 0),
    articulo_id             NUMBER(40, 0)    NOT NULL,
    CONSTRAINT PK15 PRIMARY KEY (REVISADO_articulo_id)
)
;



-- 
-- TABLE: REVISOR 
--

create table REVISOR(
    EMPLEADO_ID     NUMBER(40, 0)    NOT NULL,
    #CONTRATO       NUMBER(40, 0)    NOT NULL,
    EMAIL           VARCHAR2(40),
    FIN_CONTRATO    DATE             NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY (EMPLEADO_ID)
)
;



-- 
-- TABLE: STATUS 
--

create table STATUS(
    STATUS_ID    NUMBER(40, 0)    NOT NULL,
    NOMBRE       VARCHAR2(40)     NOT NULL,
    CONSTRAINT PK20 PRIMARY KEY (STATUS_ID)
)
;



-- 
-- TABLE: SUSCRIPTOR 
--

create table SUSCRIPTOR(
    SUSCRIPTOR_ID             NUMBER(40, 0)    NOT NULL,
    NOMBRE                    VARCHAR2(40)     NOT NULL,
    "APELLIDO MATERNO"        VARCHAR2(40)     NOT NULL,
    "FECHA DE SUSCRIPCION"    DATE             NOT NULL,
    EMAIL                     VARCHAR2(40)     NOT NULL,
    "APELLIDO PATERNO"        VARCHAR2(40)     NOT NULL,
    "DURACION A LA VIGENCIA"  VARCHAR2(40)     NOT NULL,
    CALLE                     VARCHAR2(40)     NOT NULL,
    NUMERO                    NUMBER(40, 0)    NOT NULL,
    COLONIA                   VARCHAR2(40)     NOT NULL,
    CODIGO_POSTAL             NUMBER(40, 0)    NOT NULL,
    DELEGACION_MUNICIPIO      VARCHAR2(40)     NOT NULL,
    ESTADO                    VARCHAR2(40)     NOT NULL,
    CONSTRAINT PK17 PRIMARY KEY (SUSCRIPTOR_ID)
)
;



-- 
-- TABLE: AREA_REVISOR 
--

ALTER TABLE AREA_REVISOR ADD CONSTRAINT RefREVISOR15 
    FOREIGN KEY (EMPLEADO_ID)
    REFERENCES REVISOR(EMPLEADO_ID)
;

ALTER TABLE AREA_REVISOR ADD CONSTRAINT RefAREA_DE_INTERES16 
    FOREIGN KEY ("AREA DE INT_ID")
    REFERENCES "AREA DE INTERES"("AREA DE INT_ID")
;


-- 
-- TABLE: ARTICULO 
--

ALTER TABLE ARTICULO ADD CONSTRAINT RefAREA_DE_INTERES6 
    FOREIGN KEY ("AREA DE INT_ID")
    REFERENCES "AREA DE INTERES"("AREA DE INT_ID")
;

ALTER TABLE ARTICULO ADD CONSTRAINT RefEDITOR21 
    FOREIGN KEY (EDITOR_ID)
    REFERENCES EDITOR(EMPLEADO_ID)
;

ALTER TABLE ARTICULO ADD CONSTRAINT RefSTATUS28 
    FOREIGN KEY (STATUS_ID)
    REFERENCES STATUS(STATUS_ID)
;


-- 
-- TABLE: AUTOR_ARTICULO 
--

ALTER TABLE AUTOR_ARTICULO ADD CONSTRAINT RefAUTOR4 
    FOREIGN KEY (articulo_id)
    REFERENCES AUTOR(articulo_id)
;

ALTER TABLE AUTOR_ARTICULO ADD CONSTRAINT RefARTICULO5 
    FOREIGN KEY (articulo_id)
    REFERENCES ARTICULO(articulo_id)
;


-- 
-- TABLE: EDITOR 
--

ALTER TABLE EDITOR ADD CONSTRAINT RefEMPLEADO13 
    FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
;


-- 
-- TABLE: HISTORICO 
--

ALTER TABLE HISTORICO ADD CONSTRAINT RefSTATUS26 
    FOREIGN KEY (STATUS_ID)
    REFERENCES STATUS(STATUS_ID)
;

ALTER TABLE HISTORICO ADD CONSTRAINT RefARTICULO29 
    FOREIGN KEY (articulo_id)
    REFERENCES ARTICULO(articulo_id)
;


-- 
-- TABLE: PDF 
--

ALTER TABLE PDF ADD CONSTRAINT RefARTICULO30 
    FOREIGN KEY (articulo_id)
    REFERENCES ARTICULO(articulo_id)
;


-- 
-- TABLE: publicacion_articulo 
--

ALTER TABLE publicacion_articulo ADD CONSTRAINT RefARTICULO8 
    FOREIGN KEY (articulo_id)
    REFERENCES ARTICULO(articulo_id)
;

ALTER TABLE publicacion_articulo ADD CONSTRAINT RefPUBLICACION9 
    FOREIGN KEY (publicacion_id)
    REFERENCES PUBLICACION(publicacion_id)
;


-- 
-- TABLE: PUBLICACION_SUSCRIPTOR 
--

ALTER TABLE PUBLICACION_SUSCRIPTOR ADD CONSTRAINT RefSUSCRIPTOR23 
    FOREIGN KEY (SUSCRIPTOR_ID)
    REFERENCES SUSCRIPTOR(SUSCRIPTOR_ID)
;

ALTER TABLE PUBLICACION_SUSCRIPTOR ADD CONSTRAINT RefPUBLICACION24 
    FOREIGN KEY (publicacion_id)
    REFERENCES PUBLICACION(publicacion_id)
;


-- 
-- TABLE: REVISADO_ARTICULO 
--

ALTER TABLE REVISADO_ARTICULO ADD CONSTRAINT RefREVISOR17 
    FOREIGN KEY (REVISOR_ID)
    REFERENCES REVISOR(EMPLEADO_ID)
;

ALTER TABLE REVISADO_ARTICULO ADD CONSTRAINT RefARTICULO18 
    FOREIGN KEY (articulo_id)
    REFERENCES ARTICULO(articulo_id)
;


-- 
-- TABLE: REVISOR 
--

ALTER TABLE REVISOR ADD CONSTRAINT RefEMPLEADO14 
    FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
;


