-- 1)
select a.nombre, a.clave_articulo, sa.clave from articulo_famoso af
JOIN articulo a ON af.articulo_id = a.articulo_id
JOIN status_articulo sa ON sa.status_articulo_id = a.status_articulo_id
WHERE af.nombre_completo = 'William Harvey';

-- 2)
select articulo_id, a.nombre, a.clave_articulo from status_articulo sa
JOIN articulo a USING (status_articulo_id)
NATURAL JOIN articulo_donado ad
JOIN pais p USING (pais_id)
WHERE sa.clave = 'ENTREGADO' AND p.descripcion = 'BELGICA';

-- 3)
select articulo_id, ar.nombre, ar.precio_inicial, sv.precio_venta, tipo_articulo,
s.nombre, s.fecha_inicio from cliente cl
NATURAL JOIN subasta_venta sv
JOIN articulo ar USING (articulo_id)
JOIN subasta s USING (subasta_id)
WHERE to_char(fecha_inicio, 'YYYY') >= 2010 
AND to_char(fecha_fin, 'YYYY') <= 2010 
AND cl.nombre = 'MARICELA' 
AND cl.apellido_paterno = 'PAEZ'
AND cl.apellido_materno = 'MARTINEZ';

-- 4)
select cl.nombre, cl.apellido_paterno, cl.apellido_materno, numero_tarjeta,
mes_vigencia, anio_vigencia from cliente cl
JOIN tarjeta_cliente tc ON cl.cliente_id = tc.cliente_id
WHERE (anio_vigencia <= 11
AND mes_vigencia < 11) OR (anio_vigencia < 11
AND mes_vigencia <= 12);

-- 5) LEFT OUTER JOIN de ARTICULO(izq) y Subasta_Venta ya que no todos
-- Los articulos arqueologicos han sido vendidos
select ar.nombre, clave_articulo, tipo_articulo, anio_hallazgo, precio_inicial,
precio_venta from articulo_arqueologico aa
JOIN articulo ar ON ar.articulo_id = aa.articulo_id
LEFT OUTER JOIN subasta_venta sv ON ar.articulo_id = sv.articulo_id
JOIN status_articulo sa ON sa.status_articulo_id = ar.status_articulo_id
WHERE precio_inicial >= 800000;

-- 6)
select nombre, apellido_paterno, apellido_materno, email, tipo_tarjeta from cliente c
LEFT OUTER JOIN tarjeta_cliente tc ON tc.cliente_id = c.cliente_id
WHERE OCUPACION ='ABOGADO'
ORDER BY tipo_tarjeta;

-- 7)
select articulo_id, nombre, clave_articulo, precio_inicial from articulo a
JOIN status_articulo sa ON a.status_articulo_id = sa.status_articulo_id
WHERE precio_inicial > 900000
INTERSECT 
select articulo_id, nombre, clave_articulo, precio_inicial from articulo a
JOIN status_articulo sa ON a.status_articulo_id = sa.status_articulo_id
WHERE clave = 'REGISTRADO';

-- 8)
select c.cliente_id, c.nombre, apellido_paterno, apellido_materno,
sum(precio_venta) as TOTAL, count(*) as NUM_ARTICULOS from cliente c
JOIN subasta_venta sv ON c.cliente_id = sv.cliente_id
JOIN articulo a ON a.articulo_id = sv.articulo_id
GROUP BY (c.cliente_id, c.nombre, apellido_paterno, apellido_materno)
HAVING sum(precio_venta) > 3000000
UNION
select c.cliente_id, c.nombre, apellido_paterno, apellido_materno,
sum(precio_venta) as TOTAL, count(*) as NUM_ARTICULOS from cliente c
JOIN subasta_venta sv ON c.cliente_id = sv.cliente_id
JOIN articulo a ON a.articulo_id = sv.articulo_id
GROUP BY (c.cliente_id, c.nombre, apellido_paterno, apellido_materno)
HAVING count(*) > 5;

-- 9)
select a.articulo_id, nombre from articulo_arqueologico aa
JOIN articulo a ON a.articulo_id = aa.articulo_id
JOIN status_articulo sa ON sa.status_articulo_id = a.status_articulo_id
WHERE clave = 'REGISTRADO' AND anio_hallazgo > 150;

-- 10)
select nombre, tipo_articulo, a.descripcion from articulo a 
JOIN status_articulo sa ON sa.status_articulo_id = a.status_articulo_id
WHERE (a.descripcion LIKE '%Colonial%') OR (a.nombre LIKE '%Colonial%')  
AND clave = 'EN SUBASTA';

-- 11)
select clave, tipo_articulo, count(*) as TOTAL from articulo a
JOIN status_articulo sa ON a.status_articulo_id = sa.status_articulo_id
GROUP BY clave, tipo_articulo
HAVING clave = 'VENDIDO' OR clave = 'ENTREGADO';

-- 12)
select s.nombre, fecha_inicio, lugar, tipo_articulo, sum(precio_venta) as TOTAL
from subasta s
JOIN articulo a ON s.subasta_id = a.subasta_id
JOIN subasta_venta sv ON a.articulo_id = sv.articulo_id
GROUP BY (s.nombre, fecha_inicio, lugar, tipo_articulo)
HAVING to_char(fecha_inicio, 'YY') = 09
ORDER BY sum(precio_venta) DESC;

-- 13)
select s.subasta_id, s.nombre, s.fecha_inicio, a.nombre, a.articulo_id, 
sv.precio_venta from subasta s, subasta_venta sv, articulo a, 
(
select s2.subasta_id, max(sv2.precio_venta) as PRECIO_MAS_ALTO from
subasta s2, articulo a2, subasta_venta sv2
WHERE s2.subasta_id = a2.subasta_id
AND a2.articulo_id = sv2.articulo_id
AND to_char(fecha_inicio, 'MM/YYYY') IN ('01/2010', '03/2010', '06/2010')
GROUP BY s2.subasta_id
) q1
WHERE s.subasta_id = a.subasta_id
AND sv.articulo_id = a.articulo_id
AND q1.subasta_id = s.subasta_id
AND sv.precio_venta = q1.PRECIO_MAS_ALTO;

-- 14)

select sum(sv.precio_venta) from cliente c
JOIN tarjeta_cliente tc ON tc.cliente_id = c.cliente_id
JOIN factura_cliente fc ON fc.tarjeta_cliente_id = tc.tarjeta_cliente_id
JOIN subasta_venta sv ON sv.factura_cliente_id  =fc.factura_cliente_id
WHERE c.cliente_id = 
(
select c2.cliente_id from cliente c2 
WHERE c2.nombre = 'GALILEA' 
AND c2.apellido_paterno = 'GOMEZ' 
AND c2.apellido_materno = 'GONZALEZ'
)
AND fc.fecha_factura=
(
select max(fc2.fecha_factura) from cliente c2
JOIN tarjeta_cliente tc2 ON tc2.cliente_id = c2.cliente_id
JOIN factura_cliente fc2 ON fc2.tarjeta_cliente_id =tc2.tarjeta_cliente_id
WHERE c2.cliente_id = c.cliente_id
);

-- 15)
select s.subasta_id, s.nombre, count(*) as articulos_vendidos 
from subasta s
JOIN articulo a ON s.subasta_id = a.subasta_id
JOIN subasta_venta sv ON a.articulo_id  = sv.articulo_id
WHERE to_char(s.fecha_inicio, 'YYYY') = '2010'
HAVING count(*)>3
GROUP BY s.subasta_id, s.nombre;

-- 16)
select s.subasta_id, s.fecha_inicio, a.articulo_id, a.nombre, a.precio_inicial,
(
select avg(a2.precio_inicial) from subasta s2
JOIN articulo a2 ON a2.subasta_id = s2.subasta_id
JOIN status_articulo sa ON a2.status_articulo_id = sa.status_articulo_id
WHERE a2.nombre LIKE '%Motocicleta%' AND to_char(s2.fecha_inicio, 'YY')='10'
AND sa.clave IN ('VENDIDO', 'ENTREGADO')
) as PROMEDIO from subasta s
JOIN articulo a ON a.subasta_id = s.subasta_id
JOIN subasta_venta sv ON sv.articulo_id = a.articulo_id
WHERE to_char(fecha_inicio, 'MM/YY') = '07/10' 
AND a.nombre LIKE '%Motocicleta%';

-- 17)
select p.pais_id, p.descripcion, count(*) as ARTICULOS_DONADOS from pais p
JOIN articulo_donado ad ON ad.pais_id = p.pais_id
JOIN articulo a ON a.articulo_id = ad.articulo_id
WHERE a.precio_inicial > 300000
HAVING count(*) >=3
GROUP BY p.pais_id, p.descripcion
ORDER BY p.pais_id;

-- 18)
select s.nombre, s.lugar, s.fecha_inicio, sum(sv.precio_venta) as TOTAL 
from subasta s
JOIN articulo a ON a.subasta_id = s.subasta_id
JOIN subasta_venta sv ON sv.articulo_id = a.articulo_id
WHERE to_char(fecha_inicio, 'YYYY') = '2010'
HAVING sum(sv.precio_venta) >= 3000000
GROUP BY s.nombre, s.lugar, s.fecha_inicio;

-- 19) Standard
select fc.fecha_factura, tc.numero_tarjeta, c.nombre,
c.apellido_paterno, c.apellido_materno, sv.precio_venta, a.precio_inicial, 
sv.precio_venta - a.precio_inicial as DIFERENCIA, a.nombre, a.clave_articulo,
a.tipo_articulo, af.nombre_completo, aa.anio_hallazgo, p.clave
from cliente c 
JOIN tarjeta_cliente tc ON c.cliente_id = tc.cliente_id
JOIN factura_cliente fc ON tc.tarjeta_cliente_id = fc.tarjeta_cliente_id
JOIN subasta_venta sv ON fc.factura_cliente_id = sv.factura_cliente_id
JOIN articulo a ON sv.articulo_id = a.articulo_id
LEFT JOIN articulo_donado ad ON a.articulo_id = ad.articulo_id
LEFT JOIN articulo_arqueologico aa ON a.articulo_id=aa.articulo_id
LEFT JOIN articulo_famoso af ON a.articulo_id = af.articulo_id
LEFT JOIN pais p ON ad.pais_id = p.pais_id
WHERE tc.numero_tarjeta = 5681375824866375;

-- 19) (+) va del lado de la tabla que puede tener valores nulos
select fc.fecha_factura, tc.numero_tarjeta, c.nombre,
c.apellido_paterno, c.apellido_materno, sv.precio_venta, a.precio_inicial, 
sv.precio_venta - a.precio_inicial as DIFERENCIA, a.nombre, a.clave_articulo,
a.tipo_articulo, af.nombre_completo, aa.anio_hallazgo, p.clave
from cliente c, tarjeta_cliente tc, factura_cliente fc, subasta_venta sv,
articulo a, articulo_famoso af, articulo_arqueologico aa, articulo_donado ad,
pais p
WHERE c.cliente_id = tc.cliente_id 
AND tc.tarjeta_cliente_id = fc.tarjeta_cliente_id 
AND fc.factura_cliente_id = sv.factura_cliente_id 
AND sv.articulo_id = a.articulo_id 
AND a.articulo_id = ad.articulo_id (+) 
AND a.articulo_id = aa.articulo_id (+) 
AND a.articulo_id = af.articulo_id (+) 
AND ad.pais_id = p.pais_id (+) 
AND tc.numero_tarjeta = 5681375824866375;

-- 20)
select c.nombre, c.apellido_paterno, c.apellido_materno, sum(precio_venta)
from cliente c
JOIN subasta_venta sv ON sv.cliente_id = c.cliente_id
WHERE factura_cliente_id IS NULL
HAVING sum(precio_venta) > 1000000
GROUP BY c.nombre, c.apellido_paterno, c.apellido_materno;

-- 21)
select s.subasta_id, s.nombre, s.fecha_inicio, s.fecha_fin, s.lugar, 
count(*) as NUM_ARTICULOS from subasta s
JOIN articulo a ON a.subasta_id = s.subasta_id
JOIN subasta_venta sv ON sv.articulo_id = a.articulo_id
HAVING count(*) =
(
  select max(num_articulos) from 
    ( 
    select s.subasta_id, 
    count(*) as NUM_ARTICULOS from subasta s
    JOIN articulo a ON a.subasta_id = s.subasta_id
    JOIN subasta_venta sv ON sv.articulo_id = a.articulo_id
    GROUP BY s.subasta_id
    )q1 
)
GROUP BY s.subasta_id, s.nombre, s.fecha_inicio, s.fecha_fin, s.lugar;







