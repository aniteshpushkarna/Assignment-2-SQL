--USING JOIN
SELECT Customer.CustomerID,Customer.PersonID
		FROM Sales.Customer AS Customer
		LEFT JOIN Sales.SalesOrderHeader AS OrderHeader 
		ON Customer.CustomerID = OrderHeader.CustomerID
		WHERE OrderHeader.CustomerID IS NULL

--USING SUB QUERY
SELECT Customer.CustomerID
		FROM Sales.Customer AS Customer
		WHERE Customer.CustomerID NOT IN 
		(SELECT ORDERHEADER.CustomerID 
		FROM Sales.SalesOrderHeader AS ORDERHEADER)

--USING CTE
WITH NotPlacedOrder AS
(
	SELECT OrderHeader.CustomerID
			FROM Sales.SalesOrderHeader AS OrderHeader
)

--USING EXISTS
SELECT Customer.CustomerID
		FROM Sales.Customer AS Customer
		WHERE NOT EXISTS 
		(SELECT ORDERHEADER.CustomerID 
		FROM Sales.SalesOrderHeader AS OrderHeader
		WHERE Customer.CustomerID = OrderHeader.CustomerID)
