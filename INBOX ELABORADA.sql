select device_id , message , reception_datetime from inbox i where id in(
SELECT 
--*
--"sequence" ,
--device_id,
--max(message) 
--first_value(id)  over (partition by device_id order by id desc) as maxs
--"source" ,
MAX(id)
--substr(MESSAGE,125,6) as hod 
--substr(MESSAGE,114,17) as vel_rot_hod ,
--reception_datetime 
--consumption_datetime 
FROM inbox i
--WHERE DEVICE_ID IN ('C23C','C25D','C244','C23B','C25F')
WHERE DEVICE_ID IN ('81AC','80DE','848D','C333','C265','8B53','C23D','B23F','C25D','C269','C22D','8B58','C24E','84DC','C236','C219','C246','8A41','858E','8762','8087','C2FA','8285','C2F9','C232','C263','8290','C226','C25E','815A','8326','87E9','825D','8168','8A3D','827D','C22C','81C9','86FE','8852','8B3A','8856','8404','8627','C334','8093','C2EE','C24C','89AB','8496','8529','8101','89F9','C2DE','8A6F','C220','866D','800F','C264','8306','C237','87AE','C253','8AFD','8601','83C0','8632','8008','853C','8742','8470','803B','8629','8659','8669','825B','C23B','83C4','85F3','8A3C','C241','8106','88C5','8A7E','88FD','C341','C229','C218','C22B','C25A','C243','C2F6','C2F7','C242','C22E','85BB','C258','8A40','C224','8031','C276','8263','87EF','80AD','869E','82C4','C251','C255','80B2','8A56','876E','C221','C249','850E','C268','C24A','C21F','8711','C256','812D','61B8','824F','8564','84BE','884A','8260','85AD','8451','8A6B','C330','823D','8633','8252','C2F2','C27D','C2E5','C2F5','801C','C210','84E5','C23C','C24F','C25C','82E2','8A6D','8303','8A1F','C26F','83AC','C20E','C257','C233','83EB','85BF','8918','8737','821D','8201','8148','8242','C25F','C22F','822A','C282','8862','C225','C222','80E2','C244','C214','C345','82F0','84AD','83E5','8595','8135','835F','8777','8A3E','8722','83D1','833B','8204','C332','C300','802B','84C0','8333','8500','8182','86D1','8078','C216','C227','C24B','C259','C234','C23F','C22A','C23A','898D','C21B','8459','814E','845E','C2EC','C217','87FD','C212','C213','C21A','C247','C270','C273','8660','81F7','8197','80C2','8582','891A','82C6','81B4','8092','816E','C250','8709','82FE','8A2E','839D','8ABB')
--and message not like '>RUV%'
--and message ~ 'R1905'
and reception_datetime > '2022-08-10'
--and STATUS <> 2
and MESSAGE ~ 'VR16,2E'
--and reception_datetime < to_date('2022-03-25','YYYY-MM-DD')
--group by device_id
--order by reception_datetime desc
group by device_id 
order by device_id ASC
)





SELECT 
--*
--"sequence" ,
--"source" ,
device_id ,
MESSAGE,
--SPLIT_PART(SPLIT_PART(MESSAGE,',', 13),';',1) as SCRIPT,
--substr(MESSAGE,61,6) as hod ,
-- SPLIT_PART(MESSAGE,',', 5) as HODOMETRO,
--substr(MESSAGE,114,17) as vel_rot_hod ,
reception_datetime ,
consumption_datetime ,
status 
FROM inbox i
--where device_id = 'C23C'
where device_id IN ('C23C','C25D','C244','C23B','C25F')
--WHERE DEVICE_ID in ('80B2','89F9','891A','C22D','833B','61B8','81C9','8303','84AD','8918')
--and (message ~ 'RUV0020' or MESSAGE ~'RUV0121')
and MESSAGE ~'VR16,2E'
--and MESSAGE not like '>RED%'
--and STATUS <> 2
and reception_datetime > '2022-08-10'
--group by 1,2,3,4,5
order by ID desc

--select para ver falha na abertura de trechos vl6
select device_id,message,left_msg,last_msg, reception_datetime from(
select 
id,
device_id ,
MESSAGE,
split_part(message,',',1) left_msg, 
lead(split_part(message,',',1)) over(order by id desc) as last_msg,
reception_datetime ,
consumption_datetime ,
status 
FROM inbox i
where device_id in ('80B2','89F9','891A','C22D','833B','61B8','81C9','8303','84AD','8918')
where device_id = '8918'
and (message ~ 'RUV0020' or MESSAGE ~'RUV0121')
and status <> 2
and RECEPTION_DATETIME > '2022-09-02'
)as tabela
where left_msg = last_msg
order by ID desc



--SELECT ONDE USA SCRIPT DA EMPRESA 
select distinct(DEVICE_ID), MAX(MESSAGE) FROM(
select 
id,
device_id ,
MESSAGE,
SPLIT_PART(SPLIT_PART(MESSAGE,',', 13),';',1) as SCRIPT,
reception_datetime ,
consumption_datetime ,
status 
from inbox
WHERE MESSAGE ~'RAX183') as TABELA
where reception_datetime > '2022-08-09'
and SCRIPT ~'JSLTB_S7'
group by 1


---- conta quantidade de erro de abertura de trecho vl6----
--with x as(
select device_id,message,left_msg,last_msg, RECEPTION_DATETIME from(
select 
id,
device_id ,
MESSAGE,
RECEPTION_DATETIME,
split_part(message,',',1) left_msg, 
lead(split_part(message,',',1)) over(partition by device_id order by id desc) as last_msg
FROM inbox i
where device_id in ('C23C')
--where device_id in ('80B2','89F9','891A','C22D','833B','61B8','81C9','8303','84AD','8918')
--where device_id in ('81AC','80DE','848D','C333','C265','8B53','C23D','B23F','C25D','C269','C22D','8B58','C24E','84DC','C236','C219','C246','8A41','858E','8762','8087','C2FA','8285','C2F9','C232','C263','8290','C226','C25E','815A','8326','87E9','825D','8168','8A3D','827D','C22C','81C9','86FE','8852','8B3A','8856','8404','8627','C334','8093','C2EE','C24C','89AB','8496','8529','8101','89F9','C2DE','8A6F','C220','866D','800F','C264','8306','C237','87AE','C253','8AFD','8601','83C0','8632','8008','853C','8742','8470','803B','8629','8659','8669','825B','C23B','83C4','85F3','8A3C','C241','8106','88C5','8A7E','88FD','C341','C229','C218','C22B','C25A','C243','C2F6','C2F7','C242','C22E','85BB','C258','8A40','C224','8031','C276','8263','87EF','80AD','869E','82C4','C251','C255','80B2','8A56','876E','C221','C249','850E','C268','C24A','C21F','8711','C256','812D','61B8','824F','8564','84BE','884A','8260','85AD','8451','8A6B','C330','823D','8633','8252','C2F2','C27D','C2E5','C2F5','801C','C210','84E5','C23C','C24F','C25C','82E2','8A6D','8303','8A1F','C26F','83AC','C20E','C257','C233','83EB','85BF','8918','8737','821D','8201','8148','8242','C25F','C22F','822A','C282','8862','C225','C222','80E2','C244','C214','C345','82F0','84AD','83E5','8595','8135','835F','8777','8A3E','8722','83D1','833B','8204','C332','C300','802B','84C0','8333','8500','8182','86D1','8078','C216','C227','C24B','C259','C234','C23F','C22A','C23A','898D','C21B','8459','814E','845E','C2EC','C217','87FD','C212','C213','C21A','C247','C270','C273','8660','81F7','8197','80C2','8582','891A','82C6','81B4','8092','816E','C250','8709','82FE','8A2E','839D','8ABB')
and (message ~ 'RUV0020' or MESSAGE ~'RUV0121')
and status <> 2
and RECEPTION_DATETIME > '2022-09-06'
group by id, message, device_id, RECEPTION_DATETIME
order by device_id
)as tabela
where left_msg = last_msg
order by  DEVICE_ID desc
--)select X.DEVICE_ID, count(*) from x
--group by device_id

