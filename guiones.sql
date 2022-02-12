--Información del Primer Periodo de Alumnos de Preescolar, Primaria y Secundaria
SELECT
vi.*
, (select count(*) from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = vi.alumno_curp
    and dat.cct = vi.cct) as materias
, (select count(dat.pi) from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = vi.alumno_curp
    and dat.cct = vi.cct) as datos
, (select count(*) from MVIEW_ALUMNOS_2122_PERIODO dat 
    where dat.curp = vi.alumno_curp
    and dat.pi > 5
    and dat.cct = vi.cct) as aprobadas
FROM (select ALUMNO_CURP
, CCT, ALCALDIA, NIVEL
from W_PADRON_ALUMNOS_FIDEGAR_DUP
where NIVEL = 'PRIMARIA') vi
-- where vi.cct = '09DDI0004Y'
;

select unique pi from MATRICULA.MVIEW_ALUMNOS_2122_PERIODO
--where curp = 'VEBA181226HDFNCNA5'
;

--Información de Bajas de  Alumnos de Preescolar, Primaria y Secundaria
SELECT * FROM MATRICULA.MVIEW_ALUMNOS_2122_BAJAS;


select count(*) from MVIEW_ALUMNOS_2122_PERIODO dat 
where curp = 'VEBA181226HDFNCNA5';

DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP where id > 0;