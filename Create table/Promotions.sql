CREATE TABLE Promotions (
  PromotionID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  PromotionName VARCHAR(55) NOT NULL,
  Description VARCHAR(255) NOT NULL,
  DiscountPercentage DECIMAL(10,2) NOT NULL
);