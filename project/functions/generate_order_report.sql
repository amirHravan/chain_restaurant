CREATE FUNCTION GenerateOrderReport()
RETURNS TABLE
AS
RETURN
    SELECT o.oId, o.ordererName, o.oDate, o.oTime, f.fId, f.fName, t.tNo, t.tCapasity
    FROM [Order] o
    INNER JOIN Contain c ON o.oId = c.oId
    INNER JOIN Food f ON c.fId = f.fId
    INNER JOIN [Table] t ON o.tNo = t.tNo;