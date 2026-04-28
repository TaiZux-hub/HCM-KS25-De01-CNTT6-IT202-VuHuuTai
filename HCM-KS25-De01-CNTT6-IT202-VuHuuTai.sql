
DROP DATABASE IF EXISTS salesManagement;
CREATE DATABASE salesManagement;
USE salesManagement;

CREATE TABLE products(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    nha_san_xuat VARCHAR(100) NOT NULL,
    price DECIMAL(18,2),
    product_stock INT
);

CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20),
    customer_address VARCHAR(250)
);

CREATE TABLE orders(
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL(18,2),
    customer_id INT,
    note TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_detail (
    order_id VARCHAR(10),
    product_id INT,
    quantity INT,
    price_at_time DECIMAL(18,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, nha_san_xuat, price, product_stock) VALUES
('MacBook Air M2','Apple',20000000,10),
('iPhone 15','Apple',25000000,5),
('Dell XPS 13','Dell',18000000,7),
('Asus ZenBook','Asus',15000000,8),
('Logitech Mouse','Logitech',500000,50);

INSERT INTO customers (customer_name, customer_email, customer_phone, customer_address) VALUES
('Nguyen Van A','a@gmail.com','0123456789','HN'),
('Tran Thi B','b@gmail.com',NULL,'HCM'),
('Le Van C','c@gmail.com','0456099324','DN'),
('Pham Van D','d@gmail.com','0789542376','HN'),
('Hoang Van E','e@gmail.com',NULL,'HCM');

INSERT INTO orders (order_id, order_date, total_amount, customer_id, note) VALUES
('DH001','2025-04-01',45000000,1,NULL),
('DH002','2025-04-02',18000000,3,NULL),
('DH003','2025-04-03',15000000,4,NULL),
('DH004','2025-04-04',500000,1,NULL),
('DH005','2025-04-05',18000000,3,NULL);

INSERT INTO order_detail VALUES
('DH001',1,1,20000000),
('DH001',2,1,25000000),
('DH002',3,1,18000000),
('DH003',4,1,15000000),
('DH004',5,1,500000),
('DH005',3,1,18000000);

SET SQL_SAFE_UPDATES = 0;

-- Tăng giá sản phẩm Apple 10%
UPDATE products
SET price = price * 1.1
WHERE nha_san_xuat = 'Apple';

DELETE FROM customers
WHERE customer_phone IS NULL
AND customer_id NOT IN (SELECT customer_id FROM orders);

SET SQL_SAFE_UPDATES = 1;


SELECT * FROM products;

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM order_detail;

SELECT * FROM products
WHERE price BETWEEN 10000000 AND 20000000;

SELECT p.product_name
FROM products p, order_detail od
WHERE p.product_id = od.product_id
AND od.order_id = 'DH001';

SELECT DISTINCT c.customer_name
FROM customers c, orders o, order_detail od, products p
WHERE c.customer_id = o.customer_id
AND o.order_id = od.order_id
AND od.product_id = p.product_id
AND p.product_name = 'MacBook Air M2';