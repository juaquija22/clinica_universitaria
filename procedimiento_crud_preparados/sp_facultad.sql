DELIMITER $$

-- ============================================================
-- FACULTAD
-- ============================================================

CREATE PROCEDURE sp_facultad_insertar(
    IN p_nombre_facultad VARCHAR(100),
    IN p_decano          VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Facultad', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'INSERT INTO Facultad (nombre_facultad, decano) VALUES (?, ?)';
        SET @p1  = p_nombre_facultad;
        SET @p2  = p_decano;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_facultad_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Facultad', v_codigo, v_mensaje);
    END;

    SELECT * FROM Facultad;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_facultad_obtener_por_id(
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
        CALL sp_error_log_insertar('Facultad', v_codigo, v_mensaje);
    END;

    SET @sql = 'SELECT * FROM Facultad WHERE facultad_id = ?';
    SET @p1  = p_facultad_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_facultad_actualizar(
    IN p_facultad_id     INT,
    IN p_nombre_facultad VARCHAR(100),
    IN p_decano          VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Facultad', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Facultad SET nombre_facultad = ?, decano = ? WHERE facultad_id = ?';
        SET @p1  = p_nombre_facultad;
        SET @p2  = p_decano;
        SET @p3  = p_facultad_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_facultad_eliminar(
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
        CALL sp_error_log_insertar('Facultad', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Facultad WHERE facultad_id = ?';
        SET @p1  = p_facultad_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_facultad_insertar('Ingeniería', 'Dr. Turing');
-- CALL sp_facultad_obtener_todos();
-- CALL sp_facultad_obtener_por_id(1);
-- CALL sp_facultad_actualizar(1, 'Medicina General', 'Dr. Wilson');
-- CALL sp_facultad_eliminar(1);
