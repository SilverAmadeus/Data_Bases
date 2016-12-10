--Por el momento ejecutar  como sysdba
CREATE USER moro_proy_admin 
IDENTIFIED BY moro QUOTA unlimited ON USERS;

--Alternativa 1
/*
GRANT create session, create table, create view, 
create synonym, create public synonym, create sequence, 
create procedure, create trigger, create user, alter user, 
drop any table, backup any table, select any table, 
insert any table, update any table, delete any table
to moro_proy_admin;

*/
--Alternativa 2
GRANT create session to moro_proy_admin;
GRANT create table to moro_proy_admin;
GRANT create view to moro_proy_admin;
GRANT create synonym to moro_proy_admin;
GRANT create public synonym to moro_proy_admin;
GRANT create procedure to moro_proy_admin;
GRANT create trigger to moro_proy_admin;
GRANT create sequence to moro_proy_admin;
GRANT drop any table to moro_proy_admin;
GRANT alter any table to moro_proy_admin;
GRANT select any table to moro_proy_admin;
GRANT insert any table to moro_proy_admin;
GRANT update any table to moro_proy_admin;
GRANT delete any table to moro_proy_admin;

Prompt Administrador creado

CREATE USER moro_proy_user 
IDENTIFIED BY moro;

GRANT create session to moro_proy_user;

Prompt Usuario creado
