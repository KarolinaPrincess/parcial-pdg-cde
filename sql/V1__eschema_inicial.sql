--Creacion de tabla rangos para almacenar los diferentes rangos de los investigadores
CREATE TABLE rangos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

--Creacion de tabla investigadores para almacenar los datos de los investigadores, incluyendo su rango
CREATE TABLE investigadores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    rango_id INT NOT NULL
);

--Creacion de tabla laboratorios para almacenar los datos de los laboratorios disponibles
CREATE TABLE laboratorios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

--Creacion de tabla equipos para almacenar los datos de los equipos disponibles en cada laboratorio
CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    laboratorio_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'Activo'
);

--Creacion de tabla reservas para almacenar las reservas realizadas por los investigadores, incluyendo la fecha y hora de la reserva
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    investigador_id INT NOT NULL,
    laboratorio_id INT NOT NULL,
    equipo_id INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

--Creacion de tabla log_auditoria para almacenar un registro de las acciones realizadas en el sistema
CREATE TABLE log_auditoria (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(50) NOT NULL,
    detalles TEXT
);