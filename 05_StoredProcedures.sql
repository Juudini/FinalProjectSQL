USE clinicalsys;
-- ~~>STORED PROCEDURES<~~ ----- Obtener turnos con id_medico -----
DROP PROCEDURE IF EXISTS get_turnos;
DELIMITER $$
CREATE PROCEDURE get_turnos (IN medico_id INT)
BEGIN
	SET @res = CONCAT('
        SELECT t.fecha, t.hora, t.descripcion,
        et.nombre, 
        p.nombre AS nombre_paciente,
        p.apellido AS apellido_paciente
        FROM turno t
        INNER JOIN paciente p ON t.id_paciente = p.id_paciente
        INNER JOIN estado_turno et ON t.id_estado_turno = et.id_estado_turno
        WHERE t.id_medico =', medico_id
    );
	PREPARE consulta FROM @res;
    EXECUTE consulta;
END$$

CALL get_turnos(6);

-- ~~>STORED PROCEDURES<~~ ----- Cambiar estado del turno por id_turno -----
set @@sql_safe_updates=0
DROP PROCEDURE IF EXISTS change_estado_turno;
DELIMITER $$
CREATE PROCEDURE change_estado_turno (
	IN p_turno INT,
	IN nuevo_estado VARCHAR(20),
    OUT p_resultado VARCHAR(100)
)
BEGIN
    -- Verificar si existe el turno
    DECLARE turno_exist INT;
    SET turno_exist = (
        SELECT COUNT(*)
        FROM turno
        WHERE id_turno = p_turno
    );
    IF turno_exist = 0 THEN
        SET p_resultado = 'Turno no encontrado.';
    ELSE
        IF nuevo_estado = (SELECT nombre FROM estado_turno 
			WHERE id_estado_turno = (
			SELECT id_estado_turno 
			FROM turno 
			WHERE id_turno = p_turno)) THEN
            SET p_resultado = 'El estado es el mismo.';
        ELSEIF nuevo_estado = 'Cancelado' THEN
            -- Cancelar y eliminar el turno
            DELETE FROM turno 
            WHERE id_turno = p_turno;
            SET p_resultado = 'Turno cancelado exitosamente.';
        ELSE
            -- Modificar el estado del turno
            UPDATE turno 
            SET id_estado_turno = (
            SELECT id_estado_turno
            FROM estado_turno et 
            WHERE nuevo_estado = et.nombre LIMIT 1)
            WHERE id_turno = p_turno;
            SET p_resultado = CONCAT('Turno modificado: ', nuevo_estado, '.');
        END IF;
    END IF;
END$$

CALL change_estado_turno(7, 'Confirmado', @resultado);
SELECT @resultado;

DROP PROCEDURE IF EXISTS obtener_historial_medico;
-- ~~>STORED PROCEDURES<~~ ----- Obtener Historial medico completo mediante id_paciente -----
DELIMITER $$
CREATE PROCEDURE obtener_historial_medico(id_paciente_param INT)
BEGIN
    SELECT
        hm.id_paciente,
        t.fecha AS fecha_turno,
        m.apellido AS apellido_medico,
        m.nombre AS nombre_medico,
        tr.descripcion AS descripcion_tratamiento,
        tr.fecha_inicio AS fecha_inicio_tratamiento,
        tr.fecha_fin AS fecha_fin_tratamiento
    FROM historial_medico hm
    INNER JOIN turno t ON hm.id_turno = t.id_turno
    INNER JOIN medico m ON t.id_medico = m.id_medico
    INNER JOIN tratamiento tr ON hm.id_tratamiento = tr.id_tratamiento
    WHERE hm.id_paciente = id_paciente_param;
END$$

CALL obtener_historial_medico(2);
