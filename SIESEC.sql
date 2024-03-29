SELECT a.curp, grupoactivo_id, grupo.grado as grado, grupo.nombre as grupo
, a.talleractivo_id, taller.nombre as taller, taller.grado as grado_taller
, taller.nivelescolar_id as nivelid_taller
, tec.cmpo_tec, tec.abreviatura, mod.nombre as modalidad
FROM SIIE.ALUMNO A
INNER JOIN SIIE.PERSONA B ON A.ID = B.ID
INNER JOIN SIIE.GRUPO GRUPO ON A.GRUPOACTIVO_ID = GRUPO.ID
INNER JOIN SIIE.PLANTEL PLANTEL ON GRUPO.PLANTEL_ID = PLANTEL.ID
INNER JOIN SIIE.GRUPOTALLER TALLER ON TALLER.ID = A.TALLERACTIVO_ID
INNER JOIN SIIE.TECNOLOGIA TEC ON TALLER.TECNOLOGIA_ID = TEC.ID
INNER JOIN SIIE.MODALIDAD MOD ON TEC.MODALIDAD_ID = MOD.ID
WHERE  SUBSTR(CCT,1,5) IN ('09DES', '09DSN', '09DST', '09DTV', '09PES', '09PSN', '09PST', '09PTV', '09DML')
AND B.CURP IN( 'EIMJ070412MDFSRDA9', 'RUGJ070123HDFZNSA3', 'SOAB070907HDFLLRA5' , 'AOTC070312HDFCDRA0', 'GOLL071031HDFNNSA3');


SELECT
a.id, a.curp, grupoactivo_id, grupo.grado as grado, grupo.nombre as grupo
, a.talleractivo_id, taller.nombre as taller, taller.grado as grado_taller
FROM SIIE.ALUMNO A
INNER JOIN SIIE.GRUPO GRUPO ON A.GRUPOACTIVO_ID = GRUPO.ID
INNER JOIN SIIE.PLANTEL PLANTEL ON GRUPO.PLANTEL_ID = PLANTEL.ID
INNER JOIN SIIE.GRUPOTALLER TALLER ON TALLER.ID = A.TALLERACTIVO_ID
WHERE  SUBSTR(CCT,1,5) IN ('09DES', '09DSN', '09DST', '09DTV', '09PES', '09PSN', '09PST', '09PTV', '09DML')
AND grupo.grado != taller.grado;