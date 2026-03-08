-- Charts Analysis
--1.    Daily Trend for Total Orders
--2.    Hourly Trend for Total Orders
--3.    Monthly trend for total orders
--4.    Percentage of sales by pizza category
--5.    Percentage of sales by pizza size
--6.    Total pizza revenue Sold by Category
--7.    Top 5 Best sellers by revenue
--8.    Bottom 5 worst sellers by revenue



--1.    Daily Trend for Total Orders
CREATE VIEW vw_daily_order_trend AS (
SELECT 
    TO_CHAR(order_date, 'Day') as DOW, -- also use DATENAME(DW, datecolumn) wherendw is Day of Week'
    COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY
    DOW
ORDER BY
    total_orders
DESC
);

--2.    Hourly Trend for Total Orders
CREATE VIEW vw_hourly_order_trend AS(
SELECT
    EXTRACT(HOUR FROM order_time) as hour_of_day,
    COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY
    hour_of_day
ORDER BY
    total_orders
DESC
);

--3.    Monthly trend for total orders
CREATE VIEW vw_monthly_order_trend AS (
SELECT 
    TO_CHAR(order_date, 'Month') AS month,
    COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY
    month
ORDER BY
    total_orders
DESC
);

--4.    Percentage of sales by pizza category
CREATE VIEW vw_sales_percentage_by_category AS (
WITH category_sales AS(
    SELECT
        pt.category AS category,
        SUM(od.quantity * p.price) AS revenue
    FROM
        pizza_types AS pt
    JOIN
        pizzas AS p
    ON
        pt.pizza_type_id = p.pizza_type_id
    JOIN
        order_details AS od
    ON
        p.pizza_id = od.pizza_id
    GROUP BY
       pt.category
)


SELECT
    category,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS percent_of_sales
FROM 
    category_sales
);

--5.    Percentage of sales by pizza size
CREATE VIEW vw_sales_percentage_by_size AS (
WITH pizza_size_sales AS (
    SELECT 
        size,
        SUM(quantity * price) AS revenue
    FROM    
        pizzas
    JOIN
        order_details
    ON
        pizzas.pizza_id = order_details.pizza_id
    GROUP BY
        size
    ORDER BY
        revenue 
    DESC
)


SELECT
    size,
    revenue,
    ROUND(
        (revenue * 100) /
        SUM(revenue) OVER(), 
    2)AS pct_of_pizza_size_sold
FROM
    pizza_size_sales
);

--6.    Total Pizza revenue by Category
CREATE VIEW vw_revenue_by_pizza_category AS (
WITH category_sales AS(
    SELECT
        category,
        SUM(quantity * price) AS revenue
    FROM
        pizza_types
    JOIN
        pizzas
    ON
        pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN
        order_details
    ON
        pizzas.pizza_id = order_details.pizza_id
    GROUP BY
        category
    ORDER BY
        revenue
    DESC
)

SELECT 
    *
FROM
    category_sales
);

--7.    Top 5 Best sellers by revenue
CREATE VIEW vw_top5_pizzas_by_revenue AS(
WITH pizza_type_sales AS (
    SELECT
        name,
        SUM(quantity * price) AS revenue
    FROM
        pizza_types
    JOIN
        pizzas
    ON
        pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN
        order_details
    ON
        pizzas.pizza_id = order_details.pizza_id
    GROUP BY
        name
    ORDER BY
        revenue
    DESC
)
SELECT
    *
FROM
    pizza_type_sales
LIMIT
    5
);    
--8.    Bottom 5 worst sellers by revenue
CREATE VIEW vw_bottom5_pizzas_by_revenue AS (
WITH pizza_type_sales AS (
    SELECT
        name,
        SUM(quantity * price) AS revenue
    FROM
        pizza_types
    JOIN
        pizzas
    ON
        pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN
        order_details
    ON
        pizzas.pizza_id = order_details.pizza_id
    GROUP BY
        name
    ORDER BY
        revenue
    
)
SELECT
    *
FROM
    pizza_type_sales
LIMIT
    5
);