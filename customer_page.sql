/*
Get initial data from form
Used per session
*/
DECLARE
   v_customer_id      customers.customer_id%TYPE;
   v_cust_first_name    customers.cust_first_name%TYPE;
   v_cust_last_name      customers.cust_last_name%TYPE;
   v_cust_address_street_address    customers.cust_address.street_address%TYPE;
   v_cust_address_postal_code    customers.cust_address.postal_code%TYPE;
   v_cust_address_city    customers.cust_address.city%TYPE;
   v_cust_address_state_province    customers.cust_address.state_province%TYPE;
   v_cust_address_country_id    customers.cust_address.country_id%TYPE;
   v_phone_numbers      customers.phone_numbers%TYPE;
   v_nls_language     customers.nls_language%TYPE;
   v_nls_territory     customers.nls_territory%TYPE;
   v_credit_limit     customers.credit_limit%TYPE;
   v_cust_email     customers.cust_email%TYPE;
   v_account_mgr_id     customers.account_mgr_id%TYPE;
   TYPE gen_cv IS REF CURSOR;
   v_cv            gen_cv;
   v_statem        VARCHAR2(600);

BEGIN
      v_statem := '
          SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id
          FROM customers c
         WHERE rownum <=1 
         ORDER BY customer_id';
    OPEN v_cv FOR v_statem;
   FETCH v_cv INTO v_customer_id, v_cust_first_name, v_cust_last_name, v_cust_address_street_address, v_cust_address_postal_code, v_cust_address_city, v_cust_address_state_province, v_cust_address_country_id, v_phone_numbers, v_nls_language, v_nls_territory, v_credit_limit, v_cust_email, v_account_mgr_id;
   IF (v_cv%NOTFOUND) THEN 
       :P2_customer_id:=NULL;
       :P2_cust_first_name:=NULL; 
       :P2_cust_last_name:=NULL;
       :P2_cust_address_street_address:=NULL;
       :P2_cust_address_postal_code:=NULL;
       :P2_cust_address_city:=NULL;
       :P2_cust_address_state_province:=NULL;
       :P2_cust_address_country_id:=NULL;
       :P2_phone_numbers:=NULL;
       :P2_nls_language:=NULL;
       :P2_nls_territory:=NULL;
       :P2_credit_limit:=NULL;
       :P2_cust_email:=NULL;
       :P2_account_mgr_id:=NULL;
    ELSE
       :P2_customer_id:=v_customer_id;
       :P2_cust_first_name:=v_cust_first_name; 
       :P2_cust_last_name:=v_cust_last_name;
       :P2_cust_address_street_address:=v_cust_address_street_address;
       :P2_cust_address_postal_code:=v_cust_address_postal_code;
       :P2_cust_address_city:=v_cust_address_city;
       :P2_cust_address_state_province:=v_cust_address_state_province;
       :P2_cust_address_country_id:=v_cust_address_country_id;
       :P2_phone_numbers:=v_phone_numbers;
       :P2_nls_language:=v_nls_language;
       :P2_nls_territory:=v_nls_territory;
       :P2_credit_limit:=v_credit_limit;
       :P2_cust_email:=v_cust_email;
       :P2_account_mgr_id:=v_account_mgr_id;
    END IF;
    CLOSE v_cv;
    :GLOBAL100_ID:=NULL; 
    :GLOBAL100_CUS_ID:=NULL; 
EXCEPTION
    WHEN OTHERS THEN
        IF v_cv IS NOT NULL AND v_cv%ISOPEN THEN
            CLOSE v_cv;
        END IF;
END;

--get data from select button
DECLARE
   v_customer_id      customers.customer_id%TYPE;
   v_cust_first_name    customers.cust_first_name%TYPE;
   v_cust_last_name      customers.cust_last_name%TYPE;
   v_cust_address_street_address    customers.cust_address.street_address%TYPE;
   v_cust_address_postal_code    customers.cust_address.postal_code%TYPE;
   v_cust_address_city    customers.cust_address.city%TYPE;
   v_cust_address_state_province    customers.cust_address.state_province%TYPE;
   v_cust_address_country_id    customers.cust_address.country_id%TYPE;
   v_phone_numbers      customers.phone_numbers%TYPE;
   v_nls_language     customers.nls_language%TYPE;
   v_nls_territory     customers.nls_territory%TYPE;
   v_credit_limit     customers.credit_limit%TYPE;
   v_cust_email     customers.cust_email%TYPE;
   v_account_mgr_id     customers.account_mgr_id%TYPE;
   v_x      INTEGER(5);
   TYPE gen_cv IS REF CURSOR;
   v_cv            gen_cv;
   v_statem        VARCHAR2(600);

BEGIN
    IF :GLOBAL100_ID='SELECT' THEN
      v_statem := 'SELECT * FROM
          (
          SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id, ROWNUM r
          FROM customers c
          )
          WHERE customer_id ='||:GLOBAL100_CUS_id;
       OPEN v_cv FOR v_statem;
   FETCH v_cv INTO v_customer_id, v_cust_first_name, v_cust_last_name, v_cust_address_street_address, v_cust_address_postal_code, v_cust_address_city, v_cust_address_state_province, v_cust_address_country_id, v_phone_numbers, v_nls_language, v_nls_territory, v_credit_limit, v_cust_email, v_account_mgr_id, v_x;
   IF (v_cv%NOTFOUND) THEN 
       :P2_customer_id:=NULL;
       :P2_cust_first_name:=NULL; 
       :P2_cust_last_name:=NULL;
       :P2_cust_address_street_address:=NULL;
       :P2_cust_address_postal_code:=NULL;
       :P2_cust_address_city:=NULL;
       :P2_cust_address_state_province:=NULL;
       :P2_cust_address_country_id:=NULL;
       :P2_phone_numbers:=NULL;
       :P2_nls_language:=NULL;
       :P2_nls_territory:=NULL;
       :P2_credit_limit:=NULL;
       :P2_cust_email:=NULL;
       :P2_account_mgr_id:=NULL;
    ELSE
       :P2_customer_id:=v_customer_id;
       :P2_cust_first_name:=v_cust_first_name; 
       :P2_cust_last_name:=v_cust_last_name;
       :P2_cust_address_street_address:=v_cust_address_street_address;
       :P2_cust_address_postal_code:=v_cust_address_postal_code;
       :P2_cust_address_city:=v_cust_address_city;
       :P2_cust_address_state_province:=v_cust_address_state_province;
       :P2_cust_address_country_id:=v_cust_address_country_id;
       :P2_phone_numbers:=v_phone_numbers;
       :P2_nls_language:=v_nls_language;
       :P2_nls_territory:=v_nls_territory;
       :P2_credit_limit:=v_credit_limit;
       :P2_cust_email:=v_cust_email;
       :P2_account_mgr_id:=v_account_mgr_id;
    END IF;
    CLOSE v_cv;
    :GLOBAL100_ID:=NULL; 
    :GLOBAL100_CUS_ID:=NULL; 
          END IF;
   
EXCEPTION
    WHEN OTHERS THEN
        IF v_cv IS NOT NULL AND v_cv%ISOPEN THEN
            CLOSE v_cv;
        END IF;
END;

--get data from "next" and "previous" buttons
DECLARE
   v_customer_id      customers.customer_id%TYPE;
   v_cust_first_name    customers.cust_first_name%TYPE;
   v_cust_last_name      customers.cust_last_name%TYPE;
   v_cust_address_street_address    customers.cust_address.street_address%TYPE;
   v_cust_address_postal_code    customers.cust_address.postal_code%TYPE;
   v_cust_address_city    customers.cust_address.city%TYPE;
   v_cust_address_state_province    customers.cust_address.state_province%TYPE;
   v_cust_address_country_id    customers.cust_address.country_id%TYPE;
   v_phone_numbers      customers.phone_numbers%TYPE;
   v_nls_language     customers.nls_language%TYPE;
   v_nls_territory     customers.nls_territory%TYPE;
   v_credit_limit     customers.credit_limit%TYPE;
   v_cust_email     customers.cust_email%TYPE;
   v_account_mgr_id     customers.account_mgr_id%TYPE;
   TYPE gen_cv IS REF CURSOR;
   v_cv            gen_cv;
   v_statem        VARCHAR2(600);

BEGIN
    IF :GLOBAL100_ID='SELECT' THEN
      v_statem := '
          SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id
          FROM customers c
          WHERE customer_id ='||:GLOBAL100_CUS_id;
      ELSE
      v_statem := '
          SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id
          FROM customers c
          
          WHERE customer_id = '||:P2_customer_id;
          END IF;
    OPEN v_cv FOR v_statem;
   FETCH v_cv INTO v_customer_id, v_cust_first_name, v_cust_last_name, v_cust_address_street_address, v_cust_address_postal_code, v_cust_address_city, v_cust_address_state_province, v_cust_address_country_id, v_phone_numbers, v_nls_language, v_nls_territory, v_credit_limit, v_cust_email, v_account_mgr_id;
   IF (v_cv%NOTFOUND) THEN 
       :P2_customer_id:=NULL;
       :P2_cust_first_name:=NULL; 
       :P2_cust_last_name:=NULL;
       :P2_cust_address_street_address:=NULL;
       :P2_cust_address_postal_code:=NULL;
       :P2_cust_address_city:=NULL;
       :P2_cust_address_state_province:=NULL;
       :P2_cust_address_country_id:=NULL;
       :P2_phone_numbers:=NULL;
       :P2_nls_language:=NULL;
       :P2_nls_territory:=NULL;
       :P2_credit_limit:=NULL;
       :P2_cust_email:=NULL;
       :P2_account_mgr_id:=NULL;
    ELSE
       :P2_customer_id:=v_customer_id;
       :P2_cust_first_name:=v_cust_first_name; 
       :P2_cust_last_name:=v_cust_last_name;
       :P2_cust_address_street_address:=v_cust_address_street_address;
       :P2_cust_address_postal_code:=v_cust_address_postal_code;
       :P2_cust_address_city:=v_cust_address_city;
       :P2_cust_address_state_province:=v_cust_address_state_province;
       :P2_cust_address_country_id:=v_cust_address_country_id;
       :P2_phone_numbers:=v_phone_numbers;
       :P2_nls_language:=v_nls_language;
       :P2_nls_territory:=v_nls_territory;
       :P2_credit_limit:=v_credit_limit;
       :P2_cust_email:=v_cust_email;
       :P2_account_mgr_id:=v_account_mgr_id;
    END IF;
    CLOSE v_cv;
    :GLOBAL100_ID:=NULL; 
    :GLOBAL100_CUS_ID:=NULL; 
EXCEPTION
    WHEN OTHERS THEN
        IF v_cv IS NOT NULL AND v_cv%ISOPEN THEN
            CLOSE v_cv;
        END IF;
END;

--validation: check before delete(if there is order for the customer, then no delete is allowed)
DECLARE
   v_order_id    orders.order_id%TYPE;
   CURSOR customer_cur IS
      SELECT o.order_id
    FROM orders o, customers c
    WHERE o.customer_id = c.customer_id
    AND
        c.customer_id = :P2_customer_id
    AND 
        ROWNUM <= 1;
BEGIN
  OPEN customer_cur;
  FETCH customer_cur INTO v_order_id;
    IF (v_order_id IS NULL) 
    THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  CLOSE customer_cur;
END;

--update customer process
DECLARE
    CURSOR customer_cur IS 
            SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id
            FROM customers c 
            WHERE customer_id=:P2_customer_id FOR UPDATE;
     c_not_done    EXCEPTION;
BEGIN
     OPEN customer_cur;
     CLOSE customer_cur;
     UPDATE customers c SET 
           c.cust_first_name=:P2_cust_first_name, 
           c.cust_last_name=:P2_cust_last_name,
           c.cust_address.street_address=:P2_cust_address_street_address,
           c.cust_address.postal_code=:P2_cust_address_postal_code,
           c.cust_address.city=:P2_cust_address_city,
           c.cust_address.state_province=:P2_cust_address_state_province,
           c.cust_address.country_id=:P2_cust_address_country_id,
           c.phone_numbers=:P2_phone_numbers,
           c.nls_language=:P2_nls_language,
           c.nls_territory=:P2_nls_territory,
           c.credit_limit=:P2_credit_limit,
           c.cust_email=:P2_cust_email,
           c.account_mgr_id=:P2_account_mgr_id
        WHERE c.customer_id=:P2_customer_id;
     IF (SQL%ROWCOUNT=0) THEN RAISE c_not_done;
     END IF;
     COMMIT;
EXCEPTION
     WHEN c_not_done THEN
          ROLLBACK;
          RAISE_APPLICATION_ERROR(-20009, 'No row found');
     WHEN OTHERS THEN
         ROLLBACK;
END;

--delete customer process
DECLARE
    CURSOR customer_cur IS SELECT * FROM customers WHERE customer_id=:P2_customer_id FOR UPDATE;
    c_not_found    EXCEPTION;
BEGIN
    OPEN customer_cur;
    CLOSE customer_cur;
    DELETE FROM customers WHERE customer_id=:P2_customer_id;
    IF (SQL%ROWCOUNT=0) THEN RAISE c_not_found;
    END IF;
    ROLLBACK; --I don't want to delete that
EXCEPTION
    WHEN c_not_found THEN
       ROLLBACK;
       RAISE_APPLICATION_ERROR(-20008, 'Row not found');
    WHEN OTHERS THEN
       ROLLBACK;
END;
--use to delete customer when "delete button" clicked by Hao Liu

--select first or last customer in the form
DECLARE
   v_customer_id      customers.customer_id%TYPE;
   v_cust_first_name    customers.cust_first_name%TYPE;
   v_cust_last_name      customers.cust_last_name%TYPE;
   v_cust_address_street_address    customers.cust_address.street_address%TYPE;
   v_cust_address_postal_code    customers.cust_address.postal_code%TYPE;
   v_cust_address_city    customers.cust_address.city%TYPE;
   v_cust_address_state_province    customers.cust_address.state_province%TYPE;
   v_cust_address_country_id    customers.cust_address.country_id%TYPE;
   v_phone_numbers      customers.phone_numbers%TYPE;
   v_nls_language     customers.nls_language%TYPE;
   v_nls_territory     customers.nls_territory%TYPE;
   v_credit_limit     customers.credit_limit%TYPE;
   v_cust_email     customers.cust_email%TYPE;
   v_account_mgr_id     customers.account_mgr_id%TYPE;
   CURSOR customer_cur IS 

    SELECT customer_id, cust_first_name, cust_last_name, (cust_address).street_address, (cust_address).postal_code, (cust_address).city, (cust_address).state_province, (cust_address).country_id, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id
    FROM customers c
    ORDER BY customer_id;
BEGIN
   OPEN customer_cur;
   FETCH customer_cur INTO v_customer_id, v_cust_first_name, v_cust_last_name, v_cust_address_street_address, v_cust_address_postal_code, v_cust_address_city, v_cust_address_state_province, v_cust_address_country_id, v_phone_numbers, v_nls_language, v_nls_territory, v_credit_limit, v_cust_email, v_account_mgr_id;
   IF (customer_cur%NOTFOUND) THEN 
       :P2_customer_id:=NULL;
       :P2_cust_first_name:=NULL; 
       :P2_cust_last_name:=NULL;
       :P2_cust_address_street_address:=NULL;
       :P2_cust_address_postal_code:=NULL;
       :P2_cust_address_city:=NULL;
       :P2_cust_address_state_province:=NULL;
       :P2_cust_address_country_id:=NULL;
       :P2_phone_numbers:=NULL;
       :P2_nls_language:=NULL;
       :P2_nls_territory:=NULL;
       :P2_credit_limit:=NULL;
       :P2_cust_email:=NULL;
       :P2_account_mgr_id:=NULL;
    ELSE
       :P2_customer_id:=v_customer_id;
       :P2_cust_first_name:=v_cust_first_name; 
       :P2_cust_last_name:=v_cust_last_name;
       :P2_cust_address_street_address:=v_cust_address_street_address;
       :P2_cust_address_postal_code:=v_cust_address_postal_code;
       :P2_cust_address_city:=v_cust_address_city;
       :P2_cust_address_state_province:=v_cust_address_state_province;
       :P2_cust_address_country_id:=v_cust_address_country_id;
       :P2_phone_numbers:=v_phone_numbers;
       :P2_nls_language:=v_nls_language;
       :P2_nls_territory:=v_nls_territory;
       :P2_credit_limit:=v_credit_limit;
       :P2_cust_email:=v_cust_email;
       :P2_account_mgr_id:=v_account_mgr_id;
    END IF;
    CLOSE customer_cur;
EXCEPTION
    WHEN OTHERS THEN
        IF (customer_cur%ISOPEN) THEN CLOSE customer_cur;
        END IF;
END;