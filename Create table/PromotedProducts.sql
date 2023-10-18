CREATE TABLE PromotedProducts (
    PromotedProductID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ProductID INT, 
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    PromotionID INT,
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID) ON DELETE CASCADE,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL
);

