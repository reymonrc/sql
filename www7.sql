select 
/* nombre_escuela */
curp, nombres, primer_apellido, segundo_apellido, cct, turno, nivel_educativo, grado, grupo
FROM SIIE.V_ALUMNOS_INSCRITOS@W6_SEC where nombres = 'Ernesto Areel';

select 
/* nombre_escuela */
curp as rb_curp, nombres as rb_nombre, primer_apellido as rb_primer_apellido,
segundo_apellido as rb_segundo_apellido, cct as rb_cct, turno as rb_turno,
nivel_educativo as rb_nivel_educativo, grado as rb_grado, grupo as rb_grupo
FROM SIIE.V_ALUMNOS_INSCRITOS@W6_SEC where curp IN ('GATO0709113HMCRRCA0',
'PIAL070813MVZRRZA9',
'MAMJ070225HPLRRRA9',
'TOVA070525MHGRGLA4',
'CAMV070209MTCRNNA9',
'FUHZ070928MDFNRMA9',
'BEAM070808HDFRSSA3',
'MECM070721MDFNHRA3',
'RAPM070602HNEMDRA8',
'ZAGE071006HDEFRTRA8',
'ZAGI071006MDFRTSA5',
'ZAMS071105MMCRRFA7',
'GOML070712HDFNRSA3',
'EAGS070803MDFSNRA3',
'TORF071210MDFRVRA8',
'GUCD070130HDFTSGA5',
'VAVM120707MDFRLRA1',
'CAVA070717MDFLZNA6',
'GUPJ070427HDFRRLA4',
'ROOD070601HMCJLGA1',
'RIHS071217HDFVRBA3',
'VAJV071010MDFLRNA4',
'MOTI070826MDFRBVA9',
'HEMA071016MMCRLTA1',
'HEMG071222HDFRDNA3',
'RARJ070202MDFMSLA6',
'SASA070911MDFLNDA2',
'YALV070518MDFNZRA6',
'RAJI070904HDFNSSA1',
'VECK070813HDFLRRA0',
'VALR070321MDFZPMA8',
'AETO070309HDFRXSA2',
'CAGR070607HDFSNMA8',
'AOTD070221MDFLNNA5',
'BAOM071030MDFLRRA1',
'GARR070318HDFRXDA6',
'AIGX070111MDFRTMA4',
'SAJH070430MDFNRNA1',
'GUED071006HMCTSRA7',
'GONP070414MDFNVLA5',
'MOSA070725MDFLNLA5',
'HECC071013HDFRRRA1',
'VICE091229HOCLSDA1',
'LOMR070429HOCPRCA8',
'FOGX070117MDFLNMA4',
'GATF070102MDFRMTA2',
'MAVC071218MMCRRTA1',
'VIGS070829MMCLNMA2',
'VIGS070829MMCLNMA2',
'VIHM070507MMCLRRA4',
'GAAR070817MDFRLGA01',
'CUHV071124MDFRRLA3',
'LOCC071008HDFZSRA3',
'AARD070206MDFLMNA1',
'RORD070710MMCDMNA6',
'LUCB070618MDFSRTA5',
'NUVE070427HMCXLNA4',
'EUOA070621HDFSCDA6',
'JUBF070112MDFNTRA4',
'HEEF071225HDFRSRA0',
'CELC071112MMCDLMA1',
'BAVJ070803HDFSZNA4',
'CACV071127MDFLDNA2',
'MOCE070606MTLRSLA5',
'GARA070225MDFRDZA9',
'AUTS070604MDFGPHA3',
'HEPV071105MDFRRLA9',
'HEMS070507MDFRRFA6',
'HEFM070406MDFRLRA2',
'BEGK070905HDFRNVA8',
'GUMP070519MDFTRLA4',
'PECB070916MDFXRRA0',
'CUCB071016MDFRRRA0',
'AABV070101MDFLLLA4',
'AIRK070210HMCRNRA5',
'BABJ071212MDFRJSA8',
'MAMV070707MDFRRLA9',
'CAML070824MDFNNHA7',
'HEGF070803MDFRLRA4',
'TADA071029HDFPLLA4',
'OIBP070616MMCLLLA3',
'GOSV070407MDFNSLA4',
'GOMF070301MDFNRRA9',
'TRUF070712MDFRNRA1',
'JIVA070816MDFMLNA7',
'LOFC070104HDFPLRA4',
'HUFA070224MDFRRLA6',
'TEED070614HDFCSGA9',
'QUPG070315MDFNNBA5',
'PEMF070212MDFRRTB5',
'MOAM070303HDFRRGA1',
'LEVY070619MDFNRSA8',
'COFA070822MDFRLMA5',
'MOVF071001MDFNLRA0',
'JUVM071212MDFRLCA9',
'GOHD051028HQTNRNA0',
'JULI070528MDFRPSA9',
'AADG070711MDFLZRA5',
'GOEI070217MDFMSTA4',
'LUMR070602MMCGXCA4',
'NAHR070608HDFRRBA3',
'GADI070904MDFRMVA7',
'NARS070917MMCVSPA4',
'RARS060123HDFMMBA9',
'VOMA070309MDFLLSA9',
'LAGA070901MDFDRQA2',
'PEGC070312MMCRNRA8',
'MIMV071114MDFRXLA0',
'GATD071127HDFRRGA3',
'LEBD071007MDFNNNA4',
'CAAM070801MDFBLRA6',
'MEMS071224MJCNRYA5',
'VIHP070711MDFLRLA2',
'GOLF070918MDFNPRA4',
'LACA070601HDFRRLA2',
'CORA070607MDFRCLA3',
'GOHS071129MDFNRPA3',
'DIGM070324HDFZRRA1',
'GAGS070508MDFRTRA2',
'SAMR071001HDFNRDA1',
'COTE071107MMCLLRA7',
'IARD071004HDFBSNA7',
'PAKD070115HDFLRRA2',
'AAMA070120HDFLLNA1',
'SORB060902HDFLSRA3',
'AAGE071214HDFLRMA3',
'TUCR070401MDFRNBA5',
'AUGN070113MDFGTTA6',
'CALS070131HDFMPLA8',
'GOPP071023HDFNXBA0',
'HEMA070222HDFRRDA5',
'RIIM071130HDFVSRA1',
'SAJA071029HDFNMLA7',
'LOBD070731MDFPRNA1',
'JUCN070212MDFRSMA4',
'BELE070611HMCCYRA6',
'VEVY071004MDFLZRA0',
'GULA071115HDFZRLA8',
'CECA070108MDFRRBA8',
'DICS070606MMCZHRA8',
'FOMA071026HDFLNDA3',
'MOFY070305HDFNLMA3',
'MEJG070625HDFNMBA7',
'RETG070910MDFYRBA01',
'PASA070609MDFLLLA1',
'PAJM070813MMCRRXA6',
'VEHN071123HDFLJTA0',
'TEHF071116MMCLRRA4',
'LOGL070604HDFZMSA1',
'BAAJ070814HMCRQSA5',
'DOMB070514MADFMRYA9',
'MAMJ070704HMCRDRA5',
'SIED070615HDFRSVA2',
'JIGE070703HDFMNDA3',
'MAAF070816MMCRQBA3'
);

select 
/* nombre_escuela, turno */
s_curp as rb_curp, s_nombre as rb_nombre, s_primerapellido as rb_primer_apellido,
s_segundoapellido as rb_segundo_apellido, s_cct as rb_cct,
nivel_educativo as rb_nivel_educativo, grado as rb_grado, grupo as rb_grupo
FROM SAEPPLOAD.V_ALUMNOS_INSCRITOS_XNIVEL where s_curp in ('VAPP091003MMCZSLA1',
'LOBE101003HDFPTRA7',
'MOGE100102HDFRMRA1',
'VEAC100416HMCRLRA4',
'COCN101011MDFNRTA3',
'COCM101011MDFNRXA6',
'RAFD100708MDFMLRA3',
'HESS091201HDFRLTA6',
'PECA100129HDFRRBA4',
'AABM100728HDFYRTA7',
'TEPM100129HDFLLRA0',
'TOYN100626MDFRPZA7',
'MEOJ100728HDFNRRA0',
'FORT100919HDFLMDA4',
'MAMP100909MNLRNLA0',
'GORP101014MMCDYLA7',
'BASI100413MDFTNSA7',
'MIEG100201HDFSSSA4',
'GOGA100415MDFNMNA9',
'CAAA100327MDFRRNA6',
'RASA101221HDFMLLA1',
'SAMA100417HDFNJXA5',
'CAVC101027HDFMLSA5',
'MEFL100917HDFJJNA8',
'BEMD100613HDFCRNA2',
'BEVI100626HDFLLSA5',
'HEAA100419MDFRLNA7',
'HUMC100325HDFTDLA1',
'RERD101212MDFYJRA7',
'GAAI100622HDFRLKA3',
'CACR100810HTLRRCA0',
'GAAF100909HDFRGRA8',
'ZARD100305HMCMMMA1',
'NAOS100430HDFVLNA3',
'VAAL101105MDFLBXA9',
'TEDM100201MDFLZRA9',
'REMI100822HDFYRNA3',
'LERE100507HDFNMRA0',
'QUHF100215MDFXRRA6',
'GOHS100716HDFNRBA8',
'GAAS101011MDFRLNA2',
'LUEK100826MDFVSNA3',
'VEMJ100414HDFGRHA5',
'PAGG100114HNERRBA9',
'VAML100810HDFZNNA7',
'VEMA100414HMCGRLA3',
'CAMS100325MDFRNFA1',
'MEMM100816MDFRRTA9',
'TEMV100816MMCLNNA6',
'BEHJ101118HDFCRHA8',
'ZELA100812HDFPPNA8',
'MERP100203MDFNMLA2',
'MAMR101020HMCRRDA3',
'SOGM100825MDFTRRA7',
'MALA101028MDFCZNA0',
'EORE100528MDFSBLA5',
'SEBI110208MDFTLYA7',
'RUPA100828HDFZRNA1',
'ROMJ100917HDFBNSA7',
'HEHHH100323HDFRRGA8',
'PELS101202HDFRLNA7',
'COVA100526HDFRLNA4',
'CAPS101011HDFRVNA4',
'MACE100326HDFRHMA0',
'BEGM100304MDFRTXA6',
'HEAA100220HDFRRLA8',
'ROEE100515MDFJSLA2',
'PIRV101118MDFCMLA1',
'SAAS100614MDFNGLA8',
'VEGE101013HDFLRLA0',
'MAMI100311HDFRNNA8',
'RACV100806MDFMHLA0',
'HEHC090717MVZRRRA5',
'RIGE101029HDFVNDA9',
'TOZA100828MDFRMNA1',
'RARI100501HDFMDSA4',
'CEVG100524HDFDLVA7',
'MUNE100329HDFXVMA0',
'MOMD100403MMCTRNA4',
'FOOE101227MDFLLMA2',
'GAGD101107HDFRRNA3',
'LODL100113MDFPMZA9',
'VAMF100401MDFRRRA7',
'TICA200629MDFRRDA2',
'VAOA101020MDFLLNA3',
'JIGO100713HDFMRSA7',
'LUMJ100312HMCNYSA9',
'GOLS100513HDFMPNA0',
'AUAE100421HMCGLMA4',
'GACH100316HDFRSMA5',
'SALS100108HDFNPNA5',
'AAAR100629MDFRGNA9',
'AAMA100110HDFRNXA2',
'HEDE100806HDFRRLA0',
'GOLA101022MDFMPNA7',
'GOOD100522HDFNTNA4',
'GOLE100110HDFNRMA6',
'MAMA100306HDFTLXA8',
'TALL101229MDFLMXA8',
'AAPE100324HDFLRDA8',
'ROMJ100827MDFMRDA1',
'UIRV100514HDFRDCA8',
'ZECS100212HDFNNMA3',
'VELL100826HDFLYSA0',
'LUHD100609MDFNRNA4',
'DUNR100427MDFXLNA0',
'CAMN100129MDFLRTA7',
'TORA100311MDFRNNA3',
'VESA101128MOCLLMA5',
'VAVL100519HMCZLNA2',
'SOAS100905HDFSLNA5',
'TAOE101126MMCPSLA8',
'REEA100617MDFYSLA0',
'AAGC100429MDFLRNA2',
'HECC100905MMCRDMA6',
'AIAA100201MDFRLNA9',
'MATR100929HDFRRGA3',
'GOLD100321HMCMPGA6',
'RIMN100909MDFVNTA0',
'RAQL100602HDFZNSA5',
'LOLY100207HDFPPRA2',
'LOML101018HDFPRSA6',
'PUIL101223HMCLBNA7',
'ROHA100623HDFSRRA4',
'UAAD100811HDFGRVA1',
'GOME101030HMCNRVA4',
'HEOA100427HDFRRNA7',
'OOHA100407MDFSRNA9',
'AAYS100427HDFRSLA8',
'MEVA100826HDFNLNA3',
'GUTY100510MHGTPTA6',
'AASA100906HDFYLBA0',
'CAV1100316HDFLZVA9',
'PEHS100128MDFRRFA6',
'DOFX100405MQTMRMA5',
'TEAA101107MDFXLNA2',
'RACS101107HDFYRBA2',
'QUVM100115MMCRLGA1',
'PACA101213HDFSHMA9',
'EIHJ100301MDFSRSA8',
'AUIY1OO316MDFRGMA2',
'MAOJ101018HDFRLDA1',
'ROLK100602MDFMPRA2',
'CXGA100908MMCSNNA7',
'VEAS100817HDFRPNA6',
'COEJ100124MDFLCTA9',
'HEAD100201HMCRLRA6',
'VAFS100125HMSZNBA0',
'AUGK100819HDFNNNA1',
'SAPT100521MMCLNBA2',
'HEAA101222HDFRRLA8',
'MOGA100105MDFNMMA7',
'OEGY101118MDFLTRA6',
'JILY101208MDFMPRA6',
'BAAS100908MMCLYPA7',
'GAPS100426MDFRRHA8',
'AAMA100122HDFNLNA0',
'AEZY100108HDFRMHA8',
'LOLS100120HDFPPBA7',
'SACD101009HMCMHVA8',
'CARA100209MDFRMLA1',
'VAGL101027HDFZNCA9',
'MAAV100926MDFRGLA3',
'SICK070402MDFRSRA0',
'RAPE100302HDFMDSA9');

