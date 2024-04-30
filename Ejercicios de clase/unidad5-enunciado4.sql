/** 

                        Sobre la BD unidad5, realiza las siguientes consultas:
                        Aunque aún no lo hayamos visto, podemos hacer tantos join como claves foráneas tenga la tabla

                                    SELECT columna-nombre(s)
                                    FROM tabla-1 
                                    JOIN tabla-2 ON tabla-1.nombre-columna = tabla-2.nombre-columna
                                    JOIN tabla-3 ON tabla-1.nombre-columna = tabla-3.nombre-columna
                                    ....
                                    JOIN tabla-n ON tabla-1.nombre-columna = tabla-n.nombre-columna

                        después de los join podemos añadir where para filtrar los datos como hemos estado haciendo hasta ahora.
                                    WHERE (condiciones)  


                        realizar grupos con los resultados obtenidos con un GROUP BY y filtar dichos grupos.
                                    GROUP BY columnas 
                                    HAVING (condiciones a nivel de grupo) 

                        por supuesto ordenar:
                                    ORDER BY columna_nombre

                        y solo obtener un par de filas 
                                    LIMIT num_filas

                        En definitiva, pensad en los join como un paso intermedio para obtener la tabla grande y aplicar todo lo que hemos visto anteriormente...


                        Además una tabla puesta en el join puede usarse dentro de otro join (TABLA 1 esta relacionada con TABLA 2 y TABLA 2 con la tabla 3)
                                    SELECT columna-nombre(s)
                                    FROM tabla-1 
                                    JOIN tabla-2 ON tabla-1.nombre-columna = tabla-2.nombre-columna
                                    JOIN tabla-3 ON tabla-2.nombre-columna = tabla-3.nombre-columna;

                        ¡¡¡ INTÉNTALO !!!!
                                    
                                    
**/



/* 
Consulta para obtener el id del departamento, el nombre del departamento, el nombre y los apellidos (ape1+ape2) de los empleados que trabaja en ese departamento. 
Ordena por nombre de departamento ascendente y por nombre del empleado ascendentemente.
*/





-- Modifica la consulta anterior para obtener solo los departamentos que se encuentran en el Edificio A. Mismo criterio de ordenación.





/*
Consulta para obtener el id del departamento, el nombre del departamento, el nombre y los apellidos (ape1+ape2) de los empleados que trabaja en ese departamento.
Solo mostrar aquellos empleados que sean de: IT, Marketing. NO USAR IN
Ordena por nombre de departamento ascendente y por nombre del empleado ascendentemente.
*/




-- Lo mismo que en la anterior pero usando IN.





/*
Consulta para obtener el id del departamento, el nombre del departamento, el nombre y los apellidos (ape1+ape2) de los empleados que trabaja en ese departamento.
Solo mostrar aquellos empleados que sean de: IT, Marketing o su departamento se encuentre en el edificio Edificio E
Ordena por nombre de departamento ascendente y por nombre del empleado ascendentemente.
*/





/* 
Consulta para obtener el nombre completo del empleado externo, la fecha de subcontratación, el nombre del departamento en el que trabaja
y el nombre de la empresa a la que pertenece dicho empleado.
Ordena por empresa ascendente y por fecha descendente
 */




-- Consulta para obtener el nombre del departamento, nombre completo del empleado, total de la venta y la fecha de la venta. Ordena por fecha de la venta desc






/*
Consulta para obtener el nombre del departamento, nombre completo del empleado, su edad, su comision, total de la venta y la fecha de la venta. 
Solo necesitamos las ventas que han sido realizadas por los empleados cuya edades oscilan entre 30-55 o no tengan comision.
Ordena por nombre empledo ascendente y fecha de la venta desc
*/





-- Consulta para obtener el nombre del departamento y la suma de total de ventas realizadas por los empleados.





/* 
Consulta para obtener el nombre del departamento y la suma de total de ventas realizadas por los empleados cuya edades oscilan entre 22-30 o no tengan comision.
Ordena de manera descendente por la suma del total de ventas
*/





-- Modifica la anterior consulta para que solo tenga en cuenta las ventas de los departamentos: Ventas y Marketing






-- Obten el nombre completo del jefe del empleado Elena Pérez Gómez y el nombre del departamento al que pertenece el jefe.






-- Consulta para obtener el nombre del departamento y el numero de ventas realizadas por los empleados que trabajan en ese departamento.







