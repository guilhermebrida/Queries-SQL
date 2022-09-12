with H AS(
select
SOURCE,
ID,
MESSAGE,
DEVICE_ID,
status,
RECEPTION_DATETIME,
CONSUMPTION_DATETIME,
SPLIT_PART(SPLIT_PART(MESSAGE, ',',3),'-',1) HORA,
SPLIT_PART(MESSAGE, ';',3) IDMESSAGE,
SPLIT_PART(MESSAGE, ',',4) TRECHO
FROM INBOX AS I
WHERE DEVICE_ID IN ('G0B2')
--and (MESSAGE ~'RUV0021' or MESSAGE ~'RUV0425' or message ~'RAX22' or message ~'RAX23')
ORDER by reception_datetime desc)
select ID,DEVICE_ID,
h.reception_datetime,
h.CONSUMPTION_DATETIME,
concat(substr(HORA,5,2),'/',substr(HORA,3,2), '/', substr(HORA,1,2), ' ', substr(HORA,7,2),':', substr(HORA,9,2), ':',substr(HORA,11,2)),
H.TRECHO,
H.IDMESSAGE,
--H.status,
h.message 
from H 
where status <> '2'
--and trecho = '1679'
order by ID DESC