START TRANSACTION;
INSERT INTO Users (Username, Password, Email, UserType)
VALUES ('Name A', 'PasswordB', 'userb@example.com', 'Customer');
SELECT @UserID := LAST_INSERT_ID();
INSERT INTO Status (Description) VALUES ('1');
INSERT INTO Status (Description) VALUES ('2');
SELECT @StatusID1 := LAST_INSERT_ID();
SELECT @StatusID2 := LAST_INSERT_ID();
INSERT INTO Businesses (BusinessName, OwnerName, Address, ContactNumber, UserID)
VALUES ('BusinessB', 'OwnerB', 'BusinessAddress1', '1234567890', @UserID);
SELECT @BusinessID1 := LAST_INSERT_ID();
INSERT INTO Products (ProductName, Description, Price, Type, StockQuantity, BusinessID)
VALUES ('Product A', 'Describe product A', 50.00, 'Type A', 100, @BusinessID1),
       ('Product B', 'Describe product B', 60.00, 'Type B', 150, @BusinessID1),
       ('Product C', 'Describe product C', 70.00, 'Type A', 200, @BusinessID1);
SELECT @ProductID1 := LAST_INSERT_ID();
SELECT @ProductID2 := LAST_INSERT_ID() - 1;
SELECT @ProductID3 := LAST_INSERT_ID() - 2;
INSERT INTO Orders (OrderDate, TotalPrice, StatusID, UserID)
VALUES (NOW(), 0, 1, @UserID);
SET @OrderID := LAST_INSERT_ID();
SET @Quantity1 = 1;
SET @Quantity2 = 2;
SET @Quantity3 = 3;
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price, Subtotal)
VALUES (@OrderID, @ProductID1, @Quantity1, 50.00, 150.00),
       (@OrderID, @ProductID2, @Quantity2, 60.00, 120.00),
       (@OrderID, @ProductID3, @Quantity3, 70.00, 210.00);
UPDATE Orders
SET TotalPrice = (SELECT SUM(Subtotal) FROM OrderItems WHERE OrderID = @OrderID)
WHERE OrderID = @OrderID;
COMMIT;