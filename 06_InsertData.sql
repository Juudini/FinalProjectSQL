USE clinicalsys;

-- Insertar Áreas
INSERT INTO area (nombre)
VALUES ('DERMATOLOGÍA'),
       ('CARDIOLOGÍA'),
       ('OFTALMOLOGÍA'),
       ('PEDIATRÍA'),
       ('TRAUMATOLOGÍA');

-- Insertar Médicos
INSERT INTO medico (id_area, apellido, nombre)
VALUES (1,'Ceretto', 'Juan'),
       (1, 'Pérez', 'Ana'),
       (1, 'García', 'Miguel'),
       (1, 'López', 'María'),
       (1, 'González', 'Pedro'),
       (2,'Houtson', 'Paul'),
       (3,'Hambers', 'Terence'),
       (3, 'Martínez', 'Carlos'),
       (4,'McGreil', 'Siana'),
       (5,'Dowrey', 'Gibbie');

-- Insertar Administrativo (Asistente/Secretario)
INSERT INTO administrativo (username, apellido, nombre, email, telefono)
VALUES ('user1', 'Pérez', 'María', 'maria@gmail.com', '+54 9 0261 123 4567'),
       ('user2', 'Martínez', 'Juan', 'juan@gmail.com', '+54 9 0261 456 7890'),
       ('user3', 'Rodríguez', 'Luis', 'luis@hotmail.com', '+54 9 0261 567 8901'),
       ('user4', 'Hernández', 'Laura', 'laura@yahoo.com', '+54 9 0261 678 9012'),
       ('user5', 'Torres', 'Mónica', 'monica@gmail.com', '+54 9 0261 012 3456');

-- Insertar Relacion Medico-Administrativo (Asistente/Secretario)
INSERT INTO asignacion_medico_administrativo (id_medico, id_administrativo)
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 1),
       (6, 2),
       (7, 3),
       (8, 4),
       (9, 4),
       (10, 5);

-- Insertar Obras Sociales
INSERT INTO obra_social (nombre, direccion, telefono, email, sitio_web)
VALUES ('OSDE', 'Av. Corrientes 1234, Buenos Aires', '+54 11 1234 5678', 'info@osde.com.ar', 'www.osde.com.ar'),
       ('Swiss Medical', 'Av. Santa Fe 4567, CABA', '+54 11 9876 5432', 'info@swissmedical.com.ar', 'www.swissmedical.com.ar'),
       ('Medifé', 'Calle Lavalle 789, Rosario', '+54 341 555 7890', 'info@medife.com.ar', 'www.medife.com.ar'),
       ('Boreal', 'Calle Alameda 1150, Mendoza', '+54 051 687 6810', 'info@boreal.com.ar', 'www.boreal.com.ar'),
       ('Galeno', 'Av. Pueyrredón 234, CABA', '+54 11 5555 9999', 'info@galeno.com.ar', 'www.galeno.com.ar'),
       ('OMINT', 'Calle San Martín 789, Córdoba', '+54 351 444 8888', 'info@omint.com.ar', 'www.omint.com.ar'),
       ('Accord Salud', 'Av. Rivadavia 5678, Mendoza', '+54 261 777 3333', 'info@accordsalud.com.ar', 'www.accordsalud.com.ar'),
       ('Union Personal', 'Av. Belgrano 987, Rosario', '+54 341 222 5555', 'info@unionpersonal.com.ar', 'www.unionpersonal.com.ar');

-- Insertar descuentos relacionados con obras sociales de Argentina
INSERT INTO descuento (nombre, porcentaje, descripcion, id_obra_social) 
VALUES ('Descuento OSDE', 10.00, 'Descuento exclusivo para afiliados de OSDE', 1),
	   ('Descuento Swiss Medical', 15.00, 'Descuento para afiliados de Swiss Medical', 2),
       ('Descuento Medifé', 12.50, 'Descuento para afiliados de Medifé', 3),
       ('Descuento Boreal', 8.00, 'Descuento para afiliados de Boreal', 4),
       ('Descuento Galeno', 10.00, 'Descuento para afiliados de Galeno', 5),
       ('Descuento OMINT', 20.00, 'Descuento especial para afiliados de OMINT', 6),
       ('Descuento Accord Salud', 12.00, 'Descuento para afiliados de Accord Salud', 7),
       ('Descuento Union Personal', 7.50, 'Descuento para afiliados de Union Personal', 8);
    
-- Insertar Paciente
INSERT INTO paciente (dni, apellido, nombre, email, telefono, direccion, id_obra_social)
VALUES (18222301,'Gonzalez','Juan Carlos','jcarlos18@gmail.com','+54 9 0263 400 9222','Calle Falsa 123', 1),
       (25056091,'De Simone','Josefina','josedesimone@gmail.com','+54 9 0261 958 8811','Avenida Imaginaria 456', 1),
       (52258903,'Gutierrez','Alvaro','alvaritogamer6@yahoo.com','+54 9 0263 466 1272','Calle Inventada 789', 1),
       (40128666,'Maranessi','Tomas','tomasitojeffthe01@hotmail.com','+54 9 0263 455 9987','Boulevard Irreal 101', 2),
       (26481878,'Akitabara','Toulette','akitainu00@hotmail.com','+1 9 5120 620 0331','Street Imaginary 567', 3),
       (30876543, 'Romero', 'Luis', 'luis.romero@hotmail.com', '+54 9 0261 567 8901', 'Avenida de Sueños 210', 4),
       (46891234, 'Fernández', 'Sofía', 'sofia.fernandez@gmail.com', '+54 9 0261 123 4567', 'Calle Ficticia 987', 5),
       (53987123, 'Ramírez', 'Martín', 'martin.ramirez@hotmail.com', '+54 9 0263 987 6543', 'Calle de Ensueño 345', 5),
       (62548912, 'López', 'Valentina', 'valentina.lopez@gmail.com', '+54 9 0263 456 7890', 'Calle Irrealidad 678', 6),
       (71235678, 'Pereira', 'Lucas', 'lucas.pereira@hotmail.com', '+54 9 0261 345 6789', 'Boulevard Imaginario 789', 6),
       (87912345, 'Suárez', 'Isabella', 'isabella.suarez@gmail.com', '+54 9 0261 987 6543', 'Avenida Irreal 543', 7),
       (98765432, 'Gómez', 'Mateo', 'mateo.gomez@hotmail.com', '+54 9 0263 321 3213', 'Calle de los Sueños 432', 7),
       (50123456, 'Silva', 'Camila', 'camila.silva@gmail.com', '+54 9 0263 567 1234', 'Avenida de Fantasía 123', 8),
       (63345231, 'Torres', 'Felipe', 'felipe.torres@hotmail.com', '+54 9 0261 894 5612', 'Boulevard Imaginación 987', 8),
       (70123456, 'Rodríguez', 'Julieta', 'julieta.rodriguez@gmail.com', '+54 9 0261 123 4560', 'Calle de Ensueños 765', 3);
    
-- Insertar Metodos de pago
INSERT INTO metodo_pago (nombre)
VALUES ('Efectivo'),
       ('Mercado Pago'),
       ('Transferencia Bancaria');

INSERT INTO tipo_transaccion (nombre)
VALUES ('Facturación'),
       ('Reembolso'),
       ('Descuento');
       
-- Insertar Estados turno
INSERT INTO estado_turno (nombre)
VALUES ('Programado'),
       ('Cancelado'),
       ('Confirmado');

-- Insertar Turnos
INSERT INTO turno (id_paciente, id_medico, fecha, hora, descripcion, id_estado_turno, costo, username)
VALUES (6, 1, '2023-09-25', '09:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (7, 6, '2023-09-26', '10:00:00', 'Chequeo análisis', 3, 13500.00, 'user1'),
       (8, 5, '2023-09-27', '11:15:00', 'Control acné', 1, 12000.00, 'user1'),
       (9, 6, '2023-09-28', '12:00:00', 'Chequeo general', 1, 0.00, 'user1'),
       (10, 9, '2023-09-29', '11:00:00', 'Chequeo general', 3, 10000.00, 'user1'),
       (12, 2, '2023-09-30', '15:00:00', 'Chequeo general', 1, 8500.00, 'user1'),
       (14, 7, '2023-10-02', '17:00:00', 'Chequeo general', 1, 0.00, 'user1'),
       (15, 10, '2023-11-03', '18:00:00', 'Control fractura', 3, 20000.00, 'user1'),
       (1, 1, '2023-12-15', '10:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (2, 2, '2023-12-15', '10:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (3, 3, '2023-12-15', '12:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (4, 4, '2023-12-16', '13:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (5, 5, '2023-12-16', '13:00:00', 'Control acné', 3, 12500.00, 'user1'),
       (13, 6, '2023-12-16', '16:00:00', 'Pedido estudios clínicos', 3, 13500.00, 'user1'),
       (11, 8, '2023-12-17', '14:30:00', 'Chequeo general', 3, 10000.00, 'user1');
       
-- Insertar Tratamientos       
INSERT INTO tratamiento (id_paciente, id_medico, descripcion, fecha_inicio, fecha_fin, costo)
VALUES (1, 1, 'Tratamiento de Acné', '2023-06-15', '2023-06-30', 15000),
       (2, 6, 'Tratamiento de Hipertensión', '2023-06-16', '2023-06-25', 80300),
       (4, 8, 'Tratamiento de Miopía', '2023-06-17', '2023-06-22', 20000),
       (6, 10, 'Tratamiento de Vacunas', '2023-06-18', '2023-06-20', 1000),
       (3, 9, 'Tratamiento de Fracturas', '2023-07-29', '2023-08-19', 118000);