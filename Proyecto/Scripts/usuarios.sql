CREATE USER moro_proy_admin 
IDENTIFIED BY moro QUOTA unlimited ON USERS;

GRANT create session, create table, create sequence to moro_proy_admin;


--CREATE USER moro_pro_user 
--IDENTIFIED BY moro QUOTA unlimited ON USERS;
--GRANT create session

