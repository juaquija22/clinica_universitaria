DELIMITER $$

-- ============================================================
-- SEDE
-- ============================================================

CREATE PROCEDURE sp_sede_insertar(
    IN p_nombre_sede VARCHAR(100),
    IN p_direccion   VARCHAR(150)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Sede', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'INSERT INTO Sede (nombre_sede, direccion) VALUES (?, ?)';
        SET @p1  = p_nombre_sede;
        SET @p2  = p_direccion;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_sede_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Sede', v_codigo, v_mensaje);
    END;

    SELECT * FROM Sede;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_sede_obtener_por_id(
    IN p_sede_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Sede', v_codigo, v_mensaje);
    END;

    SET @sql = 'SELECT * FROM Sede WHERE sede_id = ?';
    SET @p1  = p_sede_id;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_sede_actualizar(
    IN p_sede_id     INT,
    IN p_nombre_sede VARCHAR(100),
    IN p_direccion   VARCHAR(150)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Sede', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Sede SET nombre_sede = ?, direccion = ? WHERE sede_id = ?';
        SET @p1  = p_nombre_sede;
        SET @p2  = p_direccion;
        SET @p3  = p_sede_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_sede_eliminar(
    IN p_sede_id INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Sede', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Sede WHERE sede_id = ?';
        SET @p1  = p_sede_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_sede_insertar('Sede Sur', 'Carrera 10 #45');
-- CALL sp_sede_obtener_todos();
-- CALL sp_sede_obtener_por_id(1);
-- CALL sp_sede_actualizar(1, 'Centro Médico Principal', 'Calle 5 #10');
-- CALL sp_sede_eliminar(1);
