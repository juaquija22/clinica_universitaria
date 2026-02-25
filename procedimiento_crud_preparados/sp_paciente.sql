DELIMITER $$

-- ============================================================
-- PACIENTE
-- ============================================================

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

        SET @sql = 'INSERT INTO Paciente (persona_id) VALUES (?)';
        SET @p1  = p_persona_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

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

    -- Consulta estática con JOIN, no necesita parámetros
    SELECT pa.paciente_id,
           pe.nombre,
           pe.telefono
    FROM Paciente pa
    JOIN Persona pe ON pa.persona_id = pe.persona_id;
END$$

-- ------------------------------------------------------------

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

    SET @sql = 'SELECT pa.paciente_id, pe.nombre, pe.telefono
                FROM Paciente pa
                JOIN Persona pe ON pa.persona_id = pe.persona_id
                WHERE pa.paciente_id = ?';
    SET @p1  = p_paciente_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

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

        SET @sql = 'UPDATE Paciente SET persona_id = ? WHERE paciente_id = ?';
        SET @p1  = p_persona_id;
        SET @p2  = p_paciente_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

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

        SET @sql = 'DELETE FROM Paciente WHERE paciente_id = ?';
        SET @p1  = p_paciente_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_paciente_insertar(4);
-- CALL sp_paciente_obtener_todos();
-- CALL sp_paciente_obtener_por_id(501);
-- CALL sp_paciente_actualizar(501, 4);
-- CALL sp_paciente_eliminar(501);
