-- =====================================================
-- CREACIÓN DE USUARIOS Y PERMISOS
-- Clínica Universitaria
-- =====================================================

-- -----------------------------------------------------
-- 1. ADMINISTRADOR - Acceso completo a todo
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON clinica_universitaria.* TO 'admin'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.* TO 'admin'@'localhost';

-- -----------------------------------------------------
-- 2. MÉDICO - Gestionar Cita, Cita_Medicamento; leer otras tablas
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'medico'@'localhost' IDENTIFIED BY 'medico123';

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Cita TO 'medico'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Cita_Medicamento TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Paciente TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Persona TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Medicamento TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Sede TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Medico TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Especialidad_Medico TO 'medico'@'localhost';
GRANT SELECT ON clinica_universitaria.Facultad TO 'medico'@'localhost';

-- Permisos sobre procedimientos almacenados
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_insertar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_actualizar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_eliminar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_insertar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_por_cita TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_actualizar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_eliminar TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_por_id TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_por_medico TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_facultad_obtener_todos TO 'medico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_error_log_insertar TO 'medico'@'localhost';

-- -----------------------------------------------------
-- 3. PACIENTE - Solo lectura de sus propios datos
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'paciente'@'localhost' IDENTIFIED BY 'paciente123';

-- Permisos de solo lectura
GRANT SELECT ON clinica_universitaria.Paciente TO 'paciente'@'localhost';
GRANT SELECT ON clinica_universitaria.Persona TO 'paciente'@'localhost';
GRANT SELECT ON clinica_universitaria.Cita TO 'paciente'@'localhost';
GRANT SELECT ON clinica_universitaria.Medico TO 'paciente'@'localhost';
GRANT SELECT ON clinica_universitaria.Sede TO 'paciente'@'localhost';
GRANT SELECT ON clinica_universitaria.Especialidad_Medico TO 'paciente'@'localhost';

-- Permisos sobre procedimientos almacenados (solo lectura)
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_por_id TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_por_id TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_por_id TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_por_id TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_por_id TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_todos TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_por_medico TO 'paciente'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_error_log_insertar TO 'paciente'@'localhost';

-- -----------------------------------------------------
-- 4. RECEPCIONISTA - Gestionar Cita, Paciente; leer otras tablas
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'recepcionista'@'localhost' IDENTIFIED BY 'recepcionista123';

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Cita TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Paciente TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Persona TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Medico TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Sede TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Especialidad_Medico TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Facultad TO 'recepcionista'@'localhost';
GRANT SELECT ON clinica_universitaria.Cita_Medicamento TO 'recepcionista'@'localhost';

-- Permisos sobre procedimientos almacenados
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_insertar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_actualizar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_eliminar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_insertar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_actualizar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_paciente_eliminar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_insertar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_actualizar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_persona_eliminar TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medico_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_sede_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_especialidad_medico_obtener_por_medico TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_facultad_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_facultad_obtener_por_id TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_todos TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_por_cita TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_error_log_insertar TO 'recepcionista'@'localhost';

-- -----------------------------------------------------
-- 5. FARMACÉUTICO - Gestionar Medicamento, Cita_Medicamento
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'farmaceutico'@'localhost' IDENTIFIED BY 'farmaceutico123';

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Medicamento TO 'farmaceutico'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica_universitaria.Cita_Medicamento TO 'farmaceutico'@'localhost';
GRANT SELECT ON clinica_universitaria.Cita TO 'farmaceutico'@'localhost';

-- Permisos sobre procedimientos almacenados
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_insertar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_obtener_todos TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_obtener_por_id TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_actualizar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_medicamento_eliminar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_insertar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_todos TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_obtener_por_cita TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_actualizar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_medicamento_eliminar TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_todos TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_cita_obtener_por_id TO 'farmaceutico'@'localhost';
GRANT EXECUTE ON PROCEDURE clinica_universitaria.sp_error_log_insertar TO 'farmaceutico'@'localhost';

-- -----------------------------------------------------
-- Aplicar cambios de privilegios
-- -----------------------------------------------------
FLUSH PRIVILEGES;
