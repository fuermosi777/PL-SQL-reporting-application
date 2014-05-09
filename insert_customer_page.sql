DECLARE
    http_req   UTL_HTTP.REQ;  --Needed for Mule
    http_resp  utl_http.resp; --Needed for Mule
     v_msg      VARCHAR2(2000); --Needed for Mule

BEGIN
    INSERT INTO customers 
    ( customer_id, cust_first_name, cust_last_name, cust_address, phone_numbers, nls_language, nls_territory, credit_limit, cust_email, account_mgr_id )
    VALUES 
    ( :P2_customer_id, :P2_cust_first_name, :P2_cust_last_name, CUST_ADDRESS_TYP(
        :P2_cust_address_street_address,
        :P2_cust_address_postal_code,
        :P2_cust_address_city,
        :P2_cust_address_state_province,
        :P2_cust_address_country_id), 
    :P2_phone_numbers,
    :P2_nls_language,
    :P2_nls_territory,
    :P2_credit_limit,
    :P2_cust_email,
    :P2_account_mgr_id );
        http_req:=UTL_HTTP.BEGIN_REQUEST('http://127.0.0.1:8086/newcustomer?customer_id='||:P2_customer_id||'&cust_first_name='||:P2_cust_first_name||'&cust_last_name='||:P2_cust_last_name||'&phone_numbers='||:P2_phone_numbers||'&nls_language='||:P2_nls_language||'&nls_territory='||:P2_nls_territory||'&credit_limit=:P2_credit_limit'||'&cust_email=:P2_cust_email'||'&account_mgr_id=:P2_account_mgr_id');  --Needed for Mule
    http_resp := utl_http.get_response(r => http_req); --Needed for Mule
    UTL_HTTP.read_text(r => http_resp, data => v_msg); --Needed for Mule
    COMMIT;
END;