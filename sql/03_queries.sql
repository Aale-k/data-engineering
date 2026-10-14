-- Exercise 1: Customers from Finland
SELECT
    name,
    country
FROM customers
WHERE country = 'Finland';



-- Exercise 2: Orders with customer names
SELECT
    orders.order_id,
    customers.name,
    orders.order_date
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id
ORDER BY orders.order_date;



-- Exercise 3: Calculate total revenue
SELECT
    SUM(orders.quantity * products.price) AS total_revenue
FROM orders
INNER JOIN products
    ON orders.product_id = products.product_id;



-- Exercise 4: Calculate total spending per customer
    SELECT
    customers.name,
    SUM(orders.quantity * products.price) AS total_spent
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id
INNER JOIN products
    ON orders.product_id = products.product_id
GROUP BY customers.customer_id, customers.name
ORDER BY total_spent DESC;



-- Exercise 5: Rank customers by total spending
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
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_spending
ORDER BY spending_rank;



-- Exercise 6: Calculate cumulative revenue over time
SELECT
    orders.order_id,
    orders.order_date,
    orders.quantity * products.price AS order_revenue,
    SUM(orders.quantity * products.price) OVER (
        ORDER BY orders.order_date, orders.order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM orders
INNER JOIN products
    ON orders.product_id = products.product_id
ORDER BY orders.order_date, orders.order_id;