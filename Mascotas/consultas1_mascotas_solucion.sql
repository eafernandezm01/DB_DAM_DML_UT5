use mascotasDB;

-- Consulta todas las personas
select * from persona;

-- Consulta todos los animales
select * from animal;

-- Consulta todos los tipos de animales
select * from tipo_animal;

-- Consulta todos los tipos de animales ordenados por nombre de manera ascendente
select * from tipo_animal order by nombre;

-- Consulta todos los animales cuyo tipo de animal sea 1 ordenado por nombre de manera ascendente y por raza descendente;
select * from animal where id_tipo = 1 order by nombre, raza desc;

-- Consulta todos los animales cuya edad sea menor que 3 ordena por peso;
select * from animal where edad < 3 order by peso;

-- Consulta todos los animales que hayan fallecido, ordena por fecha de defuncion descendente
select * from animal where fecha_defuncion is not null order by fecha_defuncion desc;

-- Listar los nombres y edades de personas mayores de 30 años, ordenadas por nombre.
select nombre, edad from persona where edad > 30 order by nombre;

-- Encontrar los NIF y direcciones de personas sin correo electrónico.
select NIF, direccion from persona where email is null;

-- Buscar personas con código postal definido (no nulo), mostrar sus NIF y edades.
select NIF, edad from persona where cp is not null;

-- Buscar personas que no tienen un segundo apellido definido, mostrar sus nombres y edades.
select nombre, edad from persona where apellido2 is  null;

-- Busca todas las personas menores de 30 y muestra su nif, (nombre y apellido1) en una columna nombre_pesona, edad. Ordena por el nombre_persona
select nif, concat (nombre, ' ', apellido1) as 'nombre_persona' from persona where edad < 30 order by nombre_persona; 


-- Busca todas las personas y muestra su nif, (nombre apellido1 apellido2) en una columna nombre_pesona, edad. Ordena por el nombre_persona
select nif, concat (nombre, ' ', apellido1, ' ', apellido2) as 'nombre_persona' from persona order by nombre_persona; 

-- Arregla la consulta para que no haya null en nombre de persona
select nif, concat (nombre, ' ', apellido1, ' ', IFNULL(apellido2, '')) as 'nombre_persona' from persona order by nombre_persona; 

-- Personas cuyo apellido1 empieza con 'G' y tienen más de 25 años.
select * from persona where apellido1 like 'G%' and edad > 25;

-- Personas cuyo apellido1 termine con 'z'.
select * from persona where apellido1 like '%z';

-- Personas cuyo correo sea de gmail.com
select * from persona where email like '%gmail.com';

-- Pon en mayusculas el nombre de los animales. Solo los animales cuya edad sea 2 o 3. Muestra el nombre en mayuscula y la edad.
select UPPER (nombre), edad from animal where edad between 2 and 3;

-- Buscar los nombres y edades de los animales cuyo tamaño sea 'mediano' y sexo sea 'F'.
select nombre, edad from animal where tamano = 'mediano' and sexo = 'F';

