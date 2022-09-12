select * from (
select
(to_timestamp(SUBSTR(MESSAGE,8,12),'DDMMYYHH24MISS') - '3 hour'::interval ) HORA,
substr(split_part(message,',', 2),30,3) vel,
regexp_replace(split_part(message,',', 2),'\d{12}([+-]\d{2})(\d{5}).*','\1.\2') lat,
regexp_replace(split_part(message,',', 2),'\d{12}[+-]\d{7}([+-]\d{3})(\d{5}).*','\1.\2') long,
split_part(split_part(message,',',3),' ',1) IS_4G,
split_part(split_part(message,',',3),' ',2) BND,
split_part(split_part(message,',',3),' ',6) SQ,
split_part(split_part(message,',',3),' ',8) LA,
split_part(split_part(message,',',3),' ',9) ID,
split_part(message,',',5) mnc,
case split_part(message,',',5)
when '72402' then 'TIM'
when '72403' then 'TIM'
when '72404' then 'TIM'
when '72408' then 'TIM'
when '72405' then 'Claro'
when '72406' then 'VIVO'
when '72410' then 'VIVO'
when '72411' then 'VIVO'
when '72423' then 'VIVO'
when '72416' then 'OI'
when '72424' then 'OI'
when '72431' then 'OI'
when '72434' then 'CTBC'
when '72400' then 'Nextel'
when '72439' then 'Nextel'
when '72407' then 'Sercomtel'
else split_part(message,',',5)
end as OPER,
split_part(message,',',6) BW
from inbox i
where DEVICE_ID = 'FFFF'
and message ~ '>RAX45'
and reception_datetime > CURRENT_DATE - 1
order by ID DESC
) x
where hora > current_date-10
order by hora desc