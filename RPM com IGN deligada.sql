select * from (
select
DEVICE_ID,
case when SUBSTR(MESSAGE,52,2) > '80' then 'LIG' ELSE 'DESL' end as IGN,
split_part(MESSAGE,',',7) TM,
split_part(MESSAGE,',',8) ML,
split_part(MESSAGE,',',9) VD,
SPLIT_PART(split_part(MESSAGE,',',10),';',1) EX,
case
when split_part(MESSAGE,',',7)::INT + split_part(MESSAGE,',',8)::INT + split_part(MESSAGE,',',9)::INT + SPLIT_PART(split_part(MESSAGE,',',10),';',1) ::INT > 0 and SUBSTR(MESSAGE,52,2) < '80' then 'FUUUU'
else 'OK'
end as TESTE,
MESSAGE
from inbox i
where 1=1
and CONSUMPTION_datetime > NOW() - interval '24' HOUR
and message ~ 'RUV0199'
) X
where TESTE <> 'OK'