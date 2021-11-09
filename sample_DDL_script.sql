/*
-- iF DATABASE EXISTS, DROP
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'sample')
    DROP DATABASE sample
GO

CREATE DATABASE [sample]
go
USE [sample]
GO

CREATE TABLE [dbo].[department](
	[dept_no] [char](4) NOT NULL,
	[dept_name] [varchar](25) NOT NULL,
	[location] [varchar](25) NULL,
 CONSTRAINT [prim_dept] PRIMARY KEY CLUSTERED 
([dept_no] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[employee](
	[emp_no] [int] NOT NULL,
	[emp_fname] [varchar](20) NOT NULL,
	[emp_lname] [varchar](20) NOT NULL,
	[dept_no] [char](4) NULL,
 CONSTRAINT [prim_emp] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [foreign_emp] FOREIGN KEY([dept_no])
REFERENCES [dbo].[department] ([dept_no])
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [foreign_emp]
GO


CREATE TABLE [dbo].[project](
	[project_no] [char](4) NOT NULL,
	[project_name] [varchar](50) NULL,
	[budget] [float] NULL,
 CONSTRAINT [prim_proj] PRIMARY KEY CLUSTERED 
(
	[project_no] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[works_on](
	[emp_no] [int] NOT NULL,
	[project_no] [char](4) NOT NULL,
	[job] [varchar](50) NULL,
	[enter_date] [date] NULL,
 CONSTRAINT [prim_works] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[project_no] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[works_on]  WITH CHECK ADD  CONSTRAINT [foreign1_works] FOREIGN KEY([emp_no])
REFERENCES [dbo].[employee] ([emp_no])
GO

ALTER TABLE [dbo].[works_on] CHECK CONSTRAINT [foreign1_works]
GO

ALTER TABLE [dbo].[works_on]  WITH CHECK ADD  CONSTRAINT [foreign2_works] FOREIGN KEY([project_no])
REFERENCES [dbo].[project] ([project_no])
GO

ALTER TABLE [dbo].[works_on] CHECK CONSTRAINT [foreign2_works]
GO

use sample
GO

INSERT INTO department (dept_no,dept_name,location) VALUES ('D1','Accounting','Dallas');
INSERT INTO department (dept_no,dept_name,location) VALUES ('D2','Finance','Seattle');
INSERT INTO department (dept_no,dept_name,location) VALUES ('D3','IT','Boston');
INSERT INTO department (dept_no,dept_name,location) VALUES ('D4','Operatins ','New York');
INSERT INTO department (dept_no,dept_name,location) VALUES ('D5','Sales','London');

INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15000','John ', 'Smith', 'D1');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15001','Mark', 'Kelter', 'D2');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15002','Peter', 'McDonalds', 'D3');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15003','Ba', 'Tran', 'D2');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15004','Rohit', 'Joshi', 'D3');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15005','Lei', 'Zhou', 'D4');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15006','Juan', 'Garcia', 'D5');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15007','Deshaun', 'Jackson', 'D2');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('15008','Lionell', 'Messi', 'D3');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('29346','Jay', 'Moser', 'D4');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('25348','Luke', 'Smith', 'D2');
INSERT INTO employee(emp_no,emp_fname, emp_lname,dept_no) VALUES ('28559','Matthew', 'Hoyer', 'D1');


INSERT INTO project (project_no,project_name ,budget ) VALUES('p1','Inventory system', 60000);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p2','CRM system', 90000);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p3','Order Management', 135000);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p4','Accounting System', 202500);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p5','ERP system', 303750);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p6','Data Warehouse', 455625);
INSERT INTO project (project_no,project_name ,budget ) VALUES('p7','corporate website', 683437.5);



INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15000','p1','Manager','1/3/2019');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15001','p2',null,'1/4/2019');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15002','p3','Software Developer','1/3/2020');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15003','p4','Data Engineer','1/4/2020');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15004','p5','Network Admin','1/3/2021');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15005','p6','Data Analyst','1/4/2021');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15006','p7','Data Engineer','1/3/2022');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15007','p1','Data Architect','1/4/2022');
INSERT INTO works_on (emp_no ,project_no ,job ,enter_date) VALUES ('15008','p2','DBA','1/3/2023');

*/

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



