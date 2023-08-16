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
       (9, 5),
       (10, 5);

-- Insertar Paciente
INSERT INTO paciente (dni, apellido, nombre, email, telefono, direccion)
VALUES (18222301,'Gonzalez','Juan Carlos','jcarlos18@gmail.com','+54 9 0263 400 9222','Calle Falsa 123'),
       (25056091,'De Simone','Josefina','josedesimone@gmail.com','+54 9 0261 958 8811','Avenida Imaginaria 456'),
       (52258903,'Gutierrez','Alvaro','alvaritogamer6@yahoo.com','+54 9 0263 466 1272','Calle Inventada 789'),
       (40128666,'Maranessi','Tomas','tomasitojeffthe01@hotmail.com','+54 9 0263 455 9987','Boulevard Irreal 101'),
       (26481878,'Akitabara','Toulette','akitainu00@hotmail.com','+1 9 5120 620 0331','Street Imaginary 567'),
       (30876543, 'Romero', 'Luis', 'luis.romero@hotmail.com', '+54 9 0261 567 8901', 'Avenida de Sueños 210'),
       (46891234, 'Fernández', 'Sofía', 'sofia.fernandez@gmail.com', '+54 9 0261 123 4567', 'Calle Ficticia 987'),
       (53987123, 'Ramírez', 'Martín', 'martin.ramirez@hotmail.com', '+54 9 0263 987 6543', 'Calle de Ensueño 345'),
       (62548912, 'López', 'Valentina', 'valentina.lopez@gmail.com', '+54 9 0263 456 7890', 'Calle Irrealidad 678'),
       (71235678, 'Pereira', 'Lucas', 'lucas.pereira@hotmail.com', '+54 9 0261 345 6789', 'Boulevard Imaginario 789'),
       (87912345, 'Suárez', 'Isabella', 'isabella.suarez@gmail.com', '+54 9 0261 987 6543', 'Avenida Irreal 543'),
       (98765432, 'Gómez', 'Mateo', 'mateo.gomez@hotmail.com', '+54 9 0263 321 3213', 'Calle de los Sueños 432'),
       (50123456, 'Silva', 'Camila', 'camila.silva@gmail.com', '+54 9 0263 567 1234', 'Avenida de Fantasía 123'),
       (63345231, 'Torres', 'Felipe', 'felipe.torres@hotmail.com', '+54 9 0261 894 5612', 'Boulevard Imaginación 987'),
       (70123456, 'Rodríguez', 'Julieta', 'julieta.rodriguez@gmail.com', '+54 9 0261 123 4560', 'Calle de Ensueños 765');

-- Insertar Estados de Pago
INSERT INTO estado_pago (nombre)
VALUES ('Pendiente'),
       ('Reembolsado'),
       ('Completado'),
       ('Cancelado'),
       ('Error');

-- Insertar Metodos de pago
INSERT INTO metodo_pago (nombre)
VALUES ('Efectivo'),
       ('Mercado Pago'),
       ('Transferencia Bancaria');

-- Insertar Tipo transaccion
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
INSERT INTO turno (id_paciente, id_medico, fecha, hora, descripcion, id_estado_turno, costo, id_administrativo)
VALUES (6, 1, '2023-09-25', '09:00:00', 'Control acné', 3, 12500.00, 1),
       (7, 6, '2023-09-26', '10:00:00', 'Chequeo análisis', 3, 13500.00, 2),
       (8, 5, '2023-09-27', '11:15:00', 'Control acné', 1, 12500.00, 1),
       (9, 6, '2023-09-28', '12:00:00', 'Chequeo análisis', 3, 8500.00, 2),
       (10, 9, '2023-09-29', '11:00:00', 'Chequeo general', 3, 10000.00, 5),
       (12, 2, '2023-09-30', '15:00:00', 'Chequeo general', 1, 8500.00, 1),
       (14, 7, '2023-10-02', '17:00:00', 'Chequeo general', 1, 8600.00, 3),
       (15, 10, '2023-11-03', '18:00:00', 'Control fractura', 3, 20000.00, 5),
       (1, 1, '2023-12-15', '10:00:00', 'Control acné', 3, 12500.00, 1),
       (2, 2, '2023-12-15', '10:00:00', 'Control acné', 3, 12500.00, 1),
       (3, 3, '2023-12-15', '12:00:00', 'Control acné', 3, 12500.00, 1),
       (4, 8, '2023-12-16', '12:00:00', 'Control vista', 3, 12500.00, 4),
       (5, 5, '2023-12-16', '12:00:00', 'Control acné', 3, 12500.00, 1),
       (13, 6, '2023-12-16', '16:00:00', 'Pedido estudios clínicos', 3, 13500.00, 2),
       (11, 8, '2023-12-17', '14:30:00', 'Chequeo general', 3, 10000.00, 4);
       
-- Insertar Tratamientos       
INSERT INTO tratamiento (id_paciente, id_medico, descripcion, fecha_inicio, fecha_fin, costo)
VALUES (1, 1, 'Tratamiento de Acné', '2023-09-25', '2023-06-30', 15000.00),
       (9, 6, 'Tratamiento de Hipertensión', '2023-09-28', '2023-10-13', 80300.00),
       (4, 8, 'Operación de Miopía', '2023-12-16', '2023-12-16', 46000.00),
       (6, 10, 'Tratamiento de Vacunas', '2023-06-18', '2023-06-20', 1000.00),
       (10, 9, 'Tratamiento de Hormonas', '2023-09-29', '2024-02-28', 0864005.81),
	   (15, 10, 'Tratamiento de Fracturas', '2023-11-03', '2024-12-31', 18000.00);

-- Insertar la transacción en la tabla historial_facturacion_turno
START TRANSACTION;

INSERT INTO historial_facturacion_turno (id_turno, id_tipo_transaccion, id_estado_pago, id_metodo_pago, fecha_transaccion, descripcion, importe)
VALUES (1, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (2, 1, 3, 1, NOW(), 'Facturación Consulta', 13500.00),
       (4, 1, 3, 1, NOW(), 'Facturación Consulta', 10000.00),
       (5, 1, 3, 1, NOW(), 'Facturación Consulta', 8500.00),
       (8, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (9, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (10, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (11, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (12, 1, 3, 1, NOW(), 'Facturación Consulta', 12500.00),
       (13, 1, 3, 1, NOW(), 'Facturación Consulta', 13500.00),
       (14, 1, 3, 1, NOW(), 'Facturación Consulta', 10000.00),
       (15, 1, 3, 1, NOW(), 'Facturación Consulta', 10000.00);

COMMIT;
       
-- Insertar la transacción en la tabla historial_facturacion_tratamiento
START TRANSACTION;

INSERT INTO historial_facturacion_tratamiento (id_tratamiento, id_tipo_transaccion, id_estado_pago, id_metodo_pago, fecha_transaccion, descripcion, importe)
VALUES (1, 1, 3, 1, NOW(), 'Facturación cremas', 15000.00),
       (2, 1, 3, 2, NOW(), 'Facturación medicación', 80300.00),
       (3, 1, 3, 2, NOW(), 'Facturación operación', 46000.00),
       (4, 1, 3, 1, NOW(), 'Facturación vacuna', 10000.00),
       (5, 1, 3, 1, NOW(), 'Facturación medicación', 0864005.81),
       (6, 1, 3, 2, NOW(), 'Facturación procedimiento médico', 18000.00);

COMMIT;