-- Crear la base de datos
CREATE DATABASE unidad5;

-- Usar la base de datos
USE unidad5;

-- Crear la tabla de departamento
CREATE TABLE
    departamento (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(50) NOT NULL, edificio VARCHAR(50));

-- Crear la tabla de empleado
CREATE TABLE
    empleado (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        ape1 VARCHAR(50) NOT NULL,
        ape2 VARCHAR(50),
        edad TINYINT UNSIGNED NOT NULL,
        salario DECIMAL(10, 2) NOT NULL,
        fecha_contratacion DATE,
        departamento_id INT UNSIGNED,
        jefe_id INT UNSIGNED,
        comision decimal(8, 2) default 0,
        CONSTRAINT FK_EMPLEADO_DEPARTAMENTO FOREIGN KEY (departamento_id) REFERENCES departamento (id),
        CONSTRAINT FK_EMPLEADO_JEFE_ID FOREIGN KEY (jefe_id) REFERENCES empleado (id),
        CONSTRAINT CHK_EDAD_ACTIVA CHECK (edad between 18 and 65),
        CONSTRAINT CHK_SALARIO CHECK (salario > 0)
    );

CREATE TABLE empresa (
    CIF CHAR (9) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_creacion DATE,
    direccion VARCHAR (255),
    total_empleados INT UNSIGNED
);


CREATE TABLE empleado_externo (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ape1 VARCHAR(50) NOT NULL,
    ape2 VARCHAR(50),
    departamento_id INT UNSIGNED,
    jefe_id INT UNSIGNED,
    fecha_subcontratacion DATE NOT NULL,
    cif_subcontrata CHAR (9) NOT NULL,
    CONSTRAINT FK_EMPLEADOEXT_DEPARTAMENTO FOREIGN KEY (departamento_id) REFERENCES departamento (id),
    CONSTRAINT FK_EMPLEADOEXT_EMPLEADO FOREIGN KEY (jefe_id) REFERENCES empleado (id),
    CONSTRAINT FK_EMPLEADOEXT_EMPRESA FOREIGN KEY (cif_subcontrata) REFERENCES empresa (CIF)
);

-- Crear la tabla producto	
CREATE TABLE
    venta (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        fecha_venta DATE NOT NULL,
        total DECIMAL(10, 2) NOT NULL,
        empleado_id INT UNSIGNED,
        CONSTRAINT FK_EMPLEADO_ID FOREIGN KEY (empleado_id) REFERENCES empleado (id)
    );

/***
POR COMODIDAD AQUÍ ESTA EL SCRIPT DE CARGA
 **/
-- Inserts para la tabla de departamentos
INSERT INTO
    departamento (nombre, edificio)
VALUES
    ('Ventas', 'Edificio A'),
    ('Marketing', 'Edificio B'),
    ('IT', 'Edificio C'),
    ('Finanzas', 'Edificio D'),
    ('Departamento nuevo', 'Edificio E'),
    ('Formación', 'Edificio C'),
	('Investigación y Desarrollo', 'Edificio A'),
    ('Calidad', 'Edificio B'),
    ('Administración', 'Edificio I'),
	('Administración de personal', 'Edificio I'),
	('Informática', 'Edificio I'),
    ('Legal', 'Edificio J');

-- Cargar datos en la tabla empresa
INSERT INTO empresa (CIF, nombre, fecha_creacion, direccion, total_empleados) VALUES
    ('A2345678A', 'Empresa A', '2000-01-01', 'Calle Principal 123', 100),
    ('J8765432F', 'Empresa B', '1995-05-10', 'Avenida Central 456', 150),
    ('K6789123A', 'Empresa C', '2005-12-20', 'Plaza Mayor 789', 80),
    ('B6666666H', 'Empresa D', '2018-07-25', 'Calle Mayor 456', 110),
    ('C7777777J', 'Empresa E', '2000-06-30', 'Avenida Central 789', 180),
    ('D8888888B', 'Empresa F', '2009-09-09', 'Plaza de Mayo 123', 170),
    ('J9999999A', 'Empresa G', '2015-04-18', 'Calle Real 456', 130),
    ('A0101010A', 'Empresa H', '2019-11-11', 'Avenida Primavera 789', 160);


-- Inserts para la tabla de empleados
INSERT INTO
    empleado (nombre, ape1, ape2, edad, salario, fecha_contratacion, departamento_id, jefe_id, comision)
VALUES
    ('Iván','García', null, 30, 3000.00, '2022-01-15', 1, null, 600),
    ('Eva', 'García', 'López', 30, 30000.00, '2022-01-15', 1, null, 600),
    ('Jara', 'Martínez', 'Rodríguez', 25, 35000.00, '2021-12-20', 2, null, 0),
    ('Carlos', 'Pérez', 'González', 35, 40000.00, '2022-02-05', 1, 1, 150),
    ('Laura', 'Hernández', 'Fernández', 28, 32000.00, '2022-03-10', null, null, 200),
    ('Ana', 'Díaz', null, 40, 45000.00, '2022-04-25', 4, null, 0),
    ('Pedro', 'López', 'Sánchez', 33, 38000.00, '2021-11-18', 2, 2, 0),
    ('Sofía', 'Martínez', 'Hernández', 27, 31000.00, '2022-03-01', 1, 1, 0),
    ('Rosa', 'Sánchez', 'Martín', 42, 52000.00, '2022-01-05', 4, null, null),
    ('Pablo', 'Gómez', 'Jiménez', 41, 51000.00, '2021-10-10', 1, null, null),
    ('Marta', 'Hernández', 'González', 43, 49000.00, '2022-04-15', 3, null, null),
    ('Angélica', 'Hernández', 'González', 43, 49000.00, '2012-04-15', 3, null, 1000),
    ('Fátima', 'Fernández', null, 23, 49000.00, '2012-04-15', 6, null, 1000),    
    ('Juan', 'García', 'Martínez', 35, 2500.00, '2020-01-15', 1, NULL, 300),
    ('María', 'López', 'González', 28, 2200.00, '2019-05-20', 1, 1, NULL),
    ('Carlos', 'Martínez', 'Rodríguez', 40, 3000.00, '2018-10-10', 2, NULL, 500),
    ('Ana', 'Fernández', 'Pérez', 45, 3500.00, '2017-12-05', 2, 3, NULL),
    ('Pedro', 'Sánchez', 'López', 32, 2800.00, '2021-03-08', 3, NULL, NULL),
    ('Laura', 'González', 'Hernández', 30, 2600.00, '2020-09-15', 3, 5, NUll),
    ('Sergio', 'Díaz', 'Martín', 38, 3200.00, '2019-07-20', 4, NULL, NULL),
    ('Elena', 'Pérez', 'Gómez', 33, 2800.00, '2020-02-10', 4, 7, 4444),
    ('Luis', 'Ruiz', 'Sánchez', 29, 2400.00, '2018-11-25', 5, NULL, 111),
    ('Marta', 'Hernández', 'Díaz', 42, 3300.00, '2017-06-14', 5, 9, 222);

-- Cargar datos en la tabla empleado_externo
INSERT INTO empleado_externo (nombre, ape1, ape2, departamento_id, jefe_id, fecha_subcontratacion, cif_subcontrata) VALUES
    ('Iván','García',null,1, NULL, '2022-03-01', 'A2345678A'),
    ('Ricardo', 'Gómez', 'Pérez', 1, NULL, '2022-03-01', 'A2345678A'),
    ('Ana', 'González', 'Rodríguez', 1, 1, '2022-03-15', 'A2345678A'),
    ('David', 'Martínez', 'García', 2, NULL, '2021-11-10', 'K6789123A'),
    ('Lucía', 'Sánchez', 'López', 2, 3, '2022-01-20', 'K6789123A'),
	('Sofía', 'Gómez', 'Martínez', 1, NULL, '2022-04-01', 'A2345678A'),
    ('Mario', 'Rodríguez', 'Hernández', 1, 1, '2022-04-15', 'A2345678A'),
    ('Lucas', 'Fernández', 'Sánchez', 2, NULL, '2022-04-10', 'J8765432F'),
    ('Laura', 'Martínez', 'González', 2, 3, '2022-04-20', 'J8765432F'),
    ('Diego', 'Hernández', 'López', 3, NULL, '2022-04-05', 'K6789123A'),
    ('Ana', 'García', 'Pérez', 3, 5, '2022-04-25', 'K6789123A'),
    ('Martín', 'Sánchez', 'Gómez', 4, NULL, '2022-04-15', 'B6666666H'),
    ('Sara', 'Pérez', 'Díaz', 4, 7, '2022-04-30', 'B6666666H'),
    ('Eva', 'García', 'López', 5, NULL, '2022-04-20', 'C7777777J'),
    ('Carlos', 'Díaz', 'García', 5, 9, '2022-04-10', 'C7777777J'),
    ('Lucía', 'Hernández', 'Martínez', 6, NULL, '2022-04-25', 'D8888888B'),
    ('Javier', 'Martín', 'Sánchez', 6, 11, '2022-04-05', 'D8888888B'),
    ('Andrea', 'Pérez', 'Gómez', 7, NULL, '2022-04-30', 'J9999999A'),
    ('Daniel', 'López', 'Hernández', 7, 13, '2022-04-15', 'J9999999A'),
    ('María', 'García', 'Martínez', 8, NULL, '2022-04-10', 'A0101010A'),
    ('Pablo', 'Rodríguez', 'López', 8, 15, '2022-04-20', 'A0101010A'),
    ('Eva', 'Garcia', null, 8, 15, '2022-04-20', 'A0101010A');

INSERT INTO
    venta (fecha_venta, total, empleado_id)
VALUES
    ('2022-01-15', 150.00, 1),
    ('2024-04-02', 200.50, 2),
    ('2024-04-03', 75.25, 1),
    ('2022-03-01', 1500.00, 1),
    ('2022-03-15', 2000.00, 2),
    ('2021-11-10', 1800.00, 3),
    ('2022-01-20', 2200.00, 4);