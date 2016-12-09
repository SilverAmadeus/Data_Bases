-- Valores de default en las tablas pueden ser los de las secuencias
-- para los id

-- Checar si la PK de PDF puede ser el ID del articulo al que pertenece
--CHECK puede ir en STATUS


--1)Autor
create table autor(
    autor_id            NUMBER(30)       NOT NULL,
    ocupacion           VARCHAR2(40)     NOT NULL,
    institucion         VARCHAR2(40)     NOT NULL,
    nombre              VARCHAR2(40)     NOT NULL,
    apellido_materno    VARCHAR2(40)     NOT NULL,
    apellido_paterno    VARCHAR2(40)     NOT NULL,
    CONSTRAINT autor_pk PRIMARY KEY (autor_id)
);

--2) Empleado
create table empleado(
    empleado_id         NUMBER(30)       NOT NULL,
    es_revisor          NUMBER(1, 0)     NOT NULL,
    es_editor           NUMBER(1, 0)     NOT NULL,
    nombre              VARCHAR2(40)     NOT NULL,
    apellido_paterno    VARCHAR2(40)     NOT NULL,
    apellido_materno    VARCHAR2(40)     NOT NULL,
    fecha_ingreso       DATE             NOT NULL,
    CONSTRAINT empleado_pk PRIMARY KEY (empleado_id)
);

--3 )Publicación
create table publicacion(
    publicacion_id  NUMBER(30)    NOT NULL,
    bimestre        VARCHAR2(40)  NOT NULL,--Checar tipo de dato
    fecha           DATE          NOT NULL,
    titulo          VARCHAR2(40)  NOT NULL,
    num_vendidos    NUMBER(30)    NULL,
    anio            NUMBER(30)    NOT NULL,
    num_generados   NUMBER(30)    NOT NULL,
    CONSTRAINT publicacion_pk PRIMARY KEY (publicacion_id)
);


--4) Status
create table status(
    status_id    NUMBER(30)    NOT NULL,
    nombre       VARCHAR2(40)     NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (status_id)
);

--5) Suscriptor
create table suscriptor(
    suscriptor_id             NUMBER(30)       NOT NULL,
    nombre                    VARCHAR2(40)     NOT NULL,
    apellido_paterno          VARCHAR2(40)     NOT NULL,
    apellido_materno          VARCHAR2(40)     NOT NULL,
    fecha_suscripcion         DATE             NOT NULL,
    email                     VARCHAR2(40)     NOT NULL,
    vigencia                  VARCHAR2(40)     NOT NULL,
    calle                     VARCHAR2(40)     NOT NULL,
    numero                    NUMBER(30)       NOT NULL,
    colonia                   VARCHAR2(40)     NOT NULL,
    codigo_postal             NUMBER(30)       NOT NULL,
    delegacion_municipio      VARCHAR2(40)     NOT NULL,
    estado                    VARCHAR2(40)     NOT NULL,
    CONSTRAINT suscriptor_pk PRIMARY KEY (suscriptor_id)
);

--6) Area de Interés 
create table area_de_interes(
    area_de_interes_id  NUMBER(30)    NOT NULL,
    descripcion         VARCHAR2(40)  NOT NULL,
    nombre              VARCHAR2(40)  NOT NULL,
    clave               VARCHAR2(40)  NOT NULL,
    CONSTRAINT area_de_interes_pk PRIMARY KEY (area_de_interes_id),
    CONSTRAINT area_de_interes_clave_uk UNIQUE (clave)
);

--7) Editor
create table editor(
    empleado_id    NUMBER(30)       NOT NULL,
    grado          VARCHAR2(40)     NOT NULL,
    email          VARCHAR2(40)     NOT NULL,
    cedula         NUMBER(30)       NOT NULL,
    CONSTRAINT editor_pk PRIMARY KEY (empleado_id),
    CONSTRAINT editor_empleado_fk 
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id),
    CONSTRAINT editor_cedula_uk UNIQUE (cedula)
);

--8) Revisor
create table revisor(
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
create table area_revisor(
    area_revisor_id     NUMBER(30)    NOT NULL,
    anios_experiencia   NUMBER(4)     NOT NULL,
    revisor_id          NUMBER(30)    NOT NULL,
    area_de_interes_id  NUMBER(30)    NOT NULL,
    CONSTRAINT area_revisor_pk PRIMARY KEY (area_revisor_id),
    CONSTRAINT area_revisor_empleado_fk 
    FOREIGN KEY (revisor_id) REFERENCES revisor(empleado_id),
    CONSTRAINT area_rev_area_de_int_fk 
    FOREIGN KEY (area_de_interes_id) REFERENCES area_de_interes(area_de_interes_id)
);

--10) Artículo
create table articulo(
    articulo_id         NUMBER(30)    NOT NULL,
    folio               VARCHAR2(18)  NOT NULL,
    titulo              VARCHAR2(40)  NOT NULL,
    sinopsis            VARCHAR2(40)  NOT NULL,
    area_de_interes_id  NUMBER(30)    NOT NULL,
    status_id           NUMBER(30)    NOT NULL,
    editor_id           NUMBER(30), 
    CONSTRAINT articulo_pk PRIMARY KEY (articulo_id),
    CONSTRAINT articulo_area_interes_fk 
    FOREIGN KEY (area_de_interes_id) REFERENCES area_de_interes(area_de_interes_id),
    CONSTRAINT articulo_editor_fk 
    FOREIGN KEY (editor_id) REFERENCES editor(empleado_id),
    CONSTRAINT articulo_status_fk 
    FOREIGN KEY (status_id) REFERENCES status(status_id)
);


--11) Autor Artículo
create table autor_articulo(
    autor_articulo_id    NUMBER(30)    NOT NULL,
    autor_id             NUMBER(30)    NOT NULL,
    articulo_id          NUMBER(30)    NOT NULL,
    CONSTRAINT autor_articulo_pk PRIMARY KEY (autor_articulo_id),
    CONSTRAINT autor_articulo_autor_fk 
    FOREIGN KEY (autor_id) REFERENCES autor(autor_id),
    CONSTRAINT autor_articulo_articulo_fk 
    FOREIGN KEY (articulo_id) REFERENCES articulo(articulo_id)
);


--12) Historico
create table historico(
    historico_id   NUMBER(30)    NOT NULL,
    status_id      NUMBER(30)    NOT NULL,
    articulo_id    NUMBER(30)    NOT NULL,
    CONSTRAINT historico_pk PRIMARY KEY (historico_id),
    CONSTRAINT historico_status_fk FOREIGN KEY (status_id)
    REFERENCES status(status_id),
    CONSTRAINT historico_articulo_fk FOREIGN KEY (articulo_id)
    REFERENCES articulo(articulo_id)
);

--13) Pdf
create table pdf(
    pdf_id        NUMBER(30)       NOT NULL,
    archivo       BLOB             NOT NULL, --checar el tipo de dato
    descripcion   VARCHAR2(140)    NOT NULL,
    clave         VARCHAR2(40)     NOT NULL,
    articulo_id   NUMBER(30)       NOT NULL,
    CONSTRAINT pdf_pk PRIMARY KEY (pdf_id),
    CONSTRAINT pdf_articulo_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id),
    CONSTRAINT pdf_clave_uk UNIQUE (clave)
);


--14) Publicación-Artículo
create table publicacion_articulo(
    publicacion_articulo_id     NUMBER(30)    NOT NULL,
    articulo_id                 NUMBER(30)    NOT NULL,
    publicacion_id              NUMBER(30)    NOT NULL,
    num_paginas                 NUMBER(30)    NOT NULL,
    CONSTRAINT publicacion_articulo_pk PRIMARY KEY (publicacion_articulo_id),
    CONSTRAINT pub_articulo_articulo_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id),
    CONSTRAINT pub_articulo_publicacion_fk FOREIGN KEY (publicacion_id) 
    REFERENCES publicacion(publicacion_id)
);

--15) Publicacion-Suscriptor
create table publicacion_suscriptor(
    publicacion_suscriptor_id    CHAR(40)      NOT NULL,
    suscriptor_id                NUMBER(30)    NOT NULL,
    publicacion_id               NUMBER(30)    NOT NULL,
    fecha_envio                  DATE          NOT NULL,
    CONSTRAINT publicacion_suscriptor_pk PRIMARY KEY (publicacion_suscriptor_id),
    CONSTRAINT pub_suscriptor_suscriptor_fk FOREIGN KEY (suscriptor_id) 
    REFERENCES suscriptor(suscriptor_id),
    CONSTRAINT pub_suscriptor_publicacion_fk FOREIGN KEY (publicacion_id) 
    REFERENCES publicacion(publicacion_id)
);

--16) Revisado-Articulo
create table revisado_articulo(
    revisado_articulo_id    NUMBER(30)    NOT NULL,
    notificacion            BLOB , --Checar el tipo de dato.
    calificacion            NUMBER(30),
    revisor_id              NUMBER(30),
    articulo_id             NUMBER(30)    NOT NULL,
    CONSTRAINT revisado_articulo_pk PRIMARY KEY (revisado_articulo_id),
    CONSTRAINT rev_articulo_revisor_id_fk FOREIGN KEY (revisor_id) 
    REFERENCES revisor(empleado_id),
    CONSTRAINT rev_articulo_articulo_id_fk FOREIGN KEY (articulo_id) 
    REFERENCES articulo(articulo_id)    
);