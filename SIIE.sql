select sum(case
when dat.pi is null then 1
else 11 end) as cuenta
from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = 'VEBA181226HDFNCNA5';
    
SELECT
vi.*
, (select sum(case
when dat.pi is null then 1
when dat.pi > 5 then 101
when dat.asignatura_id in ('T00999','061014','062014','063014','113061','AR0730','AR9999',
'114011','114021','115011','116021','113051','116011','111032','112052','TINGLE') 
or length(dat.asignatura_id) < 5
then 10001 else 1000001 end)
from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = vi.curp) as cuenta
FROM (select 
CURP, CCT, ALCALDIA, NIVEL, GRADO
from tmpp1_2122
where NIVEL = 'SECUNDARIA'
and cct in ('09DES4310M','09DTV0052T')
) vi
;
 
   
DELETE FROM TMPP1_2122;

SELECT 
--UNIQUE vi.curp, vi.cct, vi.alcaldia_cct as alcaldia,
--vi.niveleducativo as nivel, vi.grado
UNIQUE vi.cct, trim(vi.nombreescuela) as NOMBRE_PLANTEL, vi.alcaldia_cct as alcaldia, vi.niveleducativo as nivel
, vi.grado, vi.asignatura_id, trim(vi.asignatura) as ASIGNATURA
--, (select sum(case when vi.pi is null then 1 
--when vi.pi > 5 then 10001
--else 100000001 end)
--from MVIEW_ALUMNOS_2122_PERIODO dat where
--dat.cct = vi.cct and dat.asignatura_id = vi.asignatura_id
--and dat.grado = vi.grado and dat.niveleducativo = vi.niveleducativo
--) as datos
from MVIEW_ALUMNOS_2122_PERIODO vi
where vi.asignatura_id is not null
--where vi.niveleducativo = 'PRIMARIA'
;

update tmpmat_2122 vi set CUENTA = (select sum(case when dat.pi is null then 1 
when dat.pi > 5 then 10001
else 100000001 end)
from MVIEW_ALUMNOS_2122_PERIODO dat where
dat.cct = vi.cct and dat.asignatura_id = vi.asignatura_id
and dat.grado = vi.grado and dat.niveleducativo = vi.nivel
);

SELECT ASIGNATURA, GRADO
, count(*) CCT_CON_MAS_REPROBADAS
from (select * from tmpmat_2122 
where nivel = 'SECUNDARIA'
--and asignatura_id not in ('P00033','P00005')
and (asignatura_id not in ('T00999','061014','062014','063014','113061','AR0730','AR9999',
'114011','114021','115011','116021','113051','116011','111032','112052','TINGLE') 
-- and length(asignatura_id) > 4
)
and cuenta < 10000
-- and floor(mod(cuenta,100000000)/10000)/mod(cuenta,10000) < 0.5
) group by asignatura, grado
;

SELECT vi.*
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00012') AS P00012
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00007') AS P00007
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00001') AS P00001
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00004') AS P00004
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00020') AS P00020
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00034') AS P00034
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00010') AS P00010
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00033') AS P00033
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00002') AS P00002
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00003') AS P00003
, (SELECT dat.pi FROM MVIEW_ALUMNOS_2122_PERIODO dat
  WHERE dat.curp = vi.alumno_curp AND dat.asignatura_id = 'P00005') AS P00005
FROM (SELECT CURP AS ALUMNO_CURP, CCT, ALCALDIA, NIVEL, GRADO FROM tmpp1_2122) vi
where nivel = 'PRIMARIA';

alter table tmpp1_2122 add (
P00012 integer, P00007 integer, P00001 integer
, P00004 integer, P00020 integer, P00034 integer
, P00010 integer, P00033 integer, P00002 integer
, P00003 integer, P00005 integer);

update tmpp1_2122 tmp set P00012 = (select vi.pi from MVIEW_ALUMNOS_2122_PERIODO vi
where tmp.curp = vi.curp and vi.asignatura_id = 'P00012'
and tmp.nivel = 'PRIMARIA');
update tmpp1_2122 tmp set P00001 = (select vi.pi from MVIEW_ALUMNOS_2122_PERIODO vi
where tmp.curp = vi.curp and vi.asignatura_id = 'P00001'
and tmp.nivel = 'PRIMARIA')