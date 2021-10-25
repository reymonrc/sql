SELECT vista.sostenimiento, vista.alcaldia_cct, vista.niveleducativo, vista.cct,
REGEXP_REPLACE(vista.nombreescuela,'( ){2,}', ' ') as NOMBRE_ESCUELA,
 vista.turno, vista.grado, vista.curp, vista.primerapellido, vista.segundoapellido, vista.nombres, vista.tutor, vista.parentesco,
case when prein.email is not null
  then prein.email
  else correo.correo_google end as EMAIL, prein.email_adicional
FROM sed_alumnos 
left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and matricula.sed_inscripciones.sis_firma_digital = 1
left join PROCESA_INFORMACION.alumnos_correos correo on sed_alumnos.sal_curp_alumno =  correo.s_curp
left join procesa_INFORMACION.preinscripciones_datos prein on sed_alumnos.sal_curp_alumno = prein.curp,
MVIEW_ALUMNOS_20212022 vista
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and sed_alumnos.sal_curp_alumno = vista.curp;