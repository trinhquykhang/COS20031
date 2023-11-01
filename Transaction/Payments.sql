START TRANSACTION;
SELECT @OrderID := OrderID FROM Orders ORDER BY OrderID DESC LIMIT 1;

--Calculate the total product added
SELECT COUNT(*) INTO @NumberOfProduct FROM Products;
INSERT INTO Invoices (OrderID, InvoiceDate, Amount, BillingAddress, StatusID)
VALUES (@OrderID, NOW(), @NumberOfProduct, '123 Street, City, Country', 1);
SELECT @TotalPrice := TotalPrice FROM Orders WHERE OrderID = @OrderID;
INSERT INTO Payments (PaymentDate, Amount, PaymentMethod, OrderID)
VALUES (NOW(), @TotalPrice, 'Payment Method', @OrderID);

--Set Status
UPDATE Orders SET StatusID = 2 WHERE OrderID = @OrderID;
SELECT @StatusID := StatusID FROM Status ORDER BY StatusID DESC LIMIT 1;
SELECT @UserID := UserID FROM  Users ORDER BY  UserID DESC LIMIT 1;

-- Send notifications to users
INSERT INTO Notifications (Title, Message, SendDate, UserID, StatusID, Type)
VALUES ('Payment Notifications', 'Payment Successful', NOW(), @UserID, @StatusID, 'Clothes');
COMMIT;