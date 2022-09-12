select *
from inbox i
where device_id = '88FE'
and reception_datetime > current_date -2
--and message like '>RUV0020%'
--and message like '>RUV0120%'
--AND message like '>RUV0199%'
and (message like '>RUV0121%' or message like '>RUV0020%' or message like '>RUV0199%')
order by id desc 