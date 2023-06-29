CREATE PROCEDURE GetRestaurantIngredientStock
AS
BEGIN
    SELECT r.rId, r.rName, SUM(i.inAmount) AS TotalStock
    FROM Restaurant r
    JOIN Store s ON r.rId = s.rId
    JOIN Ingredient i ON s.inId = i.inId
    GROUP BY r.rId, r.rName;
END