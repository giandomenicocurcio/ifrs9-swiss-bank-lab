--Accounts

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance NUMERIC,
    currency TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO accounts VALUES
(1001, 1, 12000, 'CHF'),
(1002, 1, 5000, 'EUR'),
(2001, 2, 8000, 'CHF'),
(3001, 3, 15000, 'CHF');

INSERT INTO accounts VALUES
(4001, 4, 25000, 'CHF'),
(5001, 5, 115000, 'CHF'),
(6001, 6, 235000, 'CHF'),
(7001, 7, 85000, 'CHF'),
(8001, 8, 35000, 'CHF'),
(9001, 9, 6000, 'CHF'),
(10001, 10, 50000, 'CHF');


