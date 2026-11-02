CREATE DATABASE IF NOT EXISTS shopping;
USE shopping;

CREATE TABLE IF NOT EXISTS Orders (
    Order_ID INT PRIMARY KEY
);

INSERT IGNORE INTO Orders VALUES
(101),(102),(103),(104),(105);

CREATE TABLE IF NOT EXISTS Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Payment_Date DATE NOT NULL,
    Payment_Mode VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Transaction_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CHECK (Payment_Mode IN
    ('UPI','Credit Card','Debit Card','Net Banking','Cash on Delivery')),
    CHECK (Payment_Status IN ('Pending','Success','Failed')),
    CHECK (Transaction_Amount > 0)
);

INSERT INTO Payment VALUES
(1,101,'2026-10-01','UPI','Success',2500),
(2,102,'2026-10-02','Credit Card','Failed',3500),
(3,103,'2026-10-03','Debit Card','Success',1500),
(4,104,'2026-10-04','Net Banking','Pending',4000),
(5,105,'2026-10-05','Cash on Delivery','Success',2000);

SELECT * FROM Payment WHERE Payment_Status='Success';

SELECT * FROM Payment
WHERE Payment_Status IN ('Failed','Pending');

UPDATE Payment SET Payment_Status='Success'
WHERE Payment_ID=2;

SELECT Payment_Status,COUNT(*) AS Total
FROM Payment GROUP BY Payment_Status;

SELECT * FROM Payment WHERE Order_ID=101;

SELECT Payment_Mode,COUNT(*) AS Total
FROM Payment GROUP BY Payment_Mode;

SELECT Payment_Mode,COUNT(*) AS Total
FROM Payment GROUP BY Payment_Mode
ORDER BY Total DESC LIMIT 1;

SELECT SUM(Transaction_Amount) AS Revenue
FROM Payment WHERE Payment_Status='Success';

SELECT Payment_Mode,SUM(Transaction_Amount) AS Revenue
FROM Payment WHERE Payment_Status='Success'
GROUP BY Payment_Mode;

SELECT AVG(Transaction_Amount) AS Average_Amount
FROM Payment;

SELECT * FROM Payment p
JOIN Orders o ON p.Order_ID=o.Order_ID;

SELECT * FROM Payment
WHERE Payment_Status IN ('Failed','Pending');