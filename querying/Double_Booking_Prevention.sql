-- Trigger to prevent double booking of personal trainers. -- 
create trigger DoubleBookPrevention on Bookings
after insert 
as 

if exists ( select b.PersonalTrainerID, b.[Date] from Bookings b
			inner join inserted i on i.PersonalTrainerID = b.PersonalTrainerID
			       and i.Date = b.Date)
begin 
	rollback
	RAISERROR('Cannot double-book personal trainers!', 16,1);
end 
go

select * from Bookings;

insert into Bookings
(PersonalTrainerID, MemberID, BookingStatus, [Date])
values 
(10, 16, 2, '2022-10-11');