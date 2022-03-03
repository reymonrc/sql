--Información del Primer Periodo de Alumnos de Preescolar, Primaria y Secundaria
SELECT
vi.*
, (select sum(case
when dat.pi is null then 1
else 11 end)
from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = vi.alumno_curp) as cuenta
FROM (select ALUMNO_CURP
, CCT, ALCALDIA, NIVEL
from W_PADRON_ALUMNOS_FIDEGAR_DUP
where NIVEL = 'PRIMARIA') vi
-- where vi.cct = '09DDI0004Y'
;
    
select * from MATRICULA.MVIEW_ALUMNOS_2122_PERIODO
where niveleducativo = 'PREESCOLAR'
and pi is not null
;

--Información de Bajas de  Alumnos de Preescolar, Primaria y Secundaria
SELECT * FROM MATRICULA.MVIEW_ALUMNOS_2122_BAJAS;

DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP;

SELECT unique
vista.COORDINACION as DIRECCION_GENERAL
, case when substr(vi.cct,3,1) = 'P'
    then 'PRIVADO'
    else 'PUBLICO' 
    end as SOSTENIMIENTO
, trim(sos.DES_SOSTENIMIENTO) as SOSTENIMIENTO_AEFCM
, vi.nivel as NIVEL_EDUCATIVO
, decode(substr(vi.cct,4,2)
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
         ,'BA', 'NOCTURNO'
         , 'SIN CLASIFICAR'
        ) as SERVICIO_EDUCATIVO
, vi.alcaldia as  ALCADIA
, vi.CCT
, trim(vista.nombreescuela) as NOMBRE_PLANTEL
, vista.idturno as TURNO_ID
, vista.TURNO
, vista.GRADO
, vista.GRUPO
--, null as SISTEMA_ID
--, null as SISTEMA
--, null as ALUMNO_ID
, vi.ALUMNO_CURP
, vista.primerapellido as PRIMER_APELLIDO
, vista.segundoapellido as SEGUNDO_APELLIDO
, vista.NOMBRES
--, vi.id
from W_PADRON_ALUMNOS_FIDEGAR_DUP vi
left join MVIEW_ALUMNOS_2122_PERIODO vista on vi.alumno_curp = vista.curp and vista.niveleducativo = 'SECUNDARIA'
left join cct bdu on vista.cct = bdu.cct
left join sostenimiento sos on sos.cod_sostenimiento = bdu.cod_sostenimiento
-- where mod(vi.id,100) - floor(vi.id/100) > 3 and vi.id > 100
-- where mod(vi.id,1000000) > 9999
-- where (mod(vi.id,100)-(floor(mod(vi.id,10000)/100)+floor(mod(vi.id,1000000)/10000)+floor(mod(vi.id,100000000)/1000000))) > 4
where vi.id < 100 and vi.id > 1
-- where mod(vi.id,100)-floor(mod(vi.id,10000)/100) > 3
-- and curp = 'VIGJ090606HDFLNNA7'
;
