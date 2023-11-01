START TRANSACTION;
--Insert values into Users table
INSERT INTO Users (Username, Password, Email, UserType)
VALUES ('Name A', 'PasswordB', 'userb@example.com', 'Customer');
--Select UserID
SELECT @UserID := LAST_INSERT_ID();
--Insert values into Status table
INSERT INTO Status (Description) VALUES ('1');
INSERT INTO Status (Description) VALUES ('2');
--Select StatusID
SELECT @StatusID1 := LAST_INSERT_ID();
SELECT @StatusID2 := LAST_INSERT_ID();
--Insert values into Businesses table
INSERT INTO Businesses (BusinessName, OwnerName, Address, ContactNumber, UserID)
VALUES ('BusinessB', 'OwnerB', 'BusinessAddress1', '1234567890', @UserID);
--Select BusinessID
SELECT @BusinessID1 := LAST_INSERT_ID();
--Insert values into Products table
INSERT INTO Products (ProductName, Description, Price, Type, StockQuantity, BusinessID)
VALUES ('Product A', 'Describe product A', 50.00, 'Type A', 100, @BusinessID1),
       ('Product B', 'Describe product B', 60.00, 'Type B', 150, @BusinessID1),
       ('Product C', 'Describe product C', 70.00, 'Type A', 200, @BusinessID1);
--Select ProductID 
SELECT @ProductID1 := LAST_INSERT_ID();
SELECT @ProductID2 := LAST_INSERT_ID() - 1;
SELECT @ProductID3 := LAST_INSERT_ID() - 2;
--Insert values into Orders table
INSERT INTO Orders (OrderDate, TotalPrice, StatusID, UserID)
VALUES (NOW(), 0, 1, @UserID);
SET @OrderID := LAST_INSERT_ID();
SET @Quantity1 = 1;
SET @Quantity2 = 2;
SET @Quantity3 = 3;
--Insert values into OrderItems table
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price, Subtotal)
VALUES (@OrderID, @ProductID1, @Quantity1, 50.00, 150.00),
       (@OrderID, @ProductID2, @Quantity2, 60.00, 120.00),
       (@OrderID, @ProductID3, @Quantity3, 70.00, 210.00);
--Update TotalPrice of Orders table by sum of Subtotal in OrderItems table which have 'OrderID = @OrderID' condition
UPDATE Orders
SET TotalPrice = (SELECT SUM(Subtotal) FROM OrderItems WHERE OrderID = @OrderID)
WHERE OrderID = @OrderID;
COMMIT;