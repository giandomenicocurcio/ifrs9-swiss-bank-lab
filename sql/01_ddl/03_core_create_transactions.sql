--Transactions

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount NUMERIC,
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions VALUES
(1, 1001, 500, '2026-01-10'),
(2, 1001, -200, '2026-01-12'),
(3, 1002, 300, '2026-01-15'),
(4, 2001, 1000, '2026-01-18'),
(5, 3001, -500, '2026-01-20');

INSERT INTO transactions VALUES
(6, 4001, -8500, '2026-01-20'),
(7, 5001, -550, '2026-01-20'),
(8, 6001, -500, '2026-01-20'),
(9, 7001, -5000, '2026-01-20'),
(10, 8001, 15500, '2026-01-20'),
(11, 9001, -6500, '2026-01-20'),
(12, 10001, -4500, '2026-01-20');








