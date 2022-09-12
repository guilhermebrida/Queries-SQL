with X as (
select
(to_timestamp(SPLIT_PART(SPLIT_PART(MESSAGE, ',',2),'-',1),'DDMMYYHH24MISS') - '3 hour'::interval ) HORA,
MESSAGE
from inbox i
where device_id = 'JKA0'
and reception_datetime > current_date -6
and MESSAGE like ('>RAX%')
--dataaa between date('2021-11-23 15:10:31.000 -0300') and date('2021-11-22 20:49:18.000 -0300'))
--and message like '>RUV0020%'
--and message like '>RUV0120%'
--AND message like '>RUV0199%'
--and MESSAGE like '>RED%'
--and (message like '>RUV0121%' or message like '>RUV0020%' or message like '>RUV0199%')
order by id desc
)
select * from X
--where HORA = '2021-11-23 10:25:31'
where HORA BETWEEN '2021-11-23 10:25:31' and '2021-11-23 10:28:01.000 -0300'
