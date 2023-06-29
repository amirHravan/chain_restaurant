Use ChainRestaurant;

-- a report showing the monthly sales for a specific restaurant:
SELECT MONTH(O.oDate) AS [Month], SUM(F.fPrice) AS MonthlySales
FROM [Order] O
JOIN Contain C ON O.oId = C.oId
JOIN Food F ON C.fId = F.fId
WHERE O.rId = 1 -- Replace 1 with the desired restaurant ID
GROUP BY MONTH(O.oDate);

-- the average party size for each restaurant's reservations:
SELECT R.rName, AVG(Re.rePartySize) AS AveragePartySize
FROM Restaurant R
JOIN Reservation Re ON R.rId = Re.rId
GROUP BY R.rName;

-- list of all restaurants along with the number of tables they have:
SELECT R.rName, COUNT(T.tNo) AS TableCount
FROM Restaurant R
LEFT JOIN [Table] T ON R.rId = T.rId
GROUP BY R.rName;

-- count of all restaurants
SELECT COUNT(R.rId) As restaurantCount
FROM Restaurant R;

-- all capacity of all restaurants
SELECT R.rName AS RestaurantName, SUM(T.tCapacity) AS TableCapacity
FROM Restaurant R
INNER JOIN [Table] T ON R.rId = T.rId
GROUP BY R.rName;

-- selects evaluations that has a score of more or equal to 4
SELECT E.eComment AS comment
FROM Evaluation E
WHERE E.eScore >= 4;


-- shows number of orders in each day
SELECT O.oDate AS dateOfOrder, COUNT(O.oId) AS [count]
FROM [Order] O
GROUP BY O.oDate;


-- shows top 3 most frequnt foods orderd
SELECT TOP 3 F.fName AS foodName , SUM(C.cAmount) AS freq
FROM Contain C
JOIN Food F ON F.fId = C.fId
GROUP BY F.fName
ORDER BY SUM(C.cAmount) DESC;

-- shows all restaurant names with order count of that restaurant
SELECT R.rName AS restaurantName, COUNT(O.oId) AS orderCount
FROM [Order] O
JOIN [Restaurant] R ON O.rId = R.rId
GROUP BY R.rName;
