CREATE TABLE Products (
  ProductID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ProductName VARCHAR(30) NOT NULL,
  Description VARCHAR(255) NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  Type VARCHAR(20) NOT NULL,
  StockQuantity INT(255) NOT NULL,
  BusinessID INT,
  FOREIGN KEY (BusinessID) REFERENCES Businesses(BusinessID) ON DELETE CASCADE
 );