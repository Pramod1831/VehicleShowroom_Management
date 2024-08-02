CREATE DATABASE BikeShowroom;
USE BikeShowroom;

CREATE TABLE Bikes (
    BikeID INT AUTO_INCREMENT PRIMARY KEY,
    Model VARCHAR(255) NOT NULL,
    Brand VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    BikeID INT,
    CustomerID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (BikeID) REFERENCES Bikes(BikeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Service (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    BikeID INT,
    CustomerID INT,
    ServiceDate DATE,
    ServiceDescription TEXT,
    ServiceCost DECIMAL(10, 2),
    FOREIGN KEY (BikeID) REFERENCES Bikes(BikeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255),
    Address VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierID INT,
    BikeID INT,
    OrderDate DATE,
    Quantity INT,
    Status VARCHAR(50),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (BikeID) REFERENCES Bikes(BikeID)
);
INSERT INTO Bikes (Model, Brand, Price, StockQuantity) VALUES 
('Model X1', 'Brand A', 1500.00, 10),
('Model Y1', 'Brand B', 1800.00, 5),
('Model Z1', 'Brand C', 2000.00, 8),
('Model X2', 'Brand A', 1700.00, 15),
('Model Y2', 'Brand B', 1900.00, 3);

INSERT INTO Customers (FirstName, LastName, Address, Phone, Email) VALUES 
('John', 'Doe', '123 Main St', '555-1234', 'john.doe@example.com'),
('Jane', 'Smith', '456 Elm St', '555-5678', 'jane.smith@example.com'),
('Alice', 'Johnson', '789 Oak St', '555-9012', 'alice.johnson@example.com'),
('Bob', 'Brown', '321 Pine St', '555-3456', 'bob.brown@example.com'),
('Carol', 'Davis', '654 Maple St', '555-7890', 'carol.davis@example.com');

INSERT INTO Sales (BikeID, CustomerID, SaleDate, Quantity, TotalAmount) VALUES 
(1, 1, '2024-01-15', 1, 1500.00),
(2, 2, '2024-02-20', 1, 1800.00),
(3, 3, '2024-03-25', 1, 2000.00),
(1, 4, '2024-04-10', 1, 1500.00),
(4, 5, '2024-05-05', 1, 1700.00);

INSERT INTO Service (BikeID, CustomerID, ServiceDate, ServiceDescription, ServiceCost) VALUES 
(1, 1, '2024-06-01', 'Regular Maintenance', 100.00),
(2, 2, '2024-06-15', 'Brake Replacement', 150.00),
(3, 3, '2024-07-01', 'Chain Adjustment', 50.00),
(1, 4, '2024-07-15', 'Tire Replacement', 200.00),
(4, 5, '2024-08-01', 'Engine Tune-up', 300.00);

INSERT INTO Suppliers (Name, Contact, Address) VALUES 
('Supplier A', 'contactA@example.com', '111 Supplier St'),
('Supplier B', 'contactB@example.com', '222 Supplier Ave'),
('Supplier C', 'contactC@example.com', '333 Supplier Blvd');

INSERT INTO Orders (SupplierID, BikeID, OrderDate, Quantity, Status) VALUES 
(1, 1, '2024-01-10', 10, 'Received'),
(2, 2, '2024-01-20', 5, 'Pending'),
(3, 3, '2024-02-01', 8, 'Received'),
(1, 4, '2024-02-10', 15, 'Received'),
(2, 5, '2024-03-05', 3, 'Pending');

use BikeShowroom;
CREATE TABLE Users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);


