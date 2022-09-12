select *
from inbox i
where device_id = '845D'
and reception_datetime > current_date -3
and message like '>RED%'
order by id desc 