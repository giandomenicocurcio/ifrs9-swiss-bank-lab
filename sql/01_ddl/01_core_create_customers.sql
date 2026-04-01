-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name TEXT,
    country TEXT,
    risk_rating TEXT
);
INSERT INTO customers
VALUES (1, 'Mario Rossi', 'CH', 'Low'),
    (2, 'Anna Keller', 'DE', 'Medium'),
    (3, 'John Smith', 'US', 'High');
INSERT INTO customers
VALUES (4, 'Anna Kelleres', 'DE', 'Medium'),
    (5, 'Antonio Giacomelli', 'ITA', 'Low'),
    (6, 'Frank Meilan', 'CH', 'Low'),
    (7, 'Stephanie Volrein', 'CH', 'Low'),
    (8, 'Matiw Muller', 'CH', 'Low'),
    (9, 'Peter Meier', 'CH', 'Low'),
    (10, 'Daniel Schmidt', 'CH', 'Low');