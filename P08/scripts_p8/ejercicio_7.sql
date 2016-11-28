--7. Suponga que se desea retirar del catálogo a todos los artículos que tengan
--un precio inicial de más de 900,000, siempre y cuando el artículo todavía 
--no inicie el proceso de subasta, es decir, el artículo no
--debe tener status EN SUBASTA, ENTREGADO O VENDIDO. 
--Empleando operadores del álgebra relacional,determine el id, nombre, 
--clave, precio inicial y status de artículos que se deben retirar.
--R: Se deben obtener 6 artículos, verificar su precio.

select articulo_id,nombre,clave_articulo,precio_inicial,clave 
from articulo a, status_articulo sa
where a.status_articulo_id=sa.status_articulo_id
and precio_inicial>900000 
and clave not in ('EN SUBASTA', 'VENDIDO', 'ENTREGADO');

select articulo_id,nombre,clave_articulo,precio_inicial,clave from articulo a
join status_articulo sa on a.status_articulo_id=sa.status_articulo_id 
where precio_inicial>900000
and clave = 'REGISTRADO';

