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
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
  END;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  PROCEDURE VISUALIZAR_DATOS_CENTRO_ID(P_ID IN NUMBER,C_CENTROS OUT CURSOR_CENTROS)
  IS
  BEGIN
    OPEN C_CENTROS
    FOR
      SELECT *
      FROM CENTRO
      WHERE CODIGO = P_ID;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
  END;
    
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE VISUALIZAR_DATOS_CENTRO_NOMBRE(vNOMBRE IN CENTRO.NOMBRE%TYPE, C_CENTROS OUT CURSOR_CENTROS, PNUM_TRABAJADORES OUT NUMBER)
  IS
  BEGIN
    OPEN C_CENTROS
    FOR
      SELECT *
      FROM CENTRO 
      WHERE NOMBRE = vNOMBRE;
    SELECT COUNT(DNI) AS "Trabajadores del centro" INTO PNUM_TRABAJADORES
    FROM TRABAJADOR 
    WHERE NOMBRE= vNOMBRE;
    IF PNUM_TRABAJADORES IS NULL THEN
      RAISE_APPLICATION_ERROR(-20102, 'Tabla de trabajadores vacía');
    END IF;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
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
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
 
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
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
 
  END;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE BORRAR_DATOS_CENTRO(vCODIGO IN CENTRO.CODIGO%TYPE)
  IS
  BEGIN
    DELETE
    FROM CENTRO
  WHERE CODIGO = vCODIGO;
    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20013, 'Se han encontrado más valores de los esperados');
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
      WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20100, 'Error genérico, consulta a un administrador');
  END;
  
END;