CREATE FUNCTION Sales.ufn_SalesDetails
(@OrderId int,@CurrencyCode varchar(3),@OrderDate datetime)
RETURNS @Details TABLE(Qty int,id int,unitprice money)
AS
BEGIN
	DECLARE @Unit MONEY
	SET @Unit = (SELECT CurrencyRate.EndOfDayRate
			FROM Sales.CurrencyRate AS CurrencyRate
			WHERE CurrencyRate.FromCurrencyCode = 'USD' 
			AND CurrencyRate.ToCurrencyCode = @CurrencyCode
			AND CurrencyRate.CurrencyRateDate = @OrderDate)

	INSERT INTO @Details
		SELECT	OrderDetails.OrderQty,
			OrderDetails.ProductID,
			@Unit*OrderDetails.UnitPrice
			FROM Sales.SalesOrderDetail AS OrderDetails
			WHERE OrderDetails.SalesOrderID = @OrderId;
RETURN
END;
GO

SELECT * FROM Sales.ufn_SalesDetails(43659,'ARS','2005-07-01 00:00:00.000')