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

/* Order collection */
SELECT TOP 10 * FROM [SALES].[SALESORDERDETAIL]

SELECT  OQ.CustomerID AS CustomerID, sum(TotalValue) as OrderAmount
from (
	SELECT
			SOH.SalesOrderID,
			CUS.CustomerID,
			[ProductID],
			[UnitPrice],
			[OrderQty],
			[UnitPrice] * [OrderQty]  AS TotalValue
	FROM SALES.SALESORDERHEADER SOH 
		JOIN [SALES].[SALESORDERDETAIL] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
		JOIN Sales.Customer CUS ON CUS.CustomerID = SOH.CustomerID
) OQ group by OQ.CustomerID order by sum(TotalValue) desc

SELECT TOP 20 * FROM [Person].[Person]
SELECT TOP 20 * FROM [Person].[BusinessEntityContact] 
--SELECT TOP 20 * FROM [Person].[BusinessEntity]

SELECT TOP 10 * FROM [Sales].[SalesPerson] SP
	JOIN [Sales].[SalesTerritory] ST ON SP.[TerritoryID] = ST.TerritoryID

