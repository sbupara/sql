/* 1. For each reservation for customer Ryan Goff,  list the reservation ID, trip ID,and number of persons. */
SELECT c.FirstName, c.LastName, r.ReservationID, r.TripID, r.NumPersons
FROM Customer c
RIGHT JOIN Reservation r
ON c.CustomerNum = r.CustomerNum
WHERE c.LastName = 'Goff';

/* 2. Display the Customer number,  Last Name,  and First Name for all customerswho currently don’t have any reservation. */
SELECT c.CustomerNum, c.LastName, c.FirstName
FROM Customer c
Left JOIN Reservation r
ON r.CustomerNum = c.CustomerNum
WHERE ReservationID IS NULL;

/* 3. List the trip IDs and trip names for each pair of trips that have the same startlocation. */
SELECT a.TripID, a.TripName, b.TripID, b.TripName, a.StartLocation
From Trip a
INNER JOIN Trip b
ON a.StartLocation = b.StartLocation
AND a.TripID < b.TripID
ORDER BY a.TripID;

/* 4. List the reservation ID, trip ID, and trip date for reservations for a trip in Maine(ME). Use a subquery.*/
SELECT ReservationID, TripID, TripDate
FROM Reservation
WHERE TripID IN (SELECT TripID
				FROM TRIP
				WHERE State = 'ME');

/* 5. How many trips are in the states of Maine (ME) or Massachusetts (MA)? */
SELECT Count(*)
FROM Trip
Where State REGEXP 'MA|ME';

/* 6. How many trips originate in each state? */
SELECT StartLocation, count(StartLocation) as '# of Trips'
FROM Trip
GROUP BY StartLocation
ORDER BY StartLocation;

/* 7. How  many  reservations  include  a  trip  price  that  is  greater  than  $20  but  lessthan $75? */
SELECT Count(TripPrice)
FROM Reservation
WHERE TripPrice > 20
AND TripPrice < 75;

/* 8. Find the name of each trip containing the word “Pond.” */
SELECT TripName
FROM Trip
WHERE TripName LIKE '%Pond%';

/* 9. What is the average distance and the average maximum group size for each typeof trip? */
SELECT Type, AVG(DISTANCE), AVG(MaxGrpSize)
From Trip
GROUP BY Type
ORDER BY Type;

/* 10. For each trip in the RESERVATION table that has more than one reservation,group by trip ID and sum the trip price. */
SELECT TripID, SUM(TripPrice)
FROM RESERVATION
GROUP BY TripID
HAVING COUNT(TripID) > 1
ORDER BY TripID;

/* 11. How many current reservations does Colonial Adventure Tours have and whatis the total number of persons for all reservations? */
SELECT Count(ReservationID) as 'Current Reservations', Sum(NumPersons) as 'Total People'
From Reservation;