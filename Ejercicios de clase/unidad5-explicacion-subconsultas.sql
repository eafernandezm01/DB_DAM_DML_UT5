use unidad5;
/** Una subselect puede estar en el:
			 - En la cláusula SELECT de otra
			 - En la cláusula FROM de otra
			 - En la cláusula WHERE de otra
			 - En la cláusula HAVING de otra
 **/


/**
	PODEMOS PONER UNA SUBCONSULTA EN EL SELECT, ESTO HACE QUE PARA TODO LOS
	REGISTROS QUE DEVUELVA LA SELECT PRINCIPAL PONGA EL MISMO VALOR OBTENIDO 
	EN LA SUBSELECT. 
**/

-- Cuenta el numEmpleados existentes en la tabla empleado
-- cuenta el numEmpleados externos existentes en la tabla empleado externo
-- y muestra info del departamento
SELECT (
			select count(1)  from empleado
		) total_empleados, 
        (
				select count(1)  from empleado_externo
		) total_empleados_externo,
        d.*
from departamento d;


/* En el where de otra select */
-- Dame el nombre, ape1, ape2 y salario de los empleados que ganen menos de la
-- media de todos los empleados. 
select nombre, ape1, ape2, salario
from empleado
where salario < (select avg (salario) from empleado);

-- Salario medio de los empleados que trabajan en Ventas
select avg (salario) 
from empleado
where departamento_id = (select id from departamento where nombre= 'Ventas');

-- Salario medio de los empleados que trabajan en Ventas pero join
select avg (salario) 
from empleado
join departamento d ON  d.id = empleado.departamento_id
where d.nombre= 'Ventas';

-- Nombre, ape1, ape2, salario que sea inferior a la media del salario de los empleados que trabajan
-- en ventas
select nombre, ape1, ape2, salario
from empleado
where salario < (
     select avg (salario) 
     from empleado
	 join departamento d ON  d.id = empleado.departamento_id
     where d.nombre= 'Ventas'
);

-- Nombre, ape1, ape2, salario de los empleados que han efectuado ventas con importe > 2000
select nombre, ape1, ape2, salario
from empleado
where id IN (
	select distinct v.empleado_id 
	from venta v 
    where v.total > 2000
);

select e.nombre, e.ape1, e.ape2, e.salario
from empleado e
join venta v ON v.empleado_id = e.id
where v.total > 2000;

