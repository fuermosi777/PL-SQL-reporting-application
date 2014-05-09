--get initial data from order table
DECLARE
   v_order_id      orders.order_id%TYPE;
   v_order_date    orders.order_date%TYPE;
   v_order_mode      orders.order_mode%TYPE;
   v_customer_id    orders.customer_id%TYPE;
   v_order_status    orders.order_status%TYPE;
   v_order_total    orders.order_total%TYPE;
   v_sales_rep_id    orders.sales_rep_id%TYPE;
   v_promotion_id    orders.promotion_id%TYPE;
   CURSOR order_cur IS 
    SELECT * FROM
    orders
    WHERE rownum <= 1;
BEGIN
   OPEN order_cur;
   FETCH order_cur INTO v_order_id, v_order_date, v_order_mode, v_customer_id, v_order_status, v_order_total, v_sales_rep_id, v_promotion_id;
   IF (order_cur%NOTFOUND) THEN 
       :P3_order_id:=NULL;
       :P3_order_date:=NULL; 
       :P3_order_mode:=NULL;
       :P3_customer_id:=NULL;
       :P3_order_status:=NULL;
       :P3_order_total:=NULL;
       :P3_sales_rep_id:=NULL;
       :P3_promotion_id:=NULL;
    ELSE
       :P3_order_id:=v_order_id;
       :P3_order_date:=v_order_date; 
       :P3_order_mode:=v_order_mode;
       :P3_customer_id:=v_customer_id;
       :P3_order_status:=v_order_status;
       :P3_order_total:=v_order_total;
       :P3_sales_rep_id:=v_sales_rep_id;
       :P3_promotion_id:=v_promotion_id;
    END IF;
    CLOSE order_cur;
EXCEPTION
    WHEN OTHERS THEN
        IF (order_cur%ISOPEN) THEN CLOSE order_cur;
        END IF;
END;

--get data from select button
DECLARE
   v_order_id      orders.order_id%TYPE;
   v_order_date    orders.order_date%TYPE;
   v_order_mode      orders.order_mode%TYPE;
   v_customer_id    orders.customer_id%TYPE;
   v_order_status    orders.order_status%TYPE;
   v_order_total    orders.order_total%TYPE;
   v_sales_rep_id    orders.sales_rep_id%TYPE;
   v_promotion_id    orders.promotion_id%TYPE;
   TYPE gen_cv IS REF CURSOR;
   v_cv            gen_cv;
   v_statem        VARCHAR2(600);
BEGIN
    IF :GLOBAL100_ID='SELECT' THEN
    v_statem := 'SELECT * FROM
         orders
          WHERE order_id ='||:GLOBAL100_CUS_id;
       OPEN v_cv FOR v_statem;
   FETCH v_cv INTO v_order_id, v_order_date, v_order_mode, v_customer_id, v_order_status, v_order_total, v_sales_rep_id, v_promotion_id;
   IF (v_cv%NOTFOUND) THEN 
       :P3_order_id:=NULL;
       :P3_order_date:=NULL; 
       :P3_order_mode:=NULL;
       :P3_customer_id:=NULL;
       :P3_order_status:=NULL;
       :P3_order_total:=NULL;
       :P3_sales_rep_id:=NULL;
       :P3_promotion_id:=NULL;
    ELSE
       :P3_order_id:=v_order_id;
       :P3_order_date:=v_order_date; 
       :P3_order_mode:=v_order_mode;
       :P3_customer_id:=v_customer_id;
       :P3_order_status:=v_order_status;
       :P3_order_total:=v_order_total;
       :P3_sales_rep_id:=v_sales_rep_id;
       :P3_promotion_id:=v_promotion_id;
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

--get data from buttons
DECLARE
   v_order_id      orders.order_id%TYPE;
   v_order_date    orders.order_date%TYPE;
   v_order_mode      orders.order_mode%TYPE;
   v_customer_id    orders.customer_id%TYPE;
   v_order_status    orders.order_status%TYPE;
   v_order_total    orders.order_total%TYPE;
   v_sales_rep_id    orders.sales_rep_id%TYPE;
   v_promotion_id    orders.promotion_id%TYPE;
   CURSOR order_cur IS 
    SELECT * FROM
    orders
    WHERE order_id = :P3_order_id;
BEGIN
   OPEN order_cur;
   FETCH order_cur INTO v_order_id, v_order_date, v_order_mode, v_customer_id, v_order_status, v_order_total, v_sales_rep_id, v_promotion_id;
   IF (order_cur%NOTFOUND) THEN 
       :P3_order_id:=NULL;
       :P3_order_date:=NULL; 
       :P3_order_mode:=NULL;
       :P3_customer_id:=NULL;
       :P3_order_status:=NULL;
       :P3_order_total:=NULL;
       :P3_sales_rep_id:=NULL;
       :P3_promotion_id:=NULL;
    ELSE
       :P3_order_id:=v_order_id;
       :P3_order_date:=v_order_date; 
       :P3_order_mode:=v_order_mode;
       :P3_customer_id:=v_customer_id;
       :P3_order_status:=v_order_status;
       :P3_order_total:=v_order_total;
       :P3_sales_rep_id:=v_sales_rep_id;
       :P3_promotion_id:=v_promotion_id;
    END IF;
    CLOSE order_cur;
EXCEPTION
    WHEN OTHERS THEN
        IF (order_cur%ISOPEN) THEN CLOSE order_cur;
        END IF;
END;

--update orders
DECLARE
    CURSOR order_cur IS 
            SELECT *
            FROM orders o 
            WHERE order_id=:P3_order_id FOR UPDATE;
     o_not_done    EXCEPTION;
BEGIN
     OPEN order_cur;
     CLOSE order_cur;
     UPDATE orders o SET 
       o.order_id=:P3_order_id,
       o.order_date=:P3_order_date, 
       o.order_mode=:P3_order_mode,
       o.customer_id=:P3_customer_id,
       o.order_status=:P3_order_status,
       o.order_total=:P3_order_total,
       o.sales_rep_id=:P3_sales_rep_id,
       o.promotion_id=:P3_promotion_id
        WHERE o.order_id=:P3_order_id;
     IF (SQL%ROWCOUNT=0) THEN RAISE o_not_done;
     END IF;
     COMMIT;
EXCEPTION
     WHEN o_not_done THEN
          ROLLBACK;
          RAISE_APPLICATION_ERROR(-20009, 'No row found');
     WHEN OTHERS THEN
         ROLLBACK;
END;

--delete orders
DECLARE
    CURSOR order_cur IS SELECT * FROM orders WHERE order_id=:P3_order_id FOR UPDATE;
    o_not_found    EXCEPTION;
BEGIN
    OPEN order_cur;
    CLOSE order_cur;
    DELETE FROM orders WHERE order_id=:P3_order_id;
    IF (SQL%ROWCOUNT=0) THEN RAISE o_not_found;
    END IF;
    ROLLBACK; --I don't really want to delete that
EXCEPTION
    WHEN o_not_found THEN
       ROLLBACK;
       RAISE_APPLICATION_ERROR(-20008, 'Row not found');
    WHEN OTHERS THEN
       ROLLBACK;
END;

--get first or last order
DECLARE
   v_order_id      orders.order_id%TYPE;
   v_order_date    orders.order_date%TYPE;
   v_order_mode      orders.order_mode%TYPE;
   v_customer_id    orders.customer_id%TYPE;
   v_order_status    orders.order_status%TYPE;
   v_order_total    orders.order_total%TYPE;
   v_sales_rep_id    orders.sales_rep_id%TYPE;
   v_promotion_id    orders.promotion_id%TYPE;
   CURSOR order_cur IS 
    SELECT * FROM
    orders
    ORDER BY order_id;
BEGIN
   OPEN order_cur;
   FETCH order_cur INTO v_order_id, v_order_date, v_order_mode, v_customer_id, v_order_status, v_order_total, v_sales_rep_id, v_promotion_id;
   IF (order_cur%NOTFOUND) THEN 
       :P3_order_id:=NULL;
       :P3_order_date:=NULL; 
       :P3_order_mode:=NULL;
       :P3_customer_id:=NULL;
       :P3_order_status:=NULL;
       :P3_order_total:=NULL;
       :P3_sales_rep_id:=NULL;
       :P3_promotion_id:=NULL;
    ELSE
       :P3_order_id:=v_order_id;
       :P3_order_date:=v_order_date; 
       :P3_order_mode:=v_order_mode;
       :P3_customer_id:=v_customer_id;
       :P3_order_status:=v_order_status;
       :P3_order_total:=v_order_total;
       :P3_sales_rep_id:=v_sales_rep_id;
       :P3_promotion_id:=v_promotion_id;
    END IF;
    CLOSE order_cur;
EXCEPTION
    WHEN OTHERS THEN
        IF (order_cur%ISOPEN) THEN CLOSE order_cur;
        END IF;
END;