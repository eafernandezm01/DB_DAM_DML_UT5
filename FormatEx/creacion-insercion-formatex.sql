CREATE DATABASE FormatExBD;

USE FormatExBD;

CREATE TABLE DEPARTAMENTO(
	cod_dpto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni_director char(9)
);

CREATE TABLE PROFESOR(
	dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    prApellido VARCHAR(50) NOT NULL,
    sgApellido VARCHAR(50),
    mail VARCHAR (50),
    cod_dpto INT,
    CONSTRAINT fk_profesor_departamento FOREIGN KEY(cod_dpto) REFERENCES DEPARTAMENTO(cod_dpto)
);

ALTER TABLE DEPARTAMENTO 
ADD CONSTRAINT fk_departamento_profesores FOREIGN KEY (dni_director) REFERENCES PROFESOR(dni);

CREATE TABLE FAMILIA (
    cod_familia INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE CICLO(
	cod_ciclo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    sigla CHAR(4),
    cod_familia INT,
    CONSTRAINT fk_ciclo_familia FOREIGN KEY(cod_familia) REFERENCES FAMILIA(cod_familia)
);

CREATE TABLE MODULO(
	cod_modulo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    numhoras INT NOT NULL,
    bilingue ENUM ('S','N'),
    cod_ciclo INT,
    curso TINYINT, -- 1 o 2
    CONSTRAINT fk_mod_ciclo FOREIGN KEY(cod_ciclo) REFERENCES CICLO(cod_ciclo)
);

CREATE TABLE CONTRATO(
	cod_contrato INT,
    dni_profesor VARCHAR(9),   
    CONSTRAINT pk_contrato PRIMARY KEY(cod_contrato),
	CONSTRAINT fk_contrato_profesor FOREIGN KEY(dni_profesor) REFERENCES PROFESOR(dni)
);

CREATE TABLE CONTRATO_MODULO(
	cod_contrato INT,
    cod_modulo INT,
    CONSTRAINT pk_contrato PRIMARY KEY(cod_contrato,cod_modulo),
    CONSTRAINT fk_contrato_modulo FOREIGN KEY(cod_contrato) REFERENCES CONTRATO(cod_contrato),
	CONSTRAINT fk_contrato_modulo_mod FOREIGN KEY(cod_modulo) REFERENCES MODULO(cod_modulo)
);

CREATE TABLE ALUMNO(
	dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    prApellido VARCHAR(50) NOT NULL,
    sgApellido VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    mail VARCHAR (50),
    ultima_titulacion ENUM ('BACH', 'ESO', 'CFGM', 'CFGS', 'FB', 'GRADO', 'OTRO')
);

CREATE TABLE MATRICULA(
	matricula INT,
    dni_alumno VARCHAR(9) NOT NULL,
    curso YEAR NOT NULL,
    CONSTRAINT pk_matricula PRIMARY KEY(matricula),
    CONSTRAINT fk_matricula_alumno FOREIGN KEY(dni_alumno) REFERENCES ALUMNO(dni)
);

CREATE TABLE CALIFICACION(
	matricula INT,
    cod_modulo INT,
    nota INT,
    CONSTRAINT pk_calificacion PRIMARY KEY(matricula,cod_modulo),
    CONSTRAINT fk_calif_matricula FOREIGN KEY(matricula) REFERENCES MATRICULA(matricula),
	CONSTRAINT fk_calif_modulo FOREIGN KEY(cod_modulo) REFERENCES MODULO(cod_modulo)
);


INSERT INTO DEPARTAMENTO (cod_dpto, nombre)
VALUES 
    (1, 'INFORMATICA'), 
    (2, 'FOL'),
    (3, 'MECÁNICA'),
    (4, 'INGLÉS');


INSERT INTO PROFESOR (dni, nombre, prApellido, sgApellido, mail, cod_dpto)
VALUES
    ('12345678A', 'Juan', 'Pérez', 'García', 'juan.perez@gmail.com', 1),
    ('98765432B', 'María', 'López', 'Martínez', 'maria.lopez@gmail.com', 2),
    ('11111111C', 'Carlos', 'Gómez', null, 'carlos.gomez@gmail.com', 1),
    ('22222222D', 'Ana', 'Martínez', 'Sánchez', 'ana.martinez@gmail.com', 2),
    ('33333333E', 'David', 'Fernández', 'González', 'david.fernandez@gmail.com', 1),
    ('44444444F', 'Laura', 'Sánchez', 'Díaz', 'laura.sanchez@gmail.com', null),
    ('55555555G', 'Pablo', 'Rodríguez', 'Hernández', 'pablo.rodriguez@gmail.com', 1),
    ('66666666H', 'Elena', 'González', 'Muñoz', null, 2),
    ('77777777I', 'Sergio', 'Díaz', null, 'sergio.diaz@gmail.com', 1),
    ('88888888J', 'Carmen', 'Muñoz', 'Álvarez', 'carmen.munoz@gmail.com', 2),
    ('55555556E', 'Ana', 'López', 'Sánchez', 'ana.lopez@gmail.com', 3),
    ('66666667F', 'Carlos', 'Martínez', 'González', 'carlos.martinez@gmail.com', 4),
    ('77777778G', 'Laura', 'García', null, 'laura.garcia@gmail.com', null),
    ('88888889H', 'Pedro', 'Sánchez', 'Fernández', 'pedro.sanchez@gmail.com', 4),
    ('99999990I', 'María', 'Hernández', 'Gómez', 'maria.hernandez@gmail.com', null),
    ('99999991J', 'Javier', 'García', 'Fernández', 'javier.garcia@gmail.com', null),
    ('99999992K', 'Lucía', 'Martínez', 'Sánchez', 'lucia.martinez@gmail.com', 3),
    ('99999993L', 'David', 'Gómez', 'Pérez', null, 1);

UPDATE DEPARTAMENTO SET dni_director = '12345678A' where cod_dpto = 1;
UPDATE DEPARTAMENTO SET dni_director = '98765432B' where cod_dpto = 2;
UPDATE DEPARTAMENTO SET dni_director = '55555556E' where cod_dpto = 3;


INSERT INTO ALUMNO (dni, nombre, prApellido, sgApellido, fecha_nacimiento, mail, ultima_titulacion)
VALUES
    ('11111111K', 'Pedro', 'Gómez', 'Sánchez', '2000-01-15', 'pedro.gomez@gmail.com', 'CFGM'),
    ('22222222L', 'Laura', 'Díaz', 'Fernández', '1999-05-20', 'laura.diaz@gmail.com', 'BACH'),
    ('33333333M', 'Miguel', 'Fernández', 'García', '1998-11-10', 'miguel.fernandez@gmail.com', 'CFGS'),
    ('44444444N', 'Ana', 'García', 'Martínez', '1997-09-25', 'ana.garcia@gmail.com', 'ESO'),
    ('55555555O', 'Lucía', 'Martínez', 'López', '2001-03-05', 'lucia.martinez@gmail.com', 'GRADO'),
    ('66666666P', 'Diego', 'López', 'Pérez', '2002-07-30', 'diego.lopez@gmail.com', 'OTRO'),
    ('77777777Q', 'Elena', 'Pérez', 'Gómez', '1999-08-12', 'elena.perez@gmail.com', 'CFGM'),
    ('88888888R', 'Carlos', 'Sánchez', 'González', '2003-04-18', 'carlos.sanchez@gmail.com', 'FB'),
    ('99999999S', 'María', 'González', 'Romero', '2000-12-22', null, 'CFGS'),
    ('00000000T', 'Javier', 'Romero', 'Álvarez', '1998-06-08', 'javier.romero@gmail.com', 'CFGS'),
    ('12346789C', 'Sofía', 'García', 'Martínez', '2001-03-12', 'sofia.garcia@gmail.com', 'CFGS'),
    ('98654321D', 'Alejandro', 'Martínez', 'Gómez', '2000-07-18', null, 'BACH'),
    ('11111111E', 'Clara', 'Fernández', 'Sánchez', '2002-10-25', 'clara.fernandez@gmail.com', 'CFGM'),
    ('22222222F', 'Daniel', 'López', 'Pérez', '2003-01-30', 'daniel.lopez@gmail.com', 'ESO'),
    ('33333533G', 'Lucas', 'Gómez', 'Hernández', '2000-05-14', 'lucas.gomez@gmail.com', 'CFGM'),
    ('44844444H', 'Valeria', 'Pérez', 'González', '2001-08-22', 'valeria.perez@gmail.com', 'ESO'),
    ('55855555I', 'Manuel', 'Muñoz', 'Martínez', '2002-11-03', null, 'CFGS'),
    ('66665666J', 'Julia', 'Romero', 'Díaz', '2003-02-17', 'julia.romero@gmail.com', 'BACH');



INSERT INTO FAMILIA (cod_familia, nombre)
VALUES
    (1, 'Informática y Comunicaciones'),
    (2, 'Administración y Gestión'),
    (3, 'Sanidad');


INSERT INTO CICLO (cod_ciclo, nombre, sigla, cod_familia)
VALUES
    (1, 'Desarrollo de Aplicaciones Multiplataforma', 'DAM', 1),
    (2, 'Administración y Finanzas', 'ADFY', 2),
    (3, 'Técnico en Cuidados Auxiliares de Enfermería', 'TCAE', 3),
    (4, 'Administración de Sistemas Informáticos en Red', 'ASIR', 1),
    (5, 'Desarrollo de Aplicaciones Web', 'DAW', 1),
    (6, 'Técnico en Emergencias Sanitarias', 'TES', 3);
    

INSERT INTO MODULO (cod_modulo, nombre, numhoras, bilingue, cod_ciclo, curso)
VALUES
    (1, 'Programación', 200, 'N', 1, 1),
    (2, 'Bases de Datos', 180, 'N', 1, 1),
    (3, 'Entornos de Desarrollo', 160, 'N', 1, 1),
    (4, 'Sistemas Informáticos', 150, 'N', 1, 1),
    (5, 'Lenguajes de Marcas y Sistemas de Gestión de Información', 120, 'N', 1, 1),
    (6, 'Formación y Orientación Laboral', 90, 'S', 1, 1),
    (7, 'Empresa e Iniciativa Emprendedora', 60, 'S', 1, 2),
    (8, 'Desarrollo de Interfaces', 220, 'N', 1, 2),
    (9, 'Acceso a Datos', 220, 'N', 1, 2),
    (10, 'Programación Multimedia y Dispositivos Móviles', 160, 'N', 1, 2),
    (11, 'Módulo de ADFY 1', 200, 'N', 2, 1),
    (12, 'Módulo de ADFY 2', 180, 'N', 2, 1),
    (13, 'Módulo de ADFY 3', 160, 'N', 2, 1),
    (14, 'Módulo de ADFY 4', 150, 'N', 2, 1),
    (15, 'Módulo de ADFY 5', 120, 'N', 2, 1),
    (16, 'Módulo de ADFY 6', 90, 'N', 2, 1),
    (17, 'Módulo de ADFY 7', 60, 'N', 2, 1),
    (18, 'Módulo de TCAE 1', 200, 'N', 3, 1),
    (19, 'Módulo de TCAE 2', 180, 'N', 3, 1),
    (20, 'Módulo de TCAE 3', 160, 'N', 3, 1),
    (21, 'Módulo de TCAE 4', 150, 'N', 3, 1),
    (22, 'Módulo de TCAE 5', 120, 'N', 3, 1),
    (23, 'Módulo de TCAE 6', 90, 'N', 3, 1),
    (24, 'Módulo de TCAE 7', 60, 'N', 3, 1),
    (25, 'Sistemas Operativos Monopuesto', 150, 'N', 4, 1),
    (26, 'Sistemas Operativos en Red', 180, 'N', 4, 1),
    (27, 'Seguridad Informática', 160, 'N', 4, 1),
    (28, 'Servicios de Red e Internet', 200, 'N', 4, 1),
    (29, 'Implantación de Sistemas Operativos', 220, 'N', 4, 2),
    (30, 'Programación', 200, 'N', 5, 1),
    (31, 'Diseño Web', 150, 'N', 5, 1),
    (32, 'Bases de Datos', 180, 'N', 5, 1),
    (33, 'Entornos de Desarrollo', 160, 'N', 5, 1),
    (34, 'Lenguajes de Marcas', 120, 'N', 5, 1),
    (35, 'Formación y Orientación Laboral', 90, 'N', 5, 1),
    (36, 'Empresa e Iniciativa Emprendedora', 60, 'S', 5, 2),
    (37, 'Desarrollo Web en Entorno Cliente', 220, 'N', 5, 2),
    (38, 'Desarrollo Web en Entorno Servidor', 220, 'N', 5, 2),
    (39, 'Despliegue de Aplicaciones Web', 160, 'N', 5, 2);


INSERT INTO CONTRATO (cod_contrato, dni_profesor)
VALUES
    (1, '12345678A'), 
    (2, '11111111C'), 
    (3, '33333333E'), 
    (4, '55555555G'),
    (5, '77777777I');
   

INSERT INTO CONTRATO_MODULO (cod_contrato, cod_modulo)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5),
    (3, 6),
    (3, 7),
    (4, 8),
    (4, 9),
    (5, 10);

INSERT INTO MATRICULA (matricula, dni_alumno, curso)
VALUES
    (1, '11111111K', 2020),
    (2, '22222222L', 2020),
    (3, '33333333M', 2020),
    (4, '44444444N', 2020),
    (5, '55555555O', 2020),
    (6, '66666666P', 2020),
    (7, '77777777Q', 2020),
    (8, '88888888R', 2020),
    (9, '99999999S', 2020),
    (10, '00000000T', 2020);

INSERT INTO CALIFICACION (matricula, cod_modulo, nota)
VALUES
    (1, 1, 8),
    (1, 2, 7),
    (2, 3, 6),
    (2, 4, 9),
    (3, 5, 8),
    (3, 6, 7),
    (4, 7, 9),
    (4, 8, 8),
    (5, 9, 7),
    (5, 10, 8);

