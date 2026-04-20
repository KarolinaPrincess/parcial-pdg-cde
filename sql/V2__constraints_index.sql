-- Restricciones de Integridad Referencial
ALTER TABLE investigadores ADD CONSTRAINT fk_rango FOREIGN KEY (rango_id) REFERENCES rangos(id) ON DELETE RESTRICT;
ALTER TABLE equipos ADD CONSTRAINT fk_lab_equipo FOREIGN KEY (laboratorio_id) REFERENCES laboratorios(id) ON DELETE CASCADE;
ALTER TABLE reservas ADD CONSTRAINT fk_reserva_inv FOREIGN KEY (investigador_id) REFERENCES investigadores(id) ON DELETE CASCADE;
ALTER TABLE reservas ADD CONSTRAINT fk_reserva_lab FOREIGN KEY (laboratorio_id) REFERENCES laboratorios(id) ON DELETE CASCADE;
ALTER TABLE reservas ADD CONSTRAINT fk_reserva_equipo FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON DELETE CASCADE;

-- Restricciones de Dominio 
ALTER TABLE laboratorios ADD CONSTRAINT chk_bioseguridad CHECK (nivel_bioseguridad BETWEEN 1 AND 4);
ALTER TABLE reservas ADD CONSTRAINT chk_horas CHECK (hora_inicio < hora_fin);

-- Índices para consultas
CREATE INDEX idx_fecha_reserva ON reservas(fecha_reserva);