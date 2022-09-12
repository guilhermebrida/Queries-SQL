select owner,table_name from all_tab_columns where upper(column_name) like upper('%CHECKLIST%');

SELECT DISTINCT (DESCRIPTION) FROM CHECKLIST.QUESTIONNAIRES q 

SELECT * FROM aero.HARDWARE_CONFIG hc 

SELECT * FROM aero.ASSET_TYPES at2 

SELECT * FROM aero.ASSETS a 


SELECT
--*
ach.CUSTOMER_CHILD_ID ,
ach.MATRIZ ,
ck.ASSET_ID ,
ck.CHECKLIST_ID ,
q.description,
a.ASSET_ID ,
a.ASSET_TYPE_ID ,
at2.DESCRIPTION 
FROM
CHECKLIST.CHECKLISTS ck
LEFT JOIN checklist.checklist_attachments ct ON ck.checklist_id = ct.checklist_id
LEFT JOIN checklist.checklist_answers ca ON ct.checklist_id = ca.checklist_id
LEFT JOIN checklist.answer_attachments cat ON ca.answer_id = cat.answer_id 
JOIN CHECKLIST.QUESTIONNAIRES q ON ck.QUESTIONNAIRE_ID = q.QUESTIONNAIRE_ID
JOIN aero.ACTIVE_CUSTOMERS_HIERARCHY ach ON ach.CUSTOMER_CHILD_ID = q.CUSTOMER_CHILD_ID 
JOIN aero.ASSETS a ON ach.CUSTOMER_CHILD_ID = a.CUSTOMER_CHILD_ID 
JOIN aero.ASSET_TYPES at2 ON a.ASSET_TYPE_ID  = at2.ASSET_TYPE_ID 
