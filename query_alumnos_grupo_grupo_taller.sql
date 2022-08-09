select 
pl.cct
, pl.nombre nombre_escuela
, ce.nombre ciclo_escolar
, niv.nombre nivel_educativo
, tno.nombre turno
, g.grado
, g.nombre grupo
, p.curp
, p.primerapellido
, p.segundoapellido
, p.nombres
, gt.nombre nombre_taller
, t.nombre nombre_tecnologia 
from alumno a
, persona p
, grupo g
, grupotaller gt
, plantel pl
, tecnologia t
, cicloescolar ce
, niveleducativo niv
, turno tno
where 
a.id = p.id
and a.grupoactivo_id = g.id
and g.plantel_id = pl.id
and g.cicloescolar_id = ce.id
and g.nivelescolar_id = niv.id
and g.turno_id = tno.id
and a.talleractivo_id = gt.id(+)
and gt.tecnologia_id = t.id(+)
and pl.cct = '09DST0001Z'
order by 1,2,3,4,5
;