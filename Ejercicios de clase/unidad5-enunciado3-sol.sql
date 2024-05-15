/** SOLO REALIZARLO CON SUBCONSULTAS **/

use unidad5;
-- Encuentra todos los empleados que trabajan en el departamento de Marketing.
select * 
from empleado 
where departamento_id = (select id from departamento where nombre = 'Marketing');

-- Encuentra el nombre del departamento en el que trabaja Carlos Pérez González.
SELECT d.nombre 
FROM departamento d 
WHERE d.id = (SELECT departamento_id 
				FROM empleado e 
				WHERE e.nombre = 'Carlos' AND e.ape1 = 'Pérez' AND e.ape2 = 'González');

-- Encuentra el id, nombre y apellido del jefe de Ana Fernández.
select jefe.id, jefe.nombre, jefe.ape1
from empleado jefe
where jefe.id = (select jefe_id from empleado where nombre = 'Ana' and ape1 = 'Fernández');

-- Encuentra los empleados cuyo salario sea mayor que el de Laura Hernández Fernández. Ordena por salario de manera descendente.
select *
from empleado
where salario > (select salario from empleado e where e.nombre = 'Laura' and e.ape1 = 'Hernández' and e.ape2 = 'Fernández')
order by salario desc;

-- Encuentra los empleados que tienen una edad mayor que el promedio de edad de todos los empleados. Ordena por edad de manera ascendente
select * 
from empleado
where edad > (select avg(e.edad) from empleado e)
order by edad asc;

-- Encuentra los empleados que tienen una edad menor que la edad del jefe de su departamento.
SELECT * 
FROM empleado e 
WHERE edad < (
    SELECT edad 
    FROM empleado 
    WHERE id = e.jefe_id
);


-- Encuentra los departamentos cuyos empleado del departamento tenga una comisión mayor que la comisión promedio de todos los empleados.
SELECT * 
FROM departamento d 
WHERE EXISTS (
    SELECT * 
    FROM empleado e 
    WHERE e.departamento_id = d.id 
    AND e.comision > (
        SELECT AVG(comision) 
        FROM empleado
    )
);

-- Encuentra el nombre de la empresa que subcontrató a Iván García.
SELECT nombre 
FROM empresa 
WHERE CIF = (
    SELECT cif_subcontrata 
    FROM empleado_externo 
    WHERE nombre = 'Iván' AND ape1 = 'García'
);



-- Encuentra el nombre y apellido (en una columna), fecha de subcontración en format DD/MM/YYYY de todos los empleados que fueron subcontratados después de que Eva García López fue subcontratada. Ordena por el nombre completo y por fecha
SELECT CONCAT(nombre, ' ', ape1) nombre_completo, date_format(fecha_subcontratacion, '%d/%m/%Y')
FROM empleado_externo 
WHERE fecha_subcontratacion > (
    SELECT aux.fecha_subcontratacion 
    FROM empleado_externo aux
    WHERE aux.nombre = 'Eva' AND aux.ape1 = 'García' AND aux.ape2 = 'López'
) order by nombre_completo, fecha_subcontratacion;


-- Encuentra los empleados que realizaron ventas
SELECT * 
FROM empleado e 
WHERE EXISTS (
    SELECT * 
    FROM venta v 
    WHERE v.empleado_id = e.id 
);

-- Encuentra los empleados que realizaron ventas en el año 2021
SELECT * 
FROM empleado e 
WHERE EXISTS (
    SELECT * 
    FROM venta v 
    WHERE year (fecha_venta) = 2021 and v.empleado_id = e.id 
);

-- Encuentra los empleados que NO realizaron ventas
SELECT * 
FROM empleado e 
WHERE NOT EXISTS (
    SELECT * 
    FROM venta v 
    WHERE v.empleado_id = e.id 
);

-- Encuentra el nombre y apellido en una columna de los empleados externos que fueron subcontratados por la empresa con CIF 'J8765432F'.
SELECT CONCAT(nombre, ' ', ape1) AS empleado 
FROM empleado_externo 
WHERE cif_subcontrata = 'J8765432F';

-- Encuentra los empleados que trabajan en el mismo departamento que Iván Garcia (y no tiene segundo apellido) y que tienen un salario menor que el suyo.
SELECT * 
FROM empleado e 
WHERE e.salario < (
    SELECT salario 
    FROM empleado 
    WHERE nombre = 'Iván' AND ape1 = 'Garcia' AND ape2 is null
    and e.departamento_id = departamento_id
);

-- Encuentra los empleados que trabajan en el mismo departamento que Iván Garcia (y no tiene segundo apellido) y que tienen un salario menor que el suyo. Sin correlacionar
SELECT * 
FROM empleado e 
WHERE e.departamento_id = (
    SELECT departamento_id 
    FROM empleado 
    WHERE nombre = 'Iván' AND ape1 = 'Garcia' AND ape2 is null
) 
AND e.salario < (
    SELECT salario 
    FROM empleado 
    WHERE nombre = 'Iván' AND ape1 = 'Garcia' AND ape2 is null
);


-- Encuentra el nombre y apellidos del jefe del jefe de Elena Pérez Gómez.
SELECT CONCAT_WS(' ',sj.nombre, sj.ape1, sj.ape2) AS superjefe 
FROM empleado sj 
WHERE sj.id = (
    SELECT jefe.jefe_id 
    FROM empleado jefe
    WHERE jefe.id = (SELECT jefe_id 
						FROM empleado 
						WHERE nombre = 'Elena' AND ape1 = 'Pérez' AND ape2 = 'Gómez')
);



-- Encuentra todos los empleados cuyo departamento está en los departamentos de 'Ventas', 'Marketing' y 'IT'.
SELECT * FROM empleado WHERE departamento_id IN (
    SELECT id FROM departamento WHERE nombre IN ('Ventas', 'Marketing', 'IT')
);

-- Encuentra los departamentos cuyos nombres no están en la lista 'Ventas', 'Marketing' y 'IT'.
SELECT * FROM departamento WHERE nombre NOT IN ('Ventas', 'Marketing', 'IT');

-- Encuentra los empleados que no han realizado ventas.
SELECT * FROM empleado WHERE id NOT IN (
    SELECT DISTINCT empleado_id FROM venta
);

-- Otra forma
SELECT * 
FROM empleado e 
WHERE NOT EXISTS (
    SELECT 1
    FROM venta v 
    WHERE v.empleado_id = e.id
);

-- Encuentra los empleados externos que fueron subcontratados por las empresas 'Empresa A', 'Empresa B' y 'Empresa C'.
SELECT * FROM empleado_externo WHERE cif_subcontrata IN (Select cif from empresa where nombre in ('Empresa A', 'Empresa B', 'Empresa C'));


-- Empleados cuyo salario es mayor que al menos uno de los empleados del departamento de Ventas.
SELECT * 
FROM empleado 
WHERE salario > ANY (
    SELECT salario 
    FROM empleado 
    WHERE departamento_id = (SELECT id FROM departamento WHERE nombre = 'Ventas')
);

-- Empleados cuyo salario es mayor que todos de los empleados del departamento de Ventas.
SELECT * 
FROM empleado 
WHERE salario > ALL (
    SELECT salario 
    FROM empleado 
    WHERE departamento_id = (SELECT id FROM departamento WHERE nombre = 'Ventas')
);

