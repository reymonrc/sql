select fin.*, ini.inicio,
ini.inicio-fin.actual diferencia,
round((ini.inicio-fin.actual)*100/ini.inicio,2) as desercion
from
(select
X.CCT, trim(x.nombreescuela) as nombre, x.alcaldia_cct as alcaldia, count(*) ACTUAL
from MVIEW_ALUMNOS_20212022 x
where X.IDNIVELEDUCATIVO = 2 and x.servicioeducativo = 'EDUCACIÓN PREESCOLAR'
and x.alcaldia_cct in ('BENITO JUÁREZ','COYOACÁN','CUAUHTÉMOC')
group by X.CCT, x.nombreescuela, x.alcaldia_cct) fin
LEFT OUTER JOIN 
(select y.SIS_SES_CCT_ESCUELA as CCT, count(*) INICIO
from MATRICULA.sed_inscripciones y
where y.sis_sce_cve_ciclo_escolar = '2021-2022'
and y.SIS_SNE_CVE_NIVEL_ESCOLAR = 2
group by y.sis_ses_cct_escuela) ini
   ON fin.cct = ini.cct
;