--  Advanced SQL and Data Quality
-- Topics: HAVING, CASE, NULL handling, duplicate detection, deduplication

-- Exercise 1: Finding customers who spent more than 500

SELECT
    customers.name,
    SUM(orders.quantity * products.price) AS total_spent
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id
INNER JOIN products
    ON orders.product_id = products.product_id
GROUP BY customers.customer_id, customers.name
HAVING SUM(orders.quantity * products.price) > 500
ORDER BY total_spent DESC;

-- Exercise 2: Finding Finnish customers who spent more than 500

SELECT
    customers.name,
    SUM(orders.quantity * products.price) AS total_spent
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id
INNER JOIN products
    ON orders.product_id = products.product_id
WHERE customers.country = 'Finland'
GROUP BY customers.customer_id, customers.name
HAVING SUM(orders.quantity * products.price) > 500
ORDER BY total_spent DESC;

-- Exercise 3: Categorizing products by price

SELECT
    product_name,
    price,
    CASE
        WHEN price >= 500 THEN 'Expensive'
        WHEN price >= 100 THEN 'Moderate'
        ELSE 'Affordable'
    END AS price_category
FROM products
ORDER BY price DESC;


-- Exercise 4: Segmenting customers by total spending

WITH customer_spending AS (
    SELECT
        customers.name,
        SUM(orders.quantity * products.price) AS total_spent
    FROM orders
    INNER JOIN customers
        ON orders.customer_id = customers.customer_id
    INNER JOIN products
        ON orders.product_id = products.product_id
    GROUP BY customers.customer_id, customers.name
)
SELECT
    name,
    total_spent,
    CASE
        WHEN total_spent >= 1000 THEN 'High Value'
        WHEN total_spent >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spending
ORDER BY total_spent DESC;



-- Exercise 5: Finding customers with missing email addresses

SELECT
    customer_id,
    name,
    email
FROM customers
WHERE email IS NULL
ORDER BY customer_id;


-- Exercise 5.1: Displaying a default value for missing emails

SELECT
    customer_id,
    name,
    COALESCE(email, 'Not provided') AS email_status
FROM customers
ORDER BY customer_id;



-- Exercise 6: Detecting duplicate customer names

WITH sample_customers(name, country) AS (
    VALUES
        ('Aino Virtanen', 'Finland'),
        ('Erik Andersson', 'Sweden'),
        ('Aino Virtanen', 'Finland'),
        ('Mikko Korhonen', 'Finland'),
        ('Erik Andersson', 'Sweden')
)
SELECT
    name,
    COUNT(*) AS occurrence_count
FROM sample_customers
GROUP BY name
HAVING COUNT(*) > 1;



-- Exercise 7: Deduplicating customer records using ROW_NUMBER()

WITH sample_customers(record_id, name, country) AS (
    VALUES
        (101, 'Aino Virtanen', 'Finland'),
        (102, 'Erik Andersson', 'Sweden'),
        (103, 'Aino Virtanen', 'Finland'),
        (104, 'Mikko Korhonen', 'Finland'),
        (105, 'Erik Andersson', 'Sweden')
),
ranked_customers AS (
    SELECT
        record_id,
        name,
        country,
        ROW_NUMBER() OVER (
            PARTITION BY name
            ORDER BY record_id
        ) AS row_num
    FROM sample_customers
)
SELECT
    record_id,
    name,
    country
FROM ranked_customers
WHERE row_num = 1
ORDER BY record_id;