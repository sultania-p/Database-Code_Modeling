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




