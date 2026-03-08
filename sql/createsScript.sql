-- Table creation queries
-- 1.  Order
-- 2.  Pizza Type
-- 3.  Pizza
-- 4.  Order Details


-- **************************************************************************************************************
--1.    Order Table
CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);
-- **************************************************************************************************************
--2.    Pizza Type table
CREATE TABLE pizza_types(
    pizza_type_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(20) NOT NULL,
    ingredients TEXT NOT NULL
);

-- **************************************************************************************************************
--3.    Pizza table
CREATE TABLE pizzas(
    pizza_id VARCHAR(20) PRIMARY KEY,
    pizza_type_id VARCHAR(20) REFERENCES pizza_types(pizza_type_id) NOT NULL,
    size VARCHAR(5) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    CONSTRAINT pizza_check_size CHECK(size in ('S', 'M', 'L', 'XXL', 'XL'))

);
-- **************************************************************************************************************

--4.    order details
CREATE TABLE order_details(
    order_detail_id INT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE, -- <- Upon deletion of this record, subsequent definition/references will be deleted hence (CASCADE).
    pizza_id VARCHAR(20) REFERENCES pizzas(pizza_id) NOT NULL,
    quantity INT NOT NULL
);
-- **************************************************************************************************************

