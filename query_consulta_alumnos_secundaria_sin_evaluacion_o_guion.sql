select
--distinct ',''' ||y.curp || ''''
y.cct
, y.NOMBRE
, y.turno_id
, y.turno
, y.grado
, y.grupo
, y.CURP
, y.PRIMERAPELLIDO
, y.SEGUNDOAPELLIDO
, y.NOMBRES
, y.orden
--, y.materia_id
, y.materia
--, y.alumno_id
--, y.NIVELESCOLAR_ID
--, y.cicloescolar_id
--, y.periodo_id
, y.calificacion
from
(
select
x.*
, (select e.calificacion from alumno_evaluacion ae, evaluacion e
   where
     AE.ALUMNO_ID = x.alumno_id 
     and AE.EVALUACIONES_ID = e.id and E.PERIODO_ID = x.periodo_id and E.CICLOESCOLAR_ID = x.cicloescolar_id
     and E.MATERIA_ID = x.materia_id
  ) calificacion
from
(
select
pl.cct
, PL.NOMBRE
, g.turno_id
, T.NOMBRE turno
, g.grado
, G.NOMBRE grupo
, P.CURP
, P.PRIMERAPELLIDO
, P.SEGUNDOAPELLIDO
, P.NOMBRES
, m.orden
, m.id materia_id
, M.NOMBRE materia
, a.id alumno_id
, G.NIVELESCOLAR_ID
, ce.id cicloescolar_id
, per.id periodo_id
from alumno a
,persona p
, grupo g
, plantel pl
, turno t
, planestudios pe
, planestudios_materia pem
, materia m
, cicloescolar ce
, periodo per
where
a.id = p.id
and a.grupoactivo_id = g.id
and g.plantel_id = pl.id
and g.turno_id = t.id
and G.NIVELESCOLAR_ID = 4
and pl.cct in ('09DES4310M','09DTV0052T')
and pe.id = decode(g.grado,1, A.PLAN1_ID, 2, A.PLAN2_ID, 3, A.PLAN3_ID )
and pe.id = PEM.PLANESTUDIOS_ID
and PEM.MATERIAS_ID = m.id
and m.grado = g.grado
and ce.activo = 1
and PER.id = 5
and PER.NIVELEDUCATIVO_ID = G.NIVELESCOLAR_ID
--and a.id = 3312944
) x

) y
--left join alumno_evaluacion ae on AE.ALUMNO_ID = x.alumno_id
--left join evaluacion e on AE.EVALUACIONES_ID = e.id and E.PERIODO_ID = x.periodo_id and E.CICLOESCOLAR_ID = x.cicloescolar_id
where 
--y.calificacion is null
--or y.calificacion = 0
--or 
--y.calificacion = -8
 y.curp in
(
'RAJB080903HDFMMRA8'
,'MOVR080416HDFRRBA3'
,'CAAJ080609MMCMRNA5'
,'GARH070201HDFRBCA0'
,'VIMA090915HMCCRNA2'
,'PEPJ081009HDFRDNA8'
,'AOCA090929HVZNRBA0'
,'GUSD080903HDFTLMA9'
,'TOAE080212HDFRLRA6'
,'GAFD080301HDFRLGA2'
,'EIAC080724MDFLLMA3'
,'MAAG080104MMCRNBA6'
,'MOJA091009HDFRMLA7'
,'ZECM080611MDFPHXA6'
,'ROCE091012HDFMRDA4'
,'RUSY090808MDFZRRA0'
,'VARE080623HDFLDLA2'
,'GARE090428MDFRBVA4'
,'SACC080201HMCNRRA8'
,'LESA080610MDFNCLA7'
)
order by 1,2,3,4,5,6,7,11
;