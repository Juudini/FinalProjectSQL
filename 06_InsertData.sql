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

-- Insertar Estados turno
INSERT INTO estado_turno (nombre)
VALUES ('Programado'),
	   ('Cancelado'),
	   ('Completado');

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
       
-- Insertar Tratamientos       
INSERT INTO tratamiento (id_paciente, id_medico, descripcion, fecha_inicio, fecha_fin, costo)
VALUES (1, 1, 'Tratamiento de Acné', '2023-06-15', '2023-06-30', 15000),
       (2, 6, 'Tratamiento de Hipertensión', '2023-06-16', '2023-06-25', 80300),
       (4, 8, 'Tratamiento de Miopía', '2023-06-17', '2023-06-22', 20000),
       (6, 10, 'Tratamiento de Vacunas', '2023-06-18', '2023-06-20', 1000),
       (3, 9, 'Tratamiento de Fracturas', '2023-07-29', '2023-08-19', 118000);
       
-- Insertar Turnos    ARREGLAR HORAS PARA QUE NO TENGAN CON EL MISMO MEDICO AL MISMO HORARIO   
INSERT INTO turno (id_paciente, id_medico, fecha_hora, descripcion, estado)
VALUES (6, 3, '2023-09-25 09:00:00', 'Control acné', 'Confirmado'),
      (7, 6, '2023-09-26 10:00:00', 'Chequeo análisis', 'Confirmado'),
      (8, 5, '2023-09-27 11:15:00', 'Control acné', 'Confirmado'),
      (9, 6, '2023-09-28 12:00:00', 'Chequeo general', 'Cancelado'),
      (10, 9, '2023-09-29 11:00:00', 'Chequeo general', 'Confirmado'),
      (12, 2, '2023-09-30 15:00:00', 'Chequeo general', 'Pendiente'),
      (14, 7, '2023-10-02 17:00:00', 'Chequeo general', 'Cancelado'),
      (15, 10, '2023-11-03 18:00:00', 'Control fractura', 'Confirmado'),
      (1, 2, '2023-12-15 10:00:00', 'Control acné', 'Confirmado'),
      (2, 2, '2023-12-15 10:00:00', 'Control acné', 'Confirmado'),
      (3, 3, '2023-12-15 12:00:00', 'Control acné', 'Confirmado'),
      (4, 4, '2023-12-16 13:00:00', 'Control acné', 'Confirmado'),
      (5, 5, '2023-12-16 13:00:00', 'Control acné', 'Confirmado'),
      (13, 6, '2023-12-16 16:00:00', 'Pedido estudios clínicos', 'Confirmado'),
      (11, 8, '2023-12-17 14:30:00', 'Chequeo general', 'Confirmado');
      