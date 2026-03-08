-- KPI's
--1.    Total Revenue
--2.    Average Order Value (AOV)
--3.    Total Pizza Sold
--4.    Total Orders
--5.    Average Pizza per Order


--1.    Total Revenue KPI
CREATE VIEW Total_Revenue AS(
WITH pizza_sales_revenue AS (
    SELECT
        pt.name AS pizza_name,
        o.order_id AS order_id,--  added order_id to ensure uniqueness of record to avoid duplicate entry
        p.price AS price,
        od.quantity AS qty,
        (p.price * od.quantity) AS revenue
    FROM
        pizza_types AS pt
    JOIN
        pizzas as p
    ON
        pt.pizza_type_id = p.pizza_type_id
    JOIN
        order_details AS od
    ON
        p.pizza_id = od.pizza_id
    JOIN
        orders AS O
    ON
        od.order_id = o.order_id
    ORDER BY
        od.quantity
    DESC
)
SELECT
    ROUND(SUM(revenue),2) AS Total_Revenue
FROM
    pizza_sales_revenue
);

SELECT
    *
FROM
    Total_Revenue;

--2.    Average Order Value (AOV) KPI
CREATE VIEW Average_Oder_Value AS(
WITH pizza_sales_revenue AS (
    SELECT
        pt.name AS pizza_name,
        o.order_id AS order_id, --  added order_id to ensure uniqueness of record to avoid duplicate entry
        p.price AS price,
        od.quantity AS qty,
        (p.price * od.quantity) AS revenue
    FROM
        pizza_types AS pt
    JOIN
        pizzas as p
    ON
        pt.pizza_type_id = p.pizza_type_id
    JOIN
        order_details AS od
    ON
        p.pizza_id = od.pizza_id
    JOIN
        orders AS O
    ON
        od.order_id = o.order_id
    ORDER BY
        od.quantity
    DESC
)
SELECT
    ROUND(SUM(revenue)/ COUNT(DISTINCT order_id), 2) AS AOV
FROM
    pizza_sales_revenue
);

SELECT
    *
FROM
    Average_Oder_Value;


--3.    Total Pizza Sold KPI
CREATE VIEW Total_Pizza_Sold AS(
SELECT
    SUM(quantity) AS total_pizza_sold
FROM
    order_details
);
SELECT
    *
FROM
    Total_Pizza_Sold;

--4.    Total Orders KPI
CREATE VIEW Total_Order AS(
SELECT
    COUNT(order_id) AS total_orders
FROM
    orders
);

SELECT
    *
FROM
    Total_Order;
    
--5.    Average Pizza per Order KPI
CREATE VIEW Average_Pizza_Per_Order AS(
SELECT
    ROUND(
        SUM(quantity) /
        COUNT(DISTINCT order_id),
        2
    ) AS average_pizza_per_order
FROM
    order_details
);

SELECT
    *
FROM
   Average_Pizza_Per_Order; 