SELECT vista.curp as CURP, vista.nombres, vista.primerapellido, vista.segundoapellido,
vista.coordinacion, vista.cct, REGEXP_REPLACE(vista.nombreescuela,'( ){2,}', ' ') as NOMBREESCUELA,
vista.niveleducativo, vista.grado, vista.grupo
FROM matricula.mview_alumnos_20212022 vista
left join PROCESA_INFORMACION.alumnos_correos correo on vista.curp = correo.s_curp
where correo.correo_google is NULL
and substr(vista.cct, 3, 1) not in ('P'); -- sin particulares