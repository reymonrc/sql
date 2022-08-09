select 
--  'ES' cod_tipo, 'Sec General' as Tipo, 
  zona_escolar
 , cod_dep_normat
--  , cod_situacion
 , cct as  CCT_Superv
from cct
where substr(CCT,3,2) = 'FI' 
 and zona_escolar in -- ('038') 
 (select unique zona_escolar from cct
 where substr(CCT,4,2) = 'ES')
 and cod_dep_normat = 'SG'
 and cod_situacion in (1,4)
;

select 
 unique substr(CCT,4,2) as cod
 from cct
 where cod_dep_normat = 'PR'
;

000
001
002
003
004
005
006
007
008
009
010
011
012
013
014
015
016
017
018
019
020
021
022
023
024
025
026
027
028
029
030
031
032
033
034
035
036
037
038
039
040
041
042
044
045
046
049
052
053
054
055
056
057
058
059
060
061
062
063
064
065
066
067
068
069
070
071
072
073
074
075
076
077
078
080
081
082
083
084
085
086
087
088
089
090
091
092
093
094
095
096
097
098
099
100
101
102
103
104
105
106
107
108
109
11 
110
14 
53 
58 
70 
