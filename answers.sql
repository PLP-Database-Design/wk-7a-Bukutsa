---1

SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    
) AS n
WHERE n.n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1
ORDER BY OrderID, Product;


---2


-- Create the Customers table
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- 
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- 
CREATE TABLE Orders (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- 
INSERT INTO Orders (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

--
DROP TABLE OrderDetails;


-- 
SELECT * FROM Customers;
SELECT * FROM Orders;
