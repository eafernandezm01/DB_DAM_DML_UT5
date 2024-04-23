use unidad5;

select * from departamento;


select edificio from departamento;


select distinct edificio from departamento;


select edificio 'SEDES', nombre from departamento;
select edificio 'SEDES', nombre as 'Nombre departamento' from departamento;

-- Error Code: 1054. Unknown column 'edificiosss' in 'field list'
-- select edificiosss from departamento;

-- Error Code: 1146. Table 'unidad5.departamentossssss' doesn't exist
-- select edificio from departamentossssss;


select departamento.edificio from departamento;


select * from departamento where id = 4;


select * from departamento where id = 4 or id = 2;
select * from departamento where id in (2, 4);


select * from departamento where nombre = 'IT' or nombre = 'Finanzas';
select * from departamento where nombre in ('IT', 'Finanzas');


select * from departamento where edificio like '%C' and nombre = 'Ventas';


select nombre, ape1, ape2 from empleado order by nombre, ape1 desc;

select nombre, salario, (salario / 2) 'mitad salario',  5/2 as division, 'FIJO' as 'Tipo contrato' 
from empleado
where departamento_id = 1;


select concat (nombre, ' ', ape1, '-', 'OTRA COSA'), concat (ape1, ' ', nombre), nombre, ape1 
from empleado;


select concat_ws (' ', nombre, ape1, 'OTRA COSA', 5)
from empleado;


select concat_ws ('.', id, nombre, ape1, ape2, salario, fecha_contratacion, departamento_id, jefe_id, comision)
from empleado;


select UPPER(nombre), upper('eva')  from empleado;


select LOWER(nombre), LOWER('eva')  from empleado;


select reverse(lower(nombre)) 'palíndromo'
from empleado 
where nombre = reverse(nombre);


select upper(left (ape1, 2)) from empleado;
select left (upper(ape1), 2) from empleado;


select concat (upper(left(ape2,2)), upper(left(ape1,2)), upper(left(nombre,2)))
from empleado;


-- Cuando te juntas con un nulo te vuelves nulo
select concat (upper(left(ape2,2)), upper(left(ape1,2)), upper(left(nombre,2)))
from empleado;


-- Por ahora así pero esto no debe hacerse de esta forma...
SELECT 
    CONCAT(UPPER(LEFT(IFNULL(ape2, ''), 2)),
            UPPER(LEFT(ape1, 2)),
            UPPER(LEFT(nombre, 2))) 'alias'
FROM
    empleado
WHERE
    CHAR_LENGTH(CONCAT(UPPER(LEFT(IFNULL(ape2, ''), 2)),
                    UPPER(LEFT(ape1, 2)),
                    UPPER(LEFT(nombre, 2)))) = 4;


select ape1, upper(right(ape1,2)) '2caracteres'
from empleado;


select nombre, replace(nombre, 'Departamento nuevo', 'Departamento viejo') as renombrado 
from departamento;


select nombre, ape1, ape2 from empleado where ape2 is null;


select nombre, ape1, ape2 from empleado where ape2 is not null;















