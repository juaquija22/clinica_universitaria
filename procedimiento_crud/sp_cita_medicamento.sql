

DELIMITER $$

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
        INSERT INTO Cita_Medicamento (cod_cita, medicamento_id, dosis)
        VALUES (p_cod_cita, p_medicamento_id, p_dosis);
    COMMIT;
END$$

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

    SELECT cm.cod_cita,
           c.fecha,
           med.nombre_medicamento,
           cm.dosis
    FROM Cita_Medicamento cm
    JOIN Cita        c   ON cm.cod_cita       = c.cod_cita
    JOIN Medicamento med ON cm.medicamento_id = med.medicamento_id
    WHERE cm.cod_cita = p_cod_cita;
END$$

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
        UPDATE Cita_Medicamento
        SET dosis = p_dosis
        WHERE cod_cita       = p_cod_cita
          AND medicamento_id = p_medicamento_id;
    COMMIT;
END$$

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
        DELETE FROM Cita_Medicamento
        WHERE cod_cita       = p_cod_cita
          AND medicamento_id = p_medicamento_id;
    COMMIT;
END$$

DELIMITER ;


-- EJEMPLOS DE USO

-- CALL sp_cita_medicamento_insertar(1, 3, '250mg');
-- CALL sp_cita_medicamento_obtener_todos();
-- CALL sp_cita_medicamento_obtener_por_cita(1);
-- CALL sp_cita_medicamento_actualizar(1, 1, '1000mg');
-- CALL sp_cita_medicamento_eliminar(1, 2);
