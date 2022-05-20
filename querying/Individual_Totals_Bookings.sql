-- Returns individual status for complete, canceled and incomplete bookings. 
select 
	bS.StatusName,
	count(b.BookingStatus) as [Individual Totals]
from Bookings b
inner join BookingStatus bs on b.BookingStatus = bS.ID
group by BookingStatus, bS.StatusName;

