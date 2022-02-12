DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR where id > 0;

--Consulta General
select
fi.alumno_curp, fi.cct, fi.nivel, fi.colonia as grado, si.sis_ses_cct_escuela as CCT_ESCUELA
, case
      when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')
           then 'INICIAL'
--     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1 and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) not in ('16','17','18') and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')
--          then 'INICIAL' /*Que tengan 3,4 o 5 años cumplidos al 31 de diciembre de 2021 para el ciclo escolar 2021-2022*/
--     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1 and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) in ('16','17','18')
--          then 'PREESCOLAR INICIAL' /*Que tengan 3,4 o 5 años cumplidos al 31 de diciembre de 2021 para el ciclo escolar 2021-2022*/
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 3 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BA','BN')
          then 'PRIMARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 4 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','SN')
          then 'SECUNDARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'CAM LABORAL'
     when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then 'CAM ' || DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4)
          then DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                     , 'NIVEL DESCONOCIDO'
                                    )
     else 'DESCONOCIDO'
end nivel_educativo
, si.sis_sge_cve_grado_escolar as GRADO_ID
, CASE when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'LABORAL'
       when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (3,4) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','BA','BN','SN')
          then 'ADULTOS'
       WHEN si.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4) 
          then DECODE(si.sis_sge_cve_grado_escolar
                                    ,1,'PRIMERO'
                                    ,2,'SEGUNDO'
                                    ,3,'TERCERO'
                                    ,4,'CUARTO'
                                    ,5,'QUINTO'
                                    ,6,'SEXTO'
                                    ,sis_sge_cve_grado_escolar
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1)
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,1 ,'INICIAL LACTANTES'
                                     ,2 ,'INICIAL MATERNAL'
                                     ,sis_sge_cve_grado_escolar
                                     )
        else sis_sge_cve_grado_escolar 
end GRADO_ESCOLAR
, bdsos.des_sostenimiento as SOSTENIMIENTO
, CASE when fi.cct != si.sis_ses_cct_escuela then si.sis_ses_cct_escuela
      when fi.nivel != (case
      when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')
           then 'INICIAL'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 3 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BA','BN')
          then 'PRIMARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 4 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','SN')
          then 'SECUNDARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'CAM LABORAL'
     when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then 'CAM ' || DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4)
          then DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                     , 'NIVEL DESCONOCIDO'
                                    )
     else 'DESCONOCIDO'
end)
        then (case
      when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')
           then 'INICIAL'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 3 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BA','BN')
          then 'PRIMARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 4 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','SN')
          then 'SECUNDARIA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'CAM LABORAL'
     when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then 'CAM ' || DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4)
          then DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                     , 'NIVEL DESCONOCIDO'
                                    )
     else 'DESCONOCIDO'
end)   
      when fi.colonia!= (CASE when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'LABORAL'
       when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (3,4) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','BA','BN','SN')
          then 'ADULTOS'
       WHEN si.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4) 
          then DECODE(si.sis_sge_cve_grado_escolar
                                    ,1,'PRIMERO'
                                    ,2,'SEGUNDO'
                                    ,3,'TERCERO'
                                    ,4,'CUARTO'
                                    ,5,'QUINTO'
                                    ,6,'SEXTO'
                                    ,sis_sge_cve_grado_escolar
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')   
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,1 ,'INICIAL LACTANTES'
                                     ,2 ,'INICIAL MATERNAL'
                                     ,sis_sge_cve_grado_escolar
                                     )
        else sis_sge_cve_grado_escolar 
end) then (CASE when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'LABORAL'
       when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,0 ,'INICIAL LACTANTES'
                                     ,1 ,'INICIAL MATERNAL'
                                     ,2 ,'PREESCOLAR'
                                     ,3 ,'PRIMARIA'
                                     ,4 ,'SECUNDARIA'
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (3,4) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('BS','BA','BN','SN')
          then 'ADULTOS'
       WHEN si.SIS_SNE_CVE_NIVEL_ESCOLAR in (2,3,4) 
          then DECODE(si.sis_sge_cve_grado_escolar
                                    ,1,'PRIMERO'
                                    ,2,'SEGUNDO'
                                    ,3,'TERCERO'
                                    ,4,'CUARTO'
                                    ,5,'QUINTO'
                                    ,6,'SEXTO'
                                    ,sis_sge_cve_grado_escolar
                                    )
       when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1) and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')   
          then DECODE(SI.sis_sge_cve_grado_escolar
                                     ,1 ,'INICIAL LACTANTES'
                                     ,2 ,'INICIAL MATERNAL'
                                     ,sis_sge_cve_grado_escolar
                                     )
        else sis_sge_cve_grado_escolar 
end)
       ELSE ''
end COMPARACION
from W_PADRON_ALUMNOS_FIDEGAR fi left join sed_inscripciones si
on fi.alumno_curp = si.sis_sal_curp_alumno
left join BDUNICA.cct bdcct on fi.cct=bdcct.cct
left join BDUNICA.sostenimiento bdsos on bdcct.cod_sostenimiento = bdsos.cod_sostenimiento
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and substr(SI.SIS_SES_CCT_ESCUELA,3,1) = 'P'
-- and grado = 'ADULTOS'
-- and NIVEL = 'CAM PREESCOLAR'
--and
--(
--  (
--    SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1 and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) not in ('16','17','18') and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO')
--  )
--  or
--  ( -- SE: INICIAL NIVEL: PREESCOLAR
--    SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1
--    and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) in ('16','17','18')
--  )
--  or
--  (
--    SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 3 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BA'
--  )
--  or
--  (
--    SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 4 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BS'
--  )
--  or
--  (
--    SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
--  )
--  or
--  (
--    substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO')
--    and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
--  )
--
--)
;


select CURP, sum(CAL16_17) as CAL16_17, sum(CAL17_18) as CAL17_18, sum(CAL18_19) as CAL18_19, sum(CAL19_20) as CAL19_20, sum(CAL20_21) as CAL20_21 from
(select si.sis_sal_curp_alumno as CURP
-- , case when si.sis_sce_cve_ciclo_escolar = '2015-2016' then sis_calificacion_grado end CAL15_16
, case when si.sis_sce_cve_ciclo_escolar = '2016-2017' then sis_calificacion_grado end CAL16_17
, case when si.sis_sce_cve_ciclo_escolar = '2017-2018' then sis_calificacion_grado end CAL17_18
, case when si.sis_sce_cve_ciclo_escolar = '2018-2019' then sis_calificacion_grado end CAL18_19
, case when si.sis_sce_cve_ciclo_escolar = '2019-2020' then sis_calificacion_grado end CAL19_20
, case when si.sis_sce_cve_ciclo_escolar = '2020-2021' then sis_calificacion_grado end CAL20_21
from PROCESA_INFORMACION.w_padron_alumnos_fidegar_dup fi left join sed_inscripciones si
on fi.alumno_curp = si.sis_sal_curp_alumno
and si.sis_sce_cve_ciclo_escolar in ('2016-2017','2017-2018','2018-2019','2019-2020','2020-2021'))
group by CURP
-- order by 1,2
;

