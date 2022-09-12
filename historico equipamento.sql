SELECT * FROM aero.VEHICLE_IMEI_HISTORY vih 
WHERE VEHICLE_PREFIX LIKE 'RE048A'
--WHERE IMEI = '86919603609807'


select
*
from AERO.vehicle_hardware_history
JOIN AERO.hardwares USING(hardware_id)
join AERO.vehicles USING (vehicle_id)
--JOIN aero.VEHICLE_IMEI_HISTORY vih USING (vehicle_prefix)
WHERE NAME = '869196033609807'
--WHERE VEHICLE_PREFIX = 'RE048A'

SELECT * FROM aero.HISTORY