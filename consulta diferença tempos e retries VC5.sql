WITH X AS(
SELECT
--ID,
o.device_id,
O.DATETIME,
o.delivery_datetime ,
LEAD(o.delivery_datetime , 1) OVER (ORDER BY O.delivery_datetime asc) PROX_RECEBIDO ,
TRUNC((LEAD(o.delivery_datetime , 1) OVER (ORDER BY O.delivery_datetime asc)-o.delivery_datetime)*24*60) DIF_MIN,
SEQUENCE,
RETRIES, 
MESSAGE ULT_MESSAGE
From Aero.Hw_Vircom5_Outbox o
ORDER BY O.delivery_datetime ASC
)
SELECT 
--DISTINCT (DEVICE_ID),
--ID ,
DEVICE_ID ,
DATETIME ,
DELIVERY_DATETIME ,
x.prox_recebido,
x.dif_min,
RETRIES ,
"SEQUENCE" ,
x.ult_message
--COUNT(DISTINCT(ult_message)),
--DISTINCT(ULT_MESSAGE)
--COUNT(x.device_id)
FROM X
WHERE 1=1
--AND DEVICE_ID = 'H06W'
AND DIF_MIN = 0
--and delivery_datetime BETWEEN TO_DATE('2021-11-26 10:21:17', 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE('2021-11-29 12:43:23','YYYY-MM-DD HH24:MI:SS')
AND RETRIES <= 1
AND X.ULT_MESSAGE LIKE ('SBA0063%')
--AND vi.imei LIKE ('VIRLORC%_56AA')
ORDER BY x.dif_min asc