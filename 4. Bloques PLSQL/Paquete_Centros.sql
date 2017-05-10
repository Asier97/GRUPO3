CREATE OR REPLACE PACKAGE BODY GESTIONAR_CENTRO 
IS
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  PROCEDURE VISUALIZAR_LISTA_CENTRO(C_CENTROS OUT CURSOR_CENTROS)
  IS
  BEGIN 
    OPEN C_CENTROS
    FOR
      SELECT * FROM CENTRO;  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
  END;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  PROCEDURE VISUALIZAR_DATOS_CENTRO_ID(P_ID IN NUMBER,PDATOS_CENTRO OUT VARCHAR2, PNUM_TRABAJADORES OUT NUMBER)
  IS
  BEGIN
      SELECT CODIGO INTO PDATOS_CENTRO
      FROM CENTRO
      WHERE CODIGO = P_ID;
      SELECT COUNT(DNI) AS "Trabajadores del centro" INTO PNUM_TRABAJADORES
      FROM TRABAJADOR
      WHERE CENTRO = P_ID;
        IF PNUM_TRABAJADORES IS NULL THEN
        RAISE_APPLICATION_ERROR (-20012, 'Tabla trabajadores vacía');
        END IF;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
  END;
    
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE VISUALIZAR_DATOS_CENTRO_NOMBRE(P_NOMBRE IN VARCHAR2, PDATOS_CENTRO OUT VARCHAR2, PNUM_TRABAJADORES OUT NUMBER)
  IS
  BEGIN
      SELECT CODIGO INTO PDATOS_CENTRO
      FROM CENTRO 
      WHERE UPPER(NOMBRE)=UPPER(P_NOMBRE);
    SELECT COUNT(DNI) AS "Trabajadores del centro" INTO PNUM_TRABAJADORES
    FROM TRABAJADOR 
    WHERE UPPER(NOMBRE)=UPPER(P_NOMBRE);
    IF PNUM_TRABAJADORES IS NULL THEN
      RAISE_APPLICATION_ERROR(-20102, 'Tabla de trabajadores vacía');
    END IF;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
  END;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE INSERTAR_DATOS_CENTRO(NOMBRE IN CENTRO.NOMBRE%TYPE, DIRECCION IN CENTRO.DIRECCION%TYPE, TELEFONO IN CENTRO.TELEFONO%TYPE)
  IS
  BEGIN
    INSERT INTO CENTRO(NOMBRE, DIRECCION, TELEFONO) VALUES (NOMBRE, DIRECCION, TELEFONO);
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
 
  END;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE ACTUALIZAR_DATOS_CENTRO(vNOMBRE IN CENTRO.NOMBRE%TYPE, vDIRECCION IN CENTRO.DIRECCION%TYPE, vTELEFONO IN CENTRO.TELEFONO%TYPE, vCODIGO IN CENTRO.CODIGO%TYPE)
  IS
  BEGIN
    UPDATE CENTRO SET NOMBRE = vNOMBRE, DIRECCION = vDIRECCION, TELEFONO = vTELEFONO
    WHERE CODIGO = vCODIGO;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
 
  END;
END;