-- Encuentra todos los empleados que trabajan en el departamento de Marketing.
select e.*
from empleado e
join departamento d on e.departamento_id = d.id
where d.nombre = 'Marketing';

-- Encuentra el nombre del departamento en el que trabaja Carlos Pérez González.
select d.nombre
from empleado e
join departamento d on e.departamento_id = d.id
where e.nombre='Carlos' and e.ape1 = 'Pérez' and e.ape2='González';


-- Encuentra el id, nombre y apellido del jefe de Ana Fernández.
SELECT j.id, j.nombre, j.ape1, j.ape2
FROM empleado e
JOIN empleado j ON e.jefe_id = j.id
where e.nombre='Ana' and e.ape1 = 'Fernández';

-- Encuentra los empleados cuyo salario sea mayor que el de Laura Hernández Fernández. Ordena por salario de manera descendente.
SELECT e.*
FROM empleado e
JOIN (
			select salario 
            from empleado l 
            WHERE l.nombre = 'Laura' and l.ape1 = 'Hernández' and l.ape2 = 'Fernández'
	  ) laura ON e.salario > laura.salario
ORDER BY e.salario DESC;

SELECT e.*
FROM empleado e
JOIN empleado l ON e.salario > l.salario
WHERE l.nombre='Laura' and l.ape1 = 'Hernández' and l.ape2='Fernández'
ORDER BY e.salario DESC;

-- Encuentra los empleados que tienen una edad mayor que el promedio de edad de todos los empleados. Ordena por edad de manera ascendente
SELECT e.*
FROM empleado e
JOIN (SELECT AVG(edad) as media FROM empleado) aux ON e.edad > aux.media
ORDER BY e.edad ASC;

-- Encuentra los departamentos cuyos empleado del departamento tenga una comisión mayor que la comisión promedio de todos los empleados.
SELECT distinct d.*
FROM departamento d
JOIN empleado e ON d.id = e.departamento_id
JOIN (select AVG(comision) media FROM empleado) aux ON e.comision > aux.media;

SELECT distinct d.*
FROM departamento d
INNER JOIN empleado e ON d.id = e.departamento_id
WHERE e.comision > (select AVG(comision) FROM empleado);

-- Encuentra el nombre de la empresa que subcontrató a Iván García.
SELECT em.nombre
FROM empresa em
INNER JOIN empleado_externo ee ON em.CIF = ee.cif_subcontrata
WHERE ee.nombre='Iván' and ee.ape1 = 'García';

-- Encuentra el nombre y apellido (en una columna), fecha de subcontración en format DD/MM/YYYY de todos los empleados que fueron subcontratados después de que Eva García López fue subcontratada. Ordena por el nombre completo y por fecha
SELECT CONCAT(nombre, ' ', ape1) nombre_completo, date_format(fecha_subcontratacion, '%d/%m/%Y')
FROM empleado_externo
WHERE fecha_subcontratacion > (SELECT fecha_subcontratacion FROM empleado_externo WHERE nombre='Eva' and ape1 = 'García' and ape2='Lopez')
ORDER BY nombre_completo, fecha_subcontratacion;

-- Encuentra los empleados que realizaron ventas
SELECT DISTINCT e.*
FROM empleado e
INNER JOIN venta v ON e.id = v.empleado_id;

-- Encuentra los empleados que realizaron ventas en el año 2021
SELECT DISTINCT e.*
FROM empleado e
INNER JOIN venta v ON e.id = v.empleado_id
WHERE YEAR(v.fecha_venta) = 2021;


-- Encuentra los empleados que NO realizaron ventas
SELECT e.*
FROM empleado e
LEFT JOIN venta v ON e.id = v.empleado_id
WHERE v.id IS NULL;

-- Encuentra el nombre y apellido en una columna de los empleados externos que fueron subcontratados por la empresa con CIF 'J8765432F'.
SELECT CONCAT(nombre, ' ', ape1) AS empleado 
FROM empleado_externo 
WHERE cif_subcontrata = 'J8765432F';

-- Encuentra los empleados que trabajan en el mismo departamento que Iván Garcia (y no tiene segundo apellido) y que tienen un salario menor que el suyo.
SELECT e.*
FROM empleado e
JOIN empleado i ON e.departamento_id = i.departamento_id
WHERE i.nombre = 'Iván' AND i.ape1 = 'García' AND e.salario < i.salario;

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
FROM empleado e
JOIN empleado je ON e.jefe_id = je.id
JOIN empleado sj ON je.jefe_id = sj.id
WHERE e.nombre = 'Elena' AND e.ape1 = 'Pérez' AND e.ape2 = 'Gómez';


-- Encuentra todos los empleados cuyo departamento está en los departamentos de 'Ventas', 'Marketing' y 'IT'.
SELECT e.*
FROM empleado e
JOIN departamento d ON e.departamento_id = d.id
WHERE d.nombre IN ('Ventas', 'Marketing', 'IT');

-- Encuentra los departamentos cuyos nombres no están en la lista 'Ventas', 'Marketing' y 'IT'.
SELECT * FROM departamento WHERE nombre NOT IN ('Ventas', 'Marketing', 'IT');

-- Encuentra los empleados que no han realizado ventas.
SELECT e.*
FROM empleado e
LEFT JOIN venta v ON e.id = v.empleado_id
WHERE v.id IS NULL;

-- Encuentra los empleados externos que fueron subcontratados por las empresas 'Empresa A', 'Empresa B' y 'Empresa C'.
SELECT e.*
FROM empleado_externo e
JOIN empresa em ON e.cif_subcontrata = em.CIF
WHERE em.nombre IN ('Empresa A', 'Empresa B', 'Empresa C');

-- Empleados cuyo salario es mayor que al menos uno de los empleados del departamento de Ventas.
SELECT e.* 
FROM empleado e
WHERE e.salario > ANY (
    SELECT salario 
    FROM empleado 
    WHERE departamento_id = (SELECT id FROM departamento WHERE nombre = 'Ventas')
);

-- Empleados cuyo salario es mayor que todos de los empleados del departamento de Ventas.
SELECT e.* 
FROM empleado e
WHERE e.salario > ALL (
    SELECT salario 
    FROM empleado 
    WHERE departamento_id = (SELECT id FROM departamento WHERE nombre = 'Ventas')
);

