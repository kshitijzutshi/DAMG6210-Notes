-- Exercise 1 
 
/* Retrieve only the following columns from the 
   Production.Product table: 
   Product ID 
   Name 
   Selling start date 
   Selling end date 
   Size 
   Weight */ 
 
 
-- Exercise 2 
 
/* Select all info for all orders with no credit card id. */ 
 
 
-- Exercise 3 
 
/* Select all info for all products with size specified. */  
 
 
-- Exercise 4 
 
/* Select all information for products that started selling  
   between January 1, 2007 and December 31, 2007. */ 
 
 
-- Exercise 5 
 
/* Select all info for all orders placed in June 2007 using date 
   functions, and include a column for an estimated delivery date  
   that is 7 days after the order date. */ 
 
 
 
 
-- Exercise 6 
 
/* Determine the date that is 30 days from today and display only  
   the date in mm/dd/yyyy format (4-digit year). */ 
 
 
-- Exercise 7 
 
/* Determine the number of orders, overall total due, 
   average of total due, amount of the smallest amount due, and  
   amount of the largest amount due for all orders placed in May 
   2008. Make sure all columns have a descriptive heading. */ 
 
 
-- Exercise 8 
 
/* Retrieve the Customer ID, total number of orders and overall total 
   due for the customers who placed more than one order in 2007  
   and sort the result by the overall total due in the descending 
   order. */ 
 
 
-- Exercise 9 
 
/*  
   Provide a unique list of the sales person ids who have sold  
   the product id 777. Sort the list by the sales person id. */ 
 
 
-- Exercise 10 
 
/* List the product ID, name, list price, size of products 
   Under the ‘Bikes’ category (ProductCategoryID = 1) and  
   Subcategory ‘Mountain Bikes’. */ 
 
-- Exercise 11 
 
/* List the SalesOrderID and currency name for each order. */ 







USE AdventureWorks2008R2;

-- Exercise 1 Sol.

SELECT ProductID , Name , SellStartDate , SellEndDate , [Size] , Weight  FROM AdventureWorks2008R2.Production.Product p


-- Exercise 2 Sol.

SELECT * FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh  WHERE CreditCardID IS NULL 

-- Exercise 3 Sol.

SELECT * FROM AdventureWorks2008R2.Production.Product p WHERE [Size] IS NOT NULL 

-- Exercise 4 Sol.

SELECT *  FROM AdventureWorks2008R2.Production.Product p WHERE SellStartDate BETWEEN '01/01/2007' AND '12/31/2007'


--Exercise 5 Sol.

SELECT *, DATEADD(DAY, 7, OrderDate) AS [ETA]  FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh  WHERE DATEPART(MONTH, OrderDate) = 6 AND DATEPART(YEAR, OrderDate) = 2007

-- Exercise 6 Sol.

SELECT DATEADD(DAY, 30, GETDATE()) AS [30 Days Post]   -- OUTPUT 2022-07-19 19:52:11.680

SELECT CONVERT(CHAR(20), DATEADD(DAY, 30, GETDATE()), 101) AS [30 Days Post]  -- OUTPUT 07/19/2022

-- Exercise 7 Sol.

SELECT COUNT(*) AS [No. of Orders], SUM(TotalDue) AS [Total Due], AVG(TotalDue) AS [Avg. Total Due], MIN(TotalDue) AS [Smallest Amt. Due], MAX(TotalDue) AS [Largest Amt. Due]  FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh  where DATEPART(MONTH, OrderDate) = 5 AND DATEPART(YEAR, OrderDate) = 2008

-- Exercise 8 Sol.

SELECT CustomerID , COUNT(*) AS [OrderCount], SUM(TotalDue) AS [TotalDue]  FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh WHERE (DATEPART(YEAR, OrderDate) = 2007) GROUP BY CustomerID  ORDER BY SUM([TotalDue]) DESC   

-- Exercise 9 Sol.

SELECT DISTINCT SalesPersonID  FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh INNER JOIN AdventureWorks2008R2.Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID  WHERE ProductID = 777 ORDER BY SalesPersonID 

-- Exercise 10 Sol.

SELECT p.ProductID , p.Name , p.ListPrice , p.[Size]  FROM AdventureWorks2008R2.Production.Product p INNER JOIN AdventureWorks2008R2.Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID WHERE ps.ProductCategoryID = 1 AND ps.Name = 'Mountain Bikes'

-- Exercise 11 Sol.

SELECT soh.SalesOrderID , c.Name  FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh INNER JOIN AdventureWorks2008R2.Sales.CurrencyRate cr ON soh.CurrencyRateID = cr.CurrencyRateID INNER JOIN AdventureWorks2008R2.Sales.Currency c ON c.CurrencyCode = cr.ToCurrencyCode 