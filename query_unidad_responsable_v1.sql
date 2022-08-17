--
-- UNIDAD RESPONSABLE
--
select
*
from bdu_cct ct
where ct.nombre like 'DIRECCIÓN GENERAL%'
and ct.cct in('09AEN0001O','09ATE0001Z','09AUE0001Y','09ASF0001I')
;


---
--- ESCUELAS POR DIRECCION GENERAL
---
--create table ZZMP_DIRECCION_GENERAL as
insert into ZZMP_DIRECCION_GENERAL
(
  DIRECCION_GENERAL      --VARCHAR2(11 BYTE),
  ,CCT_DIRECCION_GENERAL  --VARCHAR2(14 BYTE),
  ,COD_DEP_NORMAT         --CHAR(2 BYTE),
  ,TOTAL                  --NUMBER
)
;
select
direccion_general
, decode(direccion_general
         ,'DGOSE' ,'09ASF0001I'
         ,'DGSEI' ,'09AUE0001Y'
         ,'DGENAM','09AEN0001O'
         ,'DGEST' ,'09ATE0001Z'
         ,'SIN CLASIFICAR'
        ) cct_direccion_general
, cod_dep_normat
, count(*) total
from
(
select  --09DPR
ct.cct
, DECODE(ct.cod_dep_normat
         ,'PR','DGOSE'
         ,'IZ','DGSEI'
         ,'EN','DGENAM'
         ,'EP','DGOSE'
         ,'NU','DGOSE'
         ,'OB','DGOSE'
         ,'OS','DGOSE'
         ,'SG','DGOSE'
         ,'TE','DGEST'
         ,'TV','DGOSE'   
         ,'EX','DGOSE'
         ,'DF','DGOSE' -- 09FBS0001H consultar
         ,'CE','DGOSE' -- 09KES***** consultar
         ,'AL','DGOSE' -- AL del INBA consultar
         ,'EE','DGOSE'
        
         ,'DESCONOCIDO'
   ) DIRECCION_GENERAL
, ct.cod_dep_normat   
---select ct.cct, ct.cod_dep_normat
from bdu_cct ct
where
substr(ct.cct,4,2) in (/*'PR','IX','BN','DI','JN','ES','ST','TV','SN','BA','BS','ML','CO','DM',*/'AL','AR') -- 2510 1286
and ct.cod_situacion in (1,4)
--and substr(ct.cct,4,2) in ('AL','AR')
)
group by
direccion_general
, cod_dep_normat
;


select
ct.cct
, trim(ct.nombre) nombre_cct
, ct.cod_dep_normat
, trim(dpn.des_dep_normat) dependencia_normativa
, ct.cod_municipio
, trim(ci.nombre) alcaldia
, ct.cod_sostenimiento
, trim(sos.des_sostenimiento) sostenimiento
from bdu_cct ct
, bdu_sostenimiento sos
, bdu_dependencia_normat dpn
, bdu_cit ci
where ct.cct = '09KES0008J'
and ct.cod_sostenimiento = sos.cod_sostenimiento
and ct.cod_dep_normat = dpn.cod_dep_normat
and ct.cod_entidad = ci.cod_entidad
and ct.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
;

select
ct.cct
, trim(ct.nombre) nombre_cct
, ct.cod_dep_normat
, trim(dpn.des_dep_normat) dependencia_normativa
, ct.cod_municipio
, trim(ci.nombre) alcaldia
, ct.cod_sostenimiento
, trim(sos.des_sostenimiento) sostenimiento
from bdu_cct ct
, bdu_sostenimiento sos
, bdu_dependencia_normat dpn
, bdu_cit ci
where 
1=1
and ct.cod_situacion in (1,4)
and ct.cod_dep_normat = 'DF'
and substr(ct.cct,4,2) = 'BS'
and ct.cod_sostenimiento = sos.cod_sostenimiento
and ct.cod_dep_normat = dpn.cod_dep_normat
and ct.cod_entidad = ci.cod_entidad
and ct.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
order by 1
;


select
ct.cct
, trim(ct.nombre) nombre_cct
, ct.cod_dep_normat
, trim(dpn.des_dep_normat) dependencia_normativa
, ct.cod_municipio
, trim(ci.nombre) alcaldia
, ct.cod_sostenimiento
, trim(sos.des_sostenimiento) sostenimiento
from bdu_cct ct
, bdu_sostenimiento sos
, bdu_dependencia_normat dpn
, bdu_cit ci
where 
1=1
and ct.cod_situacion in (1,4)
and ct.cod_dep_normat = 'EN'
and substr(ct.cct,4,2) in ('PR','IX','BN','DI','JN','ES','ST','TV','SN','BA','BS','ML','CO','DM')
--and substr(ct.cct,4,2) = 'BS'
and ct.cod_sostenimiento = sos.cod_sostenimiento
and ct.cod_dep_normat = dpn.cod_dep_normat
and ct.cod_entidad = ci.cod_entidad
and ct.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
order by 1
;



select
distinct ct.cod_dep_normat 
--ct.cct
--, trim(ct.nombre) nombre_cct
--, ct.cod_dep_normat
--, trim(dpn.des_dep_normat) dependencia_normativa
--, ct.cod_municipio
--, trim(ci.nombre) alcaldia
--, ct.cod_sostenimiento
--, trim(sos.des_sostenimiento) sostenimiento
from bdu_cct ct
, bdu_sostenimiento sos
, bdu_dependencia_normat dpn
, bdu_cit ci
where 
1=1
and ct.cod_situacion in (1,4)
and substr(ct.cct,4,2) in ('TV')--in ('ML','CO','DM')-- in('BA', 'BS')
and ct.cod_sostenimiento = sos.cod_sostenimiento
and ct.cod_dep_normat = dpn.cod_dep_normat
and ct.cod_entidad = ci.cod_entidad
and ct.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
order by 1
;


---
---
---
insert into ZZMP_LOAD_DOMICILIO
(
  ID             --NUMBER(7),
  ,CCT            --VARCHAR2(10 BYTE),
  ,CALLE          --VARCHAR2(60 BYTE),
  ,COD_ENTIDAD    --VARCHAR2(2 BYTE),
  ,COD_MUNICIPIO  --VARCHAR2(3 BYTE),
  ,COD_LOCALIDAD  --VARCHAR2(4 BYTE)
)

select 
(8224+rownum)
, ct.cct
, trim(ct.cct_domicilio) calle
, ci.cod_entidad
, ci.cod_municipio
, ci.cod_localidad
from bdu_cct ct
, bdu_cit ci
where ct.cct in('09AEN0001O','09ATE0001Z','09AUE0001Y','09ASF0001I')
and ct.cod_entidad = ci.cod_entidad
and ct.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
;

insert into DOMICILIO
(
  ID              
  ,CALLE          
  ,COD_ENTIDAD    
  ,COD_MUNICIPIO  
  ,COD_LOCALIDAD  
)
select
  ID              
  ,CALLE          
  ,COD_ENTIDAD    
  ,COD_MUNICIPIO  
  ,COD_LOCALIDAD  
from ZZMP_LOAD_DOMICILIO x
where not exists
(
 select * from domicilio d 
 where d.id = x.id
)
;
;

select
*
from ZZMP_LOAD_DOMICILIO x
where exists
(
  select * from domicilio d
  where x.id = d.id
  and trim(x.calle) = trim(d.calle) 
);


---
--- Agregar los cct's de las direcciones generales
---
insert into ESCUELA
(
  ID                            --NUMBER(7),
  ,CCT                           --VARCHAR2(10 BYTE),
  ,TIPO_DE_CCT_ID                --NUMBER(5),
  ,UNIDAD_RESPONSABLE_CCT_ID     --NUMBER(7),
  ,DIRECCION_OPERATIVA_CCT_ID    --NUMBER(7),
  ,DEPENDENCIA_NORMATIVA_CCT_ID  --NUMBER(7),
  ,COD_DEP_NORMAT                --VARCHAR2(2 BYTE),
  ,COD_SOSTENIMIENTO             --VARCHAR2(3 BYTE),
  ,ZONA_ESCOLAR_CCT_ID           --NUMBER(7),
  ,SECTOR_CCT_ID                 --NUMBER(7),
  ,DOMICILIO_DOMICILIO_ID        --NUMBER          NOT NULL,
  ,SERVICIO_REGIONAL_ID          --NUMBER          NOT NULL
)
select
  rownum id                            --NUMBER(7),
  ,ct.cct cct                           --VARCHAR2(10 BYTE),
  , 7 tipo_de_cct_id                --NUMBER(5),
  ,null unidad_responsable_cct_id     --NUMBER(7),
  ,null direccion_operativa_cct_id    --NUMBER(7),
  ,null dependencia_normativa_cct_id  --NUMBER(7),
  ,null cod_dep_normat                --VARCHAR2(2 BYTE),
  ,null cod_sostenimiento             --VARCHAR2(3 BYTE),
  ,null zona_escolar_cct_id           --NUMBER(7),
  ,null sector_cct_id                 --NUMBER(7),
  ,(select d.id from domicilio d, zzmp_load_domicilio dtmp where dtmp.cct = ct.cct and dtmp.id = d.id) domicilio_domicilio_id        --NUMBER          NOT NULL,
  ,(select sr.id from servicio_regional sr where sr.cod_serv_reg = ct.cod_serv_reg) servicio_regional_id          --NUMBER          NOT NULL
from bdu_cct ct
where ct.nombre like 'DIRECCIÓN GENERAL%'
and ct.cct in('09AEN0001O','09ATE0001Z','09AUE0001Y','09ASF0001I')
;



---
--- Agregar todos los registros de las escuelas que aparecen en la estadística de inicio 2020-2021
---
select * from ZZMP_DIRECCION_GENERAL;

insert into ESCUELA
(
  ID                            --NUMBER(7),
  ,CCT                           --VARCHAR2(10 BYTE),
  ,TIPO_DE_CCT_ID                --NUMBER(5),
  ,UNIDAD_RESPONSABLE_CCT_ID     --NUMBER(7),
  ,DIRECCION_OPERATIVA_CCT_ID    --NUMBER(7),
  ,DEPENDENCIA_NORMATIVA_CCT_ID  --NUMBER(7),
  ,COD_DEP_NORMAT                --VARCHAR2(2 BYTE),
  ,COD_SOSTENIMIENTO             --VARCHAR2(3 BYTE),
  ,ZONA_ESCOLAR_CCT_ID           --NUMBER(7),
  ,SECTOR_CCT_ID                 --NUMBER(7),
  ,DOMICILIO_DOMICILIO_ID        --NUMBER          NOT NULL,
  ,SERVICIO_REGIONAL_ID          --NUMBER          NOT NULL
)
select
(4+rownum) id
 ,ct.cct CCT                           --VARCHAR2(10 BYTE),
 ,1 TIPO_DE_CCT_ID                --NUMBER(5),
 ,(
   select esc.id
   from escuela esc
   , ZZMP_DIRECCION_GENERAL dg
   where dg.cod_dep_normat = ct.cod_dep_normat
   and dg.cct_direccion_general = esc.cct
  ) 
  UNIDAD_RESPONSABLE_CCT_ID     --NUMBER(7),
 ,null DIRECCION_OPERATIVA_CCT_ID    --NUMBER(7),
 ,null DEPENDENCIA_NORMATIVA_CCT_ID  --NUMBER(7),
 ,null COD_DEP_NORMAT                --VARCHAR2(2 BYTE),
 ,null COD_SOSTENIMIENTO             --VARCHAR2(3 BYTE),
 ,null ZONA_ESCOLAR_CCT_ID           --NUMBER(7),
 ,null SECTOR_CCT_ID                 --NUMBER(7),
 ,(select d.id from domicilio d, zzmp_load_domicilio dtmp where dtmp.cct = ct.cct and dtmp.id = d.id) domicilio_domicilio_id
 ,(select sr.id from servicio_regional sr where sr.cod_serv_reg = ct.cod_serv_reg) servicio_regional_id 
from
(
select clavecct from ZZMP_I2021_ADULTOS    union
select clavecct from ZZMP_I2021_INICIAL    union
select clavecct from ZZMP_I2021_ESPECIAL   union
select clavecct from ZZMP_I2021_PREESCOLAR union
select clavecct from ZZMP_I2021_PRIMARIA   union
select clavecct from ZZMP_I2021_SECUNDARIA 
) x
, bdu_cct ct
where
x.clavecct = ct.cct
;  

---
---
---
select
ct.cct
, trim(ct.nombre) nombre_ur
, count(*) total_escuelas
from escuela esc
, escuela ur
, bdu_cct ct
where
esc.unidad_responsable_cct_id = ur.id
and ct.cct = ur.cct
group by ct.cct, ct.nombre
;

---
---
---
select
ct.cct
, trim(ct.nombre) nombre_ur
, trim(ci.nombre) alcadia
, count(*) total_escuelas
from escuela esc
, escuela ur
, bdu_cct ct
, domicilio dom
, bdu_cit ci
where
esc.unidad_responsable_cct_id = ur.id
and ct.cct = ur.cct
and esc.domicilio_id = dom.id
and dom.cod_entidad = ci.cod_entidad
and dom.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad

group by ct.cct, ct.nombre, ci.nombre
order by 1,2,3
;

---
--- Identificar direcciones operativas de  DGOSE Secundaria
---
select
*
from bdu_cct ct
where ct.nombre like '%DIRECC%OPERAT%'
and ct.cod_situacion in (1,4)
and substr(ct.cct,3,3) = 'ASG'
;

select max(id) from ZZMP_LOAD_DOMICILIO;
insert into INFORMES_CE.ZZMP_LOAD_DOMICILIO
(
  ID             --NUMBER(7),
  ,CCT            --VARCHAR2(10 BYTE),
  ,CALLE          --VARCHAR2(60 BYTE),
  ,COD_ENTIDAD    --VARCHAR2(2 BYTE),
  ,COD_MUNICIPIO  --VARCHAR2(3 BYTE),
  ,COD_LOCALIDAD  --VARCHAR2(4 BYTE)
)
;
select
8228 + rownum id
, ct.cct
, ct.cct_domicilio
, ct.cod_entidad
, ct.cod_municipio
, ct.cod_localidad
from bdu_cct ct

where ct.nombre like '%DIRECC%OPERAT%'
and ct.cod_situacion in (1,4)
and substr(ct.cct,3,3) = 'ASG'
order by ct.nombre
;

;


insert into DOMICILIO
(
  ID             --NUMBER(7),
  ,CALLE          --VARCHAR2(60 BYTE),
  ,COD_ENTIDAD    --VARCHAR2(2 BYTE),
  ,COD_MUNICIPIO  --VARCHAR2(3 BYTE),
  ,COD_LOCALIDAD  --VARCHAR2(4 BYTE)
)
select
  ID             --NUMBER(7),
  ,CALLE          --VARCHAR2(60 BYTE),
  ,COD_ENTIDAD    --VARCHAR2(2 BYTE),
  ,COD_MUNICIPIO  --VARCHAR2(3 BYTE),
  ,COD_LOCALIDAD  --VARCHAR2(4 BYTE)
from ZZMP_LOAD_DOMICILIO
where id > 8228
;
;

select max(id) from ESCUELA;
insert into ESCUELA
(
  ID                            --NUMBER(7),
  ,CCT                           --VARCHAR2(10 BYTE),
  ,TIPO_DE_CCT_ID                --NUMBER(5),
  ,UNIDAD_RESPONSABLE_CCT_ID     --NUMBER(7),
  ,DIRECCION_OPERATIVA_CCT_ID    --NUMBER(7),
  ,DEPENDENCIA_NORMATIVA_CCT_ID  --NUMBER(7),
  ,COD_DEP_NORMAT                --VARCHAR2(2 BYTE),
  ,COD_SOSTENIMIENTO             --VARCHAR2(3 BYTE),
  ,ZONA_ESCOLAR_CCT_ID           --NUMBER(7),
  ,SECTOR_CCT_ID                 --NUMBER(7),
  ,DOMICILIO_ID                  --NUMBER          NOT NULL,
  ,SERVICIO_REGIONAL_ID          --NUMBER          NOT NULL
)

select
  8228 + rownum ID                            --NUMBER(7),
  ,ct.CCT                           --VARCHAR2(10 BYTE),
  , 5 TIPO_DE_CCT_ID                --NUMBER(5),
  ,(select ur.id from escuela ur where ur.cct='09ASF0001I') UNIDAD_RESPONSABLE_CCT_ID     --NUMBER(7),
  ,null DIRECCION_OPERATIVA_CCT_ID    --NUMBER(7),
  ,null DEPENDENCIA_NORMATIVA_CCT_ID  --NUMBER(7),
  ,null COD_DEP_NORMAT                --VARCHAR2(2 BYTE),
  ,null COD_SOSTENIMIENTO             --VARCHAR2(3 BYTE),
  ,null ZONA_ESCOLAR_CCT_ID           --NUMBER(7),
  ,null SECTOR_CCT_ID                 --NUMBER(7),
  ,(select d.id from domicilio d, zzmp_load_domicilio dtmp where dtmp.cct = ct.cct and dtmp.id = d.id) domicilio_domicilio_id        --NUMBER          NOT NULL,
  ,(select sr.id from servicio_regional sr where sr.cod_serv_reg = ct.cod_serv_reg) servicio_regional_id          --NUMBER          NOT NULL

from bdu_cct ct
where ct.nombre like '%DIRECC%OPERAT%'
and ct.cod_situacion in (1,4)
and substr(ct.cct,3,3) = 'ASG'
order by ct.nombre
;
---
---Establecer las direcciones operativas de DGOSE
---
select
ct_escuela.cod_serv_reg
, esc.*
from escuela esc
, escuela ur
, bdu_cct ct
, domicilio dom
, bdu_cit ci
, bdu_cct ct_escuela
where
esc.unidad_responsable_cct_id = ur.id
and ct.cct = ur.cct
and esc.cct = ct_escuela.cct
and esc.domicilio_id = dom.id
and dom.cod_entidad = ci.cod_entidad
and dom.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
and ur.cct = '09ASF0001I' -- DGOSE
and substr(esc.cct,4,2) in ('ES','ST','TV','ST')
and esc.tipo_de_cct_id = 1
;
update escuela esc
set esc.direccion_operativa_cct_id = (
 select
 dirope.id 
 from bdu_cct ct, escuela dirope
 where
 ct.cct = esc.cct
 and dirope.cct = (
                    case when ct.cod_municipio in ('015','026','027','021') then '09ASG0072B'
                         when ct.cod_municipio in ('013','016') then '09ASG0073A'
                         when ct.cod_municipio in ('025','014','017','018','028') then '09ASG0074Z'
                         when ct.cod_municipio in ('019','020','023','022','024') then '09ASG0075Z'
                    end
                  )
)
where 
exists
(
  select * from 
 escuela ur
, bdu_cct ct
, domicilio dom
, bdu_cit ci
, bdu_cct ct_escuela
where
esc.unidad_responsable_cct_id = ur.id
and ct.cct = ur.cct
and esc.cct = ct_escuela.cct
and esc.domicilio_id = dom.id
and dom.cod_entidad = ci.cod_entidad
and dom.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
and ur.cct = '09ASF0001I' -- DGOSE
and substr(esc.cct,4,2) in ('ES','ST','TV','ST')
and esc.tipo_de_cct_id = 1
)
;

---
---Establecer las direcciones operativas de DGOSE
---
select
dirope.cct
, ct_dirope.nombre
, count(*) total
from escuela esc
, escuela ur
, bdu_cct ct
, domicilio dom
, bdu_cit ci
, bdu_cct ct_escuela
, escuela dirope
, bdu_cct ct_dirope
where
esc.unidad_responsable_cct_id = ur.id
and ct.cct = ur.cct
and esc.cct = ct_escuela.cct
and esc.domicilio_id = dom.id
and dom.cod_entidad = ci.cod_entidad
and dom.cod_municipio = ci.cod_municipio
and '0000' = ci.cod_localidad
and ur.cct = '09ASF0001I' -- DGOSE
and substr(esc.cct,4,2) in ('ES','ST','TV','ST')
and esc.tipo_de_cct_id = 1
and esc.direccion_operativa_cct_id = dirope.id
and dirope.cct = ct_dirope.cct
group by dirope.cct, ct_dirope.nombre
order by 1
;


select
*
from escuela esc
where esc.tipo_de_cct_id = 7
;

select 
ct_ur.cct
, ct.nombre 
from cct ct
, cct ct_ur
where
substr(ct.cct,3,3) in ('PDI'
                       ,'PJN'
                       ,'PPR','PBA'
                       ,'PES','PST','PSN','PTV','PBS'
                       ,'PML'
                       )
and ct_ur.cct = (
                 case when ct.cod_dep_normat in ('ES','TV') then '09ASF0001I' --DGOSE
                      when ct.cod_dep_normat in ('IZ') then '09AUE0001Y' --DGSEI
                      when ct.cod_dep_normat in ('TE') then '09ATE0001Z' --DGEST
                 end
                )                       

-------------------------------------------------------------------------------
09ATE0007T -- Jefatura de Control Escolar
R:22 (38) 09FZT0001G -- Similar a Dirección Operativa
R:23 (46) 09FZT0002F -- Similar a Dirección Operativa
R:24 (42) 09FZT0003E -- Similar a Dirección Operativa
R:25 (37) 09FZT0004D -- Similar a Dirección Operativa
 