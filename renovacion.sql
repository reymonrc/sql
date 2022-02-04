DELETE FROM PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR_DUP where id > 0;

select CURP, sum(PRI_PRI) as PRI_PRI, sum(SEG_PRI) as CAL17_18, sum(TER_PRI) as TER_PRI,
sum(CUA_PRI) as CUA_PRI, sum(QUI_PRI) as QUI_PRI, sum(SEX_PRI) as SEX_PRI,
sum(PRI_SEC) as PRI_SEC, sum(SEG_SEC) as SEG_SEC, sum(TER_SEC) as TER_SEC
from (select si.s_curp as CURP
-- , case when si.sis_sce_cve_ciclo_escolar = '2015-2016' then sis_calificacion_grado end CAL15_16
, case when si.grado = 1 and si.nivel_id = 3 then si.n_promedio end PRI_PRI
, case when si.grado = 2 and si.nivel_id = 3 then si.n_promedio end SEG_PRI
, case when si.grado = 3 and si.nivel_id = 3 then si.n_promedio end TER_PRI
, case when si.grado = 4 and si.nivel_id = 3 then si.n_promedio end CUA_PRI
, case when si.grado = 5 and si.nivel_id = 3 then si.n_promedio end QUI_PRI
, case when si.grado = 6 and si.nivel_id = 3 then si.n_promedio end SEX_PRI
, case when si.grado = 1 and si.nivel_id = 4 then si.n_promedio end PRI_SEC
, case when si.grado = 2 and si.nivel_id = 4 then si.n_promedio end SEG_SEC
, case when si.grado = 3 and si.nivel_id = 4 then si.n_promedio end TER_SEC
from 
-- PROCESA_INFORMACION.w_padron_alumnos_fidegar_dup fi left join 
W_BECARIOS_2121A_PROMS_ALL si
-- on fi.alumno_curp = si.s_curp
-- and si.grado in (1,2,3,4,5))
) group by CURP;


update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_1gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 1 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_2gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 2 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_3gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 3 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_4gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 4 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_5gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 5 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
pri_promedio_6gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 6 and si.nivel_id = 3);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
sec_promedio_1gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 1 and si.nivel_id = 4);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
sec_promedio_2gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 2 and si.nivel_id = 4);

update PROCESA_INFORMACION.w_becarios_renovantes_2122a set
sec_promedio_3gdo = ( select si.n_promedio
from W_BECARIOS_2121A_PROMS_ALL si
where si.s_curp = curp and si.grado = 3 and si.nivel_id = 4);
