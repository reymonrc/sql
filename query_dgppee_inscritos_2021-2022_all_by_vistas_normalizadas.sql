select 
--distinct nivel_educativo, nivel_escolar
distinct substr(s_cct,4,2) c_cct
FROM SAEPPLOAD.V_ALUMNOS_INSCRITOS_XNIVEL@SIIEWEBW7_CONSULTA x
order by 1
--,2
;
select
*
from cct ct
where substr(cct,4,2) = 'EP'
;

select
sistema
, modalidad_educativa
, servicio_educativo
, nivel_educativo
, sostenimiento
, alcaldia
, situacion_cct
, cct
, nombre_cct
, turno
, grado
, count(*) total_matricula
, sysdate fecha_hora_consulta
from
(
select
   'SIIEWEB WWW7' sistema 
 , nivel_educativo modalidad_educativa
 , decode(substr(cct,4,2)
         ,'DI', 'INICIAL'
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'SIN CLASIFICACIÓN'
        ) servicio_educativo  
 , case when instr(nivel_escolar,'COMUNITARIOS') > 0 then TRIM(REPLACE(nivel_escolar,'COMUNITARIOS','')) else nivel_escolar end nivel_educativo
 , trim(SOS.DES_SOSTENIMIENTO) sostenimiento
 , trim(ci.nombre) alcaldia
 , trim(sc.des_situacion) situacion_cct
 , cct
 , trim(ct.nombre) nombre_cct
 , trim(tno.des_turno) turno
 , to_number(grado) grado
 , grupo
 FROM SAEPPLOAD.V_ALUMNOS_INSCRITOS_XNIVEL@SIIEWEBW7_CONSULTA x
 , cct ct
 , turno tno
 , situacion_centro sc
 , sostenimiento sos
 ,cit ci
 where
 1=1
 and x.s_cct = ct.cct
 and ct.cod_turno = tno.cod_turno
 and ct.cod_situacion = sc.cod_situacion
 and CT.COD_SOSTENIMIENTO = SOS.COD_SOSTENIMIENTO
 and ct.cod_entidad = ci.cod_entidad
 and ct.cod_municipio = ci.cod_municipio
 and '0000' = ci.cod_localidad
--and ct.cod_situacion in (3,5)
 
)
group by
sistema
, modalidad_educativa
, servicio_educativo
, nivel_educativo
, sostenimiento
, alcaldia
, situacion_cct
, cct
, nombre_cct
, turno
, grado
union
SELECT
sistema
, modalidad_educativa
, servicio_educativo
, nivel_educativo
, sostenimiento
, alcaldia
, situacion_cct
, cct
, nombre_cct
, turno
, grado
, count(*) total_matricula
, sysdate fecha_hora_consulta
from
(
 select
 'SIIEWEB WWW6' SISTEMA 
  ,decode(substr(x.cct,4,2)
         ,'ML', 'EDUCACIÓN ESPECIAL'
         ,'CO', 'EDUCACIÓN ESPECIAL'
         ,'DM', 'EDUCACIÓN ESPECIAL'
         ,'SN', 'EDUCACIÓN SECUNDARIA'
         ,'ES', 'EDUCACIÓN SECUNDARIA'
         ,'ST', 'EDUCACIÓN SECUNDARIA'
         ,'TV', 'EDUCACIÓN SECUNDARIA'
        ) modalidad_educativa
  ,decode(substr(x.cct,4,2)
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) servicio_educativo        
  , case when instr(x.nivel_educativo,'SECUNDARIA') > 0 then 'SECUNDARIA' else nivel_educativo end nivel_educativo
  , trim(SOS.DES_SOSTENIMIENTO) sostenimiento
  , trim(ci.nombre) alcaldia
  , trim(sc.des_situacion) situacion_cct
  , x.cct
  , trim(ct.nombre) nombre_cct
  , turno
  , grado       
  FROM SIIE.V_ALUMNOS_INSCRITOS@SIIEWEBW6SEC_CONSULTA x
  , cct ct
  , turno tno
  , situacion_centro sc
  , sostenimiento sos
  ,cit ci
  where 1=1
   and x.cct = ct.cct
   and ct.cod_turno = tno.cod_turno
   and ct.cod_situacion = sc.cod_situacion
   and CT.COD_SOSTENIMIENTO = SOS.COD_SOSTENIMIENTO
   and ct.cod_entidad = ci.cod_entidad
   and ct.cod_municipio = ci.cod_municipio
   and '0000' = ci.cod_localidad
--   and ct.cod_situacion in (3,5)
)
group by 
sistema
, modalidad_educativa
, servicio_educativo
, nivel_educativo
, sostenimiento
, alcaldia
, situacion_cct
, cct
, nombre_cct
, turno
, grado

order by 1,2,3,4
;