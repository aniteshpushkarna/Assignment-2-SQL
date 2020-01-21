WITH AccountNumbers(AccountNumber,TotalSpent)
AS
(
SELECT	OrderHeader.AccountNumber,SUM(OrderHeader.SubTotal)
		FROM Sales.SalesOrderHeader AS OrderHeader
		GROUP BY OrderHeader.AccountNumber
		HAVING SUM(OrderHeader.SubTotal) > 70000
)

SELECT	TOP 5 OrderHeader.AccountNumber,
		OrderHeader.OrderDate,
		AccountNumbers.TotalSpent
		FROM Sales.SalesOrderHeader AS OrderHeader
		INNER JOIN AccountNumbers
		ON AccountNumbers.AccountNumber = OrderHeader.AccountNumber
		ORDER BY OrderHeader.OrderDate DESC