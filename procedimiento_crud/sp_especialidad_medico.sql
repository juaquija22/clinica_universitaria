

DELIMITER $$

CREATE PROCEDURE sp_especialidad_medico_insertar(
    IN p_medico_id    INT,
    IN p_especialidad VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO Especialidad_Medico (medico_id, especialidad)
        VALUES (p_medico_id, p_especialidad);
    COMMIT;
END$$

CREATE PROCEDURE sp_especialidad_medico_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
    END;

    SELECT em.medico_id,
           pe.nombre AS nombre_medico,
           em.especialidad
    FROM Especialidad_Medico em
    JOIN Medico  m  ON em.medico_id = m.medico_id
    JOIN Persona pe ON m.persona_id = pe.persona_id;
END$$

CREATE PROCEDURE sp_especialidad_medico_obtener_por_medico(
    IN p_medico_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
    END;

    SELECT em.medico_id,
           pe.nombre AS nombre_medico,
           em.especialidad
    FROM Especialidad_Medico em
    JOIN Medico  m  ON em.medico_id = m.medico_id
    JOIN Persona pe ON m.persona_id = pe.persona_id
    WHERE em.medico_id = p_medico_id;
END$$

CREATE PROCEDURE sp_especialidad_medico_actualizar(
    IN p_medico_id        INT,
    IN p_especialidad_old VARCHAR(100),
    IN p_especialidad_new VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE Especialidad_Medico
        SET especialidad = p_especialidad_new
        WHERE medico_id    = p_medico_id
          AND especialidad = p_especialidad_old;
    COMMIT;
END$$

CREATE PROCEDURE sp_especialidad_medico_eliminar(
    IN p_medico_id    INT,
    IN p_especialidad VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Especialidad_Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        DELETE FROM Especialidad_Medico
        WHERE medico_id    = p_medico_id
          AND especialidad = p_especialidad;
    COMMIT;
END$$

DELIMITER ;


-- CALL sp_especialidad_medico_insertar(10, 'Pediatría');
-- CALL sp_especialidad_medico_obtener_todos();
-- CALL sp_especialidad_medico_obtener_por_medico(10);
-- CALL sp_especialidad_medico_actualizar(10, 'Infectología', 'Virología');
-- CALL sp_especialidad_medico_eliminar(10, 'Infectología');
