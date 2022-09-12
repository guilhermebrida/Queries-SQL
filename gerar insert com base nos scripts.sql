with Veic as(
select
cc.matriz,
v.vehicle_id vid,
v.vehicle_plates as placa,
v.vehicle_prefix as prefixo ,
v.v_mb_last_collect as coleta,
regexp_replace(i.imei,'_\w+','') equip,
regexp_replace(i.imei,'\w+_','') device_id
,decode(regexp_replace(i.imei,'_\w+',''),'VIRLOC6',cp6.CAN_SCRIPT_VERSION,cp.CONFIG_VERSION) SCRIPT_CAN
from aero.vehicles v
left join aero.vehicle_imei i on i.vehicle_id=v.vehicle_id
left join aero.active_customers_hierarchy cc on cc.customer_child_id = v.customer_child_id
left join aero.config_virtec_parameters cp on cp.vehicle_id=v.vehicle_id
left join aero.config_vl6_parameters cp6 on cp6.vehicle_id=v.vehicle_id
where v.vehicle_status in (1)
and REGEXP_LIKE(i.imei,'VIRLOC8','i')
and REGEXP_LIKE(cp.CONFIG_VERSION,'j1939|3344','i')
)
select
veic.*
,case
when upper(script_can) like '%J1939%' then 'insert into AERO.HW_'||EQUIP||'_OUTBOX (DEVICE_ID,MESSAGE) values ('''||device_id||''',''VS2906_MAT,H100'');'
when upper(script_can) like '%3344%' then 'insert into AERO.HW_'||EQUIP||'_OUTBOX (DEVICE_ID,MESSAGE) values ('''||device_id||''',''VS2903_MAT,x4/10H100'');'
end as cmd
from veic