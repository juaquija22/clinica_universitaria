DELIMITER $$

-- ============================================================
-- MEDICAMENTO
-- ============================================================

CREATE PROCEDURE sp_medicamento_insertar(
    IN p_nombre_medicamento VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'INSERT INTO Medicamento (nombre_medicamento) VALUES (?)';
        SET @p1  = p_nombre_medicamento;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_medicamento_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medicamento', v_codigo, v_mensaje);
    END;

    SELECT * FROM Medicamento;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_medicamento_obtener_por_id(
    IN p_medicamento_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medicamento', v_codigo, v_mensaje);
    END;

    SET @sql = 'SELECT * FROM Medicamento WHERE medicamento_id = ?';
    SET @p1  = p_medicamento_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_medicamento_actualizar(
    IN p_medicamento_id     INT,
    IN p_nombre_medicamento VARCHAR(100)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Medicamento SET nombre_medicamento = ? WHERE medicamento_id = ?';
        SET @p1  = p_nombre_medicamento;
        SET @p2  = p_medicamento_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_medicamento_eliminar(
    IN p_medicamento_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Medicamento WHERE medicamento_id = ?';
        SET @p1  = p_medicamento_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_medicamento_insertar('Metformina');
-- CALL sp_medicamento_obtener_todos();
-- CALL sp_medicamento_obtener_por_id(1);
-- CALL sp_medicamento_actualizar(1, 'Paracetamol 500');
-- CALL sp_medicamento_eliminar(1);
