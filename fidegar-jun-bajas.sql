DELETE FROM W_PADRON_ALUMNOS_FIDEGAR --W00A_FIDEGAR_REVALIDA
;

select
vista.CURP
, vista.NOMBRES
, vista.primerapellido as PRIMER_APELLIDO
, vista.segundoapellido as SEGUNDO_APELLIDO
, vista.CCT
, vista.niveleducativo as NIVEL_EDUCATIVO
, DECODE(GRADO
                                    ,1,'PRIMERO'
                                    ,2,'SEGUNDO'
                                    ,3,'TERCERO'
                                    ,4,'CUARTO'
                                    ,5,'QUINTO'
                                    ,6,'SEXTO'
                                    ,vista.grado
) as GRADO
--, trim(vista.nombreescuela) as NOMBRE_PLANTEL
, vista.TURNO
--, vista.SERVICIOEDUCATIVO as SERVICIO_EDUCATIVO
, vista.alcaldia_cct as  ALCADIA
, current_timestamp as fh_consulta
, vista.fh_carga, vista.fh_ejecucion
-- , 'INSCRITO' as STATUS
, 'BAJA' as STATUS
, vista.fecha_baja_tentativa
, vista.tipo_baja
-- from MATRICULA.mview_alumnos_20212022 vista
from MATRICULA.mview_alumnos_2122_bajas vista
where curp in (select curp from W00A_FIDEGAR_REVALIDA
where curp not in ( select alumno_curp from W_PADRON_ALUMNOS_FIDEGAR)
)
-- and substr(CCT,3,1) != 'P'
;

select
SAL_CURP_ALUMNO as CURP
, SAL_NOMBRE_ALUMNO as NOMBRE
, CASE WHEN SAL_PRIMER_APELLIDO is null THEN 'NULO' ELSE SAL_PRIMER_APELLIDO END as PRIMER_APELLIDO,
 SAL_SEGUNDO_APELLIDO as SEGUNDO_APELLIDO
, SIS_SES_CCT_ESCUELA as CCT
--, trim(bdunica.nombre) as NOMBRE_PANTEL
, REGEXP_REPLACE(tur.des_turno,'( ){2,}', ' ') as TURNO
, CASE WHEN SNE_DESCCRIPCION_LARGA_NIVEL = 'INICIAL LACTANTES' THEN 'LACTANTE'
 ELSE SNE_DESCCRIPCION_LARGA_NIVEL END as NIVEL
,DECODE(sis_sge_cve_grado_escolar
                                    ,1,'PRIMERO'
                                    ,2,'SEGUNDO'
                                    ,3,'TERCERO'
                                    ,4,'CUARTO'
                                    ,5,'QUINTO'
                                    ,6,'SEXTO'
                                    ,sis_sge_cve_grado_escolar
) as GRADO
--, del.descripcion as ALCALDIA
from SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and matricula.sed_inscripciones.sis_firma_digital = 1
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join bdunica.cct bdunica on matricula.sed_inscripciones.sis_ses_cct_escuela = bdunica.cct
-- left join bdunica.cve_delegacion del on bdunica.cod_municipio = del.cve_dele
left join bdunica.turno tur on bdunica.cod_turno = tur.cod_turno
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and SAL_CURP_ALUMNO in (select curp from W00A_FIDEGAR_REVALIDA
where curp not in ( select alumno_curp from W_PADRON_ALUMNOS_FIDEGAR)
)
--and substr(SIS_SES_CCT_ESCUELA,3,1) != 'P'
;