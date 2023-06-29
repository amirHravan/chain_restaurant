CREATE FUNCTION GetAverageRating(@rId INT)
RETURNS DECIMAL(4, 2)
AS
BEGIN
    DECLARE @AvgRating DECIMAL(4, 2);
    SELECT @AvgRating = AVG(eScore)
    FROM Evaluation
    WHERE rId = @rId;
    
    RETURN @AvgRating;
END;