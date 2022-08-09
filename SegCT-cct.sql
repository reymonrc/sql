select C.CCT
, ZONA_ESCOLAR
, (select DES_DEP_NORMAT from DEPENDENCIA_NORMAT N where N.COD_DEP_NORMAT = C.COD_DEP_NORMAT) as DEPENDENCIA_NORMATIVA
, (select DES_IDENTIFICADOR from IDENTIFICADOR I where I.COD_IDENTIFICADOR = C.COD_IDENTIFICADOR) as IDENTIFICADOR
, (select DES_SERVICIO from TIPO_SERVICIO S where S.COD_SERVICIO = C.COD_SERVICIO and C.COD_CLASIFIC = S.COD_CLASIFIC) as SERVICIO
, (select DES_SERV_REG from BDUNICA.servicio_regional R where C.COD_SERV_REG = R.COD_SERV_REG) as REGIONAL 
from cct C
where c.cod_clasific in ('F','A')
and c.cod_dep_normat in ('EP','EI')
--and c.cod_identificador in
-- ('IV','IE','IN','IZ','IX','AL','BA','BN','DA','EX','HB','JS','NP','PR','UC','ZL','ZQ')
-- ('IS','BS','ES','EX','FF','FS','LB','NS','SG','SN','ST','TE','TS','TV','US','ZT','AR','BB')
-- and c.cod_servicio in
-- (93,94,95,96,97,30,32,33,35,39,21,22,23,28,16)
-- (35,37,39,41,43,44,48,50)
 and c.cod_situacion in (1,4)
;

select 
 unique substr(CCT,4,2) as cod
 from cct
 where cod_dep_normat = 'PR'
;