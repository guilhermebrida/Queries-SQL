select 
device_id,
(to_timestamp(split_part(message,',', 3),'DDMMYYHH24MISS') - '3 hour'::interval  ) HORA,
case split_part(message,',', 1) 
  when '>RUV0077' then 'CONECTOU CARREGADOR'
  when '>RUV0078' then 'DESCONECTOU CARREGADOR'
  else null
end as EVENTO,
regexp_replace(split_part(message,',', 3),'\d{12}([+-]\d{2})(\d{5}).*','\1.\2') lat,
regexp_replace(split_part(message,',', 3),'\d{12}[+-]\d{7}([+-]\d{3})(\d{5}).*','\1.\2') long,
split_part(message,',', 14)::FLOAT /10 HOD,
split_part(message,',', 8) EDVs2,
('x'||SUBSTR(split_part(message,',', 8),5,2))::bit(8)::INT "BAT%",
SUBSTR(split_part(message,',', 8),7,2) CARREGADOR
,MESSAGE
from inbox where 1=1
--and device_id in ('AFD2','AFBE','ACBB','AB99','A540')
--and device_id in ('AFD2')
--and device_id in ('AFBE')
--and device_id in ('ACBB')
and device_id in ('AB99')
--and device_id in ('A540')
and reception_datetime  > (now() - interval '1 day')
and message  ~ 'RUV0[^5]'
order by hora desc
