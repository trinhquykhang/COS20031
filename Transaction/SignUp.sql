START TRANSACTION;
--The statement creates a new user with attributes like Username, Password, Email, and UserType, using placeholders. It retrieves the user ID from the Users table and stores it in the @UserID variable
INSERT INTO Users (Username, Password, Email, UserType)
VALUES ('UserA', 'Password123', 'usera@example.com', 'Customer');
SELECT @UserID := UserID FROM Users WHERE Username = 'UserA';
--The statement inserts business information into the Businesses table, identifying it with a user named 'UserA', based on attributes like BusinessName, OwnerName, Address, ContactNumber, and UserID
INSERT INTO Businesses (BusinessName, OwnerName, Address, ContactNumber, UserID)
VALUES ('BusinessA', 'OwnerA', 'BusinessAddress', '1234567890', @UserID);
COMMIT;