set define off;
select
-- i.id,
--CC.MATRIZ,
--CC.filial,
--CC.regional,
--cc.unidade,
v.vehicle_plates,
v.vehicle_prefix,
i.data_hora,
--i.TEMPO_EXCESSO,
it.descricao,
it.codigo,
vi.imei
--i.valor_limite_utilizado
--,i.*
--,'https://www.frotalog.com.br/MBServerO/route_rebuild.jsp?v='||I.vehicle_id||'&di='||to_char(data_hora+3/24-20/60/24,'rrrr-mm-dd"T"hh24:mi:ss')||'&df='||to_char(data_hora+3/24+20/60/24,'rrrr-mm-dd"T"hh24:mi:ss') rota
from AERO.infraction i
left join AERO.infraction_type it on it.codigo = i.codigo
left join AERO.vehicles v on v.vehicle_id = i.vehicle_id
left join AERO.vehicle_imei vi on v.vehicle_id = vi.vehicle_id
left join AERO.DRIVERS D on D.DRIVER_id = I.DRIVER_id
left join AERO.active_customers_hierarchy cc on cc.customer_child_id=v.customer_child_id
-- where i.data_hora > sysdate-100
where i.data_hora BETWEEN TO_DATE('01/12/2021','DD/MM/RRRR') AND TO_DATE('28/12/2021','DD/MM/RRRR') 
-- and i.id = 514123030
-- and v.vehicle_plates in ('EVA-6794')
-- AND vI.IMEI = '%8126'
-- and i.codigo not in (4098,4099,14098,4114)
-- and i.codigo in (4105) -- pmot ligado
-- and i.codigo in (6167) -- MOT DESATIVADO
-- and i.codigo in (4099) -- RPM
-- and i.codigo in (4098) -- vel
-- and i.codigo in (4101) -- frda
-- and i.codigo in (4107) -- acl
-- and i.codigo in (4101,4107) -- frda,acl
-- and i.codigo in (12401) -- cinto
-- and i.codigo in (20004) -- cinto
-- and i.codigo in (13220,12401) -- cinto
AND i.codigo in (20003) -- cond noturna
-- and i.valor_limite_utilizado = 10
-- and vehicle_plates = 'PLX6H27'
-- and i.vehicle_id=539020
and REGEXP_LIKE(cc.MATRIZ,'corteva','i')
 ORDER BY I.DATA_HORA DESC



--))