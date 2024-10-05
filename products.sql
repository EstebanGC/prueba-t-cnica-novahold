CREATE DATABASE IF NOT EXISTS products;

USE products;

CREATE TABLE IF NOT EXISTS product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    available BOOLEAN NOT NULL,
    min_units INT NOT NULL,
    max_units INT NOT NULL
);

INSERT INTO product (name, available, min_units, max_units) VALUES
('Product A', true, 10, 50),
('Product B', false, 5, 20),
('Product C', true, 1, 15),
('Product D', true, 3, 30),
('Product E', false, 8, 40),
('Product F', true, 2, 25),
('Product G', true, 12, 60),
('Product H', false, 7, 35),
('Product I', true, 4, 22),
('Product J', true, 6, 28);
