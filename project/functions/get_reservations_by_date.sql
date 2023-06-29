CREATE PROCEDURE GetReservationsByDate
    @reservationDate DATE
AS
BEGIN
    SELECT r.reId, r.reCustomerName, r.reCustomerPhone, t.tNo
    FROM Reservation r
    JOIN [Table] t ON r.tNo = t.tNo
    WHERE r.reDate = @reservationDate;
END

-- EXEC dbo.GetReservationsByDate @reservationDate = "2023-06-05"