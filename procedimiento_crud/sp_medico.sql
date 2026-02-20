

DELIMITER $$

CREATE PROCEDURE sp_medico_insertar(
    IN p_persona_id  INT,
    IN p_facultad_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO Medico (persona_id, facultad_id)
        VALUES (p_persona_id, p_facultad_id);
    COMMIT;
END$$

CREATE PROCEDURE sp_medico_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medico', v_codigo, v_mensaje);
    END;

    SELECT m.medico_id,
           pe.nombre,
           pe.telefono,
           f.nombre_facultad,
           f.decano
    FROM Medico m
    JOIN Persona  pe ON m.persona_id  = pe.persona_id
    JOIN Facultad f  ON m.facultad_id = f.facultad_id;
END$$

CREATE PROCEDURE sp_medico_obtener_por_id(
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
        CALL sp_error_log_insertar('Medico', v_codigo, v_mensaje);
    END;

    SELECT m.medico_id,
           pe.nombre,
           pe.telefono,
           f.nombre_facultad,
           f.decano
    FROM Medico m
    JOIN Persona  pe ON m.persona_id  = pe.persona_id
    JOIN Facultad f  ON m.facultad_id = f.facultad_id
    WHERE m.medico_id = p_medico_id;
END$$

CREATE PROCEDURE sp_medico_actualizar(
    IN p_medico_id   INT,
    IN p_persona_id  INT,
    IN p_facultad_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE Medico
        SET persona_id  = p_persona_id,
            facultad_id = p_facultad_id
        WHERE medico_id = p_medico_id;
    COMMIT;
END$$

CREATE PROCEDURE sp_medico_eliminar(
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
        CALL sp_error_log_insertar('Medico', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;
        DELETE FROM Medico
        WHERE medico_id = p_medico_id;
    COMMIT;
END$$

DELIMITER ;


-- CALL sp_medico_insertar(5, 1);
-- CALL sp_medico_obtener_todos();
-- CALL sp_medico_obtener_por_id(10);
-- CALL sp_medico_actualizar(10, 10, 2);
-- CALL sp_medico_eliminar(10);
