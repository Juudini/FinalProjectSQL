USE clinicalsys;
-- ~~>STORED PROCEDURES<~~ ----- Obtener todos los turnos del medico con id_medico -----
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

-- ~~>STORED PROCEDURES<~~ ----- Obtener historial medico completo de paciente -----
DELIMITER $$
CREATE PROCEDURE obtener_historial_medico_paciente(IN paciente_id INT)
BEGIN
    SELECT t.id_turno AS id_evento, 
    t.fecha AS fecha_evento,
    t.hora AS hora_evento, 
    'Turno' AS tipo_evento
    FROM turno t
    WHERE t.id_paciente = paciente_id
    UNION ALL
    SELECT tr.id_tratamiento AS id_evento,
    tr.fecha_inicio AS fecha_evento,
    NULL AS hora_evento,
    'Tratamiento' AS tipo_evento
    FROM tratamiento tr
    WHERE tr.id_paciente = paciente_id
    ORDER BY id_evento DESC;
END$$
CALL obtener_historial_medico_paciente (6)
