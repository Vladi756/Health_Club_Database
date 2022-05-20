-- This query returns members who have made the most and least bookings
-- for personal trainers.
select 
    p.FirstName, 
    p.LastName, 
    p.DateOfBirth, 
    p.[Address], 
    m.BookingsMade
from Person p
inner join Member m on p.ID = m.MemberID 
AND (m.BookingsMade = (select min(BookingsMade) from Member)
     OR m.BookingsMade = (select max(BookingsMade) from Member))
order by BookingsMade ASC;








