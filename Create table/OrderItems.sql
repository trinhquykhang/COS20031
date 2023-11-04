CREATE TABLE OrderItems (
   OrderItemID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   OrderID INT,
   FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
   ProductID INT,
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
   Quantity INT(255) NOT NULL,
   Price DECIMAL(10,2) NOT NULL,
   Subtotal DECIMAL(10,2) NOT NULL
);
