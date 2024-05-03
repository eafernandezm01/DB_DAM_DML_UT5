use unidad5;

-- Total de empleados por departamento con más de 3 empleados
SELECT departamento_id, COUNT(*) AS total_empleados
FROM empleado
GROUP BY departamento_id
having total_empleados > 3;
 


-- Total de ventas realizadas por cada empleado con más de 5 ventas
SELECT empleado_id, COUNT(*) AS total_ventas
 FROM venta
 GROUP BY empleado_id
 HAVING total_ventas > 5;


-- Cantidad de empleados externos por departamento
SELECT departamento_id, COUNT(*) AS total_empleados_externos
 FROM empleado_externo
 GROUP BY departamento_id;


-- Total de ventas realizadas por cada empleado.
SELECT empleado_id, COUNT(*) AS total_ventas
 FROM venta
 GROUP BY empleado_id;


-- Total de importe de ventas realizadas por cada empleado 
-- mientras que dicho total sea superior a 1000
SELECT empleado_id, SUM(total) AS total_ventas
 FROM venta
 GROUP BY empleado_id
 HAVING total_ventas > 1000;

-- Número de departamentos con más de 5 empleados
SELECT departamento_id, COUNT(*) AS total_empleados
 FROM empleado
 GROUP BY departamento_id
 HAVING total_empleados > 5;

-- Cantidad de empleados que ganan más de 40000 por departamento
SELECT departamento_id, COUNT(*) AS total_empleados_mas_40000
 FROM empleado
 WHERE salario > 40000
 GROUP BY departamento_id;
 

-- Importe total de ventas realizadas en el año 2023 por cada empleado
SELECT empleado_id, SUM(total) AS total_ventas_2023
 FROM venta
 WHERE YEAR(fecha_venta) = 2023
 GROUP BY empleado_id;