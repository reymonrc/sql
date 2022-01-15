select
--si.*
 SI.SIS_SNE_CVE_NIVEL_ESCOLAR
 , SI.SIS_SGE_CVE_GRADO_ESCOLAR
 , count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
group by SI.SIS_SNE_CVE_NIVEL_ESCOLAR, SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2
;

--Consulta General
select
nivel_educativo
, SIS_SNE_CVE_NIVEL_ESCOLAR
,  substr(SIS_SES_CCT_ESCUELA,4,2) cla_cct
, sis_sge_cve_grado_escolar
, count(*) total
from
(
select
SI.SIS_SERVICIO_EDUCATIVO
, case 
    
      when SI.SIS_SNE_CVE_NIVEL_ESCOLAR in (0,1)
           then 'INICIAL'
--     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1 and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) not in ('16','17','18') and substr(SI.SIS_SES_CCT_ESCUELA,4,2) not in ('ML','CO') 
--          then 'INICIAL' /*Que tengan 3,4 o 5 años cumplidos al 31 de diciembre de 2021 para el ciclo escolar 2021-2022*/
--     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1 and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) in ('16','17','18') 
--          then 'PREESCOLAR INICIAL' /*Que tengan 3,4 o 5 años cumplidos al 31 de diciembre de 2021 para el ciclo escolar 2021-2022*/
          
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 3 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BA' 
          then 'PRIMARIA BÁSICA PARA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 4 and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BS' 
          then 'SECUNDARIA BÁSICA PARA ADULTOS'
     when SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
          then 'ESPECIAL CAM LABORAL'    
     when substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO') and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
          then 'ESPECIAL ' || DECODE(SI.SIS_SNE_CVE_NIVEL_ESCOLAR
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
, si.*
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
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
)
group by 
nivel_educativo
, SIS_SNE_CVE_NIVEL_ESCOLAR
, substr(SIS_SES_CCT_ESCUELA,4,2)
, sis_sge_cve_grado_escolar


order by 1,2
;


-- Alumnos del servicio educativo Inicial que están cursando educación "Lactantes o Maternal"
select
si.*
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1
and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) not in ('16','17','18')
;


-- Alumnos del servicio educativo Inicial que están cursando educación preescolar
select
si.*
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 1
and substr(SI.SIS_SAL_CURP_ALUMNO,5,2) in ('16','17','18')
;

-- Alumnos del servicio educativo Básica para Adultos que están cursando educación primaria
select
 substr(SI.SIS_SES_CCT_ESCUELA,3,3) clasificadores_cct
, SI.SIS_SGE_CVE_GRADO_ESCOLAR 
, count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BA'
group by substr(SI.SIS_SES_CCT_ESCUELA,3,3), SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2 
;

-- Alumnos del servicio educativo Básica para Adultos que están cursando educación secundaria
select
 substr(SI.SIS_SES_CCT_ESCUELA,3,3) clasificadores_cct
, SI.SIS_SGE_CVE_GRADO_ESCOLAR 
, count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and substr(SI.SIS_SES_CCT_ESCUELA,4,2) = 'BS'
group by substr(SI.SIS_SES_CCT_ESCUELA,3,3), SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2 
;


-- Alumnos del servicio educativo CAM Laboral que están cursando educación especial
select
 substr(SI.SIS_SES_CCT_ESCUELA,3,3) clasificadores_cct
, SI.SIS_SGE_CVE_GRADO_ESCOLAR 
, count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and SI.SIS_SNE_CVE_NIVEL_ESCOLAR = 5
group by substr(SI.SIS_SES_CCT_ESCUELA,3,3), SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2 
;

-- Alumnos del servicio educativo CAM Laboral que están cursando educación especial
select
SI.SIS_SNE_CVE_NIVEL_ESCOLAR
, substr(SI.SIS_SES_CCT_ESCUELA,3,3) clasificadores_cct
, SI.SIS_SGE_CVE_GRADO_ESCOLAR 
, count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO')
and SI.SIS_SNE_CVE_NIVEL_ESCOLAR != 5
group by SI.SIS_SNE_CVE_NIVEL_ESCOLAR,substr(SI.SIS_SES_CCT_ESCUELA,3,3), SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2,3 
;

select 
substr(ct.cct,3,3)
,count(*) total
from cct ct
where CT.COD_DEP_NORMAT = 'EE'
and exists
(
 select * from sed_inscripciones si
 where 1=1
 and SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
 and ct.cct = SI.SIS_SES_CCT_ESCUELA
)
group by substr(ct.cct,3,3)
order by 1
;


-- Alumnos del servicio educativo "GENERAL" que están cursando educación inicial, preescolar,primaria, secundaria
select
SI.SIS_SNE_CVE_NIVEL_ESCOLAR
, substr(SI.SIS_SES_CCT_ESCUELA,4,2) clasificadores_cct
--, SI.SIS_SGE_CVE_GRADO_ESCOLAR 
, count(*) total
from sed_inscripciones si
where SI.SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and SI.SIS_SNE_CVE_NIVEL_ESCOLAR in(2,3,4)
--and substr(SI.SIS_SES_CCT_ESCUELA,4,2) in ('ML','CO')

group by SI.SIS_SNE_CVE_NIVEL_ESCOLAR,substr(SI.SIS_SES_CCT_ESCUELA,4,2)
--, SI.SIS_SGE_CVE_GRADO_ESCOLAR
order by 1,2,3 
;

select 
ct.*
from cct ct
where substr(CT.CCT,4,2) = 'CR'
order by 1
;