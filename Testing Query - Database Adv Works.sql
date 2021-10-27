--test queries for getting to know the database

select top 10 * from [Person].[Person]
select * from [Person].[Address]
/*
select * from [Person].[EmailAddress]
select * from [Person].[AddressType]
select * from [Production].[Product]
select * from [HumanResources].[Employee]
select * from [Production].[Product]
*/

select top 10 * from [Person].[Person] P
join [Person].[Address] A on P.rowguid = A.rowguid
where P.BusinessEntityID = 1;

select top 20 * from [HumanResources].[Employee] E
join [Person].[Person] P on E.BusinessEntityID = P.BusinessEntityID
join [HumanResources].[EmployeeDepartmentHistory] DH on E.BusinessEntityID = dh.BusinessEntityID
join [HumanResources].[Department] D on dh.DepartmentID = D.DepartmentID
where E.BusinessEntityID = 1

select top 10 * from [Production].[Product] order by ProductID;
