CREATE TABLE Customers (
  CustomerID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  CustomerName VARCHAR(30) NOT NULL,
  CustomerEmail VARCHAR(30) NOT NULL,
  CustomerPhone VARCHAR(10) NOT NULL,
  CustomerAddress VARCHAR(30) NOT NULL,
  BusinessID INT,
  FOREIGN KEY (BusinessID) REFERENCES Businesses(BusinessID) ON DELETE CASCADE
);