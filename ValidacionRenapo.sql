CREATE TABLE PROCESA_INFORMACION.W_VALIDA_RENAPO (
numero integer not null
, banco	VARCHAR2(60 BYTE) not null
, cuenta_chequera	VARCHAR2(20 BYTE) not null
, cheque	VARCHAR2(20 BYTE) not null
, importe FLOAT not null
, monto	VARCHAR2(60 BYTE) not null
, periodo	VARCHAR2(30 BYTE) not null
, emision	VARCHAR2(20 BYTE) not null
, ciclo_escolar	VARCHAR2(20 BYTE) not null
, curp	VARCHAR2(19 BYTE) not null
, nombre	VARCHAR2(120 BYTE) not null
, sexo	VARCHAR2(1 BYTE) not null
, edad	integer not null
, nac_año   integer not null
, nac_mes   integer not null
, nac_dia   integer not null
, fecha_nac	integer not null
, entidad_fed	VARCHAR2(60 BYTE) -- not null
, alcaldia	VARCHAR2(60 BYTE) -- not null
, cct	    VARCHAR2(10 BYTE) not null
, escuela	    VARCHAR2(120 BYTE) not null
, direccion_general	VARCHAR2(20 BYTE) not null
, nivel	        VARCHAR2(30 BYTE) not null
, estatus_beca  VARCHAR2(1 BYTE) not null
);

delete tabl