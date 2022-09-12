select
cc.matriz,
cc.filial,
cc.regional,
cc.unidade,
v.vehicle_id,
v.description as modelo,
V.Vehicle_Year As Ano,
v.vehicle_plates as placa,
v.vehicle_prefix as prefixo,
v.embeded_fences_limit,
regexp_replace(i.imei,'_\w+','') equip,
regexp_replace(i.imei,'\w+_','') did
from aero.vehicles v
left join aero.vehicle_imei i on i.vehicle_id=v.vehicle_id
left join aero.active_customers_hierarchy cc on cc.customer_child_id = v.customer_child_id
where v.vehicle_status in (1)
--and UPPER(cc.matriz) like '%CPFL%'
--AND I.IMEI LIKE 'VIRLOC10_%'
AND regexp_replace(i.imei,'\w+_','') IN ('25AA','240B','2E3B','2448','24D0','2468','2738','2738','273B','2724','273B','2459','240B','2E3B','2E3B','2459','2724','2645','2645','2448','24D0','2468','25AA')
--and v.vehicle_plates in ('CUH9J18','DEI6F33','EJE0F47','EWU8D45','GIQ4A38','GIV4C37','GDU5D72','GEI0I37')
--AND v.VEHICLE_PREFIX IN ('000175','000184','000179','000192')



SELECT *
from aero.vehicles v
left join aero.vehicle_imei i on i.vehicle_id=v.vehicle_id
left join aero.active_customers_hierarchy cc on cc.customer_child_id = v.customer_child_id
WHERE 