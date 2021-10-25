select rownum as ID,
 SAL_CURP_ALUMNO as ALUMNO_CURP, SAL_NOMBRE_ALUMNO as ALUMNO_NOMBRE,
 CASE WHEN SAL_PRIMER_APELLIDO is null THEN 'NULO' ELSE SAL_PRIMER_APELLIDO END as ALUMNO_APATERNO,
 SAL_SEGUNDO_APELLIDO as ALUMNO_AMATERNO,
 SAL_SEXO_ALUMNO as ALUMNO_GENERO, SIS_SES_CCT_ESCUELA as CCT,
 REGEXP_REPLACE(vista.nombreescuela,'( ){2,}', ' ') as NOMBRE_ESCUELA, vista.turno as TURNO,
 CASE WHEN SNE_DESCCRIPCION_LARGA_NIVEL = 'INICIAL LACTANTES' THEN 'LACTANTE' 
 ELSE SNE_DESCCRIPCION_LARGA_NIVEL END as NIVEL,
 vista.grado as GRADO,
 vista.colonia_cct as COLONIA, vista.alcaldia_cct as ALCALDIA,
 CASE WHEN vista.codigopostal_cct is null THEN 'NULO' ELSE vista.codigopostal_cct END as CODIGO_POSTAL,
 null as UNIDAD_TERRITORIAL,
 case WHEN INSTR(vista.tutor, ' ') > 0
           THEN SUBSTR(vista.tutor, 1, LENGTH(vista.tutor) - INSTR(REVERSE(vista.tutor), ' ', 1, 2))
           ELSE null
       END AS TUTOR_NOMBRE,
 CASE WHEN INSTR(vista.tutor, ' ', 1, 2) > 0
           THEN SUBSTR(REVERSE(SUBSTR(REVERSE(vista.tutor), 1, 
                       INSTR(REVERSE(vista.tutor), ' ', 1, 2) - 1)),1, LENGTH(REVERSE(SUBSTR(REVERSE(vista.tutor), 1, 
                       INSTR(REVERSE(vista.tutor), ' ', 1, 2) - 1))) - INSTR(REVERSE(REVERSE(SUBSTR(REVERSE(vista.tutor), 1, 
                       INSTR(REVERSE(vista.tutor), ' ', 1, 2) - 1))), ' ', 1, 1))
           ELSE null
       END AS TUTOR_APATERNO,
 CASE WHEN INSTR(vista.tutor, ' ') > 0
           THEN REVERSE(SUBSTR(REVERSE(vista.tutor), 1, 
                       INSTR(REVERSE(vista.tutor), ' ') - 1))
           ELSE vista.tutor
       END AS TUTOR_AMATERNO,
vista.parentesco as TUTOR_PARENTESCO,
   /* SAL_NOMBRE_MADRE_ALUMNO, SAL_NOMBRE_PADRE_ALUMNO,*/
   /*curp, nombres, primer_apellido, segundo_apellido, parentezco, correo, calle, numero_exterior, numero_interior */
 CASE WHEN SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,' ',''),'-',''),'(',''),')',''),-10,10) is null
   THEN vista.telefono ELSE SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(sed_alumnos.sal_telefono_domicilio,' ',''),'-',''),'(',''),')',''),-10,10) END as TUTOR_TELEFONO,
 correo.correo_google as TUTOR_CORREO,
 vista.calle as TUTOR_CALLE, vista.colonia as TUTOR_COLONIA,
 vista.alcaldia as TUTOR_MUNICIPIO,
 vista.codigo_postal as TUTOR_CODIGO_POSTAL, SIS_SCE_CVE_CICLO_ESCOLAR as CICLO_ESCOLAR,
'PROCESA_INFORMACION' as USUARIO_CREACION, CURRENT_DATE as FECHA_CREACION
from SED_ALUMNOS left JOIN MATRICULA.sed_inscripciones
 on sed_alumnos.sal_curp_alumno = matricula.sed_inscripciones.sis_sal_curp_alumno
 and matricula.sed_inscripciones.sis_firma_digital = 1
left join MATRICULA.sed_niveles_escolares on SIS_SNE_CVE_NIVEL_ESCOLAR = SNE_CVE_NIVEL_ESCOLAR
left join PROCESA_INFORMACION.alumnos_correos correo on sed_alumnos.sal_curp_alumno =  correo.s_curp,
MVIEW_ALUMNOS_20212022 vista,
PROCESA_INFORMACION.w_padron_alumnos_fidegar_dup dup
/*preinscripciones_datos datos*/
where SIS_SCE_CVE_CICLO_ESCOLAR = '2021-2022'
and dup.cct = SIS_SES_CCT_ESCUELA and dup.inscripcion_seleccionada = 1
/*and sed_alumnos.sal_curp_alumno = datos.curp*/
and sed_alumnos.sal_curp_alumno = vista.curp
and sal_curp_alumno in (
'GURA180725MDFLMDA8',
'LARC160128HDFRDMA4',
'FACS160220MDFRRCA4',
'GADE161111MDFRZVA3',
'HERH180731MDFRVNA5',
'AOLA090403HMSNPLA5',
'MEBV081124MDFJTLA2',
'MOCA110311HDFNNNA5',
'GACA091210MDFRMXA2',
'EASS091224HDFSLNA7',
'SORN090204MMCLJTA2',
'ROEA170301HDFMSXA5',
'HEGA170401HDFRMBA4',
'RARD181106MDFMYNA2',
'HEMJ091207HMCRXRA3',
'BEMR091008MDFRNGA4',
'ZUGA021224HDFXDRA0',
'CAQB090326HDFNRRA5',
'CAGC090127HDFHLHA0',
'PASN090929MDFRLZA7',
'EAAM090414MASSLLA9',
'LOAA080305MMCPNLA8',
'AEGN090102HDFNRHA0',
'OASM090826HDFCNRA4',
'MERE091117HDFNVLA2',
'OEOU090101HDFRRLA8',
'BAHD091208MMCNRNA4',
'MUAM080421HMCXVRA6',
'PEAA090107HDFRLBA9',
'MEFR090421HDFNLGA2',
'AEGA161108MDFRDMA4',
'VEAP090223MDFRZLA6',
'GALL160405HDFRPNA0',
'DOAI090331MDFMRLA0',
'VXCA120803MDFLSLA8',
'HEGJ071216MDFRRHA6',
'AACY091124HDFBRLA0',
'MOBI090816MDFNLNA9',
'AIVA081023MDFVZLA5',
'FILS180803HMCGNBA3',
'RISM180805MDFVNLA3',
'AAOA180109HDFLRNA7',
'GULK150618MDFVZRA7',
'RILS100625MMCVPMA2',
'MEMG110613MDFNRBA7',
'MEMJ100322MDFNRSA3',
'AESD141226HDFRRGA2',
'JILR140605MDFMMMA8',
'DADI140704MDFZVVA8',
'CUAN140921MMSVLTA0',
'MORB110620HDFRVRA4',
'AICA140103MDFRHLA0',
'LIGO130216HDFRNLA4',
'BAJO140711HDFRMSA9',
'ROGR100509HDFSRCA5',
'GAGZ110301MDFRNRA4',
'LAMA141026HDFMRXA7',
'NXCA120611MDFVVNA7',
'GOVM091118MDFNLXA5',
'VALV141003MMCZRCA3',
'MOFA140701MDFSRLA0',
'BAJI120723HDFRMKA9',
'DICV100728MDFZNLA3',
'MEFA140708MDFJNDA8',
'SOPK070423MDFLRRA7',
'CAMG090705MDFSRNA0',
'GOJS080608MDFNRRA8',
'HECD090319MDFRRNA0',
'DORA090104MDFMVNA5',
'CAMJ090820HDFMRBA0',
'AUQV090911MMCQRLA4',
'CARA090224MDFSMNA2',
'CASJ091224MDFBLDA3',
'RAHB090810MDFMRRA1',
'SOMJ081212MDFTRSA4',
'CUHJ081216MDFRBNA8',
'VIVA090717MDFLLNA4',
'SACS090307HDFLRNA5',
'PUME090514HTCLRRA6',
'GOHD130117HDFNDGA1',
'RXBA090602HDFMHNA7',
'OEMJ080701HMCRNRA7',
'LUCM091119HDFNRTA8',
'CAVD160331HDFMDGA6',
'MOVD081013HDFRZNA9',
'IELY090818HMCGPHA3',
'MORI091204HMCNYCA1',
'FEOA090913HDFRRNA1',
'BARJ090417HDFNSSA0',
'AUAA100607HDFGLMA3',
'JUGB070521HMCRTRA9',
'AEGM101229HDFRRRA4',
'GAGL081031MDFRRCA1');

ALTER TABLE PROCESA_INFORMACION.W_PADRON_ALUMNOS_FIDEGAR MODIFY TUTOR_TELEFONO VARCHAR2(60);

DELETE FROM PROCESA_INFORMACION.padron_alumnos_fidegar where id > 0;