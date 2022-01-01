--CREATE DATABASE FBMS;
--PERSON
CREATE TABLE PERSON 
(
    PersonID INT NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Birthdate DATE,
    City VARCHAR(50),
    [State] VARCHAR(50),
    Country VARCHAR(50),
    EmailID nVARCHAR(50),
    MobileNumber VARCHAR(50) NOT NULL,
    AGE AS DATEDIFF(YY, [Birthdate], GETDATE()), --COMPUTED COLUMN
    PersonType VARCHAR(50) NOT NULL CONSTRAINT PersonType_CHK CHECK (PersonType IN ('Users','Passenger')),
    CONSTRAINT Person_PK PRIMARY KEY (PersonID)
);
--NONCLUSTERERED INDEX
CREATE NONCLUSTERED INDEX IX_Person_Name ON PERSON (FirstName,Lastname) INCLUDE (PersonID,Birthdate);

--USERS
CREATE TABLE USERS
(
    PersonID INT NOT NULL IDENTITY(1,1),
    UserID AS 100+PersonID PERSISTED NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Password VARBINARY(400),
    CONSTRAINT User_PK PRIMARY KEY(UserID),
    CONSTRAINT User_FK FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
);

--BOOKING
CREATE TABLE BOOKING
(
    BookingID INT NOT NULL IDENTITY(1,1),
    PersonID INT NOT NULL,
    PassengerID INT NOT NULL,
    BookingTimestamp DATETIME NOT NULL,
    TransactionTimestamp DATETIME NOT NULL,
    TrasactionStatus VARCHAR(50) NOT NULL CONSTRAINT Status_CHK CHECK(TrasactionStatus IN('Pending','Completed','Failed')),
    CONSTRAINT Booking_PK PRIMARY KEY CLUSTERED(BookingID),
    CONSTRAINT Booking_FK FOREIGN KEY (PersonID) REFERENCES PERSON (PersonID) 
);

--PASSENGER
CREATE TABLE PASSENGER 
(
    PersonID INT NOT NULL IDENTITY(1,1),
    PassengerID AS 500+PersonID PERSISTED NOT NULL,
    BookingID INT NOT NULL ,
    PassengerType VARCHAR(50) NOT NULL CONSTRAINT Type_CHK CHECK (PassengerType IN ('Adult','Infant','Children')),
    CONSTRAINT Passenger_PK PRIMARY KEY CLUSTERED(PassengerID),
    CONSTRAINT Passenger_FK FOREIGN KEY(PersonID) REFERENCES PERSON(PersonID),
    CONSTRAINT PassengerBooking_FK FOREIGN KEY(BookingID) REFERENCES BOOKING(BookingID)
);

--AIRCRAFT
CREATE TABLE Aircraft
(
    AinNumber INT NOT NULL IDENTITY(10000,1),
    ManufacturingCompany VARCHAR(50),
    ModelNumber VARCHAR(50),
    Seats INT NOT NULL,
    ModelType VARCHAR(50) CONSTRAINT Model_CHK CHECK (ModelType IN('Commercial','Private')),
    CONSTRAINT Aircraft_PK PRIMARY KEY CLUSTERED(AinNumber)
);


--EMPLOYEE
CREATE TABLE EMPLOYEE
(
    EmployeeID int NOT NULL identity(1,1),
    FirstName varchar(50),
    LastName varchar(50),
    DateOfBirth date,
    Email varchar(100),
    PhoneNumber decimal(10,0),
    ManagerID int,
    EmployeeType varchar(50) CONSTRAINT EmployeeType_CHK CHECK(EmployeeType IN('Airport','Remote','Airline')),
    CONSTRAINT Employee_PK PRIMARY KEY CLUSTERED (EmployeeID),
    CONSTRAINT Employee_FK FOREIGN KEY (ManagerID) REFERENCES EMPLOYEE (EmployeeID) 
);
--NONCLUSTERED INDEX
CREATE NONCLUSTERED INDEX IX_Employee_FirstName ON EMPLOYEE (FirstName) INCLUDE (EmployeeID,LastName,DateOfBirth);

--AIRPORTS
CREATE TABLE AIRPORTS
(
AirportID Char(3) not null CONSTRAINT AirportID_CHK CHECK (AirportID IN ('BOS','JFK','HYD','DEL','BOM','MAA','LHR','DOH','DXB','AUH','SFO')),
AirportName nvarchar(50),
AirportLocation nvarchar(30),
CONSTRAINT Airports_PK PRIMARY KEY (AirportID)
);

--AIRPORTEMPLOYEE
CREATE TABLE AIRPORTEMPLOYEE
(
    EmployeeID int NOT NULL identity(1,1),
    AirportEmployeeID AS 10+EmployeeID PERSISTED NOT NULL,
    AirportID Char(3) NOT NULL CONSTRAINT AirportID_CHK1 CHECK (AirportID IN ('BOS','JFK','HYD','DEL','BOM','MAA','LHR','DOH','DXB','AUH','SFO')),
    CONSTRAINT Airport_Employee_PK PRIMARY KEY CLUSTERED (AirportEmployeeID),
    CONSTRAINT Airport_Employee_FK1 FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE (EmployeeID),
    CONSTRAINT Airport_Employee_FK2 FOREIGN KEY (AirportID) REFERENCES AIRPORTS (AirportID)
);


--WORKLOCATION
CREATE TABLE WORKLOCATION
(
    LocationID INT NOT NULL identity(1000,1),
    LocationName VARCHAR(30),
    Address VARCHAR(50),
    NumberOfEmployees INT,
    CONSTRAINT WorkLocation_PK PRIMARY KEY CLUSTERED (LocationID)
);

--REMOTEEMPLOYEE
CREATE TABLE REMOTEEMPLOYEE
(
    EmployeeID int NOT NULL identity(1,1),
    RemoteEmployeeID AS 20+EmployeeID PERSISTED NOT NULL,
    LocationID INT NOT NULL,
    CONSTRAINT Remote_Employee_PK PRIMARY KEY CLUSTERED (RemoteEmployeeID),
    CONSTRAINT Remote_Employee_FK1 FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE (EmployeeID),
    CONSTRAINT Remote_Employee_FK2 FOREIGN KEY (LocationID) REFERENCES WORKLOCATION (LocationID)
);

--AIRLINE
CREATE TABLE Airline
(
    AirlineID INT NOT NULL identity(1,1),
    AirlineName VARCHAR(50),
    AirlineType VARCHAR(25) CONSTRAINT Airlinetype_CHK CHECK (AirlineType IN ('Major','National','Regional')),
    CONSTRAINT AirlineID_PK PRIMARY KEY CLUSTERED (AirlineID)
);


--AIRLINEEMPLOYEE
CREATE TABLE AIRLINEEMPLOYEE
(
	EmployeeID int NOT NULL identity(1,1),
	AirlineEmployeeID AS 30+EmployeeID PERSISTED NOT NULL,
	Salary decimal(15,2),
	AirlineID int NOT NULL,
    CONSTRAINT Airline_Employee_PK PRIMARY KEY CLUSTERED (AirlineEmployeeID),
    CONSTRAINT Airline_Employee_FK1 FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE (EmployeeID),
	CONSTRAINT Airline_Employee_FK2 FOREIGN KEY (AirlineID) REFERENCES AIRLINE (AirlineID)
);

--BAGGAGE
CREATE TABLE Baggage
(
    BaggageID INT NOT NULL IDENTITY(1,1),
    BaggageWeight DECIMAL(15,2),
    PassengerID INT NOT NULL,
    BookingID INT NOT NULL,
    CONSTRAINT Baggage_PK PRIMARY KEY CLUSTERED (BaggageID),
    CONSTRAINT Baggage_FK1 FOREIGN KEY (PassengerID) REFERENCES PASSENGER (PassengerID), 
    CONSTRAINT Baggage_FK2 FOREIGN KEY (BookingID) REFERENCES BOOKING (BookingID) 
);

--ROUTE
CREATE TABLE [ROUTE]
(
RouteNumber nvarchar(10) not null,
OriginAirportID char(3) not null CONSTRAINT OrgAirport_CHK CHECK (OriginAirportID IN ('BOS','JFK','HYD','DEL','BOM','MAA','LHR','DOH','DXB','AUH','SFO')),
DestinationAirportID char(3) not null CONSTRAINT DesAirport_CHK CHECK (DestinationAirportID IN ('BOS','JFK','HYD','DEL','BOM','MAA','LHR','DOH','DXB','AUH','SFO')),
CONSTRAINT Route_PK PRIMARY KEY (RouteNumber),
CONSTRAINT Route_FK1 FOREIGN KEY (OriginAirportID) REFERENCES Airports(AirportID),
CONSTRAINT Route_FK2 FOREIGN KEY (DestinationAirportID) REFERENCES Airports(AirportID)
);

--PAYMENT
CREATE TABLE PAYMENT
(
PaymentID int not null IDENTITY(3000,2),
BookingID int not null ,
CardType nvarchar(10) CONSTRAINT card_chk CHECK( CardType IN('Credit', 'Debit')),
CardNumber varchar(16) CONSTRAINT card_number_chk CHECK(CardNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
ExpiryDate DATE,
CONSTRAINT Payment_PK PRIMARY KEY CLUSTERED (PaymentID),
CONSTRAINT PAyment_FK FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

--FLIGHTSCHEDULE
CREATE TABLE FLIGHTSCHEDULE
(
    FlightScheduleID int NOT NULL identity(1,1),
    DepartureTimestamp datetime,
    ArrivalTimestamp datetime,
    FlightStatusCode varchar(20),
    SeatAvailable int,
    RouteNumber nvarchar(10) NOT NULL,
    AINNumber INT NOT NULL,
    CONSTRAINT Flight_Schedule_PK PRIMARY KEY CLUSTERED (FlightScheduleID),
    CONSTRAINT Flight_Schedule_FK1 FOREIGN KEY (RouteNumber) REFERENCES [ROUTE] (RouteNumber),
    CONSTRAINT Flight_Schedule_FK2 FOREIGN KEY (AINNumber) REFERENCES AIRCRAFT (AINNumber)
);

--TRIP
CREATE TABLE TRIP
(
    AirlineID INT NOT NULL identity(1,1),
    RouteNumber nvarchar(10) NOT NULL,
    BaggageAllowance DECIMAL(15,2),
    PassengersCount INT,
    CrewMembersCount INT,
    CONSTRAINT Trip_PK1 PRIMARY KEY CLUSTERED (RouteNumber, AirlineID),
    CONSTRAINT Trip_FK1 FOREIGN KEY (RouteNumber) REFERENCES [ROUTE] (RouteNumber),
    CONSTRAINT Trip_FK2 FOREIGN KEY (AirlineID) REFERENCES Airline (AirlineID)
);

--IMMUNIZATION
CREATE TABLE IMMUNIZATION
(
    ImmunizationID INT NOT NULL identity(1,1),
    PassengerID INT NOT NULL,
    ImmunizationName VARCHAR(30),
    CompletedTimestamp datetime,
    ImmunizationCountry VARCHAR(50),
    CONSTRAINT Immunization_PK PRIMARY KEY CLUSTERED (ImmunizationID),
    CONSTRAINT Immunization_FK FOREIGN KEY (PassengerID) REFERENCES PASSENGER (PassengerID) 
);

--TICKET
CREATE TABLE TICKET
(
TicketID int not null IDENTITY(2000,1),
BookingID int not null,
FlightScheduleID int not null,
LayoverTime int,
CONSTRAINT Ticket_PK PRIMARY KEY CLUSTERED(TicketID),
CONSTRAINT Ticket_FK1 FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
CONSTRAINT Ticket_FK2 FOREIGN KEY (FlightScheduleID) REFERENCES FlightSchedule(FlightScheduleID)
);

