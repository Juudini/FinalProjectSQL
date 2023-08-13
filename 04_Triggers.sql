USE clinicalsys;
-- AGREGAR EL BEGIN / END a los que faltan
-- HACER UN TRIGGER PARA AL MOMENTO DE Add un turno y tratamiento se añada tambien al historial medico del paciente
-- Controlar el tema de que al ser un Turno tiene que el turno estar 
DELIMITER $$
CREATE TRIGGER add_to_historial
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
	INSERT INTO historial_medico (id_paciente, id_turno, descripcion, fecha_hora)
	VALUES(NEW.id_paciente, NEW.id_turno, NEW.descripcion, CURTIME());
END$$


-- BEFORE Trigger inserción en la tabla "paciente"
DELIMITER $$
CREATE TRIGGER log_paciente_validation
BEFORE INSERT ON paciente
FOR EACH ROW
BEGIN
    -- Asegurar que los campos 'apellido' y 'nombre' siempre estén en mayúsculas
    SET NEW.apellido = UPPER(NEW.apellido);
    SET NEW.nombre = UPPER(NEW.nombre);
END$$

DELIMITER $$
-- AFTER Trigger inserción en la tabla "paciente"
CREATE TRIGGER log_paciente_insert
AFTER INSERT ON paciente
FOR EACH ROW
    INSERT INTO log_paciente (username, operation_date, operation_time, operation_type, id_paciente, dni, apellido, nombre)
    VALUES (USER(), CURDATE(), CURTIME(), 'AFTER', NEW.id_paciente, NEW.dni, NEW.apellido, NEW.nombre);
$$

-- TRIGGERS log_turno

DELIMITER $$
-- Trigger BEFORE inserción en la tabla "turno"
CREATE TRIGGER log_turno_validation
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
  ## Verificar si la fecha de inicio es mayor que la fecha actual.
	IF NEW.fecha_hora < NOW() THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No se puede insertar un turno con fecha de inicio anterior a la fecha actual.';
	END IF;
END$$

-- Trigger AFTER inserción en la tabla "turno"
CREATE TRIGGER log_turno_insert
AFTER INSERT ON turno
FOR EACH ROW
  INSERT INTO log_turno (username, operation_date, operation_time, operation_type, id_turno, id_paciente, id_medico, id_tratamiento, fecha_hora, estado)
  VALUES (USER(), CURDATE(), CURTIME(), 'INSERT', NEW.id_turno, NEW.id_paciente, NEW.id_medico, NEW.id_tratamiento, NEW.fecha_hora, NEW.estado);

-- TRIGGERS historial_medico (Para insertarlos en historial al momento de crear un tratamiento)


-- BEFORE Trigger inserción en la tabla "paciente"
DELIMITER $$
CREATE TRIGGER estado_to_upper_case
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
    -- Asegurar que el campo estado siempre este en mayusculas
    SET NEW.estado = UPPER(NEW.estado);
END$$

DELIMITER //

CREATE TRIGGER before_update_turno
BEFORE UPDATE ON turno
FOR EACH ROW
BEGIN
    DECLARE admin_id INT;
    DECLARE med_id INT;

    -- Obtener el ID del administrativo que está realizando la modificación
    SELECT id_administrativo INTO admin_id FROM administrativo WHERE email = NEW.username; -- Asegúrate de reemplazar "username" por el campo correcto que identifica al administrativo

    -- Obtener el ID del médico asociado al turno
    SELECT id_medico INTO med_id FROM turno WHERE id_turno = NEW.id_turno;

    -- Verificar si el administrativo es el mismo que asignó el turno y si es el médico asociado
    IF admin_id != NEW.id_administrativo OR admin_id != med_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No tienes permiso para modificar este turno';
    END IF;
END;
//

DELIMITER ;
