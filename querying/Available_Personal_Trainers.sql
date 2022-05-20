-- This query returns all personal trainers available for booking this week. 
select 
	p.PersonalTrainerID, 
	p.[Duration (days)],
	p.[Fee ($)],
	MIN(b.[Date]) as [Latest Booking]
from PersonalTrainer p
left join Bookings b on p.PersonalTrainerID = b.PersonalTrainerID
where (p.PersonalTrainerID NOT IN(select PersonalTrainerID from Bookings b)
OR b.[Date] NOT BETWEEN getDate() AND dateadd(d, 7, getDate()))
group by p.PersonalTrainerID, p.[Duration (days)], p.[Fee ($)]
order by [Latest Booking] ASC;

select * from Bookings
order by [Date] ASC;
