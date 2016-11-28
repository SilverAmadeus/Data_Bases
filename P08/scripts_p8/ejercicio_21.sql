/*21. Seleccionar todos los datos de la subasta que ha vendido el mayor número 
de artículos registrada en la base de datos.
R: La subasta que más vendió se realizó en Cuernavaca y vendió 6 artículos.*/
--Cuenta articulos
select s.subasta_id,s.nombre,lugar, count(*) as num_articulos from articulo a
join subasta s on a.subasta_id=s.subasta_id
group by s.subasta_id,s.nombre,lugar;
--Suma montos
select a.subasta_id, sum(sv.precio_venta) from articulo a
join subasta_venta sv on a.articulo_id=sv.articulo_id
group by a.subasta_id;
--Saca el maximo
select max(monto) as mayor from 
  (select a.subasta_id, sum(sv.precio_venta) as monto from articulo a
  join subasta_venta sv on a.articulo_id=sv.articulo_id
  group by a.subasta_id)q1;

--Terminada
select s.subasta_id,s.nombre,lugar, sum(sv.precio_venta) as monto,  count(*) as num_articulos from articulo a
join subasta s on a.subasta_id=s.subasta_id
join subasta_venta sv on a.articulo_id=sv.articulo_id
group by s.subasta_id,s.nombre,lugar
having sum(sv.precio_venta)=
  (select max(monto) as mayor from 
    (select a.subasta_id, sum(sv.precio_venta) as monto from articulo a
    join subasta_venta sv on a.articulo_id=sv.articulo_id
    group by a.subasta_id
    )q1
  );
  
  
  
  
