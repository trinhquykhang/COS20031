START TRANSACTION;
INSERT INTO Users (Username, Password, Email, UserType)
VALUES ('UserA', 'Password123', 'usera@example.com', 'Customer');
SELECT @UserID := UserID FROM Users WHERE Username = 'UserA';
INSERT INTO Businesses (BusinessName, OwnerName, Address, ContactNumber, UserID)
VALUES ('BusinessA', 'OwnerA', 'BusinessAddress', '1234567890', @UserID);
COMMIT;