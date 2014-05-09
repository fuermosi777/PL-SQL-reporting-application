DECLARE
   v_result    VARCHAR2(600) DEFAULT 'SELECT APEX_ITEM.RADIOGROUP(1, customer_id, ''1'', '''') "Select", customer_id, name, order_total, order_date
FROM (
    SELECT c.customer_id, concat(cust_first_name, concat('' '', cust_last_name)) AS name, order_total, order_date
    FROM customers c, orders o
    WHERE c.customer_id = o.customer_id) vv
INNER JOIN
    (SELECT name as name1, MAX(order_date) AS MaxDate --subquery used to add the max value
    FROM v_customers
    GROUP BY name) groupvv 
ON vv.name = groupvv.name1
AND vv.order_date = groupvv.MaxDate ';

BEGIN
    IF :P14_CUSTOMER_SEARCH IS NOT NULL THEN
       IF :P14_LIST='Customer ID' THEN 
            v_result:=v_result||'WHERE customer_id LIKE ''%'||:P14_CUSTOMER_SEARCH||'%''';
        ELSIF :P14_LIST='Order Total' THEN 
            v_result:=v_result||'WHERE order_total LIKE ''%'||:P14_CUSTOMER_SEARCH||'%''';
        ELSIF :P14_LIST='Customer Name' THEN 
            v_result:=v_result||'WHERE name LIKE ''%'||:P14_CUSTOMER_SEARCH||'%''';
        ELSIF :P14_LIST='Lastest Order Date' THEN 
            v_result:=v_result||'WHERE order_date LIKE ''%'||:P14_CUSTOMER_SEARCH||'%''';
        ELSE 
            v_result:=v_result||'WHERE name LIKE ''%'||:P14_CUSTOMER_SEARCH||'%''';
         END IF;
    END IF;
    RETURN v_result;
END;

--search process
DECLARE 
    v_radio         VARCHAR2(100) DEFAULT NULL;
    c_not_selected  EXCEPTION;
    c_none_found    EXCEPTION;
BEGIN
    IF APEX_APPLICATION.G_F01.COUNT<1 THEN
        RAISE c_none_found;
    END IF;
    FOR i IN 1..APEX_APPLICATION.G_F01.COUNT LOOP 
        v_radio:=APEX_APPLICATION.G_F01(i); 
        IF v_radio IS NOT NULL THEN 
            :GLOBAL100_CUS_ID:=v_radio;
            EXIT;
        END IF;
    END LOOP;
    APEX_UTIL.CLEAR_PAGE_CACHE('14');
    IF (v_radio IS NULL) THEN 
        RAISE c_not_selected;
    ELSE 
       :P14_CUSTOMER_SEARCH:=NULL;
       :GLOBAL100_ID:='SELECT';
    END IF;

EXCEPTION
   WHEN c_not_selected THEN
       RAISE_APPLICATION_ERROR(-20002,'No customer was selected.');
   WHEN c_none_found THEN
       RAISE_APPLICATION_ERROR(-20003,'No customers were found to select from.');
END;
