CREATE DATABASE ecommerce_customer_intelligence;
USE ecommerce_customer_intelligence;
SELECT DATABASE();
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    cost_price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),
    payment_amount DECIMAL(10,2),
    payment_status VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
CREATE TABLE customer_interactions (
    interaction_id INT PRIMARY KEY,
    customer_id INT,
    interaction_date DATE,
    interaction_type VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
SELECT
    TABLE_NAME,
    TABLE_ROWS
FROM information_schema.tables
WHERE table_schema = 'ecommerce_customer_intelligence';
SELECT
    TABLE_NAME,
    TABLE_ROWS
FROM information_schema.tables
WHERE table_schema = 'ecommerce_customer_intelligence';
INSERT INTO products
(product_id, product_name, category, sub_category, cost_price)
SELECT
    n,
    CONCAT(
        CASE MOD(n, 5)
            WHEN 0 THEN 'Laptop'
            WHEN 1 THEN 'Smartphone'
            WHEN 2 THEN 'Headphones'
            WHEN 3 THEN 'Monitor'
            ELSE 'Keyboard'
        END,
        ' Model ',
        n
    ),
    CASE MOD(n, 5)
        WHEN 0 THEN 'Electronics'
        WHEN 1 THEN 'Electronics'
        WHEN 2 THEN 'Accessories'
        WHEN 3 THEN 'Electronics'
        ELSE 'Accessories'
    END,
    CASE MOD(n, 5)
        WHEN 0 THEN 'Computers'
        WHEN 1 THEN 'Mobiles'
        WHEN 2 THEN 'Audio'
        WHEN 3 THEN 'Displays'
        ELSE 'Peripherals'
    END,
    ROUND(
        CASE MOD(n, 5)
            WHEN 0 THEN 35000 + RAND() * 65000
            WHEN 1 THEN 10000 + RAND() * 50000
            WHEN 2 THEN 1000 + RAND() * 7000
            WHEN 3 THEN 8000 + RAND() * 30000
            ELSE 800 + RAND() * 5000
        END,
        2
    )
FROM (
    SELECT ones.n + tens.n * 10 + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) tens
) numbers;
SELECT COUNT(*) AS total_products
FROM products;
SELECT * FROM products LIMIT 10;
INSERT INTO customers
(customer_id, customer_name, city, state, signup_date)
SELECT
    n,
    CONCAT('Customer ', n),
    CASE MOD(n, 10)
        WHEN 0 THEN 'Chennai'
        WHEN 1 THEN 'Coimbatore'
        WHEN 2 THEN 'Trichy'
        WHEN 3 THEN 'Madurai'
        WHEN 4 THEN 'Salem'
        WHEN 5 THEN 'Bangalore'
        WHEN 6 THEN 'Hyderabad'
        WHEN 7 THEN 'Mumbai'
        WHEN 8 THEN 'Pune'
        ELSE 'Delhi'
    END,
    CASE MOD(n, 10)
        WHEN 0 THEN 'Tamil Nadu'
        WHEN 1 THEN 'Tamil Nadu'
        WHEN 2 THEN 'Tamil Nadu'
        WHEN 3 THEN 'Tamil Nadu'
        WHEN 4 THEN 'Tamil Nadu'
        WHEN 5 THEN 'Karnataka'
        WHEN 6 THEN 'Telangana'
        WHEN 7 THEN 'Maharashtra'
        WHEN 8 THEN 'Maharashtra'
        ELSE 'Delhi'
    END,
    DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND(n) * 1000) DAY)
FROM (
    SELECT ones.n + tens.n * 10 + hundreds.n * 100 + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) hundreds
) numbers;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT MIN(customer_id) AS first_id,
       MAX(customer_id) AS last_id
FROM customers;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT * FROM customers LIMIT 10;
SELECT COUNT(*) AS total_orders
FROM orders;
INSERT INTO orders
(order_id, customer_id, order_date, order_status)
SELECT
    n,
    1 + MOD(n * 17, 1000),
    DATE_ADD('2024-01-01', INTERVAL MOD(n * 7, 730) DAY),
    CASE
        WHEN MOD(n, 10) = 0 THEN 'Cancelled'
        WHEN MOD(n, 10) = 1 THEN 'Returned'
        ELSE 'Completed'
    END
FROM (
    SELECT
        ones.n
        + tens.n * 10
        + hundreds.n * 100
        + thousands.n * 1000
        + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) hundreds
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4) thousands
) numbers
WHERE n <= 5000;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT *
FROM orders
LIMIT 10;
SELECT COUNT(*) AS total_order_items
FROM order_items;
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price, discount)
SELECT
    n,
    1 + MOD(n - 1, 5000),
    1 + MOD(n * 13, 100),
    1 + MOD(n * 7, 5),
    ROUND(500 + MOD(n * 137, 99500), 2),
    ROUND(MOD(n * 3, 21), 2)
FROM (
    SELECT
        ones.n
        + tens.n * 10
        + hundreds.n * 100
        + thousands.n * 1000
        + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) hundreds
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) thousands
) numbers
WHERE n <= 10000;
SELECT COUNT(*) AS total_order_items
FROM order_items;
SELECT *
FROM order_items
LIMIT 10;
SELECT COUNT(*) AS total_payments
FROM payments;
INSERT INTO payments
(payment_id, order_id, payment_method, payment_amount, payment_status)
SELECT
    n,
    n,
    CASE MOD(n, 4)
        WHEN 0 THEN 'UPI'
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Debit Card'
        ELSE 'Net Banking'
    END,
    ROUND(500 + MOD(n * 137, 99500), 2),
    CASE
        WHEN MOD(n, 10) = 0 THEN 'Failed'
        ELSE 'Paid'
    END
FROM (
    SELECT
        ones.n
        + tens.n * 10
        + hundreds.n * 100
        + thousands.n * 1000
        + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) hundreds
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4) thousands
) numbers
WHERE n <= 5000;
SELECT COUNT(*) AS total_payments
FROM payments;
SELECT *
FROM payments
LIMIT 10;
SELECT COUNT(*) AS total_interactions
FROM customer_interactions;
INSERT INTO customer_interactions
(interaction_id, customer_id, interaction_date, interaction_type)
SELECT
    n,
    1 + MOD(n * 23, 1000),
    DATE_ADD('2024-01-01', INTERVAL MOD(n * 11, 730) DAY),
    CASE MOD(n, 5)
        WHEN 0 THEN 'Website Visit'
        WHEN 1 THEN 'Product View'
        WHEN 2 THEN 'Support'
        WHEN 3 THEN 'Review'
        ELSE 'Complaint'
    END
FROM (
    SELECT
        ones.n
        + tens.n * 10
        + hundreds.n * 100
        + thousands.n * 1000
        + 1 AS n
    FROM
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) ones
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) tens
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) hundreds
    CROSS JOIN
        (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
         UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8 UNION ALL SELECT 9) thousands
) numbers
WHERE n <= 8000;
SELECT COUNT(*) AS total_interactions
FROM customer_interactions;
SELECT *
FROM customer_interactions
LIMIT 10;
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items
UNION ALL
SELECT 'payments', COUNT(*)
FROM payments
UNION ALL
SELECT 'customer_interactions', COUNT(*)
FROM customer_interactions;
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
SELECT oi.order_id, oi.product_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_id IS NULL
   OR p.product_id IS NULL;
SELECT
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ),
        2
    ) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';
SELECT
    ROUND(
        SUM(
            (
                oi.unit_price * oi.quantity *
                (1 - oi.discount / 100)
            )
            -
            (p.cost_price * oi.quantity)
        ),
        2
    ) AS total_profit
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';
SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ),
        2
    ) AS revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ),
        2
    ) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price * (1-oi.discount/100)
        ),2
    ) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id=o.customer_id
JOIN order_items oi
    ON o.order_id=oi.order_id
WHERE o.order_status='Completed'
GROUP BY c.customer_id,c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(
            oi.quantity*oi.unit_price*(1-oi.discount/100)
        ),2
    ) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id=o.customer_id
JOIN order_items oi
    ON o.order_id=oi.order_id
WHERE o.order_status='Completed'
GROUP BY c.customer_id,c.customer_name
ORDER BY lifetime_value DESC;
SELECT
CASE
    WHEN total_orders=1 THEN 'One-Time Customer'
    ELSE 'Repeat Customer'
END AS customer_type,
COUNT(*) AS customers
FROM(
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    WHERE order_status='Completed'
    GROUP BY customer_id
)t
GROUP BY customer_type;
SELECT
customer_segment,
COUNT(*) AS total_customers
FROM(
SELECT
c.customer_id,
CASE
WHEN SUM(oi.quantity*oi.unit_price*(1-oi.discount/100))>=300000
THEN 'High Value'

WHEN SUM(oi.quantity*oi.unit_price*(1-oi.discount/100))>=120000
THEN 'Medium Value'

ELSE 'Low Value'
END AS customer_segment

FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
WHERE o.order_status='Completed'
GROUP BY c.customer_id
)s
GROUP BY customer_segment;
SELECT
ROUND(
SUM(oi.quantity*oi.unit_price*(1-oi.discount/100))
/
COUNT(DISTINCT o.order_id),2
) AS average_order_value
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
WHERE o.order_status='Completed';
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price * (1 - oi.discount / 100)
        ), 2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price * (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_profit DESC
LIMIT 10;
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price * (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS profit,
    ROUND(
        (
            SUM(
                (oi.quantity * oi.unit_price * (1 - oi.discount / 100))
                -
                (oi.quantity * p.cost_price)
            )
            /
            SUM(
                oi.quantity * oi.unit_price * (1 - oi.discount / 100)
            )
        ) * 100,
        2
    ) AS profit_margin_percentage
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY profit_margin_percentage DESC;
SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price * (1 - oi.discount / 100)
        ), 2
    ) AS revenue,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price * (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(
            oi.quantity * oi.unit_price * (1 - oi.discount / 100)
        ) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)
SELECT
    product_id,
    product_name,
    category,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_sales;
SELECT MAX(order_date) AS latest_order_date
FROM orders;
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        c.customer_name,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    last_order_date,
    DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        last_order_date
    ) AS days_since_last_order
FROM customer_last_order
WHERE last_order_date IS NULL
   OR DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        last_order_date
   ) > 90
ORDER BY days_since_last_order DESC;
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY c.customer_id
)
SELECT
    COUNT(*) AS at_risk_customers
FROM customer_last_order
WHERE last_order_date IS NULL
   OR DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        last_order_date
   ) > 90;
   WITH customer_last_order AS (
    SELECT
        c.customer_id,
        c.customer_name,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    last_order_date,
    CASE
        WHEN last_order_date IS NULL THEN 'No Purchase'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 180 THEN 'High Risk'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 90 THEN 'Medium Risk'
        ELSE 'Active'
    END AS churn_risk
FROM customer_last_order;
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY c.customer_id
),
customer_risk AS (
    SELECT
        customer_id,
        CASE
            WHEN last_order_date IS NULL THEN 'No Purchase'
            WHEN DATEDIFF(
                (SELECT MAX(order_date) FROM orders),
                last_order_date
            ) > 180 THEN 'High Risk'
            WHEN DATEDIFF(
                (SELECT MAX(order_date) FROM orders),
                last_order_date
            ) > 90 THEN 'Medium Risk'
            ELSE 'Active'
        END AS churn_risk
    FROM customer_last_order
)
SELECT
    churn_risk,
    COUNT(*) AS customer_count
FROM customer_risk
GROUP BY churn_risk
ORDER BY customer_count DESC;
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        c.customer_name,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
),
customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.customer_id
)
SELECT
    clo.customer_id,
    clo.customer_name,
    clo.last_order_date,
    ROUND(COALESCE(cr.total_revenue, 0), 2) AS historical_revenue,
    DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        clo.last_order_date
    ) AS days_since_last_order
FROM customer_last_order clo
LEFT JOIN customer_revenue cr
    ON clo.customer_id = cr.customer_id
WHERE clo.last_order_date IS NULL
   OR DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        clo.last_order_date
   ) > 90
ORDER BY historical_revenue DESC;
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.customer_id) AS active_customers
FROM orders o
WHERE o.order_status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month;
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    DATE_FORMAT(first_order_date, '%Y-%m') AS first_purchase_month,
    COUNT(*) AS new_buying_customers
FROM first_purchase
GROUP BY DATE_FORMAT(first_order_date, '%Y-%m')
ORDER BY first_purchase_month;
WITH customer_monthly_orders AS (
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    order_month,
    COUNT(*) AS repeat_customers
FROM customer_monthly_orders
WHERE order_count > 1
GROUP BY order_month
ORDER BY order_month;
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
revenue_with_previous AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (
            (revenue - previous_month_revenue)
            / previous_month_revenue
        ) * 100,
        2
    ) AS mom_growth_percentage
FROM revenue_with_previous
ORDER BY month;
WITH customer_months AS (
    SELECT DISTINCT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month
    FROM orders
    WHERE order_status = 'Completed'
),
customer_month_count AS (
    SELECT
        customer_id,
        COUNT(*) AS active_months
    FROM customer_months
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_buying_customers,
    SUM(
        CASE
            WHEN active_months > 1 THEN 1
            ELSE 0
        END
    ) AS retained_customers,
    ROUND(
        SUM(
            CASE
                WHEN active_months > 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS retention_rate_percentage
FROM customer_month_count;
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_amount), 2) AS total_payment_amount
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_payment_amount DESC;
SELECT
    payment_status,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM payments),
        2
    ) AS percentage
FROM payments
GROUP BY payment_status;
SELECT
    payment_method,
    COUNT(*) AS failed_payments
FROM payments
WHERE payment_status = 'Failed'
GROUP BY payment_method
ORDER BY failed_payments DESC;
SELECT
    o.order_status,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        )
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status;
SELECT
    interaction_type,
    COUNT(*) AS interaction_count
FROM customer_interactions
GROUP BY interaction_type
ORDER BY interaction_count DESC;
SELECT
    ci.interaction_type,
    COUNT(DISTINCT ci.customer_id) AS unique_customers
FROM customer_interactions ci
GROUP BY ci.interaction_type
ORDER BY unique_customers DESC;
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(*) AS complaint_count
FROM customers c
JOIN customer_interactions ci
    ON c.customer_id = ci.customer_id
WHERE ci.interaction_type = 'Complaint'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(*) >= 2
ORDER BY complaint_count DESC;
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        ROUND(
            SUM(
                oi.quantity *
                oi.unit_price *
                (1 - oi.discount / 100)
            ), 2
        ) AS total_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM customer_revenue
ORDER BY revenue_rank;
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS total_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.city
),
ranked_customers AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY total_revenue DESC
        ) AS city_rank
    FROM customer_revenue
)
SELECT
    customer_id,
    customer_name,
    city,
    ROUND(total_revenue, 2) AS total_revenue,
    city_rank
FROM ranked_customers
WHERE city_rank <= 3
ORDER BY city, city_rank;
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (
            revenue - previous_month_revenue
        ) / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS growth_percentage
FROM comparison
ORDER BY month;
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY month;
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount / 100)
        ) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),
ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_revenue
)
SELECT
    product_id,
    product_name,
    category,
    ROUND(revenue, 2) AS revenue,
    category_rank
FROM ranked_products
WHERE category_rank <= 3
ORDER BY category, category_rank;
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ), 2
    ) AS total_revenue,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price *
             (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS total_profit,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ), 2
    ) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ), 2
    ) AS revenue,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price *
             (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Completed'
    GROUP BY c.customer_id
)
SELECT
    CASE
        WHEN last_order_date IS NULL THEN 'No Purchase'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 180 THEN 'High Risk'
        WHEN DATEDIFF(
            (SELECT MAX(order_date) FROM orders),
            last_order_date
        ) > 90 THEN 'Medium Risk'
        ELSE 'Active'
    END AS customer_status,
    COUNT(*) AS customer_count
FROM customer_last_order
GROUP BY customer_status;
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY order_status;
SELECT
    COUNT(DISTINCT o.order_id) AS completed_orders,
    COUNT(DISTINCT o.customer_id) AS buying_customers,

    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price *
             (1 - oi.discount / 100))
            -
            (oi.quantity * p.cost_price)
        ), 2
    ) AS profit,

    ROUND(
        SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount / 100)
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';
