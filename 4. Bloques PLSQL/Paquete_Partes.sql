CREATE OR REPLACE PACKAGE BODY GESTIONAR_PARTES
IS 
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE VISUALIZAR_LISTA_PARTES(C_PARTES OUT CURSOR_PARTES)
    IS
    BEGIN 
      OPEN C_PARTES
      FOR
        SELECT * FROM PARTE;   
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
    END;
    
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    
    PROCEDURE VISUALIZAR_PARTE_ID(P_ID IN NUMBER, PDATO_ID OUT NUMBER)
      IS
      BEGIN 
        SELECT ID INTO PDATO_ID
        FROM PARTE
        WHERE ID = P_ID;
        SELECT * 
        FROM PARTE
        WHERE ID = PDATO_ID;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
      END;
      
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
    
    PROCEDURE VISUALIZAR_PARTE_FECHA(P_FECHA IN DATE, PDATO_FECHA OUT DATE)
      IS 
      BEGIN
        SELECT FECHA INTO PDATO_FECHA
        FROM PARTE
        WHERE FECHA = P_FECHA;
        SELECT * 
        FROM PARTE
        WHERE FECHA = PDATO_FECHA;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20014, 'No se han encontrado datos');
    END;
    
END;
