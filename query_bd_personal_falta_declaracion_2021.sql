select
*
from zmp_personal_aefcm_sin_decl x
where
 exists
(
 select * from rdp_personal_aefcm y
 where y.curp = x.curp
)
;
--9741


--select
--distinct cod_dep_normat, des_dep_normat
--, unidad_responsable
--from
--(
select
x.id
, x.curp
, x.nombre
, x.puesto
, x.estatus
, y.cct
, (select trim(ct.cod_dep_normat) from cct@matricula ct, turno@matricula tno where ct.cct = y.cct and ct.cod_turno = tno.cod_turno)
  cod_dep_normat
, (select trim(dn.des_dep_normat) from cct@matricula ct, turno@matricula tno, dependencia_normat@matricula dn where ct.cct = y.cct and ct.cod_turno = tno.cod_turno and ct.cod_dep_normat = dn.cod_dep_normat)
  des_dep_normat
,decode((select trim(ct.cod_dep_normat) from cct@matricula ct where ct.cct = y.cct)
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
        ) unidad_responsable 
, decode(y.cct_nombre
         ,'#N/A',(select trim(ct.nombre) from cct@matricula ct, turno@matricula tno where ct.cct = y.cct and ct.cod_turno = tno.cod_turno)
         ,y.cct_nombre
        ) 
  cct_nombre       
, decode(y.cct_alcaldia
         ,'#N/A',(select trim(ci.nombre) from cct@matricula ct, turno@matricula tno, cit@matricula ci 
                   where ct.cct = y.cct and ct.cod_turno = tno.cod_turno
                   and ct.cod_entidad = ci.cod_entidad
                   and ct.cod_municipio = ci.cod_municipio
                   and '0000' = ci.cod_localidad
                 )
         ,y.cct_alcaldia
        )
  cct_alcaldia
, decode(y.cct_turno
          ,'#N/A',(select trim(tno.des_turno) from cct@matricula ct, turno@matricula tno where ct.cct = y.cct and ct.cod_turno = tno.cod_turno)
         ,y.cct_turno 
     )  
  cct_turno
, y.tipo_cct
, y.tipo_personal
, replace(y.tipo_servicio,'PRIMARIAS','PRIMARIA') tipo_servicio
, decode(y.tipo_servicio
         ,'INICIAL'        ,'1. INICIAL'
         ,'ESPECIAL'       ,'2. ESPECIAL'
         ,'PREESCOLAR'     ,'3. PREESCOLAR'
         ,'PRIMARIA'       ,'4. PRIMARIA'
         ,'PRIMARIAS'      ,'4. PRIMARIA'
         ,'SECUNDARIA'     ,'5. SECUNDARIA'
         ,'NORMALES'       ,'6. NORMALES'
         ,'ADMINISTRATIVO' ,'7. ADMINISTRATIVO'
         ,'DE APOYO'       ,'8. DE APOYO'
         ,''
        ) 
  nivel_educativo
, y.unidad_administrativa
, y.email
, case when y.curp is not null then 'ENCONTRADO' else 'NO ENCONTRADO' end resultado_busqueda
--distinct y.tipo_servicio
from zmp_personal_aefcm_sin_decl x
,rdp_personal_aefcm y 
where
x.curp = y.curp
--and y.cct in
--(
--'09DAS0001K'
--,'09FMM0002S'
--,'09DDI0011H'
--,'09DJN0144U'
--,'09DES4301E'
--,'09DES4217G'
--,'09DTV0145I'
--
--)
order by 1 
--)
;


select
ct.cct
, ct.cod_turno
, tno.des_turno
from cct@matricula ct
, turno@matricula tno
where
ct.cod_turno = tno.cod_turno
and ct.cct in
(
'09DAS0001K'
,'09FMM0002S'
,'09DDI0011H'
,'09DJN0144U'
,'09DES4301E'
,'09DES4217G'
,'09DTV0145I'

)
; 