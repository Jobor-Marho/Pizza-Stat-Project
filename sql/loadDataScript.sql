-- Load CSV to database table
-- 1.  Order
-- 2.  Pizza Type
-- 3.  Pizza
-- 4.  Order Details

-- 1.  Order
COPY 
    orders 
FROM 
    'C:/pgdata/orders.csv' 
DELIMITER ',' 
CSV HEADER;


-- 2.  Pizza Type
COPY 
    pizza_types 
FROM 
    'C:/pgdata/pizza_types.csv' 
DELIMITER ',' 
CSV HEADER;


-- 3.  Pizza
COPY 
   pizzas 
FROM 
    'C:/pgdata/pizzas.csv' 
DELIMITER ',' 
CSV HEADER;


-- 4.  Order Details
COPY 
   order_details 
FROM 
    'C:/pgdata/order_details.csv' 
DELIMITER ',' 
CSV HEADER;