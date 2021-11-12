select cct,
REGEXP_REPLACE(buda.nombre,'( ){2,}', ' ') as nombre, 
REGEXP_REPLACE(cct_domicilio,'( ){2,}', ' ') as domicilio,
REGEXP_REPLACE(cit.nombre,'( ){2,}', ' ') as colonia,
UPPER(dele.descripcion) as delegacion, cit.codigo_postal, telefono
from cct buda
left join BDUNICA.cit cit 
on buda.cod_localidad = cit.cod_localidad and buda.cod_municipio = cit.cod_municipio
left join BDUNICA.cve_delegacion dele
on buda.cod_municipio = TO_NUMBER(dele.cve_dele)
where cct in ('09DBA0102I');