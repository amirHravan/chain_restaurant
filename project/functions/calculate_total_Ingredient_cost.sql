CREATE FUNCTION CalculateTotalIngredientCost(@mId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10, 2);
    SELECT @TotalCost = SUM(i.inAmount * i.inPrice)
    FROM Ingredient i
    JOIN Contain c ON i.inId = c.cId
    JOIN Food f ON c.fId = f.fId
    WHERE f.fId = @mId;
    
    RETURN @TotalCost;
END;