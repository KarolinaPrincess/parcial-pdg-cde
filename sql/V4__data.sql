INSERT INTO rangos (nombre) VALUES ('Junior'), ('Senior'), ('Director de Proyecto');

INSERT INTO investigadores (nombre, apellidos, rango_id) VALUES 
('Ana', 'López', 1), ('Carlos', 'Pérez', 2), ('Luis', 'Gómez', 3), 
('Marta', 'Ríos', 1), ('Elena', 'Castro', 2);

INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES 
('Lab A', 1, 20), ('Lab B', 2, 15), ('Lab C', 3, 10), 
('Lab D', 4, 5), ('Lab E', 2, 12);

INSERT INTO equipos (laboratorio_id, nombre, estado, ultima_revision) VALUES 
(1, 'Microscopio', 'Activo', '2026-01-10'), 
(2, 'Centrífuga', 'Activo', '2026-02-15'), 
(3, 'Incubadora', 'Mantenimiento', '2026-04-01'), 
(4, 'Campana de flujo', 'Activo', '2026-03-20'), 
(5, 'Espectrofotómetro', 'Activo', '2026-01-25');

-- Reservas de prueba (Evitando solapamientos para que pasen el trigger)
INSERT INTO reservas (investigador_id, laboratorio_id, equipo_id, fecha_reserva, hora_inicio, hora_fin) VALUES
(1, 1, 1, '2026-05-10', '08:00', '10:00'),
(2, 2, 2, '2026-05-10', '10:00', '12:00'),
(3, 4, 4, '2026-05-11', '09:00', '11:00'), -- Director en Nivel 4 (Válido)
(4, 5, 5, '2026-05-12', '14:00', '16:00'),
(5, 1, 1, '2026-05-13', '08:00', '09:00');