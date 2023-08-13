DROP DATABASE IF EXISTS clinicalsys;
-- Creación de tabla
CREATE DATABASE IF NOT EXISTS clinicalsys;
USE clinicalsys;

CREATE TABLE area (
	id_area INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE medico (
	id_medico INT PRIMARY KEY AUTO_INCREMENT,
	id_area INT NOT NULL,  
	apellido VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	FOREIGN KEY (id_area) REFERENCES area (id_area)
);

CREATE TABLE administrativo (
    id_administrativo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	telefono VARCHAR(20) NOT NULL
);

CREATE TABLE asignacion_medico_administrativo (
    id_asignacion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_medico INT NOT NULL,
    id_administrativo INT,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_administrativo) REFERENCES administrativo(id_administrativo)
);

CREATE TABLE paciente (
	id_paciente INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
	dni INT NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);

CREATE TABLE tratamiento (
	id_tratamiento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_medico INT NOT NULL,
	id_paciente INT NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE,
	costo DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
	FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

CREATE TABLE estado_turno (
    id_estado_turno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE turno (
	id_turno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_paciente INT NOT NULL,
	id_medico INT NOT NULL,
    id_estado_turno INT NOT NULL,
	fecha_hora DATETIME NOT NULL,
	descripcion VARCHAR(100),
    costo DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_estado_turno) REFERENCES estado_turno(id_estado_turno)
);

CREATE TABLE historial_medico (
	id_historial_medico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_paciente INT NOT NULL,
	id_turno INT NOT NULL,
	id_tratamiento INT NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	fecha_hora DATETIME NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
	FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
	FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento)
);

CREATE TABLE metodo_pago (
	id_metodo_pago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE tipo_transaccion (
    id_tipo_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE historial_pagos_facturacion (
    id_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_turno INT NOT NULL,
    id_tratamiento INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    fecha_transaccion DATE NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    tipo_transaccion VARCHAR(20) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago)
);

-- Create LOG table for paciente
CREATE TABLE log_paciente (
	id_log_paciente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	operation_date DATE NOT NULL,
	operation_time TIME NOT NULL,
	operation_type VARCHAR(10) NOT NULL,
	id_paciente INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- Create LOG table for turno
CREATE TABLE log_turno (
	id_log_turno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	operation_date DATE NOT NULL,
	operation_time TIME NOT NULL,
	operation_type VARCHAR(10) NOT NULL,
	id_turno INT NOT NULL,
	fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno)
);