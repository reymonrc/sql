select ALUMNO_ID    
,CURP    
,CCT    
,TURNO_ID    
,MATERIA_ID    
,CICLOESCOLAR_ID    
,case when ev.materia_id in (/*Tecnologia:*/ 56,67,77, /*Artistica: */ 307,317,327, /*Estatal: */ 58 /*Ingles*/, 302,313,323,/*Tecnologia*/ 308, 318, 328)
and ((ev.cve_materia = 'null') or ev.cve_materia is null)
    then 
    (case when materia_id  in (/*Estatal*/ 58)
                          then 'AE9999' 
                          when materia_id in(/*Artes*/ 307, 317, 327 )
                          then 'AR9999'
                          when materia_id in(/*Tecnologia*/  56,67,77 )  
                          then 'T00999' 
                          when materia_id in(/*Tecnologia*/  308,318,328 )
                          then 'T00999' 
                          when materia_id in(/*Ingles*/ 302,313,323)
                          then 'TINGLE'
                          else
                          ev.cve_materia 
                     end)
     else CVE_MATERIA
     end
  CVE_MATERIA    
,CICLOESC    
,MATERIA    
,GRADO    
,GRUPO    
, '' || grado || grupo 
  GDO_GPO
, calificacion01f CALIFICACION01    
, calificacion02f CALIFICACION02    
, calificacion03f CALIFICACION03    
, calificacion04f CALIFICACION04    
,CALIFICACION05    
,RV0CALIFICACION    
,RCALIFICACION01    
,RCALIFICACION02    
,RCALIFICACION03    
,RCALIFICACION04    
,EXTRA01    
,to_char(FECHA_EXTRA01,'yyyymmdd')
  FECHA_EXTRA01    
,EXTRA02    
,to_char(FECHA_EXTRA02,'yyyymmdd')
  FECHA_EXTRA02    
,EXTRA03    
,to_char(FECHA_EXTRA03,'yyyymmdd')
  FECHA_EXTRA03    
,EXTRA04    
,to_char(FECHA_EXTRA04,'yyyymmdd')
  FECHA_EXTRA04    
,INASISTENCIAS01    
,INASISTENCIAS02    
,INASISTENCIAS03    
,INASISTENCIAS04    
,INASISTENCIAS05    
,TIPOEXAM1    
,TIPOEXAM2    
,TIPOEXAM3    
,TIPOEXAM4    
,CALIFICACION01F    
,CALIFICACION02F    
,CALIFICACION03F    
,CALIFICACION04F    
,PROMCALIF    
,SITUACION_ACADEMICA
,OBSERVACION01
,OBSERVACION02
,OBSERVACION03

from (
select ALUMNO_ID    
,CURP    
,CCT    
,TURNO_ID    
,MATERIA_ID    
,CICLOESCOLAR_ID    
,--case when ev.materia_id in (/*Tecnologia:*/ 56,67,77, /*Artistica: */ 307,317,327, /*Estatal: */ 58 /*Ingles*/, 302,313,323)
--and ev.cve_materia = 'null' 
--    then 
--    ( Case when ev.cve_materia is null then
--            (select M.CVE_MATERIA from materia m 
--                where m.id=ev.materia_id)
--          when ev.cve_materia='null' then
--            (select M.CVE_MATERIA from materia m 
--                where m.id=ev.materia_id)
 --         else ev.cve_materia
--      end
--   )
--     else CVE_MATERIA
--     end
  CVE_MATERIA    
,CICLOESC    
,MATERIA    
,GRADO    
,GRUPO    
,CALIFICACION01    
,CALIFICACION02    
,CALIFICACION03    
,CALIFICACION04    
,CALIFICACION05    
,RV0CALIFICACION    
,RCALIFICACION01    
,RCALIFICACION02    
,RCALIFICACION03    
,RCALIFICACION04    
,EXTRA01    
,FECHA_EXTRA01    
,EXTRA02    
,FECHA_EXTRA02    
,EXTRA03    
,FECHA_EXTRA03    
,EXTRA04    
,FECHA_EXTRA04    
,INASISTENCIAS01    
,INASISTENCIAS02    
,INASISTENCIAS03    
,INASISTENCIAS04    
,INASISTENCIAS05    
,TIPOEXAM1    
,TIPOEXAM2    
,TIPOEXAM3    
,TIPOEXAM4    
,CALIFICACION01F    
,CALIFICACION02F    
,CALIFICACION03F    
,CALIFICACION04F    
,PROMCALIF    
,SITUACION_ACADEMICA
,OBSERVACION01
,OBSERVACION02
,OBSERVACION03

from (
select ALUMNO_ID    
,CURP    
,CCT    
,TURNO_ID    
,MATERIA_ID    
,CICLOESCOLAR_ID    
--,case when ev.materia_id in (/*Tecnologia:*/ 56,67,77, /*Artistica: */ 307,317,327, /*Estatal: */ 58 /*Ingles*/, 302,313,323) 
--    then 
--    (select EV2.CVE_MATERIA 
--    from alumno_evaluacion ae2, evaluacion ev2 
--    where ev.materia_id=ev2.materia_id and ev2.periodo_id=5
--     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
--     and ev2.cicloescolar_id=ev.cicloescolar_id
--     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
--                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
--                   and ex.periodo_id= ev2.periodo_id
--                   and ae.evaluaciones_id=ex.id)
--     )
--     else CVE_MATERIA
--     end
--  CVE_MATERIA    
, case when ev.materia_id in /*Tecnologia*/ (308, 318, 328)
   then
    CASE WHEN CVE_MATERIA IN ('9991', '9992', '9993', '****', '******', '000000', 
         'AR0710', 'AR0720', 'AR0730', 'AR0740', 'AR9999', 'TINGLE', 'TFRANC',
         'TALEMA', 'TITALI', 'T13604', 'AE0710', 'AE0760', 'AE0750', 'AE0740', 'AE0730',
         'AE0720') THEN 'T00999'
      ELSE CVE_MATERIA 
    END
   else CVE_MATERIA
  end
  CVE_MATERIA
,CICLOESC    
,MATERIA    
,GRADO    
,GRUPO    
,CALIFICACION01    
,CALIFICACION02    
,CALIFICACION03    
,CALIFICACION04    
,CALIFICACION05    
,RV0CALIFICACION    
,RCALIFICACION01    
,RCALIFICACION02    
,RCALIFICACION03    
,RCALIFICACION04    
,EXTRA01    
,FECHA_EXTRA01    
,EXTRA02    
,FECHA_EXTRA02    
,EXTRA03    
,FECHA_EXTRA03    
,EXTRA04    
,FECHA_EXTRA04    
,INASISTENCIAS01    
,INASISTENCIAS02    
,INASISTENCIAS03    
,INASISTENCIAS04    
,INASISTENCIAS05    
,TIPOEXAM1    
,TIPOEXAM2    
,TIPOEXAM3    
,TIPOEXAM4    
,CALIFICACION01F    
,CALIFICACION02F    
,CALIFICACION03F    
,CALIFICACION04F    
,PROMCALIF    
,SITUACION_ACADEMICA
,OBSERVACION01
,OBSERVACION02
,OBSERVACION03

from (
select ef.*
  ,( case when extra01>=6.0 then extra01
         when extra02>=6.0 then extra02
         when extra03>=6.0 then extra03
         when extra04>=6.0 then extra04
         when rv0calificacion>=6.0 then rv0calificacion
         when (nvl2(calificacion01,1,0)+ nvl2(calificacion02,1,0)+ nvl2(calificacion03,1,0)
              + nvl2(calificacion04,1,0)+ nvl2(calificacion05,1,0))>=3 then
              trunc((nvl(calificacion01f,0)+ nvl(calificacion02f,0)+ nvl(calificacion03f,0)+ nvl(calificacion04f,0)+ nvl(calificacion05,0))/
              (nvl2(calificacion01f,1,0)+nvl2(calificacion02f,1,0)+nvl2(calificacion03f,1,0)+nvl2(calificacion04f,1,0)+nvl2(calificacion05,1,0)),1)
         else null
    end
 ) PROMCALIF
  ,( case when extra01>=6.0 then 'R'
         when extra02>=6.0 then 'R'
         when extra03>=6.0 then 'R'
         when extra04>=6.0 then 'R'
         when (nvl2(calificacion01,1,0)+ nvl2(calificacion02,1,0)+ nvl2(calificacion03,1,0)
              + nvl2(calificacion04,1,0)+ nvl2(calificacion05,1,0))>=3 and  
              (nvl(calificacion01f,0)+ nvl(calificacion02f,0)+ nvl(calificacion03f,0)+ nvl(calificacion04f,0)+ nvl(calificacion05,0))/
                 (nvl2(calificacion01f,1,0)+nvl2(calificacion02f,1,0)+nvl2(calificacion03f,1,0)+nvl2(calificacion04f,1,0)+nvl2(calificacion05,1,0))>=6.0 then 
              'R'
         when rv0calificacion>=6.0 then 'R'
         when (nvl2(calificacion01,1,0)+ nvl2(calificacion02,1,0)+ nvl2(calificacion03,1,0)
              + nvl2(calificacion04,1,0)+ nvl2(calificacion05,1,0))>=3 and
              (nvl(calificacion01f,0)+ nvl(calificacion02f,0)+ nvl(calificacion03f,0)+ nvl(calificacion04f,0)+ nvl(calificacion05,0))/
              (nvl2(calificacion01f,1,0)+nvl2(calificacion02f,1,0)+nvl2(calificacion03f,1,0)+nvl2(calificacion04f,1,0)+nvl2(calificacion05,1,0))>=5.0 then
              'I'
         else null
    end
 ) situacion_academica 
from (
select ev.*
 ,nvl2(ev.extra01,'E','') TIPOEXAM1
 ,nvl2(ev.extra02,'E','')  TIPOEXAM2
 ,nvl2(ev.extra03,'E','')  TIPOEXAM3
 ,nvl2(ev.extra04,'E','')  TIPOEXAM4
 ,( Case when calificacion01<6.0  and rcalificacion01>calificacion01 then  rcalificacion01
     else calificacion01
     end) calificacion01f
 ,( Case when calificacion02<6.0  and rcalificacion02>calificacion02 then  rcalificacion02
     else calificacion02
     end) calificacion02f
 ,( Case when calificacion03<6.0  and rcalificacion03>calificacion03 then  rcalificacion03
     else calificacion03
     end) calificacion03f
 ,( Case when calificacion04<6.0  and rcalificacion04>calificacion04 then  rcalificacion04
     else calificacion04
     end) calificacion04f
from (

select --ev.*
   ev.alumno_id
   , ev.curp
   , ev.cct
   , ev.turno_id
   ,ev.materia_id
   ,ev.cicloescolar_id
 , (case when (select me.clave from MATERIAENFASIS me, GRUPO_MATERIAENFASIS gme
                where gme.grupo_id = ev.grupo_id
                    and me.id = gme.materiaenfasis_id
                    and ME.MATERIA_ID = ev.materia_id) is not null 
         then (select me.clave from MATERIAENFASIS me, GRUPO_MATERIAENFASIS gme
                where gme.grupo_id = ev.grupo_id
                    and me.id = gme.materiaenfasis_id
                    and ME.MATERIA_ID = ev.materia_id)
         when (select t.clave from tecnologia t, GRUPOTALLER gt
                where T.ID= gt.tecnologia_id and gt.id = ev.talleractivo_id
                 and EV.MATERIA_ID in (56, 67, 77) ) is not null
         then (select t.clave from tecnologia t, GRUPOTALLER gt
                where T.ID= gt.tecnologia_id and gt.id = ev.talleractivo_id
                  and EV.MATERIA_ID in (56, 67, 77))
         when (select t.clave from tecnologia t, GRUPOTALLER gt
                where T.ID= gt.tecnologia_id and gt.id = ev.talleractivo_id
                 and EV.MATERIA_ID in (308, 318, 328) ) is not null
         then (select t.clave from tecnologia t, GRUPOTALLER gt
                where T.ID= gt.tecnologia_id and gt.id = ev.talleractivo_id
                  and EV.MATERIA_ID in (308, 318, 328))
         else ( select EV2.CVE_MATERIA 
                  from materia ev2 
                      where ev2.id= ev.materia_id)
     end
    )  cve_materia
 ,(select CL.DESCRIPCION from cicloescolar cl 
    where cl.id=ev.cicloescolar_id) cicloesc
 ,(select mm.nombre from materia mm where mm.id=ev.materia_id)
  materia
 ,(select m.grado from materia m where M.ID=ev.materia_id
  ) grado
 , ev.grupo
 , (select case when calificacion=-8 then null
           else calificacion
           end
           calificacion
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=5
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and ev2.calificacion!=-8
     ) calificacion01
 , (select case when calificacion=-8 then null
           else calificacion
           end
           calificacion
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=6
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and ev2.calificacion!=-8
     ) calificacion02
 , (select case when calificacion=-8 then null
           else calificacion
           end
           calificacion
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=7
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and ev2.calificacion!=-8
     ) calificacion03
 , (select case when calificacion=-8 then null
           else calificacion
           end
           calificacion
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=8
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and ev2.calificacion!=-8
     ) calificacion04
 , (select case when calificacion=-8 then null
           else calificacion
           end
           calificacion
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=9
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and ev2.calificacion!=-8
     ) calificacion05
 , (select er.calificacion 
    from evaluacionrecupera er 
    where er.materia_id=ev.materia_id and er.periodo_id=null
     and er.alumno_id=ev.alumno_id
     and er.cicloescolar_id=ev.cicloescolar_id
     and er.id= (select max(id) from evaluacionrecupera ex where ex.alumno_id=er.alumno_id
                   and ex.materia_id=er.materia_id and ex.cicloescolar_id=er.cicloescolar_id
                   and ex.periodo_id= er.periodo_id)
     ) rv0calificacion
 , (select er.calificacion 
    from evaluacionrecupera er 
    where er.materia_id=ev.materia_id and er.periodo_id=5
     and er.alumno_id=ev.alumno_id
     and er.cicloescolar_id=ev.cicloescolar_id
     and er.id= (select max(id) from evaluacionrecupera ex where ex.alumno_id=er.alumno_id
                   and ex.materia_id=er.materia_id and ex.cicloescolar_id=er.cicloescolar_id
                   and ex.periodo_id= er.periodo_id)
     ) rcalificacion01
 , (select er.calificacion 
    from evaluacionrecupera er 
    where er.materia_id=ev.materia_id and er.periodo_id=6
     and er.alumno_id=ev.alumno_id
     and er.cicloescolar_id=ev.cicloescolar_id
     and er.id= (select max(id) from evaluacionrecupera ex where ex.alumno_id=er.alumno_id
                   and ex.materia_id=er.materia_id and ex.cicloescolar_id=er.cicloescolar_id
                   and ex.periodo_id= er.periodo_id)
     ) rcalificacion02
 , (select er.calificacion 
    from evaluacionrecupera er 
    where er.materia_id=ev.materia_id and er.periodo_id=7
     and er.alumno_id=ev.alumno_id
     and er.cicloescolar_id=ev.cicloescolar_id
     and er.id= (select max(id) from evaluacionrecupera ex where ex.alumno_id=er.alumno_id
                   and ex.materia_id=er.materia_id and ex.cicloescolar_id=er.cicloescolar_id
                   and ex.periodo_id= er.periodo_id)
     ) rcalificacion03
 , (select er.calificacion 
    from evaluacionrecupera er 
    where er.materia_id=ev.materia_id and er.periodo_id=8
     and er.alumno_id=ev.alumno_id
     and er.cicloescolar_id=ev.cicloescolar_id
     and er.id= (select max(id) from evaluacionrecupera ex where ex.alumno_id=er.alumno_id
                   and ex.materia_id=er.materia_id and ex.cicloescolar_id=er.cicloescolar_id
                   and ex.periodo_id= er.periodo_id)
     ) rcalificacion04
  , (select ex.calificacion
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 5
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) extra01
  , (select ex.fecha
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 5
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) Fecha_extra01
  , (select ex.calificacion
     from evaluacionextra ex, alumno_evaluacionextra ax
      where ex.materia_id=ev.materia_id and ex.periodo_id= 6
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) extra02
  , (select ex.fecha
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 6
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) Fecha_extra02
  , (select ex.calificacion
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 7
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) extra03
  , (select ex.fecha
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 7
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) Fecha_extra03
  ,  (select ex.calificacion
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 8
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id 
      and ax2.evaluacionesextra_id=ex2.id
      )
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) extra04
  , (select ex.fecha
     from evaluacionextra ex, alumno_evaluacionextra ax
     where ex.materia_id=ev.materia_id and ex.periodo_id= 8
      and ax.alumno_id=ev.alumno_id and ax.evaluacionesextra_id=ex.id
      and ex.cicloescolar_id=(select max(ex2.cicloescolar_id)
     from evaluacionextra ex2, alumno_evaluacionextra ax2
     where ex2.materia_id=ex.materia_id and ex2.periodo_id= ex.periodo_id
      and ax2.alumno_id=ax.alumno_id and ex2.calificacion>=6.0
      and ax2.evaluacionesextra_id=ex2.id
      ) 
      and ex.id= (select max(id) from evaluacionextra ex2, alumno_evaluacionextra ax2 where ax2.alumno_id=ax.alumno_id
                   and ex2.materia_id=ex.materia_id and ex2.cicloescolar_id=ex.cicloescolar_id
                   and ex2.periodo_id= ex.periodo_id and ax2.evaluacionesextra_id=ex2.id)
      ) Fecha_extra04
-- , lpad('X', 400, 'X') observacion01
-- ,lpad('X', 400, 'X') observacion02
-- ,lpad('X', 400, 'X') observacion03
-- ,lpad('X', 400, 'X') observacion04
-- ,lpad('X', 400, 'X') observacion05
 ,(select inasistencias 
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=5
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id))
    inasistencias01
 ,(select inasistencias 
    from alumno_evaluacion ae2, evaluacion ev2 
        where ev.materia_id=ev2.materia_id and ev2.periodo_id=6
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id))
                    inasistencias02
 ,(select inasistencias 
    from alumno_evaluacion ae2, evaluacion ev2 
     where ev.materia_id=ev2.materia_id and ev2.periodo_id=7
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id))
      inasistencias03
 ,(select inasistencias 
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=8
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id))
      inasistencias04
 ,(select inasistencias 
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=9
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id))
       inasistencias05                   
 , (select substr(TRIM(replace(replace(replace(replace(replace(TRIM(SUBSTR(EV2.OBSERVACIONES,1,250)),'|'),chr(10),''),chr(13),''),CHR(26), ''),chr(9),' ')),1,145)
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=5
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and EV2.OBSERVACIONES is not null
     and length(trim(EV2.OBSERVACIONES))>3
     ) OBSERVACION01
 , (select substr(TRIM(replace(replace(replace(replace(replace(TRIM(SUBSTR(EV2.OBSERVACIONES,1,250)),'|'),chr(10),''),chr(13),''),CHR(26), ''),chr(9),' ')),1,145)
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=6
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and EV2.OBSERVACIONES is not null
     and length(trim(EV2.OBSERVACIONES))>3
     ) OBSERVACION02
 , (select substr(TRIM(replace(replace(replace(replace(replace(TRIM(SUBSTR(EV2.OBSERVACIONES,1,250)),'|'),chr(10),''),chr(13),''),CHR(26), ''),chr(9),' ')),1,145)
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=7
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     and EV2.OBSERVACIONES is not null
     and length(trim(EV2.OBSERVACIONES))>3
     ) OBSERVACION03

/* , (select replace(TRIM(SUBSTR(EV2.OBSERVACIONES,1,250)),'|')
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=8
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     ) OBSERVACION04
 , (select replace(TRIM(SUBSTR(EV2.OBSERVACIONES,1,250)),'|')
    from alumno_evaluacion ae2, evaluacion ev2 
    where ev.materia_id=ev2.materia_id and ev2.periodo_id=9
     and ae2.alumno_id= ev.alumno_id and ae2.evaluaciones_id=ev2.id
     and ev2.cicloescolar_id=ev.cicloescolar_id
     and ev2.id= (select max(ex.id) from alumno_evaluacion ae, evaluacion ex where ae.alumno_id=ev.alumno_id
                   and ex.materia_id=ev.materia_id and ex.cicloescolar_id=ev.cicloescolar_id
                   and ex.periodo_id= ev2.periodo_id
                   and ae.evaluaciones_id=ex.id)
     ) OBSERVACION05
*/
from (

  select distinct ae.alumno_id
   , p.curp
   , pl.cct
   , g.turno_id
   ,ev.materia_id
   ,(select grado from materia m where m.id= ev.materia_id ) grado
   ,G.NOMBRE grupo
   ,ev.cicloescolar_id
   , g.id grupo_id
   , pl.id plantel_id
   , a.talleractivo_id
  from ALUMNO_EVALUACION ae, evaluacion ev
    , persona p, alumno a
    , grupo g
    , plantel pl
    --, VAULT_ALUMNO_FIN_CICLO v
    --, HISTORICO_ALUMNO_GRUPO  v
  where --v.alumno_id=a.id
   --and p.curp= 'GEST010904HNERRM_'
   --and v.grupo_id=g.id
   --and 
   p.id= ae.alumno_id
   and p.id=a.id
   and ae.evaluaciones_id= ev.id 
   and ev.materia_id>=50
   and a.grupoactivo_id=g.id
   and g.plantel_id= pl.id
   --and ae.alumno_id=31331829
   and pl.cct='09DST0018Z'
   --and pl.cct='09DES1000O'
   --AND (ev.materia_id=308 OR
   --   ev.materia_id=318 OR
   --   ev.materia_id=328)
   --and pl.cct='09PES032402M'
   --and a.id=332833018
   and pl.niveleducativo_id=4
   and g.cicloescolar_id= (select id from cicloescolar where  activo=1)
   --and g.cicloescolar_id=15
   and ev.cicloescolar_id <= g.cicloescolar_id
   --and pl.cct=?
   --and g.grado=3
   ) ev
   ) ev
   ) ef
   order by turno_id, curp, grado, grupo, materia_id
   ) ev
   ) ev   ) ev