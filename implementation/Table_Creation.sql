<-- Table Creation --> 
create table Person(
	ID             int	          not null     identity(1,1),
	FirstName      varchar(20)    not null,
	LastName       varchar(20)    not null, 
	DateOfBirth    varchar(20)    not null,
	[Address]      varchar(20)    not null,
	PhoneNumber    int            null,

	constraint PersonPK  primary key(ID)
);


create table ClassSchedule(
    ScheduleID     int          not null    identity(1,1),
	[DayOfWeek]    varchar(10)  not null,
	[Time]         time(0)      not null,

	constraint ClassSchedulePK primary key(ScheduleID),
);

select * from Member;
create table Class(
    ClassID       int         not null      identity(1,1),
	ScheduleID    int         not null,
	[Price($)]    int         not null,    
	[Name]        varchar(20) not null,
	[Duration(H)] int         not null,  

	constraint ClassPK primary key(ClassID),
	constraint ClassFK foreign key(ScheduleID) references ClassSchedule(ScheduleID)
);

select * from Class


create table Member(
	MemberID            int         not null,
	[MonthlyFee ($)]    int         not null,
	RenewalDate         date        not null,
	ClassID				int         null,

	constraint MemberPK   primary key(MemberID),
	constraint MemberFK   foreign key(MemberID)  references Person(ID),
	constraint MemberFK1  foreign key(ClassID)   references Class(ClassID)
);


create table MemberClasses(
	MemberID     int    not null,
	ClassID      int    not null,

	constraint MemberClassesPK   primary key(MemberID, ClassID),
	constraint MemberClassesFK   foreign key(MemberID) references Member(MemberID),
	constraint MemberClassesFK1  foreign key(ClassID) references Class(ClassID)
);
create table HealthStatistics(
	MemberID				 int           not null, 
	[Height (cm)]			 int           null,
	[Weight (kg)]            int           null,
	[AvgHeartRate (bpm)]     int           null,
	AvgBloodPressure         varchar(20)   null,
	[GoalWeight (kg)]        int           null,
	[TargetHeartRate (bpm)]  int           null,
	TargetBloodPressure      varchar(20)   null,

	constraint HealthStatisticsPK  primary key(MemberID),
	constraint HealthStatisticsFK  foreign key(MemberID) references Member(MemberID)
);


create table DeviceUsageStatistics(
	MemberID            int       not null,
	DeviceID            int       not null,
	[Date]              date      not null,
	TimeSpentOnDevice   time      null,
	CaloriesBurned      int       null,

	constraint DeviceUsageStatisticsPK  primary key(MemberID, DeviceID, [Date]),
	constraint DeviceUsageStatisticsFK  foreign key(DeviceID) references DeviceType(DeviceID),
	constraint DeviceUsageStatsiticsFK1 foreign key(MemberID) references Member(MemberID)
);


create table DeviceType(
	DeviceID     int           not null    identity(1,1),
	DeviceName   varchar(50)   not null,

	constraint DeviceTypePK primary key(DeviceID),
);


create table Instructor(
	InstructorID    int          not null,
	JobTitle        varchar(50)  not null,
	PayGrade        int          not null,
	ClassID         int          not null,

	constraint InstructorPK  primary key(InstructorID),
	constraint InstructorFK  foreign key(InstructorID) references Person(ID),
	constraint InstructorFK1 foreign key(ClassID) references Class(ClassID)
);


create table PersonalTrainer(
	PersonalTrainerID    int     not null,
	[Fee ($)]            int     not null,
	StartDate            date    null,
	[Duration (days)]    int     null,
	EndDate              date    null,
	
	constraint PersonalTrainerPK  primary key(PersonalTrainerID),
	constraint PersonalTrainserFK foreign key(PersonalTrainerID) references Instructor(InstructorID)
);


create table Bookings(
	BookingID          int       not null     identity(1,1),
	PersonalTrainerID  int       not null,
	MemberID           int       not null,
	BookingStatus      int       not null,
	[Date]             date      not null,

	constraint BookingsPK  primary key(BookingID),
	constraint BookingsFK  foreign key(PersonalTrainerID) references PersonalTrainer(PersonalTrainerID),
	constraint BookingsFK1 foreign key(MemberID) references Member(MemberID),
	constraint BookingsFK2 foreign key(BookingStatus) references BookingStatus(ID)
);


create table BookingStatus(
	ID           int            not null   identity(1,1),
	StatusName   varchar(20)    not null, 

	constraint BookingStatusPK primary key(ID)
);


create table BookingAssociativeEntity(
	PersonalTrainerID    int    not null,
	BookingsID           int    not null,
	MemberID             int    not null,

	constraint BAEPK  primary key(PersonalTrainerID, BookingsID, MemberID),
	constraint BAEFK  foreign key(PersonalTrainerID) references PersonalTrainer(PersonalTrainerID),
	constraint BAEFK1 foreign key(BookingsID) references Bookings(BookingID),
	constraint BAEFK2 foreign key(MemberID) references Member(MemberID)
);


