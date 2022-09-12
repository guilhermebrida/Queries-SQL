set defiine off;

SELECT 
-- i.id,
CC.MATRIZ,
v.vehicle_plates,
v.vehicle_prefix,
i.data_hora,
i.TEMPO_EXCESSO,
it.descricao,
it.codigo,
vi.imei,
(select app_version from (select * from AERO.hardware_config ORDER BY date_time desc) where vehicle_id = V.Vehicle_Id and rownum=1) app,
i.valor_limite_utilizado
,'https://www.frotalog.com.br/MBServerO/route_rebuild.jsp?v='||I.vehicle_id||'&di='||TO_char((I.data_HORA+3/24-10/60/24),'rrrr-mm-dd')||'T'||TO_char(I.data_HORA+3/24-10/60/24,'hh24:mi:ss')||'&df='||TO_char(I.data_HORA+3/24+i.TEMPO_EXCESSO/3600/24+10/60/24,'rrrr-mm-dd')||'T'||TO_char(I.data_HORA+3/24+i.TEMPO_EXCESSO/3600/24+10/60/24,'hh24:mi:ss') ROTA
from AERO.infraction i
left join AERO.infraction_type it on it.codigo = i.codigo
left join AERO.vehicles v on v.vehicle_id = i.vehicle_id
left join AERO.vehicle_imei vi on v.vehicle_id = vi.vehicle_id
left join AERO.DRIVERS D on D.DRIVER_id = I.DRIVER_id
left join AERO.active_customers_hierarchy cc on cc.customer_child_id=v.customer_child_id
where i.data_hora > sysdate-2
and i.codigo in (4098) -- vel
and vehicle_plates = 'PLO0D56'