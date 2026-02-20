

DELIMITER $$

CREATE PROCEDURE sp_persona_insertar(
    IN p_nombre    VARCHAR(100),
    IN p_telefono  VARCHAR(20)
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
        INSERT INTO Persona (nombre, telefono)
        VALUES (p_nombre, p_telefono);
    COMMIT;
END$$

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

    SELECT * FROM Persona;
END$$

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

    SELECT * FROM Persona
    WHERE persona_id = p_persona_id;
END$$

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
        UPDATE Persona
        SET nombre   = p_nombre,
            telefono = p_telefono
        WHERE persona_id = p_persona_id;
    COMMIT;
END$$

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
        DELETE FROM Persona
        WHERE persona_id = p_persona_id;
    COMMIT;
END$$

DELIMITER ;


-- CALL sp_persona_insertar('Carlos López', '600-444');
-- CALL sp_persona_obtener_todos();
-- CALL sp_persona_obtener_por_id(1);
-- CALL sp_persona_actualizar(1, 'Carlos López Ruiz', '600-555');
-- CALL sp_persona_eliminar(1);
