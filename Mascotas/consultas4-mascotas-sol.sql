use mascotasdb;

-- Obtener el nombre y apellido de las personas que tienen una dirección de correo electrónico especificada.
SELECT nombre, apellido1 
FROM PERSONA 
WHERE email IS NOT NULL;

-- Mostrar el nombre y la edad de los animales que pesan más de 10 kilogramos.
SELECT nombre, edad 
FROM ANIMAL 
WHERE peso > 10;

-- Mostrar los dni de las personas que han adoptado al menos un animal.
SELECT DISTINCT NIF
FROM ADOPTA;

-- Contar el número total de personas que han adoptado al menos un animal.
SELECT COUNT(DISTINCT NIF) AS total_personas_adopcion 
FROM ADOPTA;

-- Calcular el promedio de edad de los animales adoptados por personas mayores de 30 años.
SELECT AVG(A.edad) AS promedio_edad_animales_adultos
FROM ANIMAL AS A
JOIN ADOPTA AS AD ON A.id_animal = AD.id_animal
JOIN PERSONA AS P ON AD.NIF = P.NIF
WHERE P.edad > 30;

-- Mostrar los dni de las personas que ha adoptado mas de un animal, debe aparecer el NIF y el total de animales.
SELECT NIF, count(1) total_animales
FROM ADOPTA 
GROUP BY NIF 
HAVING COUNT(1) > 1;
    
-- Mostrar el nombre y apellidos de las personas en una unica columna que han adoptado más de un animal. Con subselect en el where
SELECT concat_ws (' ', p.nombre, p.apellido1, p.apellido2) nombre_completo
from PERSONA p
WHERE NIF IN (
    SELECT NIF 
    FROM ADOPTA 
    GROUP BY NIF 
    HAVING COUNT(1) > 1
);

-- Mostrar el nombre y apellidos de las personas en una unica columna que han adoptado más de un animal, además muesta el total de los animales. Con subselect en el from-join
SELECT concat_ws (' ', p.nombre, p.apellido1, p.apellido2) nombre_completo, aux.total
from PERSONA p
   JOIN 
		(SELECT NIF, COUNT(1) total
			FROM ADOPTA 
			GROUP BY NIF 
			HAVING COUNT(1) > 1) AUX ON p.nif = AUX.NIF;


-- Obtener el nombre y el tipo de animal de los animales adoptados por personas que viven en una 'Calle' y lo que sea.
SELECT A.nombre, TA.nombre AS tipo_animal
FROM ANIMAL AS A
JOIN ADOPTA AS AD ON A.id_animal = AD.id_animal
JOIN PERSONA AS P ON AD.NIF = P.NIF
JOIN TIPO_ANIMAL AS TA ON A.id_tipo = TA.id_tipo
WHERE P.direccion LIKE 'Calle%';

-- Contar el número de animales adoptados por personas con una edad mayor a 40 años.
SELECT COUNT(*) AS total_animales_adopcion
FROM ADOPTA AS AD
JOIN PERSONA AS P ON AD.NIF = P.NIF
WHERE P.edad > 40;

-- Calcular el peso total de todos los animales adoptados.
SELECT SUM(peso) AS peso_total_animales_adopcion
FROM ANIMAL AS A
JOIN ADOPTA AS AD ON A.id_animal = AD.id_animal;


-- Calcular el peso total de todos los animales adoptados que estén vivos
SELECT SUM(peso) AS peso_total_animales_adopcion
FROM ANIMAL AS A
JOIN ADOPTA AS AD ON A.id_animal = AD.id_animal
WHERE fecha_defuncion is null;

--  Mostrar el nombre, apellido1 y apellido2 (columnas distintas). de las personas que han adoptado al menos un animal pequeño.
SELECT nombre, apellido1, apellido2
FROM PERSONA
WHERE NIF IN (
    SELECT DISTINCT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE tamano = 'pequeño'
);

-- Si la anterior la has hecho con subselect esta vez hazla con join o viceversa.
SELECT p.nombre, p.apellido1, p.apellido2
FROM PERSONA p,
    (SELECT DISTINCT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE tamano = 'pequeño') aux
where p.NIF = aux.NIF;

-- Obtener el nombre, el tipo de animal, nif del propietario de los animales adoptados en 2024.
SELECT ANIMAL.nombre, TIPO_ANIMAL.nombre AS tipo_animal, ADOPTA.NIF
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN TIPO_ANIMAL ON ANIMAL.id_tipo = TIPO_ANIMAL.id_tipo
WHERE YEAR(ADOPTA.fecha_adopcion) = 2024;

-- Contar el número de personas que han adoptado pero sus animales no son mayores o igual de 2  años.
SELECT COUNT(*) AS total_personas_sin_adopcion_mayores_de_2_anos
FROM PERSONA
WHERE NIF NOT IN (
    SELECT distinct NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE ANIMAL.edad >= 2
);

-- Calcular el peso promedio de los animales adoptados por cada sexo. Mostrar el sexo y el promedio.
SELECT sexo, AVG(peso) AS peso_promedio
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
GROUP BY sexo;

-- Mostrar el nombre, apellido1 y 2 de las personas que han adoptado animales de más de una raza.
SELECT nombre, apellido1, apellido2 
FROM PERSONA 
WHERE NIF IN (
    SELECT NIF 
    FROM ADOPTA 
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    GROUP BY NIF 
    HAVING COUNT(1) > 1
);

-- Obtener el nombre y la edad de los animales adoptados por personas cuyo apellido empieza con "G".
SELECT ANIMAL.nombre, ANIMAL.edad
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
WHERE apellido1 LIKE 'G%';

-- Contar el número total de animales adoptados en el año 2023.
SELECT COUNT(*) AS total_animales_adopcion_2023
FROM ADOPTA
WHERE YEAR(fecha_adopcion) = 2023;


-- Cuenta el número de animales adoptados por tipo en el 2023, debe aparecer el nombre del tipo de animal también,
SELECT ta.nombre, COUNT(*) 
FROM ADOPTA AD
JOIN ANIMAL A ON AD.ID_ANIMAL = A.ID_ANIMAL 
JOIN tipo_animal ta ON ta.id_tipo = a.id_tipo
group by ta.id_tipo;

-- Cuenta el defunciones por año de los animales, debe aparecer el año y el total
SELECT  YEAR (a.fecha_defuncion) año, COUNT(*) total 
FROM ADOPTA AD
JOIN ANIMAL A ON AD.ID_ANIMAL = A.ID_ANIMAL 
JOIN tipo_animal ta ON ta.id_tipo = a.id_tipo
WHERE fecha_defuncion is not null
group by YEAR (a.fecha_defuncion);

-- Calcular el promedio de peso de los animales adoptados por personas menores de 25 años.
SELECT AVG(peso) AS peso_promedio
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
WHERE PERSONA.edad < 25;

-- Mostrar el nombre de las personas que han adoptado al menos un animal de color blanco.
SELECT nombre
FROM PERSONA
WHERE NIF IN (
    SELECT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE color_dominante = 'Blanco'
);

-- Mostrar el nombre de la persona, nombre del animal, tamaño y color que han adoptado al menos un animal de color blanco. 
SELECT p.nombre nombre_persona, a.nombre nombre_animal, a.tamano, a.color_dominante
FROM PERSONA p
	JOIN ADOPTA ad ON ad.NIF = p.NIF
    JOIN ANIMAL a ON ad.id_animal = a.id_animal
    WHERE color_dominante = 'Blanco';
    
-- Calcula el peso medio de todos los animales que han sido adoptados, redondea a 2 decimales
select round(avg(a.peso), 2) peso_medio
from animal a
join adopta ad on ad.id_animal = a.id_animal;


-- Calcula el peso medio de todos los animales que han sido adoptados según su sexo, redondea a 2 decimales. 
-- Este tipo de enunciados además del dato calculado por la funcion de agregación, debemos mostrar el criterio por el que nos han pedido.
select a.sexo, round(avg(a.peso), 2) peso_medio
from animal a
join adopta ad on ad.id_animal = a.id_animal
group by a.sexo;


-- Calcula el maximo peso de los animales que han sido adaptado según su chip
-- Este tipo de enunciados además del dato calculado por la funcion de agregación, debemos mostrar el criterio por el que nos han pedido.
select a.chip, max(a.peso) max_peso_medio
from animal a
join adopta ad on ad.id_animal = a.id_animal
group by a.chip;

-- Cuenta los animales que han sido adoptados segun su chip
-- Este tipo de enunciados además del dato calculado por la funcion de agregación, debemos mostrar el criterio por el que nos han pedido.
select a.chip, count(1) total
from animal a
join adopta ad on ad.id_animal = a.id_animal
group by a.chip;


-- Muestra toda informacion de los animales que tienen chip y su peso supera la media de los adoptados con chip
select * 
from animal 
where animal.peso >
(
select  avg(a.peso) 
from animal a
join adopta ad on ad.id_animal = a.id_animal
where a.chip = 1
);

-- Prueba poniendo la subconsulta en un join, para poder mostrar además de la informacion de los animales, el peso medio. Ordena por peso.
select animal.*, round (aux.media, 2)
from animal 
join (
select  avg(a.peso) media
from animal a
join adopta ad on ad.id_animal = a.id_animal
where a.chip = 1) aux
where animal.peso > aux.media;

-- Obtener el nombre y el tipo de animal de los animales adoptados por personas que viven en Barcelona.
SELECT ANIMAL.nombre, TIPO_ANIMAL.nombre AS tipo_animal
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
JOIN TIPO_ANIMAL ON ANIMAL.id_tipo = TIPO_ANIMAL.id_tipo
WHERE PERSONA.direccion LIKE '%Barcelona%';


-- Calcular el peso total de todos los animales adoptados por personas mayores de 30 años.
SELECT SUM(peso) AS peso_total
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
WHERE PERSONA.edad > 30;

-- Mostrar el nombre de las personas que han adoptado animales de al menos 5 años de edad.
SELECT nombre
FROM PERSONA
WHERE NIF IN (
    SELECT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE ANIMAL.edad >= 5
);

-- Obtener el nombre de los tipos de animales cuya edad promedio de adopción es menor a 2 años.
SELECT nombre
FROM TIPO_ANIMAL
WHERE id_tipo IN (
    SELECT id_tipo
    FROM ANIMAL
    GROUP BY id_tipo
    HAVING AVG(edad) < 2
);


-- Consulta las personas que han adorptado animales de mas de un color dominante. Obten todos los datos de la persona
SELECT PERSONA.*
FROM ADOPTA
JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal  
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
GROUP BY NIF
HAVING COUNT(DISTINCT color_dominante) > 1;


-- Contar el número de personas que han adoptado animales de más de un color dominante.
SELECT COUNT(*) AS total_personas_adopcion_colores_mixtos
FROM (
    SELECT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    GROUP BY NIF
    HAVING COUNT(DISTINCT color_dominante) > 1
) AS personas_adopcion_colores_mixtos;

-- Mostrar el nombre de las personas que han adoptado al menos un animal de más de 20 kilogramos.
SELECT nombre
FROM PERSONA
WHERE NIF IN (
    SELECT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE peso > 20
);

-- Obtener el nombre, la edad, y el nombre y edad de las personas que lo han adoptado.
SELECT ANIMAL.nombre, ANIMAL.edad,  PERSONA.nombre, PERSONA.edad
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF;


-- Contar el número total de animales adoptados por personas con un correo electrónico especificado.
SELECT COUNT(*) AS total_animales_adopcion_con_email
FROM ADOPTA
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
WHERE email IS NOT NULL;



-- Mostrar la informacion de las personas que han adoptado animales de más de una especie: 'Pez betta', 'Canario'
SELECT * 
FROM PERSONA 
WHERE NIF IN (
    SELECT NIF 
    FROM ADOPTA 
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    JOIN TIPO_ANIMAL ON ANIMAL.id_tipo = TIPO_ANIMAL.id_tipo
    WHERE TIPO_ANIMAL.nombre IN ('Pez betta', 'Canario')
    GROUP BY NIF 
    HAVING COUNT(DISTINCT TIPO_ANIMAL.nombre) > 1
);

-- Obtener el nombre de los tipos de animales que han sido adoptados por personas menores de 30 años.
SELECT nombre
FROM TIPO_ANIMAL
WHERE id_tipo IN (
    SELECT id_tipo
    FROM ANIMAL
    WHERE id_animal IN (
        SELECT id_animal
        FROM ADOPTA
        WHERE NIF IN (
            SELECT NIF
            FROM PERSONA
            WHERE edad < 30
        )
    )
);

-- Calcular el promedio de altura de los animales adoptados por cada tipo de animal. Debe aparecer el nombre y el promedio redondeado a 2 decimale
SELECT TIPO_ANIMAL.nombre, round(AVG(ANIMAL.altura), 2) AS promedio_altura
FROM ANIMAL
JOIN TIPO_ANIMAL ON ANIMAL.id_tipo = TIPO_ANIMAL.id_tipo
GROUP BY TIPO_ANIMAL.nombre;

-- Mostrar el nombre de las personas que han adoptado al menos un animal con chip.
SELECT nombre
FROM PERSONA
WHERE NIF IN (
    SELECT NIF
    FROM ADOPTA
    JOIN ANIMAL ON ADOPTA.id_animal = ANIMAL.id_animal
    WHERE chip = 1
);

-- Obtener el nombre y la edad de los animales adoptados por personas que tienen entre 25 y 35 años.
SELECT ANIMAL.nombre, ANIMAL.edad
FROM ANIMAL
JOIN ADOPTA ON ANIMAL.id_animal = ADOPTA.id_animal
JOIN PERSONA ON ADOPTA.NIF = PERSONA.NIF
WHERE PERSONA.edad BETWEEN 25 AND 35;



