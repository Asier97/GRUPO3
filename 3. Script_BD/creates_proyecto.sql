DROP TABLE DIRECCIONES CASCADE CONSTRAINTS;
DROP TABLE CENTRO CASCADE CONSTRAINTS;
DROP TABLE TRABAJADOR CASCADE CONSTRAINTS;
DROP TABLE LOGIN CASCADE CONSTRAINTS;
DROP TABLE AVISO CASCADE CONSTRAINTS;
DROP TABLE VEHICULO CASCADE CONSTRAINTS;
DROP TABLE VIAJE CASCADE CONSTRAINTS;
DROP TABLE PARTE CASCADE CONSTRAINTS;
 
 
CREATE TABLE direcciones (
  id NUMBER
  GENERATED ALWAYS AS IDENTITY(
                    INCREMENT BY 1
                    START WITH 1
                    NOMAXVALUE
                                ),
  provincia VARCHAR(20),
  ciudad VARCHAR(20),  
  calle VARCHAR2(30)  NOT NULL,
  numero NUMBER(3)  NOT NULL,
  piso NUMBER(2),
  mano VARCHAR2(3),
  codigo_postal NUMBER(5),
  CONSTRAINT dir_id_pk PRIMARY KEY (id),
  CONSTRAINT dir_mano_ck CHECK (mano IN ('A','B','C','D','E','F','I'))
);

CREATE TABLE Centro ( 
  codigo NUMBER(2) 
  GENERATED ALWAYS AS IDENTITY (
                  INCREMENT BY 1
                  START WITH 1
                  NOMAXVALUE   ), 
  nombre VARCHAR2 (20) NOT NULL,
  direccion NUMBER NOT NULL,
  telefono NUMBER (9) NOT NULL,
  CONSTRAINT cen_cod_pk PRIMARY KEY (codigo),
  CONSTRAINT cen_dir_fk FOREIGN KEY (direccion) REFERENCES Direcciones(id)
);
  
CREATE TABLE Trabajador (
  DNI VARCHAR2 (9),
  nombre VARCHAR2 (20) NOT NULL,
  apellido1 VARCHAR2 (30) NOT NULL,
  apellido2 VARCHAR2 (30) NOT NULL,
  direccion NUMBER (5) NOT NULL,
  tel_Emp NUMBER (9) NOT NULL,
  tel_Per NUMBER (9),
  salario NUMBER (7,2),
  fecha_Nac DATE,
  tipo VARCHAR2(20),
  centro NUMBER (2) NOT NULL,
  CONSTRAINT tra_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT tra_cen_fk FOREIGN KEY (centro) REFERENCES Centro(codigo),
  CONSTRAINT tra_dir_fk FOREIGN KEY (direccion) REFERENCES Direcciones(id),
  CONSTRAINT tra_tipo_ck CHECK (tipo in ('L','A'))
);
 
CREATE TABLE Login (
  DNI VARCHAR2(9),
  usuario VARCHAR2(20) NOT NULL,
  contraseña VARCHAR2(20) NOT NULL,
  CONSTRAINT logn_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT logn_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)  
);
  
CREATE TABLE aviso (
  ID NUMBER
  GENERATED ALWAYS AS IDENTITY (
                        INCREMENT BY 1
                        START WITH 1
                        NOMAXVALUE
                                ),
  descripcion VARCHAR2(200),
  DNI VARCHAR2(9),
  CONSTRAINT avi_id_pk PRIMARY KEY (id),
  CONSTRAINT avi_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)
);
  
CREATE TABLE Vehiculo (
  matricula VARCHAR2(10),
  marca VARCHAR2(20),
  modelo VARCHAR2(20),
  peso NUMBER(5,3) NOT NULL,
  CONSTRAINT veh_mat_pk PRIMARY KEY (matricula)
);
  
CREATE TABLE Parte (
  id NUMBER 
  GENERATED ALWAYS AS IDENTITY 
                ( INCREMENT BY 1 
                  START WITH 1 
                  NOMAXVALUE                
                ),
  albaran NUMBER,
  matricula VARCHAR2(10) NOT NULL,
  DNI VARCHAR2 (9) NOT NULL,
  km_inicio NUMBER(5,3) NOT NULL,
  km_final NUMBER(5,3) NOT NULL,
  gasoil NUMBER(5,2),
  peaje NUMBER(4,2),
  dietas NUMBER(4,2),
  otros NUMBER(5,2),
  horaInicio NUMBER(5),
  horaFin NUMBER (5),
  fecha DATE,
  validacion VARCHAR2(2) NOT NULL,
  gastos NUMBER,
  incidencias VARCHAR2(300),
  CONSTRAINT par_alb_pk PRIMARY KEY (id),
  CONSTRAINT par_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI),
  CONSTRAINT par_mat_fk FOREIGN KEY (matricula) REFERENCES Vehiculo,
  CONSTRAINT par_val_ck CHECK (validacion IN ('si','no'))
);
  
CREATE TABLE viaje (
  id NUMBER 
  GENERATED ALWAYS AS IDENTITY
                ( INCREMENT BY 1
                  START WITH 1
                  NOMAXVALUE
                ),
  hora_ini NUMBER(2,2) NOT NULL,
  hora_fin NUMBER(2,2) NOT NULL,
  id_parte NUMBER,
  CONSTRAINT via_id_pk PRIMARY KEY (id),
  CONSTRAINT via_alb_fk FOREIGN KEY (id_parte) REFERENCES parte(id)
);