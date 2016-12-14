--Sinonimos y privilegios para usuario
CREATE OR REPLACE PUBLIC SYNONYM user_articulo FOR articulo;
GRANT SELECT  ON user_articulo TO moro_proy_user;

CREATE OR REPLACE PUBLIC SYNONYM user_area FOR area_de_interes;
GRANT SELECT ON user_area TO moro_proy_user;

CREATE OR REPLACE PUBLIC SYNONYM user_pdf FOR pdf;
GRANT SELECT ON user_pdf TO moro_proy_user;

CREATE OR REPLACE PUBLIC SYNONYM user_publi_art FOR publicacion_articulo;
GRANT SELECT ON user_publi_art TO moro_proy_user;

CREATE OR REPLACE PUBLIC SYNONYM user_publicacion FOR publicacion;
GRANT SELECT ON user_publicacion TO moro_proy_user;

GRANT select on v_revisores to moro_proy_user;
GRANT select on v_editores to moro_proy_user;
GRANT SELECT on v_autor_folio to moro_proy_user;

--Sinonimos de Administrador


CREATE OR REPLACE SYNONYM autor_art FOR autor_articulo;
CREATE OR REPLACE SYNONYM area_rev FOR area_revisor;
CREATE OR REPLACE SYNONYM emp FOR empleado;
CREATE OR REPLACE SYNONYM edi FOR editor;
CREATE OR REPLACE SYNONYM rev FOR revisor;
CREATE OR REPLACE SYNONYM revi_art FOR revisado_articulo;
CREATE OR REPLACE SYNONYM publi_art FOR publicacion_articulo;
CREATE OR REPLACE SYNONYM publi FOR publicacion;
CREATE OR REPLACE SYNONYM suscri FOR suscriptor;
CREATE OR REPLACE SYNONYM publi_suscri FOR publicacion_suscriptor;
CREATE OR REPLACE SYNONYM revi_art FOR revisado_articulo;
