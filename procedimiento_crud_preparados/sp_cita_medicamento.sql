DELIMITER $$

-- ============================================================
-- CITA_MEDICAMENTO
-- ============================================================

CREATE PROCEDURE sp_cita_medicamento_insertar(
    IN p_cod_cita       INT,
    IN p_medicamento_id INT,
    IN p_dosis          VARCHAR(20)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita_Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'INSERT INTO Cita_Medicamento (cod_cita, medicamento_id, dosis) VALUES (?, ?, ?)';
        SET @p1  = p_cod_cita;
        SET @p2  = p_medicamento_id;
        SET @p3  = p_dosis;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_medicamento_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita_Medicamento', v_codigo, v_mensaje);
    END;

    SELECT cm.cod_cita,
           c.fecha,
           med.nombre_medicamento,
           cm.dosis
    FROM Cita_Medicamento cm
    JOIN Cita        c   ON cm.cod_cita       = c.cod_cita
    JOIN Medicamento med ON cm.medicamento_id = med.medicamento_id;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_medicamento_obtener_por_cita(
    IN p_cod_cita INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita_Medicamento', v_codigo, v_mensaje);
    END;

    SET @sql = 'SELECT cm.cod_cita, c.fecha, med.nombre_medicamento, cm.dosis
                FROM Cita_Medicamento cm
                JOIN Cita        c   ON cm.cod_cita       = c.cod_cita
                JOIN Medicamento med ON cm.medicamento_id = med.medicamento_id
                WHERE cm.cod_cita = ?';
    SET @p1  = p_cod_cita;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_medicamento_actualizar(
    IN p_cod_cita       INT,
    IN p_medicamento_id INT,
    IN p_dosis          VARCHAR(20)
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita_Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Cita_Medicamento SET dosis = ?
                    WHERE cod_cita = ? AND medicamento_id = ?';
        SET @p1  = p_dosis;
        SET @p2  = p_cod_cita;
        SET @p3  = p_medicamento_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_medicamento_eliminar(
    IN p_cod_cita       INT,
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
        CALL sp_error_log_insertar('Cita_Medicamento', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Cita_Medicamento WHERE cod_cita = ? AND medicamento_id = ?';
        SET @p1  = p_cod_cita;
        SET @p2  = p_medicamento_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_cita_medicamento_insertar(1, 3, '250mg');
-- CALL sp_cita_medicamento_obtener_todos();
-- CALL sp_cita_medicamento_obtener_por_cita(1);
-- CALL sp_cita_medicamento_actualizar(1, 1, '1000mg');
-- CALL sp_cita_medicamento_eliminar(1, 2);
