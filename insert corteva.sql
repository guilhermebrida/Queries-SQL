
begin
for i in
(
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
and UPPER(cc.matriz) like '%CORTEVA%'
AND I.IMEI LIKE 'VIRLOC10_%'
and v.vehicle_plates in ('RHN4C80','RHO2H61','RHN4C35','RHN4C83','RHM7B27','RHM1E94','RHK3H31','RHM9F38','RHM7B31','RHL7E40','RHM1F04','RHM1F22','RHK3G26','RHM1F13','RHK6J79','RHN4C74','RHN4C09','RHK2J09','RHK3H42','RHJ0F89','RHK2J15','RHM1F26','RHM1F27','RHK3G09','RHM1F20','RHK8F06','RHK3G20','RHK3G02','RHM7B28','RHL7E45','RHK3G99')
)
loop
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'Q1901');
insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'SUT59,QCT64,7,6,0,255000');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED29');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED212');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED211');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QCT11');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QCT12');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QCT10');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED31');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED140');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED141');
--insert into AERO.HW_VIRLOC10_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QED142');
end loop;
end;
