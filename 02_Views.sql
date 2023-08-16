USE clinicalsys;
-- Vista Áreas con sus médicos
CREATE OR REPLACE VIEW area_medicos AS
SELECT m.apellido AS apellido_medico, 
	m.nombre AS nombre_medico, 
	a.nombre AS area 
FROM medico m 
INNER JOIN area a ON m.id_area = a.id_area;

-- Vista Medicos con sus administrativos (Asistente/Secretario/a)
CREATE OR REPLACE VIEW medicos_y_administrativos AS
SELECT a.nombre AS area,
       m.apellido AS apellido_medico, 
       m.nombre AS nombre_medico,
       adm.apellido AS apellido_administrativo,
       adm.nombre AS nombre_administrativo
FROM asignacion_medico_administrativo med_adm
INNER JOIN medico m ON med_adm.id_medico = m.id_medico
INNER JOIN administrativo adm ON med_adm.id_administrativo = adm.id_administrativo
INNER JOIN area a ON m.id_area = a.id_area;

-- Vista Gestión Turnos
CREATE OR REPLACE VIEW gestion_turnos AS
SELECT a.nombre AS area,
	m.apellido AS apellido_medico, 
	m.nombre AS nombre_medico,
    t.fecha, t.hora,
    et.nombre,
	p.apellido AS apellido_paciente, 
	p.nombre AS nombre_paciente,
    t.descripcion AS turno_descripcion
FROM turno t
INNER JOIN paciente p ON t.id_paciente = p.id_paciente
INNER JOIN medico m ON t.id_medico = m.id_medico
INNER JOIN area a ON m.id_medico = a.id_area
INNER JOIN estado_turno et ON t.id_estado_turno = et.id_estado_turno
ORDER BY a.id_area DESC;

-- Vista Tratamientos
CREATE OR REPLACE VIEW tratamientos_pacientes AS
SELECT m.apellido AS medico_apellido,
	m.nombre AS medico_nombre,
    tr.descripcion AS tratamiento_descripcion,
    tr.fecha_inicio AS tratamiento_fecha_inicio,
    tr.fecha_fin AS tratamiento_fecha_fin,
    a.nombre AS area,
    p.apellido AS paciente_apellido,
	p.nombre AS paciente_nombre,
    tr.costo AS tratamiento_costo
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
       t.fecha,
       t.hora,
       p.apellido AS apellido_paciente,
       p.nombre AS nombre_paciente
FROM paciente p
INNER JOIN turno t ON p.id_paciente = t.id_paciente
INNER JOIN medico m ON t.id_medico = m.id_medico
INNER JOIN area a ON m.id_area = a.id_area
INNER JOIN estado_turno et ON t.id_estado_turno = et.id_estado_turno
WHERE et.nombre = 'Confirmado'
ORDER BY a.id_area DESC;

-- Vista Turnos Pendientes
CREATE OR REPLACE VIEW turnos_programados AS
SELECT m.apellido AS apellido_medico,
       m.nombre AS nombre_medico,
       a.nombre AS area,
       t.fecha,
       t.hora,
       p.apellido AS apellido_paciente,
       p.nombre AS nombre_paciente
FROM turno t
INNER JOIN paciente p ON t.id_paciente = p.id_paciente
INNER JOIN medico m ON t.id_medico = m.id_medico
INNER JOIN area a ON m.id_area = a.id_area
INNER JOIN estado_turno et ON t.id_estado_turno = et.id_estado_turno
WHERE et.nombre = 'Programado'
ORDER BY a.id_area DESC;

-- Vista Historial de Facturación de Turnos:
CREATE VIEW vista_facturacion_turnos AS
SELECT
    hft.id_transaccion_turno AS id_transaccion,
    t.id_turno AS id_turno,
    tt.nombre AS tipo_transaccion,
    ep.nombre AS estado_pago,
    mp.nombre AS metodo_pago,
    hft.fecha_transaccion AS fecha_transaccion,
    hft.descripcion AS descripcion,
    hft.importe AS importe
FROM
    historial_facturacion_turno hft
JOIN turno t ON hft.id_turno = t.id_turno
JOIN tipo_transaccion tt ON hft.id_tipo_transaccion = tt.id_tipo_transaccion
JOIN estado_pago ep ON hft.id_estado_pago = ep.id_estado_pago
JOIN metodo_pago mp ON hft.id_metodo_pago = mp.id_metodo_pago;

-- Vista Historial de Facturación de Tratamientos:

CREATE VIEW vista_facturacion_tratamientos AS
SELECT
    hft.id_transaccion_tratamiento AS id_transaccion,
    tr.id_tratamiento AS id_tratamiento,
    tt.nombre AS tipo_transaccion,
    ep.nombre AS estado_pago,
    mp.nombre AS metodo_pago,
    hft.fecha_transaccion AS fecha_transaccion,
    hft.descripcion AS descripcion,
    hft.importe AS importe
FROM
    historial_facturacion_tratamiento hft
JOIN tratamiento tr ON hft.id_tratamiento = tr.id_tratamiento
JOIN tipo_transaccion tt ON hft.id_tipo_transaccion = tt.id_tipo_transaccion
JOIN estado_pago ep ON hft.id_estado_pago = ep.id_estado_pago
JOIN metodo_pago mp ON hft.id_metodo_pago = mp.id_metodo_pago;
