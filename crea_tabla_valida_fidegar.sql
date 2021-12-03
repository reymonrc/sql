CREATE TABLE PROCESA_INFORMACION.VALIDA_ALUMNOS_FIDEGAR
(
  ID                    NUMBER(19)              NOT NULL,
  ALUMNO_CURP           VARCHAR2(18 BYTE)       NOT NULL,
  ALUMNO_NOMBRE         VARCHAR2(60 BYTE)       NOT NULL,
  ALUMNO_PRIMER_AP      VARCHAR2(60 BYTE)       NOT NULL,
  ALUMNO_SEGUNDO_AP     VARCHAR2(60 BYTE),
  CCT                   VARCHAR2(10 BYTE)       NOT NULL,
  NIVEL                 VARCHAR2(25 BYTE)       NOT NULL,
  GRADO                 VARCHAR2(20 BYTE),      NOT NULL,
  ALCALDIA              VARCHAR2(128 BYTE)      NOT NULL,
  CCT_AEFCM             VARCHAR2(10 BYTE),
  NIVEL_AEFCM           VARCHAR2(25 BYTE),
  GRADO_AEFCM           VARCHAR2(20 BYTE),
  USUARIO_CREACION      VARCHAR2(32 BYTE)       NOT NULL,
  FECHA_CREACION        DATE                    NOT NULL,
  USUARIO_MODIFICACION  VARCHAR2(32 BYTE),
  FECHA_ACTUALIZACION   DATE
)
;

CREATE INDEX PROCESA_INFORMACION.IDX_VALIDA_ALU_FIDEGAR_CCT ON PROCESA_INFORMACION.VALIDA_ALUMNOS_FIDEGAR
(CCT)
;

CREATE UNIQUE INDEX PROCESA_INFORMACION.IDX_VALIDA_ALU_FIDEGAR_CURP ON PROCESA_INFORMACION.VALIDA_ALUMNOS_FIDEGAR
(ALUMNO_CURP)
;

ALTER TABLE PROCESA_INFORMACION.VALIDA_ALUMNOS_FIDEGAR MODIFY NIVEL VARCHAR(25);
ALTER TABLE PROCESA_INFORMACION.VALIDA_ALUMNOS_FIDEGAR MODIFY NIVEL_AEFCM VARCHAR(25);
DELETE FROM PROCESA_INFORMACION.valida_alumnos_fidegar where id > 0;
DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP where id > 0;
DELETE FROM PROCESA_INFORMACION.PADRON_ALUMNOS_FIDEGAR where id > 0;

select
matricula.sed_inscripciones.sis_sal_curp_alumno as CURP_ALUMNO,
matricula.sed_inscripciones.sis_ses_cct_escuela as cct_aefcm,
matricula.sed_grados_escolares.sge_descripcion_larga_grado as grado_AEFCM,
matricula.sed_niveles_escolares.sne_desccripcion_larga_nivel as NIVEL_AEFCM
from MATRICULA.sed_inscripciones
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join MATRICULA.sed_grados_escolares on sis_sge_cve_grado_escolar = SGE_CVE_GRADO_ESCOLAR
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and
matricula.sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar);

update PROCESA_INFORMACION.valida_alumnos_fidegar val
set cct_aefcm = (select matricula.sed_inscripciones.sis_ses_cct_escuela
from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_sal_curp_alumno=val.alumno_curp
and matricula.sed_inscripciones.sis_firma_digital = 1);

update PROCESA_INFORMACION.valida_alumnos_fidegar val
set nivel_aefcm = (select matricula.sed_niveles_escolares.sne_desccripcion_larga_nivel
from MATRICULA.sed_inscripciones
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_sal_curp_alumno=val.alumno_curp
and val.alumno_curp=sed_alumnos.sal_curp_alumno and matricula.sed_inscripciones.sis_firma_digital = 1);

select *
from MATRICULA.sed_inscripciones where
SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and
matricula.sed_inscripciones.sis_firma_digital = 1 and
sis_sal_curp_alumno in ('MUAM080421HMCXVRA6','HEGJ071216MDFRRHA6',
'AACY091124HDFBRLA0','CAGC090127HDFHLHA0','EAAM090414MASSLLA9','EASS091224HDFSLNA7','');

select *
from MATRICULA.sed_inscripciones
left JOIN SED_ALUMNOS
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and
matricula.sed_inscripciones.sis_firma_digital = 1 and
matricula.sed_inscripciones.sis_sal_curp_alumno in (
select sis_sal_curp_alumno
from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1
and matricula.sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
group by sis_sal_curp_alumno having count(*) > 1);

/*
insert into PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP
(ID,ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_TELEFONO,
TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR,
USUARIO_CREACION,FECHA_CREACION)*/
select -- 2497 +
 rownum as ID,
 SAL_CURP_ALUMNO as ALUMNO_CURP, SAL_NOMBRE_ALUMNO as ALUMNO_NOMBRE,
 CASE WHEN SAL_PRIMER_APELLIDO is null THEN 'NULO' ELSE SAL_PRIMER_APELLIDO END as ALUMNO_APATERNO,
 SAL_SEGUNDO_APELLIDO as ALUMNO_AMATERNO,
 SAL_SEXO_ALUMNO as ALUMNO_GENERO, SIS_SES_CCT_ESCUELA as CCT,
 REGEXP_REPLACE(bdunica.nombre,'( ){2,}', ' ') as NOMBRE_ESCUELA,
 SUBSTR (REGEXP_REPLACE(tur.des_turno,'( ){2,}', ' '),0,16) as TURNO,
 CASE WHEN SNE_DESCCRIPCION_LARGA_NIVEL = 'INICIAL LACTANTES' THEN 'LACTANTE'
 ELSE SNE_DESCCRIPCION_LARGA_NIVEL END as NIVEL,
 sis_sge_cve_grado_escolar as GRADO,
 col.nombre as COLONIA, del.descripcion as ALCALDIA,
 col.codigo_postal as CODIGO_POSTAL,
 null as UNIDAD_TERRITORIAL,
 case WHEN INSTR(SAL_NOMBRE_TUTOR, ' ') > 0
           THEN SUBSTR(SAL_NOMBRE_TUTOR, 1, LENGTH(SAL_NOMBRE_TUTOR) - INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2))
           ELSE null
       END AS TUTOR_NOMBRE,
 CASE WHEN INSTR(SAL_NOMBRE_TUTOR, ' ', 1, 2) > 0
           THEN SUBSTR(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
                       INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1)),1, LENGTH(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
                       INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1))) - INSTR(REVERSE(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
                       INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1))), ' ', 1, 1))
           ELSE null
       END AS TUTOR_APATERNO,
 CASE WHEN INSTR(SAL_NOMBRE_TUTOR, ' ') > 0
           THEN REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
                       INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ') - 1))
           ELSE SAL_NOMBRE_TUTOR
       END AS TUTOR_AMATERNO,
-- vista.parentesco as TUTOR_PARENTESCO,
SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,' ',''),'-',''),'(',''),')',''),-10,10) as TUTOR_TELEFONO,
correo.correo_google as TUTOR_CORREO,
SAL_CALLE as TUTOR_CALLE, col_tut.nombre as TUTOR_COLONIA,
del_tut.descripcion as TUTOR_MUNICIPIO,
 sal_codigo_postal as TUTOR_CODIGO_POSTAL, SIS_SCE_CVE_CICLO_ESCOLAR as CICLO_ESCOLAR,
'PROCESA_INFORMACION-RRC' as USUARIO_CREACION, CURRENT_DATE as FECHA_CREACION
from MATRICULA.sed_inscripciones left JOIN SED_ALUMNOS
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join PROCESA_INFORMACION.alumnos_correos correo on sed_alumnos.sal_curp_alumno =  correo.s_curp
left join bdunica.cct bdunica on matricula.sed_inscripciones.sis_ses_cct_escuela = bdunica.cct
left join bdunica.cve_delegacion del on bdunica.cod_municipio = del.cve_dele
left join bdunica.cit col on bdunica.cod_localidad = col.cod_localidad
  and bdunica.cod_municipio = col.cod_municipio and col.cod_entidad = '09'
left join bdunica.cve_delegacion del_tut on sed_alumnos.sal_smd_cve_municipio_delega = del_tut.cve_dele
left join bdunica.cit col_tut on sed_alumnos.sal_slc_cve_localidad_colonia = col_tut.cod_localidad
 and sed_alumnos.sal_smd_cve_municipio_delega = col_tut.cod_municipio and col_tut.cod_entidad = '09'
left join bdunica.turno tur on bdunica.cod_turno = tur.cod_turno
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and matricula.sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
and matricula.sed_inscripciones.sis_sal_curp_alumno in (
select sis_sal_curp_alumno
from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1
and matricula.sed_inscripciones.sis_sal_curp_alumno in
 (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
  group by sis_sal_curp_alumno having count(*) > 1);


select
matricula.sed_inscripciones.sis_sal_curp_alumno as CURP_ALUMNO,
matricula.sed_inscripciones.sis_ses_cct_escuela as cct_aefcm,
matricula.sed_grados_escolares.sge_descripcion_larga_grado as grado_AEFCM,
matricula.sed_niveles_escolares.sne_desccripcion_larga_nivel as NIVEL_AEFCM
from MATRICULA.sed_inscripciones
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join MATRICULA.sed_grados_escolares on sis_sge_cve_grado_escolar = SGE_CVE_GRADO_ESCOLAR
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1 and
matricula.sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar
where usuario_creacion = 'rrc')
and matricula.sed_inscripciones.sis_sal_curp_alumno not in /*(select sis_sal_curp_alumno from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1
and sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar where usuario_creacion = 'rrc')
group by sis_sal_curp_alumno having count(*) > 1);*/
('OASM090826HDFCNRA4',
'SOPK070423MDFLRRA7',
'MUAM080421HMCXVRA6',
'PEHB830305MCSRRR08',
'VIVA090717MDFLLNA4',
'PATE090107HDFRRDA3',
'RXBA090602HDFMHNA7',
'RAHB090810MDFMRRA1',
'SORN090204MMCLJTA2',
'AOLA090403HMSNPLA5',
'LORJ090920MDFPMMA7',
'PASN090929MDFRLZA7',
'SOMJ081212MDFTRSA4');

select * FROM MVIEW_ALUMNOS_20212022
