USE clinicalsys;
-- Vista Áreas con sus médicos
CREATE OR REPLACE VIEW area_medicos AS
SELECT m.apellido AS apellido_medico, 
	m.nombre AS nombre_medico, 
	a.nombre AS area 
FROM medico m 
INNER JOIN area a ON m.id_area = a.id_area;

-- Vista Gestión Turnos
CREATE OR REPLACE VIEW gestion_turnos AS
SELECT a.nombre AS area,
	m.apellido AS apellido_medico, 
	m.nombre AS nombre_medico,
    t.fecha_hora, t.estado,
	p.apellido AS apellido_paciente, 
	p.nombre AS nombre_paciente,
    t.descripcion AS turno_descripcion
FROM turno t
INNER JOIN paciente p ON t.id_paciente = p.id_paciente
INNER JOIN medico m ON t.id_medico = m.id_medico
INNER JOIN area a ON m.id_medico = a.id_area 
ORDER BY a.id_area DESC;

-- Vista Tratamientos de pacientes
CREATE OR REPLACE VIEW tratamientos_pacientes AS
SELECT m.apellido AS medico_apellido,
	m.nombre AS medico_nombre,
    tr.descripcion AS tratamiento_descripcion,
    tr.fecha_inicio AS tratamiento_fecha_inicio,
    tr.fecha_fin AS tratamiento_fecha_fin,
    a.nombre AS area,
    p.apellido AS paciente_apellido,
	p.nombre AS paciente_nombre,
    tr.costos AS tratamiento_costos
FROM tratamiento tr
INNER JOIN medico m ON tr.id_medico = m.id_medico
INNER JOIN paciente p ON tr.id_paciente = p.id_paciente
INNER JOIN area a ON m.id_area = a.id_area
ORDER BY a.id_area DESC;

-- Vista Turnos Confirmados
CREATE OR REPLACE VIEW turnos_confirmados AS
SELECT m.apellido AS apellido_medico,
	m.nombre AS nombre_medico,
	a.nombre AS area,
	t.fecha_hora,
	p.apellido AS apellido_paciente,
	p.nombre AS nombre_paciente
FROM paciente p
INNER JOIN turno t ON  t.id_paciente = p.id_paciente
INNER JOIN medico m ON m.id_medico = t.id_medico
INNER JOIN area a ON m.id_area = a.id_area
WHERE t.estado = 'Confirmado'
ORDER BY a.id_area DESC;

-- Vista Turnos Pendientes
CREATE OR REPLACE VIEW turnos_pendientes AS
SELECT m.apellido AS apellido_medico,
	m.nombre AS nombre_medico,
	a.nombre AS area,
	t.fecha_hora,
	p.apellido AS apellido_paciente,
	p.nombre AS nombre_paciente
FROM paciente p
INNER JOIN turno t ON t.id_paciente = p.id_paciente
INNER JOIN medico m ON m.id_medico = t.id_medico
INNER JOIN area a ON  m.id_area = a.id_area
WHERE t.estado = 'Pendiente'
ORDER BY a.id_area DESC;