CREATE FUNCTION GetRestaurantsWithMenusAndFood()
RETURNS TABLE
AS
RETURN
    SELECT r.rId, r.rName, m.mId, m.mName, f.fId, f.fName
    FROM Restaurant r
    INNER JOIN Menu m ON r.rId = m.rId
    INNER JOIN Food f ON m.mId = f.fId;