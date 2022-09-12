
SELECT
--/*+ INDEX (l AVL_LOCATIONS_BEG_I01) */
--  cc.matriz,
--  v.vehicle_id,
  V.vehicle_plates placa,
  V.vehicle_prefix prefixo,
--  D.DRIVER_FIRSTNAME||' '||D.DRIVER_LASTNAME MOT,
  V.DESCRIPTION modelo,
  L.date_hour dataa,
  L.INSERTED_ON,
--  l.source,
  substr(discretas,4,1) IGN,  
--  substr(discretas,8,1) D1,  
--  substr(discretas,7,1) D2,
--  substr(discretas,6,1) D3,
--  DISCRETAS,
  L.vel,
  L.VEL_GPS,
  L.rot rot,
--  L.HODOMETRO/10,
  l.LATITUDE,
  l.LONGITUDE
--  l.source,
--  at.description ULT_ALARME
FROM AERO.avl_locations L
JOIN aero.vehicles V ON V.vehicle_id=L.vehicle_id
LEFT JOIN aero.DRIVERS D ON D.DRIVER_id=L.DRIVER_id
LEFT JOIN AERO.alarm_types AT ON L.latest_alarm_type_id = at.id
join aero.Active_Customers_Hierarchy cc on cc.customer_child_id=v.customer_child_id
WHERE 1=1
--AND l.date_hour between  to_date('2022-03-09', 'YYYY-MM-DD') AND to_date('2022-03-11', 'YYYY-MM-DD')
--AND l.date_hour between  '01/05/20' AND '02/05/20'
AND (L.date_hour) > SYSDATE-10
--and v.vehicle_prefix = '482092'
--AND L.VEL != '0'
--AND L.ROT != '0'
--and v.vehicle_id=530264
--and source='G'
--and substr(discretas,4,1)  = '1'
--and L.VEL_GPS <> 0
and vehicle_plates in ('92026')
--and vehicle_plates in ('RFJ4H76')
--AND LATITUDE BETWEEN '-24.02042' AND '-24.02044'
--AND LONGITUDE BETWEEN '-46.45690' AND '-46.45699'
order by  l.date_hour  DESC
--order by  l.VEL_GPS  desc NULLS LAST
;

 
 