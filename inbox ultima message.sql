 select device_id , message, reception_datetime  from inbox i where id in (
 SELECT 
 max(id)
FROM inbox i
where 1=1 
and device_id in ('AB10','A1BC','D39D')
--and message not like '>RUV%'
--where device_id ='2C3D'
--and STATUS <> 2
and MESSAGE ~ 'RAX183' 
--and reception_datetime > to_date('2022-05-02 11:59:00','YYYY-MM-DD')
--and reception_datetime between to_date('2022-03-30 09:22:38.275 -0300','YYYY-MM-DD') and to_date('2022-03-31 19:42:03.000','YYYY-MM-DD') 
group by device_id
) 

select 
device_id ,MESSAGE, reception_datetime 
from inbox i 
where 1=1 
and device_id = 'G0EG'
--and device_id in ('G017','G080','G0LR','G00K','G096')
and (message ~ 'RAX22' or message ~ 'RAX23' or message ~ 'RUV0021' OR message ~ 'RUV0425' or message ~ 'RED22')
--and MESSAGE ~ 'RED22'
--and reception_datetime 
order by ID desc



select * from inbox i where device_id in ('80B2','89F9','891A','C22D','833B','61B8','81C9','8303','84AD','8918')




select *
from(select MESSAGE,
split_part(MESSAGE,',',1) top_msg,
lead(split_part(MESSAGE,',',1))OVER(partition by device_id order by ID DESC) as last_msg
from inbox where device_id ='80B2'
and (message ~ 'RUV0020' or MESSAGE ~'RUV0121')
and reception_datetime > '2022-08-25'
and STATUS <> 2
order by ID desc) as TABELA
where top_msg = last_msg


select count(message)
from(select MESSAGE,
split_part(MESSAGE,',',1) top_msg,
lead(split_part(MESSAGE,',',1))OVER(partition by device_id order by ID DESC) as last_msg
from inbox where device_id in ('80B2','89F9','891A','C22D','833B','61B8','81C9','8303','84AD','8918')
and (message ~ 'RUV0020' or MESSAGE ~'RUV0121')
and reception_datetime > '2022-08-28'
and STATUS <> 2
order by ID desc) as TABELA
where top_msg = last_msg

