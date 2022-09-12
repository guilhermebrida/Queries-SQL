select * from (
select
device_id ID,
--SUBSTR(MESSAGE,14,12),
to_timestamp(SUBSTR(MESSAGE,14,12),'DDMMYYHH24MISS') - '3 hour'::interval  HORA,
case when (cast(split_part(MESSAGE,',',9) as integer) + cast(split_part(MESSAGE,',',8) as integer) < cast(split_part(MESSAGE,',',7) as integer) )THEN 'ERRO' else '-' end as ERRO,
split_part(MESSAGE,',',7) TM,
split_part(MESSAGE,',',8) ML,
split_part(MESSAGE,',',9) VD,
cast(split_part(MESSAGE,',',9) as integer) + cast(split_part(MESSAGE,',',8) as integer) SOMA,
SPLIT_PART(split_part(MESSAGE,',',10),';',1) EX,
MESSAGE
from inbox i
where device_id = '88FE'
--where 1=1
and CONSUMPTION_datetime > NOW() - interval '24' HOUR
and (message like '>RUV0199%' or message like '>RUV0121%')

--and message like '>RUV0020%'
) X
--order by id desc 
--and reception_datetime > current_date -2
--and message like '>RED%'
--and message like '>RUV00%'
--and message like '>RUV01%'
--and message like '>RUV0199%'
--and (message like '>RUV01%' or message like '>RUV00%')

