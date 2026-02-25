-- ============================================================
-- PARTICIONES — Sistema Médico
-- ============================================================


-- ============================================================
-- Cita — RANGE por YEAR(fecha)
-- Crece diario. Las consultas siempre filtran por fecha,
-- así MySQL solo lee la partición del año consultado.
-- Facilita borrar citas viejas con DROP PARTITION.
-- ============================================================

CREATE TABLE Cita (
    cod_cita     INT          NOT NULL AUTO_INCREMENT,
    fecha        DATE         NOT NULL,
    diagnostico  VARCHAR(200),
    paciente_id  INT          NOT NULL,
    medico_id    INT          NOT NULL,
    sede_id      INT          NOT NULL,

    PRIMARY KEY (cod_cita, fecha), 
    INDEX idx_paciente (paciente_id),
    INDEX idx_medico   (medico_id),
    INDEX idx_sede     (sede_id)

)
PARTITION BY RANGE (YEAR(fecha)) (
    PARTITION p2022    VALUES LESS THAN (2023),
    PARTITION p2023    VALUES LESS THAN (2024),
    PARTITION p2024    VALUES LESS THAN (2025),
    PARTITION p2025    VALUES LESS THAN (2026),
    PARTITION p_futuro VALUES LESS THAN MAXVALUE
);


-- ============================================================
-- Cita_Medicamento 
-- ============================================================

CREATE TABLE Cita_Medicamento (
    cod_cita       INT         NOT NULL,
    medicamento_id INT         NOT NULL,
    dosis          VARCHAR(20),

    PRIMARY KEY (cod_cita, medicamento_id),  
    INDEX idx_medicamento (medicamento_id)
   
)
PARTITION BY HASH(cod_cita)
PARTITIONS 4;


-- ============================================================
-- Error_Log — RANGE por YEAR(fecha_hora)
-- Crece indefinidamente. Permite consultar errores recientes
-- sin tocar registros viejos y limpiar años con DROP PARTITION.
-- ============================================================

CREATE TABLE Error_Log (
    error_id       INT           NOT NULL AUTO_INCREMENT,
    nombre_tabla   VARCHAR(100)  NOT NULL,
    codigo_error   INT           NOT NULL,
    mensaje        VARCHAR(500)  NOT NULL,
    fecha_hora     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (error_id, fecha_hora), 
    INDEX idx_tabla (nombre_tabla)
)
PARTITION BY RANGE (YEAR(fecha_hora)) (
    PARTITION p2023    VALUES LESS THAN (2024),
    PARTITION p2024    VALUES LESS THAN (2025),
    PARTITION p2025    VALUES LESS THAN (2026),
    PARTITION p_futuro VALUES LESS THAN MAXVALUE
);
