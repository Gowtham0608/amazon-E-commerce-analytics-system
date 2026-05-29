create database amazon_db;
drop database amazon_db;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS customers;

-- 1. CUSTOMERS
CREATE TABLE customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email         VARCHAR(150) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    city          VARCHAR(50),
    country       VARCHAR(50)  DEFAULT 'India',
    signup_date   DATE,
    is_active     TINYINT DEFAULT 1
);

-- 2. SELLERS
CREATE TABLE sellers (
    seller_id      INT AUTO_INCREMENT PRIMARY KEY,
    seller_name    VARCHAR(100),
    email          VARCHAR(150) UNIQUE NOT NULL,
    category       VARCHAR(50),
    country        VARCHAR(50)  DEFAULT 'India',
    joined_date    DATE,
    account_status VARCHAR(20)  DEFAULT 'Active',
    rating         DECIMAL(3,2) DEFAULT 0.00
);

-- 3. PRODUCTS
CREATE TABLE products (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    seller_id      INT NOT NULL,
    product_name   VARCHAR(150) NOT NULL,
    category       VARCHAR(50),
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    is_listed      TINYINT DEFAULT 1,
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- 4. ORDERS
CREATE TABLE orders (
    order_id     INT           PRIMARY KEY,
    customer_id  INT           NOT NULL,
    order_date   DATE          NOT NULL,
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. ORDER ITEMS
CREATE TABLE order_items (
    item_id    INT AUTO_INCREMENT PRIMARY KEY,
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    discount   DECIMAL(5,2)  DEFAULT 0.00,
    CONSTRAINT fk_order   FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- SECTION 2 : DML — INSERT SAMPLE DATA
-- ============================================================

-- ── CUSTOMERS ────────────────────────────────────────────────
INSERT INTO customers
    (customer_id, customer_name, email, phone, city, country, signup_date)
VALUES
    (1, 'Ravi Kumar',   'ravi@mail.com',   '9876543210', 'Mumbai',    'India', '2024-01-10'),
    (2, 'Priya Singh',  'priya@mail.com',  '9123456780', 'Delhi',     'India', '2024-01-15'),
    (3, 'Amit Sharma',  'amit@mail.com',   '9988776655', 'Bangalore', 'India', '2024-02-01'),
    (4, 'Sunita Patel', 'sunita@mail.com', '9001122334', 'Chennai',   'India', '2024-02-14'),
    (5, 'John Lee',     'john@mail.com',   '9345678901', 'New York',  'USA',   '2024-03-05'),
    (6, 'Meena Rao',    'meena@mail.com',  '9456712345', 'Hyderabad', 'India', '2024-03-20');

-- ── SELLERS ──────────────────────────────────────────────────
INSERT INTO sellers
    (seller_id, seller_name, email, category, country, joined_date, account_status, rating)
VALUES
    (231, 'TechZone Store',  'techzone@sell.com', 'Electronics',   'India', '2023-01-05', 'Active',    4.50),
    (232, 'Fashion Hub',     'fashion@sell.com',  'Clothing',      'India', '2023-03-12', 'Active',    4.20),
    (233, 'Home Essentials', 'home@sell.com',     'Home & Kitchen','India', '2023-06-18', 'Active',    4.70),
    (234, 'GadgetWorld',     'gadget@sell.com',   'Electronics',   'USA',   '2023-08-01', 'Suspended', 2.80),
    (235, 'Book Palace',     'books@sell.com',    'Books',         'India', '2022-11-11', 'Active',    4.60);

-- ── PRODUCTS ─────────────────────────────────────────────────
INSERT INTO products
    (seller_id, product_name, category, price, stock_quantity)
VALUES
    (231, 'Bluetooth Headphones', 'Electronics',    2500.00, 150),
    (232, 'Men T-Shirt',          'Clothing',        499.00, 500),
    (233, 'Steel Water Bottle',   'Home & Kitchen',  350.00, 600),
    (231, 'Smart Watch',          'Electronics',    4500.00,  80),
    (235, 'Data Structures Book', 'Books',           650.00, 250),
    (231, 'Wireless Keyboard',    'Electronics',    1299.00, 120);

-- ── ORDERS ───────────────────────────────────────────────────
INSERT INTO orders
    (order_id, customer_id, order_date, order_status, total_amount)
VALUES
    (101, 1, '2024-01-20', 'Delivered', 3399.00),
    (102, 2, '2024-02-05', 'Delivered',  499.00),
    (103, 3, '2024-02-18', 'Returned',  2500.00),
    (104, 4, '2024-03-01', 'Cancelled',  350.00),
    (105, 5, '2024-03-15', 'Delivered', 5350.00),
    (106, 1, '2024-04-10', 'Delivered', 1598.00),
    (107, 2, '2024-04-25', 'Pending',    650.00),
    (108, 3, '2024-05-02', 'Delivered', 1200.00),
    (109, 4, '2024-05-20', 'Delivered', 4500.00),
    (110, 5, '2024-06-01', 'Returned',   799.00);

-- ── ORDER ITEMS ──────────────────────────────────────────────
INSERT INTO order_items
    (order_id, product_id, quantity, unit_price, discount)
VALUES
    (101, 1, 1, 2500.00,  0.00),   -- Bluetooth Headphones
    (101, 2, 2,  899.00,  5.00),   -- Men T-Shirt x2 with 5% off
    (102, 2, 1,  499.00,  0.00),   -- Men T-Shirt
    (103, 1, 1,  799.00, 10.00),   -- Headphones with 10% off (returned)
    (104, 3, 3,  350.00,  0.00),   -- Water Bottle x3 (cancelled)
    (105, 6, 1, 1200.00,  5.00),   -- Wireless Keyboard
    (106, 6, 1, 1299.00,  0.00),   -- Wireless Keyboard
    (107, 5, 1,  650.00,  0.00),   -- Data Structures Book (pending)
    (108, 3, 3,  350.00,  0.00),   -- Water Bottle x3
    (109, 4, 1, 4500.00,  0.00),   -- Smart Watch
    (110, 2, 1,  799.00,  0.00);   -- Men T-Shirt (returned)
    
    -- ============================================================
-- SECTION 3 : VERIFY DATA (Quick Checks)
-- ============================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'sellers' AS table_name, COUNT(*) AS row_count FROM sellers
UNION ALL
SELECT 'products' AS table_name, COUNT(*) AS row_count FROM products
UNION ALL
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'order_items' AS table_name, COUNT(*) AS row_count FROM order_items;



-- ============================================================BUSINESS QUESTIONS & SQL SOLUTIONS-- ============================================================

-- ────────────────────────────────────────────────────────────
-- Q1. What is the total revenue from all DELIVERED orders?
--     Concepts : SUM(), WHERE filter
-- ────────────────────────────────────────────────────────────
SELECT
    SUM(total_amount) AS total_delivered_revenue
FROM orders
WHERE order_status = 'Delivered';


-- ────────────────────────────────────────────────────────────
-- Q2. How many orders exist for each order status?
--     Concepts : COUNT(), GROUP BY, ORDER BY
-- ────────────────────────────────────────────────────────────
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ────────────────────────────────────────────────────────────
-- Q3. Who are the top 3 customers by total spending?
-- ────────────────────────────────────────────────────────────
SELECT
    c.customer_name,
    c.city,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 3;


-- ────────────────────────────────────────────────────────────
-- Q4. How many products does each seller have listed?
--     Concepts : LEFT JOIN (shows sellers with 0 products too),
--                COUNT(), GROUP BY
-- ────────────────────────────────────────────────────────────
SELECT
    s.seller_name,
    s.category        AS seller_category,
    s.account_status,
    COUNT(p.product_id) AS product_count
FROM sellers s
LEFT JOIN products p ON s.seller_id = p.seller_id
GROUP BY s.seller_id, s.seller_name, s.category, s.account_status
ORDER BY product_count DESC;


-- ────────────────────────────────────────────────────────────
-- Q5. What is the total revenue per product category?
-- ────────────────────────────────────────────────────────────
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- ────────────────────────────────────────────────────────────
-- Q6. What is the average order value per customer?
-- ────────────────────────────────────────────────────────────
SELECT
    c.customer_name,
    COUNT(o.order_id)                  AS num_orders,
    ROUND(AVG(o.total_amount), 2)      AS avg_order_value,
    SUM(o.total_amount)                AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY avg_order_value DESC;


-- ────────────────────────────────────────────────────────────
-- Q7. Which products have low stock (below 100 units)?
-- ────────────────────────────────────────────────────────────
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    s.seller_name,
    s.email AS seller_email
FROM products p
JOIN sellers s ON p.seller_id = s.seller_id
WHERE p.stock_quantity < 100
ORDER BY p.stock_quantity ASC;


-- ────────────────────────────────────────────────────────────
-- Q8. What is the monthly order count and revenue trend?
--     Concepts : DATE_FORMAT(), GROUP BY on date part,
--                time-series aggregation
-- ────────────────────────────────────────────────────────────
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id)                  AS total_orders,
    SUM(total_amount)                AS monthly_revenue,
    ROUND(AVG(total_amount), 2)      AS avg_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month ASC;


-- ────────────────────────────────────────────────────────────
-- Q9. Which seller has generated the highest total revenue?
-- ────────────────────────────────────────────────────────────
SELECT
    s.seller_name,
    s.rating,
    s.account_status,
    COUNT(DISTINCT o.order_id)                AS orders_fulfilled,
    SUM(oi.quantity * oi.unit_price)          AS gross_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price
              * (1 - oi.discount / 100)), 2)  AS net_revenue
FROM sellers s
JOIN products    p  ON s.seller_id  = p.seller_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders      o  ON oi.order_id  = o.order_id
GROUP BY s.seller_id, s.seller_name, s.rating, s.account_status
ORDER BY net_revenue DESC;


-- ────────────────────────────────────────────────────────────
-- Q10. Which customers have placed more than 1 order?
-- ────────────────────────────────────────────────────────────
SELECT
    c.customer_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.email, c.city
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

-- ────────────────────────────────────────────────────────────
-- Q11. Which city has the most customers?
-- ────────────────────────────────────────────────────────────
SELECT
    city,
    country,
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY city, country
ORDER BY customer_count DESC;

-- ────────────────────────────────────────────────────────────
-- Q12. Rank all customers by total spending (Window Function)
-- ────────────────────────────────────────────────────────────
SELECT
    customer_name,
    city,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.city
) AS customer_totals
ORDER BY spending_rank;

-- Q13. What is the return rate per seller?
-- ────────────────────────────────────────────────────────────
SELECT
    s.seller_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE
            WHEN o.order_status = 'Returned' THEN 1
            ELSE 0
        END) AS returned_orders,
    ROUND(
        SUM(CASE
                WHEN o.order_status = 'Returned' THEN 1
                ELSE 0
            END) * 100.0
        / COUNT(DISTINCT o.order_id),
    1) AS return_rate_pct
FROM sellers s
JOIN products p  ON s.seller_id  = p.seller_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o  ON oi.order_id  = o.order_id
GROUP BY s.seller_id, s.seller_name
ORDER BY return_rate_pct DESC;






    
    