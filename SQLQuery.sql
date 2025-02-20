CREATE DATABASE RETAILSTOREDB;
CREATE TABLE Customers
(
CustomerID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL,
RegistrationDate DATE NOT NULL
);

CREATE TABLE Products
(
ProductID INT PRIMARY KEY IDENTITY,
ProductName VARCHAR(100) NOT NULL,
Category VARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
StockQuantity INT NOT NULL
);

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT NOT NULL,
ProductID INT NOT NULL,
OrderDate DATE NOT NULL,
Quantity INT NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

INSERT INTO Customers (FirstName, LastName, Email, RegistrationDate) VALUES
('John', 'Doe', 'john.doe@example.com', '2024-01-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2024-01-05'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2024-01-10'),
('Bob', 'Brown', 'bob.brown@example.com', '2024-01-15'),
('Charlie', 'Davis', 'charlie.davis@example.com', '2024-01-20');
INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Laptop', 'Electronics', 999.99, 50),
('Smartphone', 'Electronics', 699.99, 100),
('Headphones', 'Accessories', 199.99, 200),
('Backpack', 'Fashion', 49.99, 150),
('Coffee Maker', 'Appliances', 79.99, 75);
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity) VALUES
(1, 1, '2024-02-01', 1),
(2, 2, '2024-02-02', 2),
(2, 3, '2024-02-03', 1),
(4, 3, '2024-02-04', 3),
(5, 1, '2024-02-05', 2);

 SELECT* FROM Customers;
 SELECT* FROM Products;
 SELECT* FROM Orders;
 SELECT* FROM Customers WHERE RegistrationDate > '2024-01-05';

SELECT TOP 3 *FROM Products ORDER BY Price DESC;

SELECT CustomerID, COUNT(OrderID) AS TotalOrders FROM Orders GROUP BY CustomerID;
SELECT 
    O.ProductID,
    SUM(O.Quantity) AS TotalQuantitySold,
    SUM(O.Quantity * P.Price) AS TotalSales
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY O.ProductID;

SELECT 
O.OrderID,
O.OrderDate,
O.Quantity,
P.Price,
P.Category,
P.ProductName,
C.FirstName,
C.LastName,
(O.Quantity * P.Price) AS TotalPrice
FROM Orders O
JOIN Customers C ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;

SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(o.Quantity * p.Price) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC; 