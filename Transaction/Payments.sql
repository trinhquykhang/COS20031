START TRANSACTION;
--The code retrieves the latest order ID from the Orders table and counts rows in the Products table, but the purpose of this count is unclear
SELECT @OrderID := OrderID FROM Orders ORDER BY OrderID DESC LIMIT 1;
SELECT COUNT(*) INTO @NumberOfProduct FROM Products;
--The code inserts an invoice with order ID, date, amount, billing address, and status ID, retrieves the total price of the order, and stores it in the @TotalPrice variable
INSERT INTO Invoices (OrderID, InvoiceDate, Amount, BillingAddress, StatusID)
VALUES (@OrderID, NOW(), @NumberOfProduct, '123 Street, City, Country', 1);
SELECT @TotalPrice := TotalPrice FROM Orders WHERE OrderID = @OrderID;
--The payment information is inserted, including the payment date, amount, method, and order ID related to the payment
INSERT INTO Payments (PaymentDate, Amount, PaymentMethod, OrderID)
VALUES (NOW(), @TotalPrice, 'Payment Method', @OrderID);
--The code updates the order status to "2" and retrieves the most recent status ID from the Status table, storing it in the @StatusID variable
UPDATE Orders SET StatusID = 2 WHERE OrderID = @OrderID;
SELECT @StatusID := StatusID FROM Status ORDER BY StatusID DESC LIMIT 1;
SELECT @UserID := UserID FROM  Users ORDER BY  UserID DESC LIMIT 1;
--The user is notified of a successful payment, with details such as title, message, send date, user ID, status ID, and type, specifically 'Clothes'
INSERT INTO Notifications (Title, Message, SendDate, UserID, StatusID, Type)
VALUES ('Payment Notifications', 'Payment Successful', NOW(), @UserID, @StatusID, 'Clothes');
--The statement removes rows from the Products table where the OrderID matches the @OrderID, indicating the removal of products related to the specific order
DELETE FROM Products WHERE OrderID = @OrderID;
COMMIT;