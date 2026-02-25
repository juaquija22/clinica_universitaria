DELIMITER $$

-- ============================================================
-- CITA
-- ============================================================

CREATE PROCEDURE sp_cita_insertar(
    IN p_fecha       DATE,
    IN p_diagnostico VARCHAR(200),
    IN p_paciente_id INT,
    IN p_medico_id   INT,
    IN p_sede_id     INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'INSERT INTO Cita (fecha, diagnostico, paciente_id, medico_id, sede_id)
                    VALUES (?, ?, ?, ?, ?)';
        SET @p1  = p_fecha;
        SET @p2  = p_diagnostico;
        SET @p3  = p_paciente_id;
        SET @p4  = p_medico_id;
        SET @p5  = p_sede_id;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3, @p4, @p5;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_obtener_todos()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
    END;

    SELECT c.cod_cita,
           c.fecha,
           c.diagnostico,
           pp.nombre AS nombre_paciente,
           pm.nombre AS nombre_medico,
           s.nombre_sede
    FROM Cita c
    JOIN Paciente pa ON c.paciente_id = pa.paciente_id
    JOIN Persona  pp ON pa.persona_id = pp.persona_id
    JOIN Medico   m  ON c.medico_id   = m.medico_id
    JOIN Persona  pm ON m.persona_id  = pm.persona_id
    JOIN Sede     s  ON c.sede_id     = s.sede_id;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_obtener_por_id(
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
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
    END;

    SET @sql = 'SELECT c.cod_cita, c.fecha, c.diagnostico,
                       pp.nombre AS nombre_paciente,
                       pm.nombre AS nombre_medico,
                       s.nombre_sede
                FROM Cita c
                JOIN Paciente pa ON c.paciente_id = pa.paciente_id
                JOIN Persona  pp ON pa.persona_id = pp.persona_id
                JOIN Medico   m  ON c.medico_id   = m.medico_id
                JOIN Persona  pm ON m.persona_id  = pm.persona_id
                JOIN Sede     s  ON c.sede_id     = s.sede_id
                WHERE c.cod_cita = ?';
    SET @p1  = p_cod_cita;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @p1;
    DEALLOCATE PREPARE stmt;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_actualizar(
    IN p_cod_cita    INT,
    IN p_fecha       DATE,
    IN p_diagnostico VARCHAR(200),
    IN p_paciente_id INT,
    IN p_medico_id   INT,
    IN p_sede_id     INT
)
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'UPDATE Cita
                    SET fecha       = ?,
                        diagnostico = ?,
                        paciente_id = ?,
                        medico_id   = ?,
                        sede_id     = ?
                    WHERE cod_cita = ?';
        SET @p1  = p_fecha;
        SET @p2  = p_diagnostico;
        SET @p3  = p_paciente_id;
        SET @p4  = p_medico_id;
        SET @p5  = p_sede_id;
        SET @p6  = p_cod_cita;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1, @p2, @p3, @p4, @p5, @p6;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

-- ------------------------------------------------------------

CREATE PROCEDURE sp_cita_eliminar(
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
        CALL sp_error_log_insertar('Cita', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        SET @sql = 'DELETE FROM Cita WHERE cod_cita = ?';
        SET @p1  = p_cod_cita;
        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @p1;
        DEALLOCATE PREPARE stmt;

    COMMIT;
END$$

DELIMITER ;


-- CALL sp_cita_insertar('2024-06-01', 'Fiebre Alta', 501, 10, 1);
-- CALL sp_cita_obtener_todos();
-- CALL sp_cita_obtener_por_id(1);
-- CALL sp_cita_actualizar(1, '2024-05-10', 'Gripe Severa', 501, 10, 1);
-- CALL sp_cita_eliminar(1);
