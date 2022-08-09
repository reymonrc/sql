delete from w_padron_alumnos_fidegar;

select * from rdp_valida_personal_aefcm where  curp = 'AAGM551203HDFLLG04';

select dat.*
, case when renapo_nombres is null
then substr ( dat.NOMBRE_COMPLETO, 1, instr ( dat.NOMBRE_COMPLETO, ' ' ) - 1 )
else renapo.renapo_primerapellido end as PRIMER_APELLIDO
-- , renapo.renapo_nombres as NOMBRE_RENAPO
, case when renapo_nombres is null and instr ( dat.NOMBRE_COMPLETO, ' ' ) > 2
then substr(substr( dat.NOMBRE_COMPLETO, 1, instr ( dat.NOMBRE_COMPLETO, ' ', 1, 2) - 1 ),instr ( dat.NOMBRE_COMPLETO, ' ' )+1 )
when renapo_nombres is null and instr ( dat.NOMBRE_COMPLETO, ' ' ) = 1 then NULL
else renapo.renapo_segundoapellido end as SEGUNDO_APELLIDO
, case when renapo_nombres is null and instr ( dat.NOMBRE_COMPLETO, ' ' ) = 1
then substr( dat.NOMBRE_COMPLETO,instr ( dat.NOMBRE_COMPLETO, ' ' ) + 1)
when renapo_nombres is null and instr ( dat.NOMBRE_COMPLETO, ' ' ) > 1
then substr( dat.NOMBRE_COMPLETO,instr ( dat.NOMBRE_COMPLETO, ' ', 1, 2 ) + 1)
else renapo.renapo_nombres end as nombres
, aefc.email, aefc.telefono
, case when dat.curp = renapo.curp then renapo.curp
  else renapo.renapo_curp end as CURP_OK
, aefc.cct as cct_cdiar
from (select unique alumno_curp as CURP
, alumno_nombre as NOMBRE_COMPLETO, cct from w_padron_alumnos_fidegar) dat
left JOIN rdp_valida_personal_aefcm renapo on dat.curp = renapo.renapo_curp
-- or dat.curp = renapo.renapo_curp
left JOIN rdp_personal_aefcm aefc on dat.curp = aefc.curp
-- where dat.curp not in (select curp from rdp_valida_personal_aefcm)
where dat.curp = 'AAGM551203HDFLLG04';
