use mascotasDB;

-- Encuentra el nombre, tipo y edad de todos los animales adoptados. Ordena por tipo asc
SELECT 
    a.nombre,
    ta.nombre AS tipo,
    a.edad
FROM
    ANIMAL a
    JOIN ADOPTA ad ON a.id_animal = ad.id_animal
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
ORDER BY
    tipo asc;

-- Muestra el nombre y la dirección de las personas que adoptaron perros.
SELECT
    p.nombre,
    p.direccion
FROM
    PERSONA p
    JOIN ADOPTA ad ON p.NIF = ad.NIF
    JOIN ANIMAL a ON ad.id_animal = a.id_animal
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    ta.nombre = 'Perro';

-- Muestra el nombre y la dirección de las personas que adoptaron perros, gatos y conejos.
SELECT
    p.nombre,
    p.direccion
FROM
    PERSONA p
    JOIN ADOPTA ad ON p.NIF = ad.NIF
    JOIN ANIMAL a ON ad.id_animal = a.id_animal
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    ta.nombre IN ('Perro', 'Gato', 'Conejo');

-- Encuentra el nombre, el tipo de todos los animales además del nombre completo del dueño y su edad. 
-- Solo aquellos adoptados por personas mayores de 30 años. Ordena por nombre completo.
SELECT
    a.nombre,
    ta.nombre AS tipo,
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_completo,
    p.edad
FROM
    ANIMAL a
    JOIN ADOPTA ad ON a.id_animal = ad.id_animal
    JOIN PERSONA p ON ad.NIF = p.NIF
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    p.edad > 30
ORDER BY
    nombre_completo;

-- Muestra el nombre y la edad de todas las personas que adoptaron animales después del año 2023.
SELECT
    p.nombre,
    p.edad
FROM
    PERSONA p
    JOIN ADOPTA ad ON p.NIF = ad.NIF
WHERE
    YEAR (fecha_adopcion) > 2023;

-- Encuentra el nombre y el tipo de todos los animales adoptados cuyo apellido1 o apellido2 de su dueño contiene la letra "a".
SELECT
    a.nombre,
    ta.nombre AS tipo
FROM
    ANIMAL a
    JOIN ADOPTA ad ON a.id_animal = ad.id_animal
    JOIN PERSONA p ON ad.NIF = p.NIF
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    p.apellido1 LIKE '%a%'
    OR p.apellido2 LIKE '%a%';

-- Muestra el nombre y el tipo de todos los animales adoptados por personas cuyo código postal empieza por "28".
SELECT
    a.nombre,
    ta.nombre AS tipo
FROM
    ANIMAL a
    JOIN ADOPTA ad ON a.id_animal = ad.id_animal
    JOIN PERSONA p ON ad.NIF = p.NIF
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    p.cp LIKE '28%';

-- Encuentra los nombres de las personas que comparten el mismo número de teléfono.
SELECT 
    P1.nombre, P1.telefono
FROM
    PERSONA P1
    JOIN PERSONA P2 ON P1.NIF <> P2.NIF
WHERE
    P1.telefono = P2.telefono
ORDER BY P1.telefono;
    
select group_concat(nombre separator ',')
from persona
where telefono is not null
group by telefono
having count(1) > 1;


-- Encuentra los nombres de las personas que viven en la misma dirección.
SELECT 
    P1.nombre, p1.direccion
FROM
    PERSONA P1
    JOIN PERSONA P2 ON P1.NIF <> P2.NIF
WHERE
    P1.direccion = P2.direccion 
ORDER BY P1.direccion;

select group_concat(nombre separator ','), direccion
from persona
where direccion is not null
group by direccion
having count(1) > 1;

-- Muestra los nombres de las personas que comparten el mismo código postal.
SELECT 
    P1.nombre, p1.cp
FROM
    PERSONA P1
    JOIN PERSONA P2 ON P1.NIF <> P2.NIF
WHERE
    P1.cp = P2.cp;
    
select group_concat(nombre separator ','), cp
from persona
where cp is not null
group by cp
having count(1) > 1;

-- Muestra el nombre de todas las personas junto con los nombres de los animales que han adoptado, si es que han adoptado alguno.
SELECT
    p.nombre,
    a.nombre AS nombre_animal
FROM
    PERSONA p
    LEFT JOIN ADOPTA ad ON p.NIF = ad.NIF
    LEFT JOIN ANIMAL a ON ad.id_animal = a.id_animal;

-- Muestra el nombre de todos los animales junto con los nombres de las personas que los adoptaron, si es que fueron adoptados.
SELECT
    a.nombre,
    p.nombre AS nombre_persona
FROM
    ANIMAL a
    LEFT JOIN ADOPTA ad ON a.id_animal = ad.id_animal
    LEFT JOIN PERSONA p ON ad.NIF = p.NIF;

-- Muestra el nombre de todas las personas que han adoptado animales, su correo, junto con el nombre del animal.
-- Filtra por aquellos que tienen email.
SELECT 
    p.nombre,
    p.email,
    a.nombre AS nombre_animal
FROM
    ADOPTA ad
    JOIN PERSONA p ON ad.NIF = p.NIF
    JOIN ANIMAL a ON ad.id_animal = a.id_animal
WHERE
    p.email IS NOT NULL;

-- Combina todas las personas con todos los animales.
SELECT
    p.nombre,
    a.nombre AS nombre_animal
FROM
    PERSONA p
    CROSS JOIN ANIMAL a;

-- Combina todas las personas que tienen menos de 30 años con todos los animales que son de tipo "Gato". Muestra el nombre de la persona, el del animal
SELECT
    p.nombre,
    a.nombre AS nombre_animal
FROM
    PERSONA p
    CROSS JOIN ANIMAL a
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    p.edad < 30
    AND ta.nombre = 'Gato';

-- Combina todas las personas cuyo nombre empieza por "A" con todos los animales que son de tipo "Perro".
SELECT
    p.nombre,
    a.nombre AS nombre_animal
FROM
    PERSONA p
    CROSS JOIN ANIMAL a
    JOIN TIPO_ANIMAL ta ON a.id_tipo = ta.id_tipo
WHERE
    p.nombre LIKE 'A%'
    AND ta.nombre = 'Perro';