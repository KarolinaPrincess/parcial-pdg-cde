-- Creacion de migracion para agregar columna de ultima revision a la tabla equipos
ALTER TABLE equipos ADD COLUMN ultima_revision DATE;