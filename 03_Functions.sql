-- ~~~>FUNCTION: Obtener descripción de último tratamiento realizado por tal médico<~~~
-- Médicos existentes: Juan, Paul, Terence, Siana, Gibbie

DROP FUNCTION IF EXISTS tratamientos_de;

DELIMITER $$
CREATE FUNCTION tratamientos_de(nombre_medico VARCHAR(20)) 
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(100);
	SET result = (SELECT CONCAT(tratamiento.descripcion, ' con el paciente ', paciente.nombre) 
		FROM tratamiento
	INNER JOIN medico
		ON tratamiento.id_medico = medico.id_medico
	INNER JOIN paciente
		ON tratamiento.id_paciente = paciente.id_paciente
		WHERE medico.nombre LIKE CONCAT('%', nombre_medico,'%')
		ORDER BY tratamiento.id_tratamiento DESC
		LIMIT 1);
	IF result IS NULL THEN
		SET result = CONCAT('No se ha encontrado tratamiento con el doctor ', nombre_medico);
	END IF;
    
    RETURN result;
END$$

SELECT tratamientos_de('Juan') AS Tratamiento;

-- ~~~> FUNCTION: Obtener estado del último turno <~~~
-- Médicos existentes: Ceretto, Houtson, Hambers, McGreil, Dowrey.

DROP FUNCTION IF EXISTS estado_ultimo_turno;

DELIMITER $$
CREATE FUNCTION estado_ultimo_turno (apellido_medico VARCHAR(20)) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE total VARCHAR(50);
	SET total = (SELECT estado
		FROM turno
		WHERE id_medico IN (SELECT id_medico
		FROM medico
		WHERE apellido LIKE CONCAT('%', apellido_medico,'%'))
        ORDER BY turno.estado DESC
        LIMIT 1);

    IF total IS NULL THEN
		SET total = CONCAT('No se han encontrados turnos de DOCTOR: ', apellido_medico);
	END IF;
    
    	RETURN total;
END$$
SELECT estado_ultimo_turno('Miguel') AS Turno;

-- OBTENER paciente por su DNI


