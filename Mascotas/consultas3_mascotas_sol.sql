USE mascotasDB;

/*
Encuentra todas las personas que han adoptado mascotas y muestra también aquellas que no han adoptado ninguna mascota.
Muestra el nombre completo de la persona, id del animal y la fecha de adopcion.
Ordena por nombre de la persona.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    a.id_animal,
    a.fecha_adopcion
FROM
    PERSONA p
    LEFT JOIN ADOPTA a ON p.NIF = a.NIF
ORDER BY
    nombre_persona;

/*
Muestra el nombre completo de la persona y la última fecha de adopción tanto de las personas que si han adoptado como las que no.
Ordena por nombre de la persona.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    MAX(a.fecha_adopcion) ultima_adopcion
FROM
    PERSONA p
    LEFT JOIN ADOPTA a ON p.NIF = a.NIF
GROUP BY
    nombre_persona
ORDER BY
    nombre_persona;

/*
Muestra el nombre todas las mascotas que han sido adoptadas, incluyendo aquellas que aún no han sido adoptadas. 
Además del nombre, muestra la fecha de adopción.
Ordena por nombre del animal.
 */
SELECT
    an.nombre,
    a.fecha_adopcion
FROM
    ANIMAL an
    LEFT JOIN ADOPTA a ON an.id_animal = a.id_animal
ORDER BY
    an.nombre;

/*
Muestra el nombre completo de la persona, el nombre de la mascota y cuando la adoptó. 
Tanto para las personas que han adoptado como las que no. 
Ordena por el nombre de la persona.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    a.fecha_adopcion,
    an.nombre
FROM
    PERSONA p
    LEFT JOIN ADOPTA a ON p.NIF = a.NIF
    LEFT JOIN ANIMAL an ON an.id_animal = a.id_animal
ORDER BY
    nombre_persona;

/*
Muestra el nombre completo de la persona, el nombre de la mascota y cuando la adoptó muestra también las mascotas que aún no han sido adoptadas. 
Ordena por el nombre de la persona.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    a.fecha_adopcion,
    an.nombre
FROM
    PERSONA p
    LEFT JOIN ADOPTA a ON p.NIF = a.NIF
    RIGHT JOIN ANIMAL an ON an.id_animal = a.id_animal
ORDER BY
    nombre_persona;

/*
Muestra nombre completo de la persona, el nombre de la mascota y cuando la adoptó, 
excluyendo aquellas mascotas que aún no han sido adoptadas.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    a.fecha_adopcion,
    an.nombre
FROM
    PERSONA p
    JOIN ADOPTA a ON p.NIF = a.NIF
    JOIN ANIMAL an ON an.id_animal = a.id_animal;

/* 
Muestra nombre completo de la persona, el nombre de la mascota, el tipo de mascota y cuando la adoptó, 
incluyendo aquellas personas que aún no han adoptado ninguna mascota.
 */
SELECT
    CONCAT_WS (' ', p.nombre, p.apellido1, p.apellido2) nombre_persona,
    an.nombre nombre_mascota,
    t.nombre tipo_animal,
    a.fecha_adopcion
FROM
    ANIMAL an
    JOIN TIPO_ANIMAL t ON an.id_tipo = t.id_tipo
    JOIN ADOPTA a ON an.id_animal = a.id_animal
    RIGHT JOIN PERSONA p ON p.NIF = a.NIF;

/*
Muestra los nombre de los animales, nombre del tipo de animal, la fecha de adopcion.
Aunque no hayan sido adoptados. Ordena por tipo de animal.
 */
SELECT
    an.nombre nombre_mascota,
    t.nombre tipo_animal,
    a.fecha_adopcion
FROM
    ANIMAL an
    JOIN TIPO_ANIMAL t ON an.id_tipo = t.id_tipo
    LEFT JOIN ADOPTA a ON an.id_animal = a.id_animal
ORDER BY
    t.nombre;

/*
Cuenta los animales existentes por tipo. 
Aunque estos no hayan sido adoptados. 
Ordena por tipo de animal.
 */
SELECT
    t.nombre tipo_animal,
    COUNT(1)
FROM
    ANIMAL an
    JOIN TIPO_ANIMAL t ON an.id_tipo = t.id_tipo
GROUP BY
    t.nombre
ORDER BY
    t.nombre;

/*
Cuenta los animales existentes que se llamen igual.
Ordena por nombre.
 */
SELECT
    an.nombre,
    COUNT(1)
FROM
    ANIMAL an
GROUP BY
    an.nombre
ORDER BY
    an.nombre;

/*
Cuenta los animales existentes por nombre del animal, cuyo nombre empice por B. 
Ordena por nombre
 */
SELECT
    an.nombre,
    COUNT(1)
FROM
    ANIMAL an
WHERE
    an.nombre LIKE 'B%'
GROUP BY
    an.nombre
ORDER BY
    an.nombre;

/* 
Muestra el tipo de animal y los animales que hay de ese tipo. 
Tiene que contar tanto si hay animales de ese tipo como si no los hay. 
Ordena por nombre del tipo

Ejecuta esto previamente 
insert into tipo_animal (nombre) values ('Oveja');

Para Oveja debe salir 0 en la cuenta.
 */
SELECT
    t.nombre,
    COUNT(a.id_tipo)
FROM
    TIPO_ANIMAL t
    LEFT JOIN ANIMAL a ON t.id_tipo = a.id_tipo
GROUP BY
    t.nombre
ORDER BY
    t.nombre;