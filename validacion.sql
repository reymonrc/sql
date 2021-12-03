/*
# Proceso de validacioón de tablas de excel de FIDEGAR

1. Se exportan las tablas de excel a archivos valida?.csv
  > Hubo que cambiar 2 casos de primer_apellido vacío
    en valida1 y valida3 total 4 modificaciones manuales

2. Secargan valida1 y valida 2 en VALIDA_ALUMNOS_FIDEGAR
3. Se encuentran y cargan duplicados con: */

DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP where id > 0;
insert into PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP
(ID,ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_TELEFONO,
TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR, USUARIO_CREACION,FECHA_CREACION)
select
 rownum as ID,
 SAL_CURP_ALUMNO as ALUMNO_CURP, SAL_NOMBRE_ALUMNO as ALUMNO_NOMBRE,
 CASE WHEN SAL_PRIMER_APELLIDO is null
  THEN 'NULO'
  ELSE SAL_PRIMER_APELLIDO END as ALUMNO_APATERNO,
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
  THEN SUBSTR(SAL_NOMBRE_TUTOR, 1,
   LENGTH(SAL_NOMBRE_TUTOR) - INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2))
  ELSE null END AS TUTOR_NOMBRE,
 CASE WHEN INSTR(SAL_NOMBRE_TUTOR, ' ', 1, 2) > 0
  THEN SUBSTR(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
   INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1)),1,
    LENGTH(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
     INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1)))
    - INSTR(REVERSE(REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
     INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ', 1, 2) - 1))), ' ', 1, 1))
   ELSE null END AS TUTOR_APATERNO,
 CASE WHEN INSTR(SAL_NOMBRE_TUTOR, ' ') > 0
  THEN REVERSE(SUBSTR(REVERSE(SAL_NOMBRE_TUTOR), 1,
   INSTR(REVERSE(SAL_NOMBRE_TUTOR), ' ') - 1))
  ELSE SAL_NOMBRE_TUTOR END AS TUTOR_AMATERNO,
SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,
  ' ',''),'-',''),'(',''),')',''),-10,10) as TUTOR_TELEFONO,
correo.correo_google as TUTOR_CORREO, SAL_CALLE as TUTOR_CALLE,
col_tut.nombre as TUTOR_COLONIA,
del_tut.descripcion as TUTOR_MUNICIPIO, sal_codigo_postal as TUTOR_CODIGO_POSTAL,
SIS_SCE_CVE_CICLO_ESCOLAR as CICLO_ESCOLAR,
'PROCESA_INFORMACION-RRC' as USUARIO_CREACION, CURRENT_DATE as FECHA_CREACION
from SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and matricula.sed_inscripciones.sis_firma_digital = 1
left join MATRICULA.sed_niveles_escolares
 on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join PROCESA_INFORMACION.alumnos_correos correo
 on sed_alumnos.sal_curp_alumno =  correo.s_curp
left join bdunica.cct bdunica
 on matricula.sed_inscripciones.sis_ses_cct_escuela = bdunica.cct
left join bdunica.cve_delegacion del on bdunica.cod_municipio = del.cve_dele
left join bdunica.cit col on bdunica.cod_localidad = col.cod_localidad
  and bdunica.cod_municipio = col.cod_municipio and col.cod_entidad = '09'
left join bdunica.cve_delegacion del_tut
 on sed_alumnos.sal_smd_cve_municipio_delega = del_tut.cve_dele
left join bdunica.cit col_tut
 on sed_alumnos.sal_slc_cve_localidad_colonia = col_tut.cod_localidad
 and sed_alumnos.sal_smd_cve_municipio_delega = col_tut.cod_municipio
 and col_tut.cod_entidad = '09'
left join bdunica.turno tur on bdunica.cod_turno = tur.cod_turno
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and matricula.sed_inscripciones.sis_sal_curp_alumno
 in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
and matricula.sed_inscripciones.sis_sal_curp_alumno in (
select sis_sal_curp_alumno from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and matricula.sed_inscripciones.sis_firma_digital = 1
group by sis_sal_curp_alumno having count(*) > 1);

/*
Se encontraron 110 registros el 02/Dic

4. Manualmente se seleccionaron los correctos */

1,426,368 filas eliminado
1,083,728 filas insertadas.

insert into PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP
(ID,ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_TELEFONO,
TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR,
USUARIO_CREACION,FECHA_CREACION)
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
and matricula.sed_inscripciones.sis_sal_curp_alumno not in (
select sis_sal_curp_alumno from MATRICULA.sed_inscripciones
group by sis_sal_curp_alumno having count(*) > 1);


DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR where id > 0;
insert into PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR
(ID,ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_PARENTESCO,
TUTOR_TELEFONO,TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR, USUARIO_CREACION,FECHA_CREACION)
select -- 2497 +
 rownum as ID, curp as ALUMNO_CURP, nombres as alumno_nombre, primerapellido as ALUMNO_APATERNO,
 segundoapellido as ALUMNO_AMATERNO, sexo as ALUMNO_GENERO, CCT, SUBSTR(NOMBREESCUELA,0,128) as NOMBRE_ESCUELA,
 TURNO, NIVELEDUCATIVO as NIVEL, GRADO, COLONIA_CCT as COLONIA, null as ALCALDIA ,CODIGOPOSTAL_CCT as CODIGO_POSTAL,
 null as UNIDAD_TERRITORIAL,
 case WHEN INSTR(TUTOR, ' ') > 0
           THEN SUBSTR(TUTOR, 1, LENGTH(TUTOR) - INSTR(REVERSE(TUTOR), ' ', 1, 2))
           ELSE null
       END AS TUTOR_NOMBRE,
 CASE WHEN INSTR(TUTOR, ' ', 1, 2) > 0
           THEN SUBSTR(REVERSE(SUBSTR(REVERSE(TUTOR), 1,
                       INSTR(REVERSE(TUTOR), ' ', 1, 2) - 1)),1, LENGTH(REVERSE(SUBSTR(REVERSE(TUTOR), 1,
                       INSTR(REVERSE(TUTOR), ' ', 1, 2) - 1))) - INSTR(REVERSE(REVERSE(SUBSTR(REVERSE(TUTOR), 1,
                       INSTR(REVERSE(TUTOR), ' ', 1, 2) - 1))), ' ', 1, 1))
           ELSE null
       END AS TUTOR_APATERNO,
 CASE WHEN INSTR(TUTOR, ' ') > 0
           THEN REVERSE(SUBSTR(REVERSE(TUTOR), 1,
                       INSTR(REVERSE(TUTOR), ' ') - 1))
           ELSE TUTOR
       END AS TUTOR_AMATERNO,
 PARENTESCO as TUTOR_PARENTESCO,
 SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(telefono,' ',''),'-',''),'(',''),')',''),-10,10) as TUTOR_TELEFONO,
 null as TUTOR_CORREO, CALLE as TUTOR_CALLE,
 colonia as TUTOR_COLONIA, alcaldia as TUTOR_MUNICIPIO,
 CODIGO_POSTAL as TUTOR_CODIGO_POSTAL, '2021-2022' as CICLO_ESCOLAR,
 'MVA2121-RRC' as USUARIO_CREACION, CURRENT_DATE as FECHA_CREACION
FROM MVIEW_ALUMNOS_20212022 where curp not in
 (select CURP from MVIEW_ALUMNOS_20212022
group by CURP having count(*) > 1);

DELETE from PROCESA_INFORMACION.w_padron_alumnos_fidegar_dup where inscripcion_seleccionada is NULL;

insert into W_PADRON_ALUMNOS_FIDEGAR
(ID,ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_PARENTESCO,
TUTOR_TELEFONO,TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR, USUARIO_CREACION,FECHA_CREACION)
select 1439715+ROWNUM as ID,
ALUMNO_CURP,ALUMNO_NOMBRE,ALUMNO_APATERNO,ALUMNO_AMATERNO,ALUMNO_GENERO,
CCT,NOMBRE_ESCUELA,TURNO,NIVEL,GRADO,COLONIA,ALCALDIA,CODIGO_POSTAL,
UNIDAD_TERRITORIAL,TUTOR_NOMBRE,TUTOR_APATERNO,TUTOR_AMATERNO,TUTOR_PARENTESCO,
TUTOR_TELEFONO,TUTOR_CORREO,TUTOR_CALLE,TUTOR_COLONIA,TUTOR_MUNICIPIO,
TUTOR_CODIGO_POSTAL,CICLO_ESCOLAR, USUARIO_CREACION,FECHA_CREACION
from w_padron_alumnos_fidegar_dup;

/*
Tenemos asi la tabla W_PADRON_ALUMNOS_FIDEGAR con los datos de la vista MVIEW_ALUMNOS_20212022
procedemos a exportar los datos para completar las hojas de calculo de fidegar */

select
ALUMNO_CURP as CURP_ALUMNO, CCT as cct_aefcm,
GRADO as grado_AEFCM, NIVEL as NIVEL_AEFCM
from PROCESA_INFORMACION.w_padron_alumnos_fidegar
where alumno_curp in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar where USUARIO_CREACION = 'ramon');

/*
Se encuentran más registros directamente en sed_inscripciones
*/

select
matricula.sed_inscripciones.sis_sal_curp_alumno as CURP_ALUMNO,
matricula.sed_inscripciones.sis_ses_cct_escuela as cct_aefcm,
matricula.sed_grados_escolares.sge_descripcion_larga_grado as grado_AEFCM,
matricula.sed_niveles_escolares.sne_desccripcion_larga_nivel as NIVEL_AEFCM
from MATRICULA.sed_inscripciones
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join MATRICULA.sed_grados_escolares on sis_sge_cve_grado_escolar = SGE_CVE_GRADO_ESCOLAR
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and
matricula.sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
and matricula.sed_inscripciones.sis_sal_curp_alumno not in (select sis_sal_curp_alumno from MATRICULA.sed_inscripciones
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and matricula.sed_inscripciones.sis_firma_digital = 1
-- and sed_inscripciones.sis_sal_curp_alumno in (SELECT ALUMNO_CURP from PROCESA_INFORMACION.valida_alumnos_fidegar)
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

-- Vista MVIEW_ALUMNOS_20212022
select SOSTENIMIENTO ,
ALCALDIA_CCT ,
SERVICIOEDUCATIVO ,
NIVELEDUCATIVO ,
COORDINACION ,
CCT ,
NOMBREESCUELA ,
DOMICILIO_CCT ,
COLONIA_CCT ,
CODIGOPOSTAL_CCT ,
TELEFONO_CCT ,
IDTURNO ,
TURNO ,
GRADO ,
GRUPO ,
CURP ,
NOMBRES ,
PRIMERAPELLIDO ,
SEGUNDOAPELLIDO ,
SEXO ,
TUTOR ,
PARENTESCO ,
TELEFONO ,
CALLE ,
NUMERO_EXT ,
NUMERO_INT ,
COLONIA ,
ALCALDIA ,
CODIGO_POSTAL ,
PROMEDIOGRADO ,
PROMEDIONIVEL ,
APROVECHAMIENTO ,
NOCONTACTADOS ,
INTERMITENTE  from MVIEW_ALUMNOS_20212022;

/*
Para Revocaciones Iztapalapa
*/

select CCT ,
NOMBRE ,
CCT_DOMICILIO ,
CALLE1 ,
CALLE2 ,
COD_ENTIDAD ,
COD_MUNICIPIO ,
COD_LOCALIDAD ,
ZONA_ESCOLAR ,
SECTOR ,
COD_SOSTENIMIENTO ,
COD_TURNO ,
CVE_INMUEBLE ,
COD_TIP_INCORP ,
NUMOFINCOR ,
FECHA_INCORPO ,
FECHA_APERTURA ,
COD_SITUACION ,
FECHA_ALTA ,
FECHA_ULT_ACT ,
DIR_PATERNO ,
DIR_MATERNO ,
DIR_NOMBRE ,
FECHA_SOLICITUD ,
OBSERVACIONES ,
FECHA_CREACION ,
FECHA_ULT_MOD ,
USUA_ULT_MOD ,
CVEINM ,
DOMICILIO_2 ,
NUMERO_INTERIOR ,
NUMERO_EXTERIOR ,
NOMBRE2 ,
ESTATUS_SIAPSEP  from BDUNICA.cct where
-- nombre = 'DONALD WINNICOTT'
REGEXP_LIKE (nombre, '* WINNICOTT*')
