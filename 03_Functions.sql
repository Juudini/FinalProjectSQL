-- ~~~>FUNCTION: Obtener descripción de último tratamiento realizado por tal médico<~~~

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

-- ~~~> FUNCTION: Obtener total Pacientes por Obra Social: <~~~
DELIMITER $$
CREATE FUNCTION pacientes_por_obra_social(p_id_obra_social INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE paciente_count INT;
    
    SELECT COUNT(*) INTO paciente_count
    FROM paciente
    WHERE id_obra_social = p_id_obra_social;
    RETURN paciente_count;
END$$

-- ~~~> FUNCTION: Calcular Turnos por medico: <~~~
DELIMITER $$
CREATE FUNCTION contar_turnos_por_medico(p_id_medico INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num_turnos INT;
    
    SELECT COUNT(*) INTO num_turnos
    FROM turno
    WHERE id_medico = p_id_medico;
    
    RETURN num_turnos;
END$$

-- ~~~> FUNCTION: Calcular Total de Pagos de un Paciente: <~~~
DELIMITER $$
CREATE FUNCTION calcular_total_pagos_paciente(p_id_paciente INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_pagos DECIMAL(10, 2);
    
    SELECT SUM(importe) INTO total_pagos
    FROM historial_pagos_facturacion
    WHERE id_turno IN (SELECT id_turno FROM turno WHERE id_paciente = p_id_paciente);
    
    RETURN total_pagos;
END$$

-- ~~~> FUNCTION: Calcular Medicos Asociados a un Area: <~~~
DELIMITER $$
CREATE FUNCTION obtener_medicos_por_area(p_id_area INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num_medicos INT;
    
    SELECT COUNT(*) INTO num_medicos
    FROM medico
    WHERE id_area = p_id_area;
    
    RETURN num_medicos;
END$$

-- ~~~> FUNCTION: Calcular Promedio de Costo de Tratamientos por Paciente: <~~~
DELIMITER $$
CREATE FUNCTION calcular_promedio_costo_tratamientos(p_id_paciente INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avg_costo DECIMAL(10, 2);
    
    SELECT AVG(costo) INTO avg_costo
    FROM tratamiento
    WHERE id_paciente = p_id_paciente;
    
    RETURN avg_costo;
END$$


-- ~~~> FUNCTION: Calcular Total de Ingresos por Tratamientos en un Rango de Fechas: <~~~
DELIMITER $$
CREATE FUNCTION calcular_total_ingresos_tratamientos(p_fecha_inicio DATE, p_fecha_fin DATE) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_ingresos DECIMAL(10, 2);
    
    SELECT SUM(importe) INTO total_ingresos
    FROM historial_pagos_facturacion
    WHERE tipo_transaccion = 'Tratamiento'
    AND fecha_transaccion BETWEEN p_fecha_inicio AND p_fecha_fin;
    
    RETURN total_ingresos;
END$$


-- ~~~> FUNCTION: Obtener PacienteID por DNI: <~~~
DROP FUNCTION IF EXISTS get_paciente_por_dni;

DELIMITER $$
CREATE FUNCTION get_paciente_por_dni(p_dni INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE paciente_id INT;

    -- Realizar la consulta para obtener el paciente por DNI
    SELECT id_paciente INTO paciente_id
    FROM paciente
    WHERE dni = p_dni;

    -- Verificar si se encontró el paciente
    IF paciente_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Paciente no encontrado';
    END IF;
    RETURN paciente_id;
END$$
