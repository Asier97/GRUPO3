CREATE OR REPLACE TRIGGER EXCESO_HORAS
AFTER 
INSERT OR UPDATE OF HORA_FIN
ON VIAJE
BEGIN
  IF ((HORA_FIN - HORA_INICIO) > 8) THEN
  INSERT INTO VIAJE (HORAS_EXCESO) VALUES ((HORA_FIN - HORA_INICIO) - 8);
  END IF;
  END;
  