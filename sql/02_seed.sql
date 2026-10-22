-- Add five customers
INSERT INTO customers (customer_id, name, country, email)
VALUES
     (1, 'Aino Virtanen', 'Finland', 'aino@example.com'),
    (2, 'Erik Andersson', 'Sweden', NULL),
    (3, 'Mikko Korhonen', 'Finland', NULL),
    (4, 'Sophie Müller', 'Germany', NULL),
    (5, 'Elin Karlsson', 'Sweden', NULL)
ON CONFLICT (customer_id) DO NOTHING;

-- Add four products
INSERT INTO products (product_id, product_name, price)
VALUES
    (1, 'Laptop', 1200.00),
    (2, 'Mouse', 25.00),
    (3, 'Keyboard', 80.00),
    (4, 'Monitor', 300.00);

-- Add ten orders
INSERT INTO orders (
    order_id,
    customer_id,
    product_id,
    quantity,
    order_date
)
VALUES
    (1, 1, 1, 1, '2026-01-05'),
    (2, 1, 2, 2, '2026-01-06'),
    (3, 2, 3, 1, '2026-01-07'),
    (4, 3, 4, 2, '2026-01-08'),
    (5, 2, 2, 3, '2026-01-09'),
    (6, 4, 1, 1, '2026-01-10'),
    (7, 5, 3, 2, '2026-01-11'),
    (8, 3, 2, 1, '2026-01-12'),
    (9, 1, 4, 1, '2026-01-13'),
    (10, 5, 2, 4, '2026-01-14');