-- ============================================================
-- FUNCIONES — CLÍNICA UNIVERSITARIA
-- ============================================================



-- 1. Número de doctores dada una especialidad

DELIMITER $$

CREATE FUNCTION fn_doctores_por_especialidad(
    p_especialidad VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total       INT DEFAULT 0;
    DECLARE v_codigo      INT DEFAULT 0;
    DECLARE v_mensaje     VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
        RETURN -1;
    END;

    SELECT COUNT(medico_id)
    INTO   v_total
    FROM   Especialidad_Medico
    WHERE  especialidad = p_especialidad;

    RETURN v_total;
END$$



-- 2. Total de pacientes atendidos por un médico

DELIMITER $$
CREATE FUNCTION fn_pacientes_por_medico(
    p_medico_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total   INT DEFAULT 0;
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
        RETURN -1;
    END;

    SELECT COUNT(DISTINCT paciente_id)
    INTO   v_total
    FROM   Cita
    WHERE  medico_id = p_medico_id;

    RETURN v_total;
END$$


-- 3. Cantidad de pacientes atendidos dada una sede

DELIMITER $$
CREATE FUNCTION fn_pacientes_por_sede(
    p_sede_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total   INT DEFAULT 0;
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
        RETURN -1;
    END;

    SELECT COUNT(DISTINCT paciente_id)
    INTO   v_total
    FROM   Cita
    WHERE  sede_id = p_sede_id;

    RETURN v_total;
END$$

DELIMITER ;



-- Número de doctores con especialidad Infectología:
-- SELECT fn_doctores_por_especialidad('Infectología') AS total_doctores;

-- Total de pacientes atendidos por el médico con ID 10:
-- SELECT fn_pacientes_por_medico(10) AS total_pacientes;

-- Cantidad de pacientes atendidos en la sede con ID 1:
-- SELECT fn_pacientes_por_sede(1) AS total_pacientes;