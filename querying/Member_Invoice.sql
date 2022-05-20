-- Stored procedure that generates a complete member device usage invoice.

alter procedure MemberInvoices(@ID int, @Days int)
as 
declare 
	@MemberID     int,
	@FirstName    varchar(255),
	@LastName     varchar(255),
	@DateOfBirth  varchar(255),
	@Address      varchar(255),
	@PhoneNumber  int,
	@TimeOnDevice int,
	@Calories     int,
	@Date         date,
	@DevName      varchar(255)
begin
select 
	@MemberID = m.MemberID,
	@FirstName = p.FirstName,
	@LastName = p.LastName,
	@DateOfBirth = p.DateOfBirth,
	@Address = p.[Address],
	@PhoneNumber = p.PhoneNumber,
	@TimeOnDevice  = d.TimeSpentOnDevice,
	@Calories = d.CaloriesBurned,
	@Date = d.Date,
	@DevName = dN.DeviceName
from Member m
	inner join Person p on p.ID = m.MemberID
	inner join DeviceUsageStatistics d on d.MemberID = m.MemberID 
	inner join DeviceType dN on d.DeviceID = dN.DeviceID
	where m.MemberID = @ID AND 
	d.[Date] Between getDate() and dateAdd(d, @Days, getDate())
	print 'Invoice: ' + @FirstName + ' ' + @LastName
	print ' '
	print '======================================'
	print 'Member Details: '
	print 'Member ID: ' + cast(@MemberID as varchar(255));
	print 'Date of Birth: ' + cast(@DateOfBirth as varchar(255));
	print 'Address: ' + cast(@Address as varchar(255));
	print 'PhoneNumber: ' + cast(@PhoneNumber as varchar(255));
	print '======================================='
	print 'Device Details: '
	print ' '
	print 'Device Name: ' + cast(@DevName as varchar(255));
	print 'Time on Device: ' + cast(@TimeOnDevice as varchar(255));
	print 'Calories: ' + cast(@Calories as varchar(255));
	print 'Date Device Used: '  + cast(@Date as varchar(255));
	print '======================================='
end


exec MemberInvoices 13, 30;
