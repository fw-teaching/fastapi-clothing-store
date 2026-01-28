-- ============================
-- DROP ALL TABLES
-- ============================

DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;


-- ============================
-- CREATE TABLES
-- ============================

-- Categories (just primary key)
CREATE TABLE IF NOT EXISTS categories (
    category_id SERIAL PRIMARY KEY
);

-- Products (primary key + foreign key)
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(category_id)
);

-- Customers (primary key)
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY
);

-- Orders (primary key + foreign key)
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id)
);

-- Order Items (primary key + foreign keys)
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id)
);

-- ============================
-- Add remaining columns
-- ============================

-- Categories
ALTER TABLE categories ADD COLUMN IF NOT EXISTS name VARCHAR NOT NULL;

-- Products
ALTER TABLE products ADD COLUMN IF NOT EXISTS name VARCHAR NOT NULL;
ALTER TABLE products ADD COLUMN IF NOT EXISTS price NUMERIC NOT NULL;
ALTER TABLE products ADD COLUMN IF NOT EXISTS stock INT NOT NULL;

-- Customers
ALTER TABLE customers ADD COLUMN IF NOT EXISTS first_name VARCHAR NOT NULL;
ALTER TABLE customers ADD COLUMN IF NOT EXISTS last_name VARCHAR NOT NULL;
ALTER TABLE customers ADD COLUMN IF NOT EXISTS email VARCHAR UNIQUE NOT NULL;

-- Orders
ALTER TABLE orders ADD COLUMN IF NOT EXISTS order_date DATE DEFAULT CURRENT_DATE;

-- Order Items
ALTER TABLE order_items ADD COLUMN IF NOT EXISTS quantity INT NOT NULL;

INSERT INTO categories (name) VALUES
('T-Shirts'),
('Jeans'),
('Shoes'),
('Accessories')
ON CONFLICT DO NOTHING;

INSERT INTO products (name, category_id, price, stock) VALUES
('Basic White T-Shirt', 1, 19.99, 100),
('Black Hoodie', 1, 39.99, 40),
('Graphic Tee', 1, 24.99, 60),
('Striped Polo Shirt', 1, 29.99, 50),
('Blue Denim Jeans', 2, 49.99, 50),
('Black Slim Jeans', 2, 59.99, 35),
('Grey Chinos', 2, 44.99, 45),
('Running Sneakers', 3, 89.99, 30),
('Leather Shoes', 3, 120.00, 20),
('Canvas Sneakers', 3, 69.99, 25),
('Leather Belt', 4, 29.99, 75),
('Wool Scarf', 4, 34.99, 40),
('Beanie Hat', 4, 19.99, 60),
('Sunglasses', 4, 49.99, 30)
ON CONFLICT DO NOTHING;

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Johnson', 'alice@example.com'),
('Bob', 'Smith', 'bob@example.com'),
('Carol', 'Davis', 'carol@example.com'),
('David', 'Brown', 'david@example.com'),
('Eva', 'Wilson', 'eva@example.com'),
('Frank', 'Miller', 'frank@example.com')
ON CONFLICT DO NOTHING;


INSERT INTO orders (customer_id, order_date) VALUES
(1,'2025-01-03'), (2,'2025-01-17'), (3,'2025-01-21'), (4,'2025-01-29'),
(5,'2025-02-04'), (6,'2025-02-11'), (1,'2025-02-19'), (2,'2025-02-27'),
(3,'2025-03-02'), (4,'2025-03-14'), (5,'2025-03-21'), (6,'2025-03-28'),
(1,'2025-04-05'), (2,'2025-04-12'), (3,'2025-04-18'), (4,'2025-04-26'),
(5,'2025-05-03'), (6,'2025-05-11'), (1,'2025-05-19'), (2,'2025-05-27'),
(3,'2025-06-04'), (4,'2025-06-09'), (5,'2025-06-17'), (6,'2025-06-25'),
(1,'2025-07-02'), (2,'2025-07-11'), (3,'2025-07-18'), (4,'2025-07-27'),
(5,'2025-08-05'), (6,'2025-08-09'), (1,'2025-08-17'), (2,'2025-08-24'),
(3,'2025-09-03'), (4,'2025-09-13'), (5,'2025-09-18'), (6,'2025-09-26'),
(1,'2025-10-04'), (2,'2025-10-10'), (3,'2025-10-19'), (4,'2025-10-28'),
(5,'2025-11-02'), (6,'2025-11-14'), (1,'2025-11-21'), (2,'2025-11-29'),
(3,'2025-12-03'), (4,'2025-12-12'), (5,'2025-12-18'), (6,'2025-12-27'),
(1,'2025-12-30')
ON CONFLICT DO NOTHING;

INSERT INTO order_items (order_id, product_id, quantity) VALUES
-- Orders 9–13
(9,1,2),(9,5,1),(9,8,1),(9,11,2),
(10,2,1),(10,6,1),(10,9,1),(10,12,2),
(11,3,2),(11,7,1),(11,10,1),(11,13,1),
(12,4,1),(12,5,2),(12,8,1),(12,14,1),
(13,1,1),(13,6,1),(13,9,2),(13,11,1),

-- Orders 14–18
(14,2,2),(14,7,1),(14,10,1),(14,12,1),
(15,3,1),(15,5,1),(15,8,2),(15,13,1),
(16,4,2),(16,6,1),(16,9,1),(16,14,1),
(17,1,1),(17,7,2),(17,10,1),(17,11,1),
(18,2,1),(18,5,2),(18,8,1),(18,12,1),

-- Orders 19–23
(19,3,2),(19,6,1),(19,9,1),(19,13,1),
(20,4,1),(20,7,1),(20,10,2),(20,14,1),
(21,1,2),(21,5,1),(21,8,1),(21,11,1),
(22,2,1),(22,6,2),(22,9,1),(22,12,1),
(23,3,1),(23,7,1),(23,10,1),(23,13,2),

-- Orders 24–28
(24,4,2),(24,5,1),(24,8,1),(24,14,1),
(25,1,1),(25,6,1),(25,9,2),(25,11,1),
(26,2,2),(26,7,1),(26,10,1),(26,12,1),
(27,3,1),(27,5,2),(27,8,1),(27,13,1),
(28,4,1),(28,6,1),(28,9,1),(28,14,2),

-- Orders 29–33
(29,1,2),(29,7,1),(29,10,1),(29,11,1),
(30,2,1),(30,5,1),(30,8,2),(30,12,1),
(31,3,2),(31,6,1),(31,9,1),(31,13,1),
(32,4,1),(32,7,2),(32,10,1),(32,14,1),
(33,1,1),(33,5,1),(33,8,1),(33,11,2),

-- Orders 34–49 (same pattern continues)
(34,2,2),(34,6,1),(34,9,1),(34,12,1),
(35,3,1),(35,7,1),(35,10,2),(35,13,1),
(36,4,2),(36,5,1),(36,8,1),(36,14,1),
(37,1,1),(37,6,2),(37,9,1),(37,11,1),
(38,2,1),(38,7,2),(38,10,1),(38,12,1),
(39,3,2),(39,5,1),(39,8,1),(39,13,1),
(40,4,1),(40,6,1),(40,9,2),(40,14,1),
(41,1,2),(41,7,1),(41,10,1),(41,11,1),
(42,2,1),(42,5,1),(42,8,2),(42,12,1),
(43,3,2),(43,6,1),(43,9,1),(43,13,1),
(44,4,1),(44,7,2),(44,10,1),(44,14,1),
(45,1,1),(45,5,1),(45,8,1),(45,11,2),
(46,2,2),(46,6,1),(46,9,1),(46,12,1),
(47,3,1),(47,7,1),(47,10,2),(47,13,1),
(48,4,2),(48,5,1),(48,8,1),(48,14,1),
(49,1,1),(49,6,2),(49,9,1),(49,11,1)
ON CONFLICT DO NOTHING;