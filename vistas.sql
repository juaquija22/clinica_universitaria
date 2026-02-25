-- ============================================================
-- VISTA 1: Médico con su facultad y especialidades
-- ============================================================

CREATE OR REPLACE VIEW vista_medico_detalle AS
SELECT
    m.medico_id,
    pe.nombre               AS medico,
    pe.telefono,
    f.nombre_facultad       AS facultad,
    f.decano,
    em.especialidad
FROM Medico m
JOIN Persona              pe ON m.persona_id  = pe.persona_id
JOIN Facultad             f  ON m.facultad_id = f.facultad_id
LEFT JOIN Especialidad_Medico em ON m.medico_id = em.medico_id;



-- ============================================================
-- VISTA 2: Número de pacientes por medicamento
-- Cuenta cuántos pacientes distintos han recibido cada medicamento
-- ============================================================

CREATE OR REPLACE VIEW vista_pacientes_por_medicamento AS
SELECT
    med.medicamento_id,
    med.nombre_medicamento          AS medicamento,
    COUNT(DISTINCT c.paciente_id)   AS total_pacientes
FROM Medicamento med
LEFT JOIN Cita_Medicamento cm  ON med.medicamento_id = cm.medicamento_id
LEFT JOIN Cita             c   ON cm.cod_cita        = c.cod_cita
GROUP BY med.medicamento_id, med.nombre_medicamento
ORDER BY total_pacientes DESC;


-- ============================================================
-- CONSULTAS DE USO
-- ============================================================

-- Ver todos los médicos con su facultad y especialidad
-- SELECT * FROM vista_medico_detalle;

-- Buscar un médico específico
-- SELECT * FROM vista_medico_detalle WHERE medico_id = 10;

-- Filtrar por facultad
-- SELECT * FROM vista_medico_detalle WHERE facultad = 'Medicina General';

-- Ver ranking de medicamentos más usados
-- SELECT * FROM vista_pacientes_por_medicamento;

-- Ver solo medicamentos con al menos 1 paciente
-- SELECT * FROM vista_pacientes_por_medicamento WHERE total_pacientes > 0;