use gaseosasValle;

-- FUNCTION
-- Crear una funcion MySQL llamada calcular_promedio_pedidos_cliente

drop function calcular_promedio_pedidos_cliente;

delimiter //
create function calcular_promedio_pedidos_cliente(id_c int)
returns decimal(10,2)
deterministic 
begin
	declare promedio_c decimal(10,2);

	select avg(total_sin_iva) into promedio_c from cliente_pedido where id_cliente = id_c;
	if promedio_c is null then
		return 0;
	end if;
	return promedio_c;
end //
delimiter ;

select DISTINCT id_cliente, calcular_promedio_pedidos_cliente(id_cliente) as promedio_cliente from cliente_pedido order by promedio_cliente ;



select * from cliente_pedido;

-- VIEW
-- Crear una vista llamada vista_resumen_sedes

drop view vista_resumen_sedes;

create view vista_resumen_sedes as select DISTINCT  s.nombre, s.id_sede, cp.total_sin_iva as valor_total, count(cp.id_sede) as productos_despachados, avg(cp.total_con_iva) as promedio 
from cliente_pedido cp inner join sede s on cp.id_sede = s.id_sede group by s.nombre, s.id_sede, valor_total;

select * from vista_resumen_sedes;


-- CONSULTA
-- Realizar una consulta con subconsulta que: Muestre el nombre del producto, categoría y stock
-- Solo incluya los productos cuyo precio sea mayor al promedio general de precios de todos los productos.

select p.nombre as 'nombre del producto', c.nombre as 'Categoria', p.stock_actual from productos p inner join categorias c on c.id_categoria = p.id_categoria where p.precio > (select avg(precio) from productos);

-- TRIGGER 
-- Crear un trigger llamado auditar_cambio_precio que: Se ejecute despues de un UPDATE en la tabla de productos.
-- Registre en una tabla auditoria_precios los campos: id_producto, precio_anterior, precio_nuevo, fecha_modificacion.
-- Solo se debe registrar si el precio realmente cambio.

delimiter //
create trigger auditar_cambio_precio
after update on productos
for each row 
begin
	if old.precio <> new.precio then
		insert into auditoria_precios (id_producto, precio_viejo, precio_nuevo, fecha_cambio) values(old.id_producto, old.precio, new.precio, now());
	end if;
end //
delimiter ;


UPDATE productos SET precio = 9000 WHERE id_producto = 23;

-- Registro en tabla auditoria
SELECT * FROM auditoria_precios;




