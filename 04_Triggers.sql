-- Trigger BEFORE INSERT en la tabla "turno"
DELIMITER $$
CREATE TRIGGER before_log_turno_validation
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
    -- Verificar si la fecha de inicio es mayor que la fecha actual.
    IF NEW.fecha < NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede insertar un turno con fecha de inicio anterior a la fecha actual.';
    END IF;
END$$

-- Trigger BEFORE INSERT en la tabla "paciente"
DELIMITER $$
CREATE TRIGGER before_log_paciente_validation
BEFORE INSERT ON paciente
FOR EACH ROW
BEGIN
    -- Asegurar que los campos 'apellido' y 'nombre' siempre estén en mayúsculas
    SET NEW.apellido = UPPER(NEW.apellido);
    SET NEW.nombre = UPPER(NEW.nombre);
END$$

-- Trigger AFTER INSERT en la tabla "paciente"
DELIMITER $$
CREATE TRIGGER after_log_paciente_insert
AFTER INSERT ON paciente
FOR EACH ROW
BEGIN
    INSERT INTO log_paciente (operation_date, operation_time, operation_type, id_paciente, dni, apellido, nombre)
    VALUES (CURDATE(), CURTIME(), 'AFTER', NEW.id_paciente, NEW.dni, NEW.apellido, NEW.nombre);
END$$

-- Trigger AFTER UPDATE datos paciente
DELIMITER $$
CREATE TRIGGER after_log_paciente_update
AFTER UPDATE ON paciente
FOR EACH ROW
BEGIN
    INSERT INTO log_paciente (operation_date, operation_time, operation_type, id_paciente, dni, apellido, nombre)
    VALUES (CURDATE(), CURTIME(), 'UPDATE', NEW.id_paciente, NEW.dni, NEW.apellido, NEW.nombre);
END$$

-- Trigger BEFORE, validar al insertar turno
DELIMITER $$
CREATE TRIGGER before_insert_turno_validation
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
    DECLARE is_relationship INT;
    -- Verificar si el administrativo está asociado al médico
    SELECT COUNT(*) INTO is_relationship FROM asignacion_medico_administrativo
    WHERE id_administrativo = NEW.id_administrativo
    AND id_medico = NEW.id_medico;
    -- Si no hay coincidencias, lanzar una excepción
    IF is_relationship = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El administrativo no está relacionado con el médico.';
    END IF;
END$$

-- Trigger AFTER INSERT en la tabla "turno"
DELIMITER $$
CREATE TRIGGER after_log_turno_insert
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
	INSERT INTO log_turno (id_administrativo, operation_date, operation_time, operation_type, id_turno, id_estado_turno, descripcion, costo)
    VALUES (NEW.id_administrativo, CURDATE(), CURTIME(), 'INSERT', NEW.id_turno, NEW.id_estado_turno, NEW.descripcion, NEW.costo);
END$$