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
        CONSTRAINT FK_DEPARTAMENTO_ID FOREIGN KEY (departamento_id) REFERENCES departamento (id),
        CONSTRAINT FK_EMPLEADO_JEFE_ID FOREIGN KEY (jefe_id) REFERENCES empleado (id),
        CONSTRAINT CHK_EDAD_ACTIVA CHECK (edad between 18 and 65),
        CONSTRAINT CHK_SALARIO CHECK (salario > 0)
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
    ('Formación', 'Edificio C');

-- Inserts para la tabla de empleados
INSERT INTO
    empleado (nombre, ape1, ape2, edad, salario, fecha_contratacion, departamento_id, jefe_id, comision)
VALUES
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
    ('Fátima', 'Fernández', null, 23, 49000.00, '2012-04-15', 6, null, 1000);

INSERT INTO
    venta (fecha_venta, total, empleado_id)
VALUES
    ('2022-01-15', 150.00, 1),
    ('2024-04-02', 200.50, 2),
    ('2024-04-03', 75.25, 1);