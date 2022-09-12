WITH x as(SELECT 
j.DATA_INICIO ,
j.DATA_FIM ,
i.IMEI ,
j.TEMPO_IGNICAO_LIGADA IGN,
j.TEMPO_MOTOR_GIRANDO TMG,
j.TEMPO_MARCHA_LENTA TML,
j.TEMPO_FAIXA_IDEAL TFI,
j.TEMPO_MOVIMENTO TM,
j.QUILOMETROS_RODADOS KM,
--DISTINCT (i.IMEI),
v.DESCRIPTION MODELO,
--v.VEHICLE_PREFIX PREFIX,
--J.VEHICLE_ID ,
--j.ERROR_ID ,
--j.HODOMETRO_INICIO ,
--j.HODOMETRO_FIM ,
j.LITROMETRO_INICIO ,
j.LITROMETRO_FIM ,
(SELECT MAX(al.vel) FROM aero.AVL_LOCATIONS al WHERE al.DATE_HOUR BETWEEN j.DATA_INICIO AND j.DATA_FIM AND v.VEHICLE_ID = al.VEHICLE_ID) AS velMax,
(SELECT MAX(al.ROT) FROM aero.AVL_LOCATIONS al WHERE al.DATE_HOUR BETWEEN j.DATA_INICIO AND j.DATA_FIM AND v.VEHICLE_ID = al.VEHICLE_ID) AS ROTMax,
v.VEHICLE_PLATES PLACA,
regexp_replace(i.imei,'\w+_','') did,
v.VEHICLE_ID ,
(j.QUILOMETROS_RODADOS/(j.LITROMETRO_FIM-j.LITROMETRO_INICIO)) kml,
cc.MATRIZ
FROM AERO.JOURNEY j 
join aero.vehicles v on v.vehicle_id=j.vehicle_id 
JOIN AERO.ACTIVE_CUSTOMERS_HIERARCHY cc on cc.customer_child_id = v.customer_child_id
JOIN AERO.VEHICLE_IMEI i on i.VEHICLE_ID=v.VEHICLE_ID
WHERE 1=1
--AND DATA_INICIO > sysdate -100
--and cc.customer_id=4345
--AND TEMPO_MOTOR_GIRANDO < (TEMPO_MARCHA_LENTA + TEMPO_FAIXA_IDEAL)
--and  v.VEHICLE_PLATES IN (  'EFO4319','BZB2B96','RDN5C42','FRJ8591','BKU3D95' )
--AND UPPER(v.DESCRIPTION) LIKE '%SCANIA%'
AND UPPER (cc.MATRIZ) NOT LIKE '%BRACELL%'
--AND j.TEMPO_IGNICAO_LIGADA  > '1000'
AND i.IMEI LIKE 'VIRLOC8_%'
--AND v.DESCRIPTION LIKE '%FIAT%'
--and UPPER(cc.matriz) like '%CREARE%'
--AND j.VEHICLE_ID IN ('543853')
--ORDER BY j.ID DESC
)
SELECT DISTINCT
x.matriz ,
x.vehicle_id,
x.imei,
x.placa ,
x.MODELO ,
--x.ign,
--x.tmg,
regexp_replace(x.imei,'\w+_','') did,
FIRST_VALUE(x.data_inicio) OVER (partition by x.vehicle_id ORDER BY x.data_inicio desc) AS di ,
FIRST_VALUE(x.data_fim) OVER (partition by x.vehicle_id ORDER BY x.data_inicio desc) AS df ,
FIRST_VALUE(x.litrometro_inicio) OVER (partition by x.vehicle_id ORDER BY x.data_inicio desc) AS li ,
FIRST_VALUE(x.litrometro_fim) OVER (partition by x.vehicle_id ORDER BY x.data_inicio desc) AS lf
--x.kml
FROM x 
WHERE data_inicio > sysdate-1
--AND regexp_replace(x.imei,'\w+_','') IN ('G052','G05B','G00E','G007','G00G','G04B','G022','G0RH','G00U','G02E','G082','G0GX','G0M7','G016','G00B','G08D','G042','G04C','G01N') 
--AND (x.LITROMETRO_FIM-x.LITROMETRO_INICIO) <> 0

SELECT * FROM aero.ERRORS e 


SELECT * FROM AERO.JOURNEY 
WHERE VEHICLE_ID IN ('508118')