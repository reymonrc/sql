SELECT * FROM matricula.mview_alumnos_20212022; -- where niveleducativo not in ('MATERNAL','PREESCOLAR','PRIMARIA','SECUNDARIA','LACTANTE');

SELECT * FROM SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
-- and matricula.sed_inscripciones.sis_firma_digital = '1'
 left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
 left join PROCESA_INFORMACION.alumnos_correos correo on sed_alumnos.sal_curp_alumno =  correo.s_curp
 left join MVIEW_ALUMNOS_20212022 vista on sed_alumnos.sal_curp_alumno = vista.curp
-- preinscripciones_datos datos
where sis_sge_cve_grado_escolar = 'T'
 and SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022';
-- and sed_alumnos.sal_curp_alumno = datos.curp;

select rownum as ID,
 SAL_CURP_ALUMNO as ALUMNO_CURP, SAL_NOMBRE_ALUMNO as ALUMNO_NOMBRE,
 CASE WHEN SAL_PRIMER_APELLIDO is null THEN 'NULO' ELSE SAL_PRIMER_APELLIDO END as ALUMNO_APATERNO,
 SAL_SEGUNDO_APELLIDO as ALUMNO_AMATERNO,
 SAL_SEXO_ALUMNO as ALUMNO_GENERO, SIS_SES_CCT_ESCUELA as CCT,
 REGEXP_REPLACE(bdunica.nombre,'( ){2,}', ' ') as NOMBRE_ESCUELA, tur.des_turno as TURNO,
 CASE WHEN SNE_DESCCRIPCION_LARGA_NIVEL = 'INICIAL LACTANTES' THEN 'LACTANTE'
 ELSE SNE_DESCCRIPCION_LARGA_NIVEL END as NIVEL,
 vista.grado as GRADO,
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
vista.parentesco as TUTOR_PARENTESCO,
 CASE WHEN SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,' ',''),'-',''),'(',''),')',''),-10,10) is null
   THEN REPLACE(REPLACE(REPLACE(REPLACE(vista.telefono,' ',''),'-',''),'(',''),')','') 
   ELSE SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,' ',''),'-',''),'(',''),')',''),-10,10) END as TUTOR_TELEFONO,
 CASE WHEN datos.email is not null then datos.email else correo.correo_google end as TUTOR_CORREO,
 datos.domicilio_calle as TUTOR_CALLE, datos.domicilio_colonia as TUTOR_COLONIA,
 datos.domicilio_municipio as TUTOR_MUNICIPIO,
 datos.domicilio_codigo_postal as TUTOR_CODIGO_POSTAL, SIS_SCE_CVE_CICLO_ESCOLAR as CICLO_ESCOLAR,
'PROCESA_INFORMACION' as USUARIO_CREACION, CURRENT_DATE as FECHA_CREACION
from SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
-- and matricula.sed_inscripciones.sis_firma_digital = 1
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join PROCESA_INFORMACION.alumnos_correos correo on sed_alumnos.sal_curp_alumno =  correo.s_curp
left join MVIEW_ALUMNOS_20212022 vista on sed_alumnos.sal_curp_alumno = vista.curp
left join bdunica.cct bdunica on matricula.sed_inscripciones.sis_ses_cct_escuela = bdunica.cct
left join bdunica.cve_delegacion del on bdunica.cod_municipio = del.cve_dele
left join bdunica.cit col on bdunica.cod_localidad = col.cod_localidad
left join bdunica.turno tur on bdunica.cod_turno = tur.cod_turno,
preinscripciones_datos datos
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022' and sis_sge_cve_grado_escolar = 'T'
and sed_alumnos.sal_curp_alumno = datos.curp;
