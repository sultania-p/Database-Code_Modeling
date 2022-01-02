INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Cristiano','Ronaldo','1985-02-05','Funchal','Madeira','Portugal','ronnie7@gmail.com','8674532467','Users');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Linoel','Messi','2018-06-24','Rosario','Santa Fe','Argentia','messi10@gmail.com','6758910349','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Neymar','Junior','1992-02-05','Mogi Das Cruzes','Sau Paulo','Brazil','neymarjr10@rediffmail.com','8742982028','Users');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Bruno','Fernandes','2005-09-08','Maia','Porto','Portugal','bruno18@gmail.com','9763450238','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Wayne','Rooney','2009-10-24','Croxteth','Liverpool','United Kingdom','rooney10@gmail.com','7682346190','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Xavier','Hernandez','1980-01-25','Terrassa','Catalonia','Spain','xavi06@rediffmail.com','876234590','Users');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Sergio','Ramos','2008-03-30','Camas','Seville','Spain','ramos04@yahoo.com','6549823402','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Nemanja','Vidic','2019-10-21','Uzice','Sumadijia','Serbia','nemanja16@gmail.com','9852346780','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Marcelo','Veiria','1988-05-12','Rio De Janeiro','Rio De Janeiro','Brazil','marcelo12@gmail.com','7654389012','Passenger');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Carlos','Puyol','2010-04-13','Segur','Pallars Jussa','Brazil','carlos05@yahoo.com','9865234802','Users');
INSERT INTO PERSON (FirstName,LastName,Birthdate,City,State,Country,EmailID,MobileNumber,PersonType) VALUES ('Iker','Casillas','1981-05-20','Mostoles','Madrid','Spain','iker01@gmail.com','9876589021','Users');

-----------------------------------------------------------USERS------------------------------------------------------------------------
INSERT INTO USERS (Username)
SELECT LASTNAME from PERSON;

--COLUMN DATA ENCRYPTION - PASSWORD
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Flightbooking2021';

SELECT name as KeyName, symmetric_key_id as KeyID,key_length as KeyLength, algorithm_desc as KeyAlgorithm
FROM sys.symmetric_keys;

CREATE CERTIFICATE Userpassword  WITH SUBJECT = 'User Password';   

CREATE SYMMETRIC KEY Userpassword_FL WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Userpassword;  

OPEN SYMMETRIC KEY Userpassword_FL DECRYPTION BY CERTIFICATE Userpassword;  

UPDATE USERS 
SET Password = EncryptByKey(Key_GUID('Userpassword_FL'),  convert(varbinary,'Flight2021'))
  
OPEN SYMMETRIC KEY Userpassword_FL  
DECRYPTION BY CERTIFICATE Userpassword;  
   
SELECT *, 
    CONVERT(varchar, DecryptByKey([Password]))   
    AS 'Decrypted password'  
    FROM USERS;   

--------------------------------------------------------------BOOKING-------------------------------------------------------------------

INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (1,501,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.001,'Pending');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (2,502,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.005,'Failed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (3,503,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.004,'Completed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (4,504,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.003,'Completed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (5,505,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.009,'Pending');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (6,506,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.01,'Failed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (7,507,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.007,'Completed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (8,508,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.006,'Pending');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (9,509,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.001,'Completed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (10,510,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.1,'Failed');
INSERT INTO BOOKING (PersonID,PassengerID,BookingTimestamp,TransactionTimestamp,TrasactionStatus) VALUES (11,511,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.2,'Failed');


----------------------------------------------------------------PASSENGER----------------------------------------------------------------

INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (1,'Adult');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (2,'Infant');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (3,'Adult');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (4,'Children');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (5,'Children');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (6,'Adult');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (7,'Children');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (8,'Infant');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (9,'Adult');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (10,'Children');
INSERT INTO PASSENGER (BookingID,PassengerType) VALUES (11,'Infant');

---------------------------------------------------------------AIRCRAFT-----------------------------------------------------------------

INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Boeing','747',120,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Airbus','333',180,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Embraer','250',150,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Bombardier','111',20,'Private');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Boeing','787',220,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Airbus','350',240,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Embraer','120',220,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Bombardier','282',20,'Private');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Boeing','877',240,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Airbus','433',160,'Commercial');
INSERT INTO Aircraft (ManufacturingCompany,ModelNumber,Seats,ModelType) 
VALUES ('Bombardier','186',30,'Private');

-----------------------------------------------------------EMPLOYEE---------------------------------------------------------------------

INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('John','Adam','1985-03-05','johnny10@gmail.com','9967456921',1,'Airport');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Megan','Turner','1990-01-10','megan77@gmail.com','8756430921',Null,'Remote');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Alissa','Cline','1992-07-15','cline34@rediffmail.com','7598468215',3,'Airline');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Evelyn','Shaw','1989-10-27','evelyn78@rediffmail.com','9865732916',Null,'Airport');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Casey','Cole','1980-05-20','casey45@gmail.com','7863290416',5,'Airline');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Dane','Holt','1993-08-12','dane12@gmail.com','8765490213',Null,'Remote');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Tom','Lee','1991-04-07','tommy07@yahoo.com','7692369812',Null,'Airline');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Jack','Steward','1987-09-21','jackie21@gmail.com','9945872691',Null,'Airport');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Lacey','Fox','1988-08-31','lacey31@gmail.com','8649362174',9,'Airline');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Olive','Lang','1991-12-25','olive25@yahoo.com','9443746281',Null,'Remote');
INSERT INTO EMPLOYEE (FirstName,LastName,DateOfBirth,Email,PhoneNumber,ManagerID,EmployeeType) 
VALUES ('Ryan','Harrison','1994-02-28','ryan28@rediffmail.com','8469214530',Null,'Airport');

--------------------------------------------------------------AIRPORTS--------------------------------------------------------------------

INSERT INTO Airports VALUES
('BOS', 'Logan International Airport', 'Boston');
INSERT INTO Airports VALUES
('JFK', 'John.F.Kennedy International Airport', 'Newyork City');
INSERT INTO Airports VALUES
('HYD', 'Rajiv Gandhi International Airport', 'Hyderabad');
INSERT INTO Airports VALUES
('BOM', 'Chatrapathi Shivaji International Airport', 'Mumbai');
INSERT INTO Airports VALUES
('DEL', 'Indira Gandhi International Airport', 'Delhi');
INSERT INTO Airports VALUES
('MAA', 'Chennai International Airport', 'Chennai');
INSERT INTO Airports VALUES
('LHR', 'London Heathrow International Airport', 'London');
INSERT INTO Airports VALUES
('DOH', 'Hamad International Airport', 'Doha');
INSERT INTO Airports VALUES
('DXB', 'Dubai International Airport', 'Dubai');
INSERT INTO Airports VALUES
('AUH', 'Abu Dhabi International Airport', 'Abu Dhabi');
INSERT INTO Airports VALUES
('SFO ', 'San Francisco International Airport', 'SanFrancisco');

--------------------------------------------------------AIRPORTEMPLOYEE----------------------------------------------------------------
INSERT INTO AIRPORTEMPLOYEE(AirportID)
SELECT AirportID from Airports;
select * from aiportemployee

--WORKLOCATION
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Boston','Boston Logan Intl Airport MA',500);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Hyderabad','Rajiv Gandhi Intl Airport Telangana',250);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Delhi','Indira Gandhi Intl Airport New Delhi',400);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Mumbai','Chhatrapati Shivaji Maharaj Intl Airport',500);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Chennai','Chennai Intl Airport',300);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('New York','JFK Intl Airport',350);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('London','Heathrow Intl Airport',600);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Doha','Hamad Intl Airport',550);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Dubai','Dubai Intl Airport',450);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('Abu Dhabi','Abu Dhabi Intl Airport',400);
INSERT INTO WorkLocation (LocationName,Address,NumberOfEmployees) VALUES ('San Fransisco','San Fransisco Intl Airport',500);

--REMOTEEMPLOYEE
INSERT INTO REMOTEEMPLOYEE (LocationID)
SELECT LocationID FROM WORKLOCATION

--AIRLINE
INSERT INTO Airline (AirlineName,AirlineType) VALUES ('United Airlines','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Delta','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('American Airlines','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Air India','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Indigo','National');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('SpiceJet','National');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Qatar Airlines','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('United Airlines','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('United Airlines','Major');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Indigo','National');

INSERT INTO Airline (AirlineName,AirlineType) VALUES ('Indigo','Regional');

--AIRLINEEMPLOYEE
INSERT INTO AIRLINEEMPLOYEE (AirlineID) SELECT AirlineID FROM AIRLINE;

UPDATE AIRLINEEMPLOYEE 
SET SALARY= 10000
WHERE  EmployeeID in (1,2,3,4,5) ;

UPDATE AIRLINEEMPLOYEE 
SET SALARY= 15000
WHERE  EmployeeID not in (1,2,3,4,5) ;

----------------------------------------------------------------BAGGAGE-----------------------------------------------------------------
INSERT INTO Baggage (PassengerID,BookingID)
SELECT PassengerID,BookingID FROM BOOKING;

UPDATE Baggage
SET BaggageWeight= 46.5
WHERE BaggageID IN(1,2,3,4);

UPDATE Baggage
SET BaggageWeight= 72
WHERE BaggageID IN(5,6,7,8);

UPDATE Baggage
SET BaggageWeight= 23
WHERE BaggageID IN(9,10,11);

-------------------------------------------------------ROUTE-----------------------------------------------------------------------------

INSERT INTO [ROUTE] VALUES
('BOS367','HYD','BOS');
INSERT INTO [ROUTE] VALUES
('JFK987','MAA','JFK');
INSERT INTO [ROUTE] VALUES
('BOS239','LHR','BOS');
INSERT INTO [ROUTE] VALUES
('JFK084','DEL','JFK');
INSERT INTO [ROUTE] VALUES
('SFO387','HYD','SFO');
INSERT INTO [ROUTE] VALUES
('BOS206','DOH','BOS');
INSERT INTO [ROUTE] VALUES
('DXB645','MAA','DXB');
INSERT INTO [ROUTE] VALUES
('JFK297','DXB','JFK');
INSERT INTO [ROUTE] VALUES
('BOS254','JFK','BOS');
INSERT INTO [ROUTE] VALUES
('BOS324','AUH','BOS');

-----------------------------------------------------------PAYMENT-----------------------------------------------------------------------

INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (1,'credit','6539352053784972','10-3-2028');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (2,'credit','2969359463784278','1-2-2028');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (3,'debit','9469359463784323','10-2-2028');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (4,'debit','1239359463784972','9-2-2028');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (5,'credit','7639359463784332','10-2-2030');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (6,'debit','9439359463784278','1-2-2030');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (7,'credit','6639359463784336','11-2-2030');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (8,'debit','9748759463256734','11-2-2030');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (9,'debit','6998759463256111','5-12-2030');
INSERT INTO [Payment]( [BookingID], [cardtype], [cardnumber], [expirydate])
VALUES (10,'credit','6539359463784972','10-2-2028');

----------------------------------------------------FLIGHTSCHEDULE---------------------------------------------------------------------

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.5,'SJ 300',70, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%367'),10004);

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.15,'QA 1000',150, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%645'),10005);

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.25,'IGO 600',40, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%084'),10006);

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.8,'DA 890',120, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%297'),10007);
INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.6,'IGO 700',90, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%987'),10008);

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.7,'UA 4678',120, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%387'),10009);

INSERT INTO FLIGHTSCHEDULE (DepartureTimestamp,ArrivalTimestamp,FlightStatusCode,SeatAvailable,RouteNumber,AINNumber)

VALUES (CURRENT_TIMESTAMP,CURRENT_TIMESTAMP+0.9,'DA 450',120, (SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%297'),10010);

---------------------------------------------------------TRIP---------------------------------------------------------------------------

INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%206'),72.0, 30, 5);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%239'),46.0, 240, 10);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%254'),46.0, 100, 7);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%324'),72.0, 90, 9);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%367'),46.0, 120, 12);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%645'),23.0, 70, 8);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%084'),72.0, 150, 11);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%297'),23.0,180,6);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%987'),72.0, 130, 10);
INSERT INTO Trip (RouteNumber,BaggageAllowance,PassengersCount,CrewMembersCount) VALUES
((SELECT RouteNumber FROM ROUTE WHERE RouteNumber LIKE '%387'),72.0,80,6);

-----------------------------------------------------------IMMUNIZATION------------------------------------------------------------------

INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(501,'ASTRAZENECA','2021-07-28 09:00:00','Portugal');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(502,'SPUTNIK','2021-08-20 11:00:00','Argentina');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(503,'PFIZER','2021-09-15 08:00:00','Brazil');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(504,'PFIZER','2021-05-10 10:00:00','Portugal');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(505,'ASTRAZENECA','2021-06-07 09:30:00','United Kingdom');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(506,'MODERNA','2021-04-18 10:30:00','Spain');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(507,'JANSSEN','2021-05-25 12:00:00','Spain');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(508,'PFIZER','2021-04-28 10:00:00','Serbia');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(509,'MODERNA','2021-05-08 14:00:00','Brazil');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(510,'SPUTNIK','2021-06-12 12:30:00','Brazil');
INSERT INTO Immunization (PassengerID,ImmunizationName,CompletedTimestamp,ImmunizationCountry) VALUES 
(511,'ASTRAZENECA','2021-07-01 10:30:00','Spain');


--------------------------------------------------------------TICKET--------------------------------------------------------------------

INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (1, 1, 4);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (2, 2, 2);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (3, 3, 3);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (4, 4, 1);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (5, 5, 4);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (6, 6, 8);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (7, 7, 2);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (8, 8, 5);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (9, 9, 1);
INSERT INTO [Ticket]([BookingID], [FlightScheduleID], [layovertime])
VALUES (10, 10, 12);

















INSERT INTO USERS (Username)
SELECT LASTNAME from PERSON;

--COLUMN DATA ENCRYPTION - PASSWORD
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Flightbooking2021';

SELECT name as KeyName, symmetric_key_id as KeyID,key_length as KeyLength, algorithm_desc as KeyAlgorithm
FROM sys.symmetric_keys;

CREATE CERTIFICATE Userpassword  WITH SUBJECT = 'User Password';   

CREATE SYMMETRIC KEY Userpassword_FL WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Userpassword;  

OPEN SYMMETRIC KEY Userpassword_FL DECRYPTION BY CERTIFICATE Userpassword;  

UPDATE USERS 
SET Password = EncryptByKey(Key_GUID('Userpassword_FL'),  convert(varbinary,'Flight2021'))
  
OPEN SYMMETRIC KEY Userpassword_FL  
DECRYPTION BY CERTIFICATE Userpassword;  
   
SELECT *, 
    CONVERT(varchar, DecryptByKey([Password]))   
    AS 'Decrypted password'  
    FROM USERS;   

