select 
COORDINACION as DIRECCION_GENERAL
, case when substr(vista.cct,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, sos.DES_SOSTENIMIENTO as SOSTENIMIENTO_AEFCM
, vista.niveleducativo as NIVEL_EDUCATIVO
, vista.SERVICIOEDUCATIVO as SERVICIO_EDUCATIVO
, vista.alcaldia_cct as  ALCADIA
, vista.CCT
, vista.nombreescuela as NOMBRE_PLANTEL
, vista.idturno as TURNO_ID
, vista.TURNO
, vista.GRADO
, vista.GRUPO
, null as SISTEMA_ID
, null as SISTEMA
, null as ALUMNO_ID
, vista.CURP
, vista.primerapellido as PRIMER_APELLIDO
, vista.segundoapellido as SEGUNDO_APELLIDO
, vista.NOMBRES
from MATRICULA.mview_alumnos_20212022 vista
left join bdunica.cct bdu on vista.cct = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
--where substr(vista.cct,3,1) = 'P'
;

select cct
, trim(nombre_plantel) as NOMBRE_PLANTEL
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = BOLETAS.cct
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, (select count(b.curp) from w_boletas_evaluacion_2020_2021 b 
    where BOLETAS.cct = b.cct) as MATRICULA_2020_2021_BOLETAS
, (select count(v.curp) from mview_alumnos_20212022 v 
    where BOLETAS.cct = v.cct) as MATRICULA_2021_2022_INSCRIP
from (select UNIQUE v.cct, bdu.nombre as NOMBRE_PLANTEL from mview_alumnos_20212022 v
    left join cct bdu on v.cct = bdu.cct) BOLETAS-- CCT BOLETAS
where substr(cct,3,1) = 'P'
