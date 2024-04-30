-- Contar el número total de empleados.
select count(1) from empleado;

-- Encontrar la edad máxima entre los empleados.
select max(edad) from empleado;

-- Encontrar la edad mínima entre los empleados.
select min(edad) from empleado;

-- Calcular el salario promedio de los empleados. Redondeado a 2 decimales
select round(avg(salario), 2) from empleado;

-- Contar el número de empleados por departamento. Si el departamento es nulo, poner 'Sin Dpto'
select ifnull(departamento_id, 'Sin Dpto'), count(id) 
from empleado
group by departamento_id;

-- Encontrar el salario máximo por departamento. Si el departamento es nulo, poner 'Sin Dpto'
select ifnull(departamento_id, 'Sin Dpto'), max(salario) 
from empleado
group by departamento_id;

-- Encontrar el salario mínimo por departamento. Si el departamento es nulo, poner 'Sin Dpto'
select ifnull(departamento_id, 'Sin Dpto'), min(salario) 
from empleado
group by departamento_id;

-- Calcular el salario promedio por departamento. Si el departamento es nulo, poner 'Sin Dpto'.  Redondeado a 2 decimales
select ifnull(departamento_id, 'Sin Dpto'), round(avg(salario),2) 
from empleado
group by departamento_id;

-- Calcular el total de comisiones por departamento. Si el departamento es nulo, poner 'Sin Dpto'
select ifnull(departamento_id, 'Sin Dpto'), sum(comision) 
from empleado
group by departamento_id;

-- Encontrar el salario máximo de los empleados por departamento, siempre que el departamento no sea nulo. Ordenar de mayor a menor salario.
select max(salario) 'maximo', departamento_id 
from empleado 
where departamento_id is not null 
group by departamento_id
order by maximo desc;

-- Modifica la anterior consulta para sacar solo los 3 departamentos que mas ganan.
select max(salario) 'maximo', departamento_id 
from empleado 
where departamento_id is not null 
group by departamento_id
order by maximo desc
limit 3;


-- Encontrar el salario máximo de los empleados por departamento,
 -- siempre que el departamento no sea nulo. 
 --  Solo debe obtener aquellos máximos mayores de 50000. Ordenar de mayor a menor salario.
select max(salario) 'maximo', departamento_id 
from empleado 
where departamento_id is not null 
group by departamento_id
having maximo > 50000
order by maximo desc;

-- Consulta de empleados obteniendo su nombre_completo y salario. 
-- Siempre que el salario sea mayor de 25000 ordena por nombre_completo.
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', salario 
from empleado where salario > 25000 order by nombre_completo;

select concat_ws(' ', nombre, ape1, ape2) 'nombre_completo', salario 
from empleado where salario > 25000 order by nombre_completo;

-- Consulta de empleados obteniendo su nombre_completo, edad, salario,
-- siempre que estos tenga edad entre 20-30 años y su salario oscile 
-- entre 25000-32000 ordena de manera descendente por salario. Con between.
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', edad, salario 
from empleado 
where salario between 25000 and 32000
and edad between 20 and 30
order by salario desc;

-- Consulta de empleados obteniendo su nombre_completo, edad, salario, siempre que estos tenga edad entre 20-30 años y su salario oscile entre 25000-32000 ordena de manera descendente por salario. Sin between.
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', edad, salario 
from empleado 
where (salario >= 25000 and salario <= 32000)
and (edad >= 20 and edad <= 30)
order by salario desc;

-- Consulta todos los empleados (tanto propios como externos) mostrando nombre + 1 apellido + 2 apellido 
-- (en una columna llamada nombre completo), fecha_contratacion o subcontratacion, y tipo ('Interno o Subcontratado'). Quitando repetidos.
-- Ordena por nombre_completo
select  concat(nombre,' ', ape1,' ', ifnull(ape2, '')) as 'nombre_completo', fecha_contratacion as fecha, 
'Interno' as tipo
from empleado
UNION
select  concat(nombre,' ', ape1,' ', ifnull(ape2, '')) as 'nombre_completo', fecha_subcontratacion as fecha, 
'Subcontratado' as tipo
from empleado_externo
order by nombre_completo;

-- Consulta todos los empleados (tanto propios como externos) mostrando nombre + 1 apellido + 2 apellido (en una columna llamada nombre completo), fecha_contratacion o subcontratacion, y tipo ('Interno o Subcontratado'). Con repetidos.
-- Ordena por nombre_completo
select  concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', fecha_contratacion fecha, 'Interno' tipo
from empleado
UNION ALL
select  concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', fecha_subcontratacion fecha, 'Subcontratado' tipo
from empleado_externo
order by nombre_completo;

-- Consulta los años que lleva cada empleado externo trabajando, mostrar el id, nombre, apellido1, fecha_subcontratacion y num años. Trunca a la baja el numero de años.
select id, concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', fecha_subcontratacion, floor(datediff(now(), fecha_subcontratacion)/365) total
from empleado_externo;

-- Partiendo de la consulta anterior obten el que mas tiempo lleva trabajando. Solo debe devolver un registro
select id, concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', 
fecha_subcontratacion, floor(datediff(now(), fecha_subcontratacion)/365) total
from empleado_externo
order by total desc
limit 1; 

-- Consulta cuantos empleados por departamento existen que 
-- tenga un salario de más de 40000 y que cobren comision.  Debe aparecer el id_departamento y el total por departamento
select departamento_id, count(id)
from empleado
where salario >= 40000 and comision is not null
group by departamento_id;

-- Consulta los datos de la venta realizada por el empleado 1 ordenados por fecha mas reciente
select *
from venta
where empleado_id = 1
order by fecha_venta desc;

-- Consulta los datos la ultima venta realizada por el empleado 1
select *
from venta
where empleado_id = 1
order by fecha_venta desc
limit 1;

-- Consulta los datos de la ventas realizadas en abril
select * 
from venta
where month(fecha_venta) = 4;

-- Consulta los datos la maxima venta realizada en abril
select * 
from venta
where month(fecha_venta) = 4
order by total desc
limit 1;


-- Cuenta el numero de ventas realizadas por el empleado 1
select count(empleado_id)
from venta
where empleado_id = 1;


-- Obten los empleados externos que nacieron 1981 
select * 
from empleado_externo
where year(fecha_nacimiento) = 1981;


-- Cuenta los empleados externos que nacieron en 1981
select count(1) 
from empleado_externo
where year(fecha_nacimiento) = 1981;

-- Obten los empleados externos que nacieron en noviembre
select *
from empleado_externo
where month(fecha_nacimiento) = 11;

-- Obten maximo año de nacimiento de los empleados
select max(year(fecha_nacimiento))
from empleado_externo;


-- Obten los nombres y apellidos de los empleados (1 columna), la edad y 
-- según el tramo de edad, es lo que debe valer plan:
-- > 55 = Plan mayores de 55
-- > 35 = Sin ventajas
-- Resto = Plan joven 
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', edad,
case 
when edad > 55 then 'Plan mayores de 55'
when edad > 35 then 'Sin ventajas'
else 'Plan joven'
end  
     as 'plan'  -- alias plan
from empleado; 

-- Haz lo mismo pero con los empleados externos.
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', floor(datediff(now(), fecha_nacimiento)/365) edad,
case 
when (datediff(now(), fecha_nacimiento)/365) > 55 then 'Plan mayores de 55'
when (datediff(now(), fecha_nacimiento)/365) > 35 then 'Sin ventajas'
else 'Plan joven'
end 'plan'
from empleado_externo; 


-- Haz lo mismo con los empleados interno y externo en la misma consulta, diferenciando cuales son internos o externos mediante una nueva columna.
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', edad,
case 
when edad > 55 then 'Plan mayores de 55'
when edad > 35 then 'Sin ventajas'
else 'Plan joven'
end as 'plan',
'Internos' as tipo
from empleado 
UNION
select concat(nombre,' ', ape1,' ', ifnull(ape2, '')) 'nombre_completo', 
floor(datediff(now(), fecha_nacimiento)/365) edad,
case 
when ((now(), fecha_nacimiento)/365) > 55 then 'Plan mayores de 55'
when ((now(), fecha_nacimiento)/365) > 35 then 'Sin ventajas'
else 'Plan joven'
end as 'plan',
'Externo' as tipo
from empleado_externo; 