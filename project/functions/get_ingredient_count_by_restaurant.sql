CREATE FUNCTION GetIngredientCountByRestaurant(@restaurantId INT)
RETURNS TABLE AS RETURN
(
    SELECT r.rName, COUNT(*) AS IngredientCount
    FROM Restaurant r
    INNER JOIN Store s ON r.rId = s.rId
    WHERE r.rId = @restaurantId
    GROUP BY r.rName
);