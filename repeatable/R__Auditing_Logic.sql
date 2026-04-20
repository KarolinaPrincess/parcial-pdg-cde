-- Función para validar reservas (Reglas de Negocio)
CREATE OR REPLACE FUNCTION trg_validar_reserva()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_bio INT;
    v_rango_inv VARCHAR(50);
    v_solapamiento INT;
BEGIN
    -- 1. Validar Nivel 4 solo para Directores
    SELECT nivel_bioseguridad INTO v_nivel_bio FROM laboratorios WHERE id = NEW.laboratorio_id;
    SELECT r.nombre INTO v_rango_inv FROM investigadores i JOIN rangos r ON i.rango_id = r.id WHERE i.id = NEW.investigador_id;
    
    IF v_nivel_bio = 4 AND v_rango_inv != 'Director de Proyecto' THEN
        RAISE EXCEPTION 'Solo los Directores de Proyecto pueden reservar laboratorios de Nivel 4.';
    END IF;

    -- 2. Validar que un investigador no reserve en el mismo horario
    SELECT COUNT(*) INTO v_solapamiento FROM reservas 
    WHERE investigador_id = NEW.investigador_id 
      AND fecha_reserva = NEW.fecha_reserva
      AND (NEW.hora_inicio < hora_fin AND NEW.hora_fin > hora_inicio);
      
    IF v_solapamiento > 0 THEN
        RAISE EXCEPTION 'El investigador ya tiene una reserva en ese horario.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_antes_reserva
BEFORE INSERT ON reservas
FOR EACH ROW EXECUTE FUNCTION trg_validar_reserva();

-- Función y Trigger de Auditoría
CREATE OR REPLACE FUNCTION trg_auditar_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria (usuario, accion, detalles)
    VALUES (current_user, 'INSERT', 'Nueva reserva creada. ID Equipo: ' || NEW.equipo_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_despues_reserva
AFTER INSERT ON reservas
FOR EACH ROW EXECUTE FUNCTION trg_auditar_reserva();