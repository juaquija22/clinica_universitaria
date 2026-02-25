DELIMITER $$

-- ============================================================
-- PROCEDIMIENTO: Genera el informe del día actual
-- ============================================================

CREATE PROCEDURE sp_informe_citas_generar()
BEGIN
    DECLARE v_codigo  INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(500);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_codigo  = MYSQL_ERRNO,
            v_mensaje = MESSAGE_TEXT;
        CALL sp_error_log_insertar('Informe_Citas_Diario', v_codigo, v_mensaje);
        ROLLBACK;
    END;

    START TRANSACTION;

        -- Elimina solo los registros del día actual para no duplicar
        DELETE FROM Informe_Citas_Diario
        WHERE fecha_cita = CURDATE();

        -- Inserta el conteo agrupado por sede, médico y fecha
        INSERT INTO Informe_Citas_Diario (fecha_cita, sede, medico, total_pacientes, generado_en)
        SELECT
            c.fecha                   AS fecha_cita,
            s.nombre_sede             AS sede,
            pe_m.nombre               AS medico,
            COUNT(c.paciente_id)      AS total_pacientes,
            NOW()                     AS generado_en
        FROM Cita c
        JOIN Sede     s    ON c.sede_id    = s.sede_id
        JOIN Medico   m    ON c.medico_id  = m.medico_id
        JOIN Persona  pe_m ON m.persona_id = pe_m.persona_id
        WHERE c.fecha = CURDATE()
        GROUP BY c.fecha, s.nombre_sede, pe_m.nombre;

    COMMIT;
END$$


-- ============================================================
-- EVENTO: Se ejecuta todos los días a las 11:59 PM
-- ============================================================

CREATE EVENT IF NOT EXISTS evt_informe_citas_diario
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURDATE(), '23:59:00')   -- arranca hoy a las 11:59 PM
DO
BEGIN
    CALL sp_informe_citas_generar();
END$$

DELIMITER ;




-- SET GLOBAL event_scheduler = ON;



-- CONSULTAS DE VERIFICACIÓN


-- Ver el informe del día de hoy
-- SELECT * FROM Informe_Citas_Diario WHERE fecha_cita = CURDATE();

-- Ver todos los registros ordenados por fecha y sede
-- SELECT * FROM Informe_Citas_Diario ORDER BY fecha_cita DESC, sede, medico;

-- Ejecutar el procedimiento manualmente para probar
-- CALL sp_informe_citas_generar();

-- Ver si el evento está activo
-- SHOW EVENTS;