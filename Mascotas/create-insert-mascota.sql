-- DDL
CREATE DATABASE mascotasDB;

USE mascotasDB;

CREATE TABLE PERSONA (
    NIF CHAR(9),
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    telefono VARCHAR(12) NOT NULL,
    email VARCHAR(50),
    direccion VARCHAR(255),
    cp CHAR(5),
    edad TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PK_PERSONA PRIMARY KEY (NIF)
);

CREATE TABLE TIPO_ANIMAL (
    id_tipo MEDIUMINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TIPO_ANIMAL PRIMARY KEY (id_tipo)
);

CREATE TABLE ANIMAL (
    id_animal INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_tipo MEDIUMINT UNSIGNED NOT NULL,
    raza VARCHAR(50),
    color_dominante VARCHAR(30),
    edad TINYINT UNSIGNED NOT NULL,
    peso DECIMAL(5, 2),
    altura DECIMAL(5, 2),
    tamano ENUM('pequeño', 'mediano', 'grande'),
    sexo ENUM ('M', 'F') NOT NULL,
    chip TINYINT UNSIGNED NOT NULL DEFAULT 0,
    fecha_defuncion DATE,
    CONSTRAINT PK_ANIMAL PRIMARY KEY (id_animal),
    CONSTRAINT FK_ANIMAL_TIPO FOREIGN KEY (id_tipo) REFERENCES Tipo_animal (id_tipo),
    CONSTRAINT CHK_CHIP CHECK (chip IN (0, 1))
);

CREATE TABLE ADOPTA (
    id_animal INT,
    NIF CHAR(9),
    fecha_adopcion DATE,
    CONSTRAINT PK_ADOPTA PRIMARY KEY (id_animal, NIF, fecha_adopcion),
    CONSTRAINT FK_ADOPCION_ANIMAL FOREIGN KEY (id_animal) REFERENCES Animal (id_animal),
    CONSTRAINT FK_ADOPCION_PERSONA FOREIGN KEY (NIF) REFERENCES Persona (NIF)
);

INSERT INTO PERSONA (NIF, nombre, apellido1, apellido2, telefono, email, direccion, cp, edad)
VALUES
    ('11111111A', 'Juan', 'González', 'Pérez', '+34623456789', 'juan@hotmail.com', 'Calle Principal 123', '28001', 30),
    ('22222222B', 'María', 'Martínez', 'López', '+34687654321', 'maria@hotmail.com', null, null, 25),
    ('33333333C', 'Pedro', 'Sánchez', 'García', '+34654321987', 'pedro@hotmail.com', 'Plaza Mayor 789', '28003', 40),
    ('44444444D', 'Ana', 'Fernández', 'Rodríguez', '+34623456789', 'ana@gmail.com', 'Calle Alcalá 456', '28004', 28),
    ('55555555E', 'Luis', 'Díaz', 'Gómez', '+34987654321', 'luis@gmail.com', 'Avenida Gran Vía 789', '28005', 35),
    ('66666666F', 'Elena', 'López', 'Martínez', '+34754321987', 'elena@hotmail.com', 'Calle Mayor 123', '28006', 22),
    ('77777777G', 'Carlos', 'Hernández', 'Sánchez', '+34612345678', 'carlos@gmail.com', 'Avenida Recoletos 456', '28007', 45),
    ('88888888H', 'Laura', 'Pérez', 'González', '+34654321098', 'laura@gmail.com', 'Plaza España 789', '28008', 29),
    ('99999999I', 'Javier', 'Gómez', 'Martín', '+34784321987', 'javier@hotmail.com', null, null, 38),
    ('10101010J', 'Sara', 'Martínez', 'López', '+34611223344', 'sara@gmail.com', 'Calle Toledo 456', '28010', 31),
    ('11111111K', 'Marta', 'González', 'Pérez', '+34699887766', 'marta@gmail.com', 'Avenida Delicias 789', '28011', 27),
    ('12121212L', 'Manuel', 'Fernández', 'García', '+34655556666', 'manuel@hotmail.com', 'Plaza Cibeles 123', '28012', 33),
    ('13131313M', 'Lorena', 'García', 'Sánchez', '+31654321987', 'lorena@gmail.com', 'Calle Bravo Murillo 456', '28013', 24),
    ('14141414N', 'Raul', 'López', 'Martínez', '123456789', null, null, null, 36),
    ('15151515O', 'Marta', 'López', 'Gómez', '+34633332222', 'marta@hotmail.com', 'Calle Princesa 123', '28015', 32),
    ('16161616P', 'Sergio', 'Fernández', 'Díaz', '+34644445555', null, 'Avenida Castellana 456', '28016', 26),
    ('17171717Q', 'Eva', 'Martín', 'López', '+34611110000', 'eva@gmail.com', 'Calle Fuencarral 789', '28017', 29),
    ('18181818R', 'Alberto', 'López', 'Sánchez', '+34678787654', 'alberto@gmail.com', 'Plaza Mayor 123', '28018', 41),
    ('19191919S', 'Carmen', 'Sánchez', 'Gómez', '+32654321987', 'carmen@gmail.com', 'Avenida Diagonal 456', '28019', 23),
    ('20202020T', 'Marta', 'Martínez', 'Hernández', '+34655556666', 'marta@gmail.com', 'Calle Gran Vía 789', '28020', 37),
    ('21212121U', 'Silvia', 'Hernández', 'Gómez', '+34622223333', 'silvia@gmail.com', 'Calle Serrano 123', '28021', 28),
    ('22222222V', 'Manuel', 'López', 'Sánchez', '+34623456789', 'manuel@hotmail.com', 'Avenida Las Ramblas 456', '28022', 30),
    ('23232323W', 'Ana', 'García', 'López', '+34687654321', 'ana@gmail.com', 'Plaza España 789', '28023', 34),
    ('24242424X', 'Raul', 'López', 'Sánchez', '+34699998888', 'raul@gmail.com', 'Calle Mayor 123', '28024', 31),
    ('25252525Y', 'Lucía', 'García', 'López', '+34666665555', 'lucia@gmail.com', 'Avenida Libertad 456', '28025', 31),
    ('45777777G', 'Carmen', 'Ramírez', 'Vidal', '+34656789012', 'carmen@educarex.com', 'Calle Gran Vía 89', '28006', 45),
    ('88888855H', 'Luis', 'Hernández', 'Fernández', '+34667890123', 'luis@educarex.com', 'Avenida de América 176', '28007', 32),
    ('99999998I', 'Marina', 'Gutiérrez', 'Cruz', '+34678901234', 'marina@educarex.com', 'Calle Serrano 210', '28008', 39),
    ('10101012J', 'Sergio', 'Ortega', 'Martínez', '+34689012345', 'sergio@educarex.com', 'Calle Fuencarral 12', '28009', 27),
    ('12121212K', 'Isabel', 'Moreno', 'Molina', '+34690123456', 'isabel@educarex.com', 'Calle Mayor 456', '28010', 31),
    ('13131313L', 'Gonzalo', 'Soto', 'García', '+34601234567', 'gonzalo@educarex.com', 'Plaza Castilla 32', '28011', 36),
    ('14141414M', 'Silvia', 'Cabrera', 'Hernández', '+34612345678', 'silvia@educarex.com', 'Calle Princesa 78', '28012', 29),
    ('15151515N', 'Roberto', 'Ruiz', 'Pérez', '+34623456789', 'roberto@educarex.com', 'Paseo de la Castellana 200', '28013', 41),
    ('16161616O', 'Clara', 'Vargas', null, '+34634567890', 'clara@educarex.com', 'Calle Bravo Murillo 95', '28014', 33),
    ('17171717P', 'Adrián', 'Jiménez', null, '+34645678901', 'adrian@educarex.com', 'Avenida de Moncloa 176', '28015', 30);


INSERT INTO
    TIPO_ANIMAL (nombre)
VALUES
    ('Perro'),
    ('Gato'),
    ('Pájaro'),
    ('Conejo'),
    ('Hurón'),
    ('Tortuga'),
    ('Hamster'),
    ('Cobaya'),
    ('Iguana'),
    ('Canario'),
    ('Periquito'),
    ('Cotorra'),
    ('Pez Dorado'),
    ('Gerbilo'),
    ('Rata'),
    ('Serpiente'),
    ('Gallina'),
    ('Cabra'),
    ('Erizo'),
    ('Pez Betta');

INSERT INTO ANIMAL (nombre, id_tipo, raza, color_dominante, edad, peso, altura, tamano, sexo, chip, fecha_defuncion)
VALUES
    ('Buddy', 1, 'Labrador Retriever', 'Dorado', 2, 20.5, 0.6, 'mediano', 'M', 1, NULL),
    ('Luna', 2, 'Siamés', 'Blanco', 3, null, null, 'pequeño', 'F', 1, NULL),
    ('Kiwi', 3, 'Loro', 'Verde', 5, 0.3, 0.2, 'pequeño', 'M', 0, NULL),
    ('Pelusa', 4, 'Cabeza de León', 'Blanco', 1, 2.1, 0.1, 'pequeño', 'F', 1, NULL),
    ('Rocky', 5, 'Hurón Común', 'Marrón', 1, 1.5, 0.2, 'pequeño', 'M', 1, NULL),
    ('Donatello', 6, 'Tortuga de Orejas Rojas', 'Verde', 8, 2.7, 0.1, 'pequeño', 'M', 1, NULL),
    ('Nibbles', 7, 'Hamster Dorado', 'Dorado', 1, 0.1, 0.05, 'pequeño', 'M', 0, NULL),
    ('Bola de Nieve', 8, 'Cobaya', 'Blanco', 2, 0.6, 0.15, 'pequeño', 'F', 0, NULL),
    ('Godzilla', 9, 'Iguana Verde', 'Verde', 4, null, null, 'mediano', 'M', 1, NULL),
    ('Piolín', 10, 'Canario Amarillo', 'Amarillo', 1, 0.1, 0.1, 'pequeño', 'M', 1, NULL),
    ('Perla', 11, 'Periquito Australiano', 'Azul', 2, 0.05, 0.1, 'pequeño', 'F', 1, NULL),
    ('Chiqui', 12, 'Cotorra Argentina', 'Verde', 3, 0.3, 0.2, 'pequeño', 'M', 1, '2024-02-10'),
    ('Goldie', 13, 'Pez Dorado', 'Dorado', 1, 0.2, 0.05, 'pequeño', 'F', 1, NULL),
    ('Nico', 14, 'Gerbilo', 'Gris', 1, 0.1, 0.1, 'pequeño', 'M', 0, NULL),
    ('Whiskers', 15, 'Rata Doméstica', 'Gris', 2,null,null, 'pequeño', 'M', 1, '2023-12-01'),
    ('Fang', 16, 'Serpiente de Maíz', 'Naranja', 3, 1.5, 0.1, 'pequeño', 'M', 1, NULL),
    ('Clara', 17, 'Gallina Araucana', 'Marrón', 1, 2.0, 0.3, 'mediano', 'F', 1, NULL),
    ('Coco', 18, 'Cabra Enana', 'Blanco', 2, 12.0, 0.5, 'mediano', 'M', 1, NULL),
    ('Sonic', 19, 'Erizo Africano', 'Marrón', 1, 0.5, 0.1, 'pequeño', 'M', 1, NULL),
    ('Nemo', 20, 'Pez Betta', 'Azul', 1, 0.05, 0.1, 'pequeño', 'M', 1, NULL),
    ('Charlotte', 1, 'Golden Retriever', 'Dorado', 3, 25.2, 0.7, 'mediano', 'F', 1, NULL),
    ('Simba', 2, 'Persa', 'Naranja', 4, 6.8, 0.4, 'mediano', 'M', 1, NULL),
    ('Tweety', 3, 'Canario', 'Amarillo', 2, 0.1, 0.1, 'pequeño', 'M', 1, '2024-01-15'),
    ('Bugs', 4, 'Conejo Belier', 'Blanco', 2, 3.0, 0.3, 'mediano', 'M', 1, NULL),
    ('Frodo', 5, 'Hurón Albino', 'Blanco', 1, 1.8, 0.2, 'pequeño', 'M', 0, NULL),
    ('Rocky', 4, 'Labrador Retriever', 'Chocolate', 3, 28.0, 0.7, 'mediano', 'M', 1, NULL),
    ('Molly', 5, 'Persa', 'Gris', 2, 3.0, 0.2, 'pequeño', 'F', 1, NULL),
    ('Lola', 6, 'Bulldog Francés', 'Blanco', 4, 10.5, 0.3, 'pequeño', 'F', 1, NULL),
    ('Max', 7, 'Golden Retriever', 'Dorado', 6, 30.0, 0.8, 'grande', 'M', 1, NULL),
    ('Lucy', 8, 'Shih Tzu', 'Blanco', 2, 5.0, 0.3, 'mediano', 'F', 1, NULL),
    ('Leo', 9, 'Chow Chow', 'Marrón', 5, 25.0, 0.6, 'mediano', 'M', 1, NULL),
    ('Mia', 10, 'Bichón Maltés', 'Blanco', 3, 4.0, 0.2, 'pequeño', 'F', 1, NULL),
    ('Sam', 1, 'Dachshund', 'Negro', 2, 7.0, 0.3, 'mediano', 'M', 1, NULL);

INSERT INTO
    ADOPTA (id_animal, NIF, fecha_adopcion)
VALUES
 (1, '11111111A', '2023-02-15'),
    (2, '22222222B', '2023-04-20'),
    (3, '33333333C', '2023-06-10'),
    (4, '44444444D', '2023-08-25'),
    (5, '55555555E', '2023-10-05'),
    (6, '66666666F', '2023-12-12'),
    (7, '77777777G', '2024-01-30'),
    (8, '88888888H', '2024-03-15'),
    (9, '99999999I', '2024-05-22'),
    (10, '10101010J', '2024-07-10'),
    (11, '11111111A', '2024-09-28'),
    (12, '22222222B', '2024-11-11'),
    (13, '33333333C', '2023-03-18'),
    (14, '44444444D', '2023-05-02'),
    (15, '55555555E', '2023-07-20'),
    (16, '66666666F', '2023-09-10'),
    (17, '77777777G', '2023-11-25'),
    (18, '88888888H', '2024-01-05'),
    (19, '99999999I', '2024-03-30'),
    (20, '10101010J', '2024-06-14'),
    (3, '11111111A', '2023-01-20'),
    (9, '22222222B', '2023-07-01'),
    (11, '33333333C', '2023-10-15'),
    (17, '44444444D', '2024-02-02'),
    (7, '55555555E', '2024-05-20');


    