
CREATE TABLE Persona (
    persona_id   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    telefono     VARCHAR(20)  UNIQUE
);


CREATE TABLE Paciente (
    paciente_id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    persona_id   INT NOT NULL UNIQUE,
    FOREIGN KEY (persona_id) REFERENCES Persona(persona_id)
);

CREATE TABLE Facultad (
    facultad_id      INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_facultad  VARCHAR(100) NOT NULL UNIQUE,
    decano           VARCHAR(100)
);


CREATE TABLE Medico (
    medico_id    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    persona_id   INT NOT NULL UNIQUE,
    facultad_id  INT NOT NULL,
    FOREIGN KEY (persona_id)  REFERENCES Persona(persona_id),
    FOREIGN KEY (facultad_id) REFERENCES Facultad(facultad_id)
);


CREATE TABLE Especialidad_Medico (
    medico_id    INT          NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    PRIMARY KEY (medico_id, especialidad),
    FOREIGN KEY (medico_id) REFERENCES Medico(medico_id)
);


CREATE TABLE Sede (
    sede_id      INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_sede  VARCHAR(100) NOT NULL UNIQUE,
    direccion    VARCHAR(150) UNIQUE
);


CREATE TABLE Medicamento (
    medicamento_id      INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_medicamento  VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Cita (
    cod_cita     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha        DATE         NOT NULL,
    diagnostico  VARCHAR(200),
    paciente_id  INT          NOT NULL,
    medico_id    INT          NOT NULL,
    sede_id      INT          NOT NULL,
    FOREIGN KEY (paciente_id) REFERENCES Paciente(paciente_id),
    FOREIGN KEY (medico_id)   REFERENCES Medico(medico_id),
    FOREIGN KEY (sede_id)     REFERENCES Sede(sede_id)
);


CREATE TABLE Cita_Medicamento (
    cod_cita       INT         NOT NULL,
    medicamento_id INT         NOT NULL,
    dosis          VARCHAR(20),
    PRIMARY KEY (cod_cita, medicamento_id),
    FOREIGN KEY (cod_cita)       REFERENCES Cita(cod_cita),
    FOREIGN KEY (medicamento_id) REFERENCES Medicamento(medicamento_id)
);




INSERT INTO Persona (persona_id, nombre, telefono) VALUES
    (1,  'Juan Rivas',   '600-111'),
    (2,  'Ana Soto',     '600-222'),
    (3,  'Luis Paz',     '600-333'),
    (10, 'Dr. House',    NULL),
    (22, 'Dra. Grey',    NULL),
    (30, 'Dr. Strange',  NULL);

INSERT INTO Paciente (paciente_id, persona_id) VALUES
    (501, 1),
    (502, 2),
    (503, 3);

INSERT INTO Facultad (facultad_id, nombre_facultad, decano) VALUES
    (1, 'Medicina',  'Dr. Wilson'),
    (2, 'Ciencias',  'Dr. Palmer');

INSERT INTO Medico (medico_id, persona_id, facultad_id) VALUES
    (10, 10, 1),
    (22, 22, 1),
    (30, 30, 2);

INSERT INTO Especialidad_Medico (medico_id, especialidad) VALUES
    (10, 'Infectología'),
    (22, 'Cardiología'),
    (30, 'Neurocirugía');

INSERT INTO Sede (sede_id, nombre_sede, direccion) VALUES
    (1, 'Centro Médico', 'Calle 5 #10'),
    (2, 'Clínica Norte', 'Av. Libertador');

INSERT INTO Medicamento (medicamento_id, nombre_medicamento) VALUES
    (1, 'Paracetamol'),
    (2, 'Ibuprofeno'),
    (3, 'Amoxicilina'),
    (4, 'Aspirina'),
    (5, 'Ergotamina');

INSERT INTO Cita (cod_cita, fecha, diagnostico, paciente_id, medico_id, sede_id) VALUES
    (1, '2024-05-10', 'Gripe Fuerte', 501, 10, 1),
    (2, '2024-05-11', 'Infección',    502, 10, 1),
    (3, '2024-05-12', 'Arritmia',     501, 22, 2),
    (4, '2024-05-15', 'Migraña',      503, 30, 2);

INSERT INTO Cita_Medicamento (cod_cita, medicamento_id, dosis) VALUES
    (1, 1, '500mg'),
    (1, 2, '400mg'),
    (2, 3, '875mg'),
    (3, 4, '100mg'),
    (4, 5, '1mg');



CREATE TABLE Error_Log (
    error_id       INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_tabla   VARCHAR(100)  NOT NULL,
    codigo_error   INT           NOT NULL,
    mensaje        VARCHAR(500)  NOT NULL,
    fecha_hora     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Informe_Citas_Diario (
    informe_id     INT           NOT NULL AUTO_INCREMENT,
    fecha_cita     DATE          NOT NULL,               
    sede           VARCHAR(100)  NOT NULL,              
    medico         VARCHAR(100)  NOT NULL,              
    total_pacientes INT          NOT NULL DEFAULT 0,     
    generado_en    DATETIME      NOT NULL,               
    PRIMARY KEY (informe_id),
    INDEX idx_fecha (fecha_cita),                        
    INDEX idx_sede  (sede)
);