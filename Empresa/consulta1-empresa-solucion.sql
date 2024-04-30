USE empresaDB;

-- Obtener los CLIENTES ordenados alfabéticamente en orden descendente (z...a).
select * from cliente order by nombre desc;

-- Obtener los clientes de Sevilla.
select * from cliente where localidad = 'SEVILLA';

-- Obtener los clientes cuyo nombre terminen en "S.A.".
select * from cliente where nombre like '%S.A.';

-- Obtener las localidades donde hay clientes.
select distinct localidad from cliente;

-- Obtener los pedidos que tengas más de 5 unidades.
select * from pedido where unidades > 5;

-- Obtener los apellidos de los empleados junto con su salario 
-- anual( salario + comision en 14 pagas) 
-- ordenado de mayor a menor por este salario total.
select apellido, (salario + ifnull(comision, 0))*14 'salario_total' 
from empleado order by salario_total desc;

-- Obtener el apellido y oficio en una única columna en minúsculas.
select lower (concat_ws('-', apellido, oficio)) from empleado;
select lower (concat(apellido, '-', oficio)) from empleado;

-- Obtener el apellido y oficio en una única columna en mayúsculas.
select upper (concat_ws('-', apellido, oficio)) from empleado;
select upper (concat(apellido, '-', oficio)) from empleado;

-- Obtener los empleados cuyo director es Garrido.

/* ¡¡¡¡ OJO, hasta que veamos subconsultas y join está permitido esto... !!!!! */
select * from empleado where director = 7698;

-- Obtener todos los empleados que son vendedores.
select * from empleado where oficio = 'vendedor';

-- Obtener los productos cuyo es tock es superior o igual a 25 ordenados por stock ascendientemente.
select * from producto where stock_disponible >= 25 order by stock_disponible;

-- Obtener las tres primeras letras de cada localidad donde están los departamentos.
select left(localidad, 3) 'tres' from departamento;
select substr(localidad,1, 3) 'tres' from departamento;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y 
-- la localidad de los clientes y en la segunda, el nombre y la localidad con todos los caracteres invertidos
select concat(dnombre, '-', localidad) 'derecho', reverse(concat(dnombre, '-', localidad)) 'reves' from departamento;
select concat_ws('-', dnombre, localidad) 'derecho', reverse(concat_ws('-', dnombre, localidad)) 'reves' from departamento;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y la localidad de los 
-- clientes en mayúscula y en la segunda, el nombre y la localidad con todos los caracteres invertidos en minúscula.
select upper(concat(nombre, '-', localidad)) 'derecho', reverse(lower(concat_ws(nombre, '-', localidad))) 'reves' from cliente;
select upper(concat_ws('-', nombre, localidad)) 'derecho', reverse(lower(concat_ws('-', nombre, localidad))) 'reves' from cliente;

-- Visualizar de alta de los empleados con el formato <día de la semana> - <dia> de <mes> de <año>.
select  DATE_FORMAT(fecha_alta, "%W - %d de %M de %Y") 'fecha' from empleado;

-- Mostrar para cada empleado su apellido junto con el número de trienios 
-- que tiene(se tiene un trienio por cada tres años en la empresa)
-- datediff(Now(), fecha_alta) 'dias',  datediff(Now(), fecha_alta)/365 'años',
select apellido, floor(datediff(Now(), fecha_alta) / (365*3)) 'trienio' from empleado; 