---
--- Inscritos 2021-2022 
---
select 
COORDINACION as DIRECCION_GENERAL
, case when substr(vista.cct,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, vista.niveleducativo as NIVEL_EDUCATIVO
, decode(substr(vista.cct,4,2)
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
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
from mview_alumnos_20212022 vista
left join cct bdu on vista.cct = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
;

---
--- Boletas 2020-2021
---
select 
decode(trim(bdu.cod_dep_normat)
         ,'SF','DGOSE'
         ,'SG','DGOSE'
         ,'TV','DGOSE'
         ,'PR','DGOSE'
         ,'EP','DGOSE'
         ,'EX','DGOSE'
         ,'EE','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'TE','DGEST'
         ,'DP','DGPPEE'
         ,'DX','DGIFA'
         ,'AP','DGA'
         ,'DF','AEFCM'
         ,'SC','OSEP'
         ,'ND','CONADE'
        ) as DIRECCION_GENERAL
, case when substr(BOLETAS.cct,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, BOLETAS.NIVEL_EDUCATIVO
, decode(substr(BOLETAS.cct,4,2)
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = BOLETAS.cct
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, BOLETAS.CCT
, bdu.nombre as NOMBRE_PLANTEL
, BOLETAS.TURNO_ID
, BOLETAS.TURNO
, BOLETAS.GRADO
, BOLETAS.GRUPO
, BOLETAS.SISTEMA_ID
, BOLETAS.SISTEMA
, BOLETAS.ID_EN_SISTEMA_ORIGEN as ALUMNO_ID
, BOLETAS.CURP
, BOLETAS.PRIMER_APELLIDO
, BOLETAS.SEGUNDO_APELLIDO
, BOLETAS.NOMBRES
from w_boletas_evaluacion_2020_2021 boletas
left join cct bdu on boletas.cct = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
;

---
--- Comparación matrícula boletas vs insctipciones
---
select cct
, trim(nombre_plantel) as NOMBRE_PLANTEL
, decode(trim(cod_dep_normat)
         ,'SF','DGOSE'
         ,'SG','DGOSE'
         ,'TV','DGOSE'
         ,'PR','DGOSE'
         ,'EP','DGOSE'
         ,'EX','DGOSE'
         ,'EE','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'TE','DGEST'
         ,'DP','DGPPEE'
         ,'DX','DGIFA'
         ,'AP','DGA'
         ,'DF','AEFCM'
         ,'SC','OSEP'
         ,'ND','CONADE'
        ) as DIRECCION_GENERAL
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = BOLETAS.cct
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, decode(cod_turno
    ,100,'MATUTINO'
    ,200,'VESPERTINO'
    ,300,'NOCTURNO'
    ,400,'DISCONTINUO'
    ,120,'MATUTINO Y VESPERTINO'
    ,123,'MATUTINO, VESPERTINO Y NOCTURNO'
    ,500,'TIEMPO COMPLETO'
    ,700,'JORNADA AMPLIADA'
    ,'DESCONOCIDO') as TURNO
, (select count(b.curp) from w_boletas_evaluacion_2020_2021 b 
    where BOLETAS.cct = b.cct) as MATRICULA_2020_2021_BOLETAS
, (select count(v.curp) from mview_alumnos_20212022 v 
    where BOLETAS.cct = v.cct) as MATRICULA_2021_2022_INSCRIP
from (select UNIQUE v.cct, bdu.nombre as NOMBRE_PLANTEL, bdu.cod_dep_normat,
    bdu.cod_turno from w_boletas_evaluacion_2020_2021 v
    left join cct bdu on v.cct = bdu.cct) BOLETAS
-- where CCT not in (select UNIQUE v.cct from w_boletas_evaluacion_2020_2021 v)
where substr(cct,3,1) = 'P';


---
--- Asginacion_preescolar
---
select
decode(trim(bdu.cod_dep_normat)
         ,'SF','DGOSE'
         ,'SG','DGOSE'
         ,'TV','DGOSE'
         ,'PR','DGOSE'
         ,'EP','DGOSE'
         ,'EX','DGOSE'
         ,'EE','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'TE','DGEST'
         ,'DP','DGPPEE'
         ,'DX','DGIFA'
         ,'AP','DGA'
         ,'DF','AEFCM'
         ,'SC','OSEP'
         ,'ND','CONADE'
        ) as DIRECCION_GENERAL
, case when substr(ASIGNACION_CCT,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, 'PREESCOLAR' as NIVEL_EDUCATIVO
, decode(substr(ASIGNACION_CCT,4,2)
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = ASIGNACION_CCT
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, ASIGNACION_CCT as CCT
, trim(bdu.nombre) as NOMBRE_PLANTEL
, asignacion_turno_id as TURNO_ID
, asignacion_turno as TURNO
, CURP
, PRIMER_APELLIDO
, SEGUNDO_APELLIDO
, NOMBRES
, asignacion_grado as GRADO
from
(
select
cmb.curp
, cmb.nompila as NOMBRES
, cmb.paterno as PRIMER_APELLIDO
, cmb.materno as SEGUNDO_APELLIDO
, pl.cct asignacion_cct
, (select ct.cod_turno from cct ct where ct.cct = pl.cct) asignacion_turno_id
, (select trim(tno.des_turno) from cct ct, turno tno where ct.cct = pl.cct and ct.cod_turno = tno.cod_turno) asignacion_turno
, cmb.grado asignacion_grado
, CMB.CANCELA
from p2122_prcmb1819_alumnos_pre cmb
, p2122_plantel pl
where cmb.llaasi = pl.ordenproceso(+)
union
select
asg.curp
, asg.nompila as NOMBRES
, asg.paterno as PRIMER_APELLIDO
, asg.materno as SEGUNDO_APELLIDO
, pl.cct asignacion_cct
, (select ct.cod_turno from cct ct where ct.cct = pl.cct) asignacion_turno_id
, (select trim(tno.des_turno) from cct ct, turno tno where ct.cct = pl.cct and ct.cod_turno = tno.cod_turno) asignacion_turno
, asg.grado asignacion_grado
, ASG.CANCELA
from p2122_pasg1819_alumnos_pre asg -- 61 549 total menos 83 canceladas = 61 466
, p2122_plantel pl
where 
asg.llaasi = pl.ordenproceso(+)
and not exists
(select * from p2122_prcmb1819_alumnos_pre cmb
 where asg.curp = cmb.curp
)
)
left join cct bdu on ASIGNACION_CCT = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
where cancela is null -- 61,466
;

 ---
--- Asignacion primaria
--- 
select
decode(trim(bdu.cod_dep_normat)
         ,'SF','DGOSE'
         ,'SG','DGOSE'
         ,'TV','DGOSE'
         ,'PR','DGOSE'
         ,'EP','DGOSE'
         ,'EX','DGOSE'
         ,'EE','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'TE','DGEST'
         ,'DP','DGPPEE'
         ,'DX','DGIFA'
         ,'AP','DGA'
         ,'DF','AEFCM'
         ,'SC','OSEP'
         ,'ND','CONADE'
        ) as DIRECCION_GENERAL
, case when substr(ASIGNACION_CCT,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, 'PRIMARIA' as NIVEL_EDUCATIVO
, decode(substr(ASIGNACION_CCT,4,2)
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = ASIGNACION_CCT
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, ASIGNACION_CCT as CCT
, trim(bdu.nombre) as NOMBRE_PLANTEL
, asignacion_turno_id as TURNO_ID
, asignacion_turno as TURNO
, CURP
, PRIMER_APELLIDO
, SEGUNDO_APELLIDO
, NOMBRES
, asignacion_grado as GRADO
from
(
select
cmb.curp
, cmb.nompila as NOMBRES
, cmb.paterno as PRIMER_APELLIDO
, cmb.materno as SEGUNDO_APELLIDO
, pl.cct asignacion_cct
, (select ct.cod_turno from cct ct where ct.cct = pl.cct) asignacion_turno_id
, (select trim(tno.des_turno) from cct ct, turno tno where ct.cct = pl.cct and ct.cod_turno = tno.cod_turno) asignacion_turno
, 1 asignacion_grado
, CMB.CANCELA
from p2122_prcmb1819_alumnos_pri cmb
, p2122_plantel pl
where cmb.llaasi = pl.ordenproceso(+)
union
select
asg.curp
, asg.nompila as NOMBRES
, asg.paterno as PRIMER_APELLIDO
, asg.materno as SEGUNDO_APELLIDO
, pl.cct asignacion_cct
, (select ct.cod_turno from cct ct where ct.cct = pl.cct) asignacion_turno_id
, (select trim(tno.des_turno) from cct ct, turno tno where ct.cct = pl.cct and ct.cod_turno = tno.cod_turno) asignacion_turno
, 1 asignacion_grado
, ASG.CANCELA
from p2122_pasg1819_alumnos_pri asg -- 92 223 total menos 30 cancelada 92 193
, p2122_plantel pl
where 
asg.llaasi = pl.ordenproceso(+)
and not exists
(select * from p2122_prcmb1819_alumnos_pri cmb
 where asg.curp = cmb.curp
)
)
left join cct bdu on ASIGNACION_CCT = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
where cancela is null
;

---
--- Asignacion secundaria
---
select
decode(trim(bdu.cod_dep_normat)
         ,'SF','DGOSE'
         ,'SG','DGOSE'
         ,'TV','DGOSE'
         ,'PR','DGOSE'
         ,'EP','DGOSE'
         ,'EX','DGOSE'
         ,'EE','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'TE','DGEST'
         ,'DP','DGPPEE'
         ,'DX','DGIFA'
         ,'AP','DGA'
         ,'DF','AEFCM'
         ,'SC','OSEP'
         ,'ND','CONADE'
        ) as DIRECCION_GENERAL
, case when substr(ASIGNACION_CCT,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, 'SECUNDARIA' as NIVEL_EDUCATIVO
, decode(substr(ASIGNACION_CCT,4,2)
         ,'CR', 'INICIAL'
         ,'DI', 'INICIAL'
         ,'JN', 'PREESCOLAR'
         ,'EP', 'PREESCOLAR COMUNITARIOS'
         ,'PR', 'PRIMARIA GENERAL'
         ,'BN', 'PRIMARIA PARA TRABAJADORES'
         ,'IX', 'PRIMARIA PARTICIPACIÓN SOCIAL'
         ,'ZQ', 'PREESCOLAR COMUNITARIOS'
         ,'ML', 'ESPECIAL'
         ,'CO', 'ESPECIAL'
         ,'DM', 'ESPECIAL'
         ,'SN', 'SECUNDARIA PARA TRABAJADORES'
         ,'ES', 'SECUNDARIA GENERAL'
         ,'ST', 'SECUNDARIA TÉCNICA'
         ,'TV', 'TELESECUNDARIA'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
, (Select trim(alc.nombre) alcaldia from
cct ct, cit alc
Where ct.cct = ASIGNACION_CCT
And ct.cod_entidad = Alc.cod_entidad
And ct.cod_municipio = alc.cod_municipio
And '0000' = alc.cod_localidad) as  ALCADIA
, ASIGNACION_CCT as CCT
, trim(bdu.nombre) as NOMBRE_PLANTEL
, asignacion_turno_id as TURNO_ID
, asignacion_turno as TURNO
, CURP
, PRIMER_APELLIDO
, SEGUNDO_APELLIDO
, NOMBRES
, asignacion_grado as GRADO
from
(
select
cmb.curp
, cmb.nombre as NOMBRES
, cmb.apel_pat as PRIMER_APELLIDO
, cmb.apel_mat as SEGUNDO_APELLIDO
, case when pl.turno_id = 120 and cmb.ampl = 2 then pl.cct_vespertino else pl.cct end asignacion_cct
, (cmb.ampl * 100) asignacion_turno_id
, (select trim(tno.des_turno) from turno tno where tno.cod_turno = (cmb.ampl * 100)) asignacion_turno
, 1 asignacion_grado
from p2122_prcmb1819_alumnos_sec cmb
, p2122_plantel pl
where cmb.llaasi = pl.ordenproceso(+)
union
select
asg.curp
, asg.nombre as NOMBRES
, asg.apel_pat as PRIMER_APELLIDO
, asg.apel_mat as SEGUNDO_APELLIDO
, case when pl.turno_id = 120 and asg.ampl = 2 then pl.cct_vespertino else pl.cct end asignacion_cct
, (asg.ampl * 100) asignacion_turno_id
, (select trim(tno.des_turno) from turno tno where tno.cod_turno = (asg.ampl * 100)) asignacion_turno
, 1 asignacion_grado
from p2122_pasg1819_alumnos_sec asg -- 119 291 menos 6 cancelados
, p2122_plantel pl
where 
asg.llaasi = pl.ordenproceso(+)
and not exists
(
  select * from p2122_prcmb1819_alumnos_sec cmb
 where asg.curp = cmb.curp
)
)
left join cct bdu on ASIGNACION_CCT = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
where 
asignacion_cct is not null
--asignacion_turno is  null
;
TO_NUMBER('100.00');
select * from p2122_pasg1819_alumnos_pre where curp = 'MXAS180208HDFDNNA6'