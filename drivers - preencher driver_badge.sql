BEGIN
    FOR I IN (
      WITH
        w_parameters AS (
          SELECT 
            1 customer_child_id   --> inserir customer
          FROM dual
        ),
        w_customer_childs AS (
          SELECT cc.*
          FROM aero.customer_child cc
          INNER JOIN w_parameters wp ON (1 = 1)
          START WITH cc.customer_child_id = wp.customer_child_id
          CONNECT BY PRIOR cc.customer_child_id = cc.PARENT
        )
        SELECT
          D.driver_id,
          regexp_replace(TRIM(db.dallas_button_info),'EE0*','') new_driver_badge
          FROM aero.drivers D
          LEFT JOIN aero.active_customers_hierarchy cc ON cc.customer_child_id = D.customer_child_id
          LEFT JOIN aero.driver_dallas_buttons ddb ON D.driver_id=ddb.driver_id
          LEFT JOIN aero.dallas_buttons db ON ddb.dallas_button_id=db.dallas_button_id
        WHERE D.driver_status IN (1)
          AND db.dallas_button_info LIKE 'EE%'
          AND D.driver_firstname || ' ' || D.driver_lastname NOT LIKE 'Motorista%'
          AND D.customer_child_id IN (SELECT customer_child_id FROM w_customer_childs )

    )
    LOOP
        UPDATE aero.drivers SET driver_badge=i.new_driver_badge WHERE driver_id = I.driver_id;
    END LOOP;
    commit;
END;