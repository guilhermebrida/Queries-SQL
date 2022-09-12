
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
and UPPER(cc.matriz) like '%JSL%'
AND I.IMEI LIKE 'VIRLOC%_%'
and v.vehicle_plates in ('IZS9E01','RND8A42','RND8A35','RND8A14','RNE8A69','RNH2C35','RNH2C46','RNM1I91','RND8A53','RNI6I47','RNM8G80','RMN8G83','RNM8G86','RNM1I94','RNM1I95','RNM8J11','RNM8G90','RNM8J13','RNM8J14','RNM8H10','RNO0D46','RNM8H22','RNM8J15','RMN8H14','RNQ5B29','RNM8H39','RNO0I69','RNO0I70','RND8A55','PTM0549','RIV4D41','JAY0H49','RND8A55')
)
loop
--insert into AERO.HW_VIRLOC8_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'VQ2903');
--insert into AERO.HW_VIRLOC8_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'QCT02');
--insert into AERO.HW_VIRLOC8_OUTBOX (DEVICE_ID, PRIORITY_TRANSMIT, DELIVERY_LEVEL, MODIFIER, MESSAGE) values (i.did,0,2,null,'VS2903,65253,0,29,02,1,4,FFFFFFFF,0,0,0500');
end loop;
end;
