 
CREATE TABLE IF NOT EXISTS customers 
(customer_id INTEGER PRIMARY KEY, 
name VARCHAR(100) NOT NULL, 
country VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY, product_name VARCHAR(100)
    NOT NULL, price NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (order_id INTEGER PRIMARY KEY,
customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
product_id INTEGER NOT NULL REFERENCES products(product_id),
quantity INTEGER NOT NULL CHECK (quantity > 0),
order_date DATE NOT NULL
);