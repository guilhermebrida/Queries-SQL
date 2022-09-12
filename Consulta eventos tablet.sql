--CONSULTAR EVENTOS
SELECT
ev.data_hora,
ev.cod_evento,
EV.ENT_DADOS,
ev.hodometro,
ev.horimetro,
ev.driver_id,
ev.error_id,
--ev.id,
ev.avl_locations_id,
ev.lat_inicial,
ev.lat_final
FROM aero.EVENTOS EV
inner join aero.vehicles v on (v.vehicle_id = ev.vehicle_id)
--where v.vehicle_plates = '15016'--
--where v.vehicle_plates = 'PF-TBO' --grua florestal bracell
--where v.vehicle_plates = 'RIU4C78'
where v.vehicle_plates = 'ENGJO3' -- 31005 grua de mesa bracell/grua de pato 31000
--where v.vehicle_plates = 'JAZ7I36' -- caminhão 1
--where v.vehicle_plates = 'GBT2055' -- caminhão 2
--where v.vehicle_plates = 'FRJ8591' -- caminhão 3
--where v.vehicle_id =531135
--where v.vehicle_plates = '15011'--RNC4H45
--and ev.cod_evento in (11)
and codigo = 6152
--and ev.data_hora > sysdate -1
--and ev.data_hora > '08/03/2022 08:00'
--AND ev.cod_evento =4024
--and ev.cod_evento like '%101'
order by ev.data_hora desc;


SELECT * FROM AERO.EVENTOS e 

SELECT * FROM AERO.EVENT