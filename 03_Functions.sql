-- ~~~> FUNCTION: Calcular cantidad Turnos por medico: <~~~
DELIMITER $$
CREATE FUNCTION calcular_turnos_por_medico(p_id_medico INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num_turnos INT;
    
    SELECT COUNT(*) INTO num_turnos
    FROM turno
    WHERE id_medico = p_id_medico;
    
    RETURN num_turnos;
END$$

-- ~~~> FUNCTION: Calcular cantidad de Medicos Asociados a un Area: <~~~
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

-- ~~~> FUNCTION: Calcular Promedio de Costo de Turno por Paciente: <~~~
DELIMITER $$
CREATE FUNCTION calcular_promedio_costo_turno() RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avg_cost DECIMAL(10, 2);
    
    SELECT AVG(costo) INTO avg_cost
    FROM turno;
    
    RETURN avg_cost;
END$$

-- ~~~> FUNCTION: Calcular Total de Ingresos por Tratamientos en un Rango de Fechas: <~~~
DELIMITER $$
CREATE FUNCTION calcular_total_ingresos_tratamientos(p_fecha_inicio DATE, p_fecha_fin DATE) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_ingresos DECIMAL(10, 2);
    
    SELECT SUM(importe) INTO total_ingresos
    FROM historial_facturacion_tratamiento
    WHERE id_tipo_transaccion = 1
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

    -- Verificar si se encontro el paciente
    IF paciente_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Paciente no encontrado';
    END IF;
    RETURN paciente_id;
END$$
