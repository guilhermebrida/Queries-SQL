select 
--CODIGO ,
--DATA_HORA ,
--ENT_DISCRETAS ,
--COD_ENT_ANALOGICAS ,
--TEMPO_EXCESSO ,
--TEMPO_ENTRADAS 
*
from AERO.EVENTOS e 
JOIN AERO.VEHICLES v USING (VEHICLE_ID)
WHERE v.VEHICLE_PLATES = 'IZK3H59'
AND DATA_HORA > '2022-01-17 13:25:03.000'
--AND ENT_DISCRETAS <> '0'
--ORDER BY id desc

SELECT *
FROM AERO.VEHICLES v 

SELECT
--v.vehicle_prefix,
--v.vehicle_plates,
--e.data_hora,
--e.tempo_excesso AS tempo
*
FROM aero.vehicles v,aero.eventos e
WHERE e.vehicle_id= v.vehicle_id
AND e.codigo= 6170
and e.data_hora > sysdate-10
and vehicle_plates='IZK3H59'

SELECT *
FROM aero.JOURNEY j 


