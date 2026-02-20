
DELIMITER $$

CREATE PROCEDURE sp_paciente_insertar(
    IN p_persona_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Paciente', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO Paciente (persona_id)
        VALUES (p_persona_id);
    COMMIT;
END$$

CREATE PROCEDURE sp_paciente_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Paciente', v_codigo, v_mensaje);
    END;

    SELECT pa.paciente_id,
           pe.nombre,
           pe.telefono
    FROM Paciente pa
    JOIN Persona pe ON pa.persona_id = pe.persona_id;
END$$

CREATE PROCEDURE sp_paciente_obtener_por_id(
    IN p_paciente_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Paciente', v_codigo, v_mensaje);
    END;

    SELECT pa.paciente_id,
           pe.nombre,
           pe.telefono
    FROM Paciente pa
    JOIN Persona pe ON pa.persona_id = pe.persona_id
    WHERE pa.paciente_id = p_paciente_id;
END$$

CREATE PROCEDURE sp_paciente_actualizar(
    IN p_paciente_id INT,
    IN p_persona_id  INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Paciente', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE Paciente
        SET persona_id = p_persona_id
        WHERE paciente_id = p_paciente_id;
    COMMIT;
END$$

CREATE PROCEDURE sp_paciente_eliminar(
    IN p_paciente_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Paciente', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        DELETE FROM Paciente
        WHERE paciente_id = p_paciente_id;
    COMMIT;
END$$

DELIMITER ;


-- CALL sp_paciente_insertar(4);
-- CALL sp_paciente_obtener_todos();
-- CALL sp_paciente_obtener_por_id(501);
-- CALL sp_paciente_actualizar(501, 4);
-- CALL sp_paciente_eliminar(501);
