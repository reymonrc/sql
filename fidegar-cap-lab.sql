select * from
MATRICULA.sed_inscripciones left JOIN SED_ALUMNOS
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
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
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and substr(sis_ses_cct_escuela, 3, 3) in ('DBA','DBS');


select 2497 + rownum as ID,
 SAL_CURP_ALUMNO as ALUMNO_CURP, SAL_NOMBRE_ALUMNO as ALUMNO_NOMBRE,
 CASE WHEN SAL_PRIMER_APELLIDO is null THEN 'NULO' ELSE SAL_PRIMER_APELLIDO END as ALUMNO_APATERNO,
 SAL_SEGUNDO_APELLIDO as ALUMNO_AMATERNO,
 SAL_SEXO_ALUMNO as ALUMNO_GENERO, SIS_SES_CCT_ESCUELA as CCT,
 REGEXP_REPLACE(bdunica.nombre,'( ){2,}', ' ') as NOMBRE_ESCUELA, 
 REGEXP_REPLACE(tur.des_turno,'( ){2,}', ' ') as TURNO,
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
from SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and matricula.sed_inscripciones.sis_firma_digital = 1
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
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and 
-- SIS_SNE_CVE_NIVEL_ESCOLAR = 5 
substr(sis_ses_cct_escuela, 3, 3) in ('DBA','DBS')
