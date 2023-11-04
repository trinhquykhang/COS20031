START TRANSACTION;
--The statement inserts user information into the Users table, retrieving the last auto-generated user ID and storing it in the @UserID variable for future use
INSERT INTO Users (Username, Password, Email, UserType)
VALUES ('Name A', 'PasswordB', 'userb@example.com', 'Customer');
SELECT @UserID := LAST_INSERT_ID();
--The code inserts status descriptions into the Status table, which can be used for order or business statuses, retrieving the last auto-generated status IDs and storing them in variables
INSERT INTO Status (Description) VALUES ('1');
INSERT INTO Status (Description) VALUES ('2');
SELECT @StatusID1 := LAST_INSERT_ID();
SELECT @StatusID2 := LAST_INSERT_ID();
--The statement inserts business information into the Businesses table, associates it with a user, and retrieves the last auto-generated business ID, storing it in the @BusinessID1 variable
INSERT INTO Businesses (BusinessName, OwnerName, Address, ContactNumber, UserID)
VALUES ('BusinessB', 'OwnerB', 'BusinessAddress1', '1234567890', @UserID);
SELECT @BusinessID1 := LAST_INSERT_ID();
--The Products table contains product information, including name, description, price, type, and stock quantity, all associated with the same business using BusinessID field, and stored in variables
INSERT INTO Products (ProductName, Description, Price, Type, StockQuantity, BusinessID)
VALUES ('Product A', 'Describe product A', 50.00, 'Type A', 100, @BusinessID1),
       ('Product B', 'Describe product B', 60.00, 'Type B', 150, @BusinessID1),
       ('Product C', 'Describe product C', 70.00, 'Type A', 200, @BusinessID1);
SELECT @ProductID1 := LAST_INSERT_ID();
SELECT @ProductID2 := LAST_INSERT_ID() - 1;
SELECT @ProductID3 := LAST_INSERT_ID() - 2;
--The statement creates an order with a current date, price, status, and user, retrieves the last auto-generated order ID, and stores it in the @OrderID variable
INSERT INTO Orders (OrderDate, TotalPrice, StatusID, UserID)
VALUES (NOW(), 0, 1, @UserID);
SET @OrderID := LAST_INSERT_ID();
--These lines set quantity variables for the order items
SET @Quantity1 = 1;
SET @Quantity2 = 2;
SET @Quantity3 = 3;
--The statement inserts order items into the OrderItems table, updating the total price by adding the subtotals of all order items associated with that order
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price, Subtotal)
VALUES (@OrderID, @ProductID1, @Quantity1, 50.00, 150.00),
       (@OrderID, @ProductID2, @Quantity2, 60.00, 120.00),
       (@OrderID, @ProductID3, @Quantity3, 70.00, 210.00);
UPDATE Orders
SET TotalPrice = (SELECT SUM(Subtotal) FROM OrderItems WHERE OrderID = @OrderID)
WHERE OrderID = @OrderID;
COMMIT;