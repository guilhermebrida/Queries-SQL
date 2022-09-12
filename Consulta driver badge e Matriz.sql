SELECT 
data_inicio,
data_fim,
cc.MATRIZ ,
cc.FILIAL ,
driver_firstname,
driver_lastname,
d.DRIVER_BADGE ,
db.DALLAS_BUTTON_ID dallasID,
db.DALLAS_BUTTON_INFO ,
vehicle_plates placas,
imei
FROM AERO.JOURNEY J
join aero.vehicles v on v.vehicle_id=j.vehicle_id
JOIN aero.DRIVERS d ON d.DRIVER_ID = j.driver_id
JOIN aero.VEHICLE_IMEI vi ON vi.VEHICLE_ID = v.VEHICLE_ID 
join AERO.active_customers_hierarchy cc on cc.customer_child_id=v.customer_child_id
JOIN aero.DRIVER_DALLAS_BUTTONS ddb ON ddb.DRIVER_ID =d.DRIVER_ID 
JOIN aero.DALLAS_BUTTONS db ON db.DALLAS_BUTTON_ID = ddb.DALLAS_BUTTON_ID 
WHERE cc.matriz like 'CTEEP'
--AND d.DRIVER_BADGE = '1099114919'
--and V.VEHICLE_PLATES  in (  'CUM5G81' )
--AND d.DRIVER_FIRSTNAME IN ('%EE')
AND d.DRIVER_LASTNAME like ('EE%')
--ORDER BY DATA_INICIO DESC 
