DELIMITER $$

-- ============================================================
-- PERSONA
-- ============================================================

CREATE PROCEDURE sp_persona_insertar(
    IN p_nombre   VARCHAR(100),
    IN p_telefono VARCHAR(20)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    -- Captura cualquier error SQL, registra y revierte
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Persona', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        -- Sentencia preparada para evitar SQL Injection
        SET @sql = 'INSERT INTO Persona (nombre, telefono) VALUES (?, ?)';
        SET @p1  = p_nombre;
        SET @p2  = p_telefono;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_persona_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Persona', v_codigo, v_mensaje);
    END;

    -- Consulta estática, no requiere parámetros
    SELECT * FROM Persona;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_persona_obtener_por_id(
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
        CALL sp_error_log_insertar('Persona', v_codigo, v_mensaje);
    END;

    -- Sentencia preparada para el filtro por ID
    SET @sql = 'SELECT * FROM Persona WHERE persona_id = ?';
    SET @p1  = p_persona_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_persona_actualizar(
    IN p_persona_id INT,
    IN p_nombre     VARCHAR(100),
    IN p_telefono   VARCHAR(20)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Persona', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Persona SET nombre = ?, telefono = ? WHERE persona_id = ?';
        SET @p1  = p_nombre;
        SET @p2  = p_telefono;
        SET @p3  = p_persona_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_persona_eliminar(
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
        CALL sp_error_log_insertar('Persona', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Persona WHERE persona_id = ?';
        SET @p1  = p_persona_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_persona_insertar('Carlos López', '600-444');
-- CALL sp_persona_obtener_todos();
-- CALL sp_persona_obtener_por_id(1);
-- CALL sp_persona_actualizar(1, 'Carlos López Ruiz', '600-555');
-- CALL sp_persona_eliminar(1);
