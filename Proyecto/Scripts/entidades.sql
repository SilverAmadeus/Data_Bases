-- Valores de default en las tablas pueden ser los de las secuencias
-- para los id

-- Checar si la PK de PDF puede ser el ID del articulo al que pertenece
--CHECK puede ir en STATUS

--connect moro_proy_admin/moro

Prompt ENTIDADES

--1)Autor
CREATE TABLE autor(
    autor_id            NUMBER       DEFAULT autor_seq.NEXTVAL,
    ocupacion           VARCHAR2(40) NOT NULL,
    institucion         VARCHAR2(40) NOT NULL,
    nombre              VARCHAR2(40) NOT NULL,
    apellido_paterno    VARCHAR2(40) NOT NULL,
    apellido_materno    VARCHAR2(40) ,
    CONSTRAINT autor_pk PRIMARY KEY (autor_id)
);
Prompt autor

--2) Empleado
CREATE TABLE empleado(
    empleado_id         NUMBER       DEFAULT empleado_seq.NEXTVAL,
    es_revisor          NUMBER(1, 0) NOT NULL,
    es_editor           NUMBER(1, 0) NOT NULL,
    nombre              VARCHAR2(40) NOT NULL,
    apellido_paterno    VARCHAR2(40) NOT NULL,
    apellido_materno    VARCHAR2(40) NOT NULL,
    fecha_ingreso       DATE         NOT NULL,
    CONSTRAINT empleado_pk PRIMARY KEY (empleado_id)
);
Prompt empleado

--3 )Publicación
CREATE TABLE publicacion(
    publicacion_id  NUMBER       DEFAULT publicacion_seq.NEXTVAL,
    bimestre        NUMBER(1)    NOT NULL,
    fecha           DATE         NOT NULL,
    titulo          VARCHAR2(60) NOT NULL,
    num_vendidos    NUMBER(30),
    anio            DATE         NOT NULL,
    num_generados   NUMBER(30)   NOT NULL,
    en_inventario as (num_generados-num_vendidos) VIRTUAL,
    CONSTRAINT publicacion_pk PRIMARY KEY (publicacion_id), 
    CONSTRAINT publicacion_bimestre_chk CHECK (bimestre between 1 and 6)
);

Prompt publicacion

--4) Status
CREATE TABLE status(
    status_id    NUMBER(30)    NOT NULL,
    clave        VARCHAR(4)    NOT NULL,
    nombre       VARCHAR2(15)  NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (status_id),
    CONSTRAINT status_clave_uk UNIQUE (clave)
);
Prompt status
--5) Suscriptor
CREATE TABLE suscriptor(
    suscriptor_id             NUMBER        DEFAULT suscriptor_seq.NEXTVAL,
    nombre                    VARCHAR2(40)  NOT NULL,
    apellido_paterno          VARCHAR2(40)  NOT NULL,
    apellido_materno          VARCHAR2(40)  NOT NULL,
    fecha_suscripcion         DATE          NOT NULL,
    email                     VARCHAR2(40)  NOT NULL,
    meses_vigencia            NUMBER(3)     NOT NULL,
    calle                     VARCHAR2(40)  NOT NULL,
    numero                    NUMBER(30)    NOT NULL,
    colonia                   VARCHAR2(40)  NOT NULL,
    codigo_postal             NUMBER(30)    NOT NULL,
    delegacion_municipio      VARCHAR2(40)  NOT NULL,
    estado                    VARCHAR2(40)  NOT NULL,
    fecha_vigencia as (ADD_MONTHS(fecha_suscripcion,meses_vigencia)) VIRTUAL,
    CONSTRAINT suscriptor_pk PRIMARY KEY (suscriptor_id)
);
Prompt suscriptor
--6) Area de Interés 
CREATE TABLE area_de_interes(
    area_de_interes_id  NUMBER        DEFAULT area_de_interes_seq.NEXTVAL,
    descripcion         VARCHAR2(40)  NOT NULL,
    clave               VARCHAR2(10)  NOT NULL,
    nombre              VARCHAR2(40)  NOT NULL,
    CONSTRAINT area_de_interes_pk PRIMARY KEY (area_de_interes_id),
    CONSTRAINT area_de_interes_clave_uk UNIQUE (clave)
);
Prompt area_de_interes

--7) Editor
CREATE TABLE editor(
    empleado_id    NUMBER(30)       NOT NULL,
    grado          VARCHAR2(40)     NOT NULL,
    email          VARCHAR2(40)     NOT NULL,
    cedula         NUMBER(30)       NOT NULL,
    CONSTRAINT editor_pk PRIMARY KEY (empleado_id),
    CONSTRAINT editor_empleado_fk 
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id),
    CONSTRAINT editor_cedula_uk UNIQUE (cedula)
);
Prompt editor

--8) Revisor
CREATE TABLE revisor(
    empleado_id     NUMBER(30)    NOT NULL,
    num_contrato    NUMBER(30)    NOT NULL,
    email           VARCHAR2(40),
    fin_contrato    DATE          NOT NULL,
    CONSTRAINT revisor_pk PRIMARY KEY (empleado_id),
    CONSTRAINT revisor_empleado_fk 
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id),
    CONSTRAINT revisor_num_contrato_uk UNIQUE (num_contrato)
);


-- DEPENDENT STUFF

--9) Area Revisor
CREATE TABLE area_revisor(
    area_revisor_id     NUMBER     DEFAULT area_revisor_seq.NEXTVAL,
    anios_experiencia   NUMBER(4)  NOT NULL,
    revisor_id          NUMBER(30) NOT NULL,
    area_de_interes_id  NUMBER(30) NOT NULL,
    CONSTRAINT area_revisor_pk PRIMARY KEY (area_revisor_id),
    CONSTRAINT area_revisor_empleado_fk 
    FOREIGN KEY (revisor_id) REFERENCES revisor(empleado_id),
    CONSTRAINT area_rev_area_de_int_fk 
    FOREIGN KEY (area_de_interes_id) REFERENCES area_de_interes(area_de_interes_id)
);
Prompt area_revisor

--10) Artículo
CREATE TABLE articulo(
    articulo_id         NUMBER        DEFAULT articulo_seq.NEXTVAL,
    folio               VARCHAR2(18)  NOT NULL,
    titulo              VARCHAR2(70)  NOT NULL,
    sinopsis            VARCHAR2(140)  NOT NULL,
    area_de_interes_id  NUMBER(30)    NOT NULL,
    ultima_actualizacion DATE         NOT NULL,
    status_id           NUMBER(30)    DEFAULT 1, --Siempre que se registra se asigna el status RECIBIDO
    editor_id           NUMBER(30), 
    CONSTRAINT articulo_pk PRIMARY KEY (articulo_id),
    CONSTRAINT articulo_area_interes_fk 
    FOREIGN KEY (area_de_interes_id) REFERENCES area_de_interes(area_de_interes_id),
    CONSTRAINT articulo_editor_fk 
    FOREIGN KEY (editor_id) REFERENCES editor(empleado_id),
    CONSTRAINT articulo_status_fk 
    FOREIGN KEY (status_id) REFERENCES status(status_id)
);
--CONSTRAINT articulo_folio_uk UNIQUE (folio) <-- Se elimino porque existe un indice para folio
Prompt articulo

--11) Autor Artículo
CREATE TABLE autor_articulo(
    autor_articulo_id    NUMBER     DEFAULT autor_articulo_seq.NEXTVAL,
    autor_id             NUMBER(30) NOT NULL,
    articulo_id          NUMBER(30) NOT NULL,
    CONSTRAINT autor_articulo_pk PRIMARY KEY (autor_articulo_id),
    CONSTRAINT autor_articulo_autor_fk 
    FOREIGN KEY (autor_id) REFERENCES autor(autor_id),
    CONSTRAINT autor_articulo_articulo_fk 
    FOREIGN KEY (articulo_id) REFERENCES articulo(articulo_id)
);
Prompt autor_articulo

--12) Historico
CREATE TABLE historico(
    historico_id   NUMBER      DEFAULT historico_seq.NEXTVAL,
    status_id      NUMBER(30)  NOT NULL,
    articulo_id    NUMBER(30)  NOT NULL,
    fecha          DATE        NOT NULL,
    CONSTRAINT historico_pk PRIMARY KEY (historico_id),
    CONSTRAINT historico_status_fk FOREIGN KEY (status_id)
    REFERENCES status(status_id),
    CONSTRAINT historico_articulo_fk FOREIGN KEY (articulo_id)
    REFERENCES articulo(articulo_id)
);
Prompt historico

--13) Pdf
CREATE TABLE pdf(
    articulo_id   NUMBER        DEFAULT pdf_seq.NEXTVAL,
    pdf_id        NUMBER(30)    NOT NULL,
    archivo       BLOB          NOT NULL, 
    descripcion   VARCHAR2(140) NOT NULL,
    clave         VARCHAR2(2)   NOT NULL,--A1,..A5
    CONSTRAINT pdf_pk PRIMARY KEY (pdf_id),
    CONSTRAINT pdf_articulo_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id),
    CONSTRAINT pdf_clave_chk CHECK (clave IN ('A1','A2','A3','A4','A5'))
);
Prompt PDF

--14) Publicación-Artículo
CREATE TABLE publicacion_articulo(
    publicacion_articulo_id     NUMBER     DEFAULT publicacion_articulo_seq.NEXTVAL,
    articulo_id                 NUMBER(30) NOT NULL,
    publicacion_id              NUMBER(30) NOT NULL,
    num_pagina                  NUMBER(30) NOT NULL,
    CONSTRAINT publicacion_articulo_pk PRIMARY KEY (publicacion_articulo_id),
    CONSTRAINT pub_articulo_articulo_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id),
    CONSTRAINT pub_articulo_publicacion_fk FOREIGN KEY (publicacion_id) 
    REFERENCES publicacion(publicacion_id)
);
Prompt publicacion_articulo

--CONSTRAINT publicacion_num_paginas_chk CHECK (num_pagina>0)

--15) Publicacion-Suscriptor
CREATE TABLE publicacion_suscriptor(
    publicacion_suscriptor_id    NUMBER     DEFAULT publicacion_suscriptor_seq.NEXTVAL,
    suscriptor_id                NUMBER(30) NOT NULL,
    publicacion_id               NUMBER(30) NOT NULL,
    fecha_envio                  DATE       NOT NULL,
    CONSTRAINT publicacion_suscriptor_pk PRIMARY KEY (publicacion_suscriptor_id),
    CONSTRAINT pub_suscriptor_suscriptor_fk FOREIGN KEY (suscriptor_id) 
    REFERENCES suscriptor(suscriptor_id),
    CONSTRAINT pub_suscriptor_publicacion_fk FOREIGN KEY (publicacion_id) 
    REFERENCES publicacion(publicacion_id)
);
Prompt publicacion_suscriptor

--16) Revisado-Articulo
CREATE TABLE revisado_articulo(
    revisado_articulo_id    NUMBER      DEFAULT revisado_articulo_seq.NEXTVAL,
    notificacion            BLOB ,
    calificacion            NUMBER(30),
    revisor_id              NUMBER(30),
    articulo_id             NUMBER(30)  NOT NULL,
    CONSTRAINT revisado_articulo_pk PRIMARY KEY (revisado_articulo_id),
    CONSTRAINT rev_articulo_revisor_id_fk FOREIGN KEY (revisor_id) 
    REFERENCES revisor(empleado_id),
    CONSTRAINT rev_articulo_articulo_id_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id)    
);
Prompt revisado_articulo
