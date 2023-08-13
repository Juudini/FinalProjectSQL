-- ~~>STORED PROCEDURES<~~----- Obtención de turnos por id_medico -----
-- MEJORANDO LA CONSULTA: despues mejorarla para si pasa otro parametro entonces obtener por estado
DROP PROCEDURE IF EXISTS get_turnos;
DELIMITER $$
CREATE PROCEDURE get_turnos (IN medico_id INT)
BEGIN
	SET @res = CONCAT('
        SELECT t.fecha_hora, t.descripcion, t.estado, 
        p.nombre AS nombre_paciente, p.apellido AS apellido_paciente
        FROM turno t
        INNER JOIN paciente p ON t.id_paciente = p.id_paciente
        WHERE t.id_medico =', medico_id
    );
	PREPARE consulta FROM @res;
    EXECUTE consulta;
END$$

CALL get_turnos(6);

-- ~~>STORED PROCEDURES<~~----- Eliminación de turno por Nombre y Apellido -----
-- Apellidos y nombres para Probar: 
-- Gonzalez - Juan Carlos. <--> De Simone - Josefina. <--> Gutierrez - Alvaro.
-- Maranessi - Tomas. <--> Akitabara - Toulette.
-- Despues arreglar para que busque si el estado es el mismo que el que ya tiene y tire un error
set @@sql_safe_updates=0
DROP PROCEDURE IF EXISTS change_estado_turno;
DELIMITER $$
CREATE PROCEDURE change_estado_turno (
	IN paciente_id INT, 
    IN medico_id INT,
	IN nuevo_estado VARCHAR(20),
    OUT p_resultado VARCHAR(100)
)
BEGIN
    -- Verificar si existe al menos un turno con los ID de paciente y médico dados
    DECLARE turno_exist INT;
    SET turno_exist = (
        SELECT COUNT(*)
        FROM turno
        WHERE id_paciente = paciente_id AND id_medico = medico_id
    );
    IF turno_exist = 0 THEN
        SET p_resultado = 'Turno no encontrado.';
    ELSE
        IF nuevo_estado = (SELECT estado FROM turno WHERE id_paciente = paciente_id AND id_medico = medico_id LIMIT 1) THEN
            SET p_resultado = 'El estado es el mismo.';
        ELSEIF nuevo_estado = 'cancelado' THEN
            -- Cancelar y eliminar el turno
            DELETE FROM turno 
            WHERE id_paciente = paciente_id AND id_medico = medico_id;
            SET p_resultado = 'Turno cancelado exitosamente.';
        ELSE
            -- Modificar el estado del turno
            UPDATE turno 
            SET estado = UPPER(nuevo_estado)
            WHERE id_paciente = paciente_id AND id_medico = medico_id;
            SET p_resultado = CONCAT('Turno modificado: ', nuevo_estado, '.');
        END IF;
    END IF;
END$$

CALL change_estado_turno(1, 2, 'confirmado', @resultado);
SELECT @resultado;
