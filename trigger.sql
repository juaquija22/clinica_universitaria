DELIMITER $$

-
CREATE TRIGGER trg_persona_validar_insertar
BEFORE INSERT ON Persona
FOR EACH ROW
BEGIN

    -- Nombre no puede estar vacío ni ser solo espacios
    IF NEW.nombre IS NULL OR TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre no puede estar vacío.';
    END IF;

    -- Nombre debe tener al menos 3 caracteres
    IF CHAR_LENGTH(TRIM(NEW.nombre)) < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre debe tener al menos 3 caracteres.';
    END IF;

    -- Teléfono no puede estar vacío
    IF NEW.telefono IS NULL OR TRIM(NEW.telefono) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono no puede estar vacío.';
    END IF;

    -- Teléfono solo permite dígitos, espacios, guiones y el signo +
    IF NEW.telefono NOT REGEXP '^[0-9 +\\-]+$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono solo puede contener números, espacios, guiones o +.';
    END IF;

END$$




CREATE TRIGGER trg_persona_validar_actualizar
BEFORE UPDATE ON Persona
FOR EACH ROW
BEGIN

    IF NEW.nombre IS NULL OR TRIM(NEW.nombre) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre no puede estar vacío.';
    END IF;

    IF CHAR_LENGTH(TRIM(NEW.nombre)) < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre debe tener al menos 3 caracteres.';
    END IF;

    IF NEW.telefono IS NULL OR TRIM(NEW.telefono) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono no puede estar vacío.';
    END IF;

    IF NEW.telefono NOT REGEXP '^[0-9 +\\-]+$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono solo puede contener números, espacios, guiones o +.';
    END IF;

END$$




CREATE TRIGGER trg_cita_validar_fecha_insertar
BEFORE INSERT ON Cita
FOR EACH ROW
BEGIN

    -- La fecha no puede ser posterior al día de hoy
    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita no puede ser una fecha futura.';
    END IF;

    -- La fecha tampoco puede ser nula
    IF NEW.fecha IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita es obligatoria.';
    END IF;

END$$




CREATE TRIGGER trg_cita_validar_fecha_actualizar
BEFORE UPDATE ON Cita
FOR EACH ROW
BEGIN

    IF NEW.fecha IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita es obligatoria.';
    END IF;

    IF NEW.fecha > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita no puede ser una fecha futura.';
    END IF;

END$$

DELIMITER ;


