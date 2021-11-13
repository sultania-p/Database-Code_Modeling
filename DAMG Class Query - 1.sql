create database DAMG6210;
GO

CREATE TABLE CUSTOMER
(
	CustomerID int NOT NULL,
	CustomerName nvarchar(25),
	CustomerAddress varchar(30),
	CustomerCity varchar(20),
	CustomerState char(2),
	CustomerPostalCode varchar(9),
	CONSTRAINT Customer_PK Primary Key (CustomerID)
);

--create product table
CREATE TABLE Product
(
	ProductID int not null,
	ProductDescription varchar(20),
	ProductFinish varchar(20) constraint ProductFinish_CHK CHECK
		(ProductFinish IN ('Cherry','Natural Ash','White Ash', 'Red Oak', 'Natural Oak')),
	ProductStandarPrice decimal(6,2),
	ProductLineID int
	CONSTRAINT Product_PK primary key (ProductID)
);

--create order table
CREATE TABLE [ORDER]
(
	OrderID int not null,
	CustomerID int,
	OrderDate datetime default getdate()
	CONSTRAINT Order_PK primary key (OrderID)
	CONSTRAINT CustomerID_FK foreign key (CustomerID) references Customer(CustomerID)
);

--crete orderline table
CREATE TABLE OrderLine
(
	OrderID int not null,
	ProductID int not null,
	OrderQuantity int
	CONSTRAINT OrderLine_PK primary key (OrderID,ProductID)
	CONSTRAINT OrderLine_OrderID_FK foreign key (OrderID) references [Order](OrderID),
	CONSTRAINT OrderLine_ProductID_FK foreign key (ProductID) references Product(ProductID)
);


select * from [dbo].[CUSTOMER];
select * from [dbo].Product;
select * from [dbo].[ORDER];
select * from [dbo].OrderLine;
select * from [dbo].[CUSTOMER_MA];

ALTER TABLE Customer ADD CustomerType varchar(20);
ALTER TABLE Customer ALTER COLUMN CustomerType varchar(30);

INSERT INTO CUSTOMER VALUES  
(1, 'Contemporary Casuals', '1355 S. Himes Blvd.', 'Gainesville', 'FL', '32601','Commercial');

INSERT INTO CUSTOMER VALUES  
(2, 'ABC Inc', '11 Main ST', 'Boston', 'MA', '02771','Commercial');

INSERT INTO CUSTOMER VALUES  
(3, 'XYZ Inc', '16 John Ave', 'Boston', 'MA', '02771','Commercial');

INSERT INTO [dbo].[Product] (
	ProductID ,
	ProductDescription ,
	ProductFinish,
	ProductStandarPrice ,
	ProductLineID
	)
	VALUES
	(1, 'End Table','Cherry',175,8);

INSERT INTO [dbo].[Product]  VALUES (2, 'King Chair','Natural Oak',400,8);
INSERT INTO [dbo].[Product]  VALUES (3, 'Big Table','Natural Oak',330,8);
INSERT INTO [dbo].[Product]  VALUES (4, 'Small Desk','Cherry',220,8);

INSERT into [dbo].[CUSTOMER_MA] select * from dbo.CUSTOMER where CustomerState = 'MA';


select CustomerState, count(*) C from CUSTOMER
group by CustomerState
order by C

select CustomerCity, count(*) City_Count from CUSTOMER
group by CustomerCity

ALTER TABLE CUSTOMER ALTER COLUMN CustomerState varchar(50);

ALTER TABLE CUSTOMER ADD CustomerCountry varchar(50);
ALTER TABLE CUSTOMER drop column CustomerCountry ;
--------


USE [DAMG6210]
GO

ALTER TABLE [dbo].[ORDER] DROP CONSTRAINT [CustomerID_FK]
GO

ALTER TABLE [dbo].[ORDER]  WITH CHECK ADD  CONSTRAINT [CustomerID_FK] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CUSTOMER] ([CustomerID])
GO

ALTER TABLE [dbo].[ORDER] CHECK CONSTRAINT [CustomerID_FK]
GO


select * from employee where dept_no='D1';
select * from employee where dept_no in ('D1','D2') and emp_no<15002;
select * from [dbo].[project] where budget>=100000;
select * from [dbo].[project] where budget>=90000 and budget <=303750;
select * from [dbo].[project] where budget between 90000 and 303750;
select * from [dbo].[project] where budget not between 100000 and 150000;
select min(budget) as minimum, max(budget) as maximum, avg(budget) as average, cast(avg(budget) as decimal(20,2)) as average_rounding
	from [dbo].[project] ;
select * from employee where dept_no<>'D1';
select distinct emp_lname  from employee;
select  emp_lname  from employee group by emp_lname; -- use distinct always for getting unique records..
select dept_no, count(*) emp_count from [dbo].[employee] group by dept_no having count(*)>=3
select * from [dbo].[works_on] where project_no = 'p2' and job is null;
select * from employee where emp_fname like '_a%';
select * from employee where substring(emp_fname,2,2) like 'a%';
select * from [dbo].[department] where location like '[C-F]%';
select * from employee;
select * from project;
select * from [dbo].[works_on];

select emp_fname,emp_lname,job--,d.location
from employee e
--inner join department d on e.dept_no=d.dept_no
left join works_on w on e.emp_no=w.emp_no

select emp_fname,emp_lname,budget,project_name
from employee e
 join works_on w on e.emp_no=w.emp_no
 join [dbo].[project] p on p.project_no = w.project_no
where budget >140000;

select emp_fname,emp_lname,budget,project_name, dept_name
from employee e
left join works_on w on e.emp_no=w.emp_no
left join [dbo].[project] p on p.project_no = w.project_no
left join department d on e.dept_no = d.dept_no
where dept_name = 'Finance';
/*
Write a SQL query that outputs a list of employees who work in the ‘Finance’ department along with their job title, enter date, project name, and budget. 
(see list of columns from sample output below).  
You must show all employees that work in the ‘Finance” department even if they didn’t work on any project.  You must submit both your query and an image of the output.
*/

select * from [dbo].[works_on];
select * from [dbo].[department];
select * from [dbo].[employee];
select * from [dbo].[project];
