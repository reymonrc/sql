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
sis_sal_curp_alumno = 'RAGM981021MVZMRR07';

select *
from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and
matricula.sed_inscripciones.sis_firma_digital = 1 and
matricula.sed_inscripciones.sis_sal_curp_alumno in (
select sis_sal_curp_alumno
-- matricula.sed_inscripciones.sis_ses_cct_escuela
-- matricula.sed_grados_escolares.sge_descripcion_larga_grado as grado_AEFCM,
-- matricula.sed_niveles_escolares.sne_desccripcion_larga_nivel as NIVEL_AEFCM
from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' -- and matricula.sed_inscripciones.sis_sal_curp_alumno=val.alumno_curp
and matricula.sed_inscripciones.sis_firma_digital = 1
group by sis_sal_curp_alumno having count(*) > 1);
