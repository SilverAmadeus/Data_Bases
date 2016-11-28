--9. SUBMEX ha decido incrementar en un 10% el precio inicial de todos aquellos artículos arqueológicos
--que tengan mas de 150 años de antigüedad y que aun no se han incluido en un proceso de subasta, es
--decir, solo se han registrado en la BD. Determine id, nombre, clave, status, año de hallazgo, y antigüedad
--en años de dichos artículos.
--R: Se deben obtener al menos 7 artículos.

select a.articulo_id, nombre, clave_articulo, clave, anio_hallazgo,to_number(to_char(sysdate,'YYYY')-anio_hallazgo) as antiguedad
from articulo a,status_articulo sa, articulo_arqueologico aa
where  aa.articulo_id=a.articulo_id 
and a.status_articulo_id=sa.status_articulo_id
and  to_number(to_char(sysdate,'YYYY')-anio_hallazgo)> 150
and clave='REGISTRADO';

select a.articulo_id, nombre,clave_articulo, clave, anio_hallazgo, antiguedad
from articulo a,
  (select articulo_id,sum(to_number(to_char(sysdate,'YYYY'))-anio_hallazgo) as antiguedad 
  from articulo_arqueologico
  group by articulo_id
  having sum(to_number(to_char(sysdate,'YYYY'))-anio_hallazgo)>150) q1,
articulo_arqueologico aa, status_articulo sa  
where q1.articulo_id=a.articulo_id
and aa.articulo_id=a.articulo_id
and a.status_articulo_id=sa.status_articulo_id
and clave = 'REGISTRADO';


