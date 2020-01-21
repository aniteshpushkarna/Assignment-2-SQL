--1
SELECT count(*) 'Total Records'
	FROM Sales.SalesPerson;

--2
SELECT Person.FirstName 'First Name',
		Person.LastName 'Last Name'
	FROM Person.Person AS Person
	WHERE Person.FirstName LIKE 'B%';

--3
SELECT Person.FirstName 'First Name',
		Person.LastName 'Last Name'
		FROM Person.Person AS Person
		INNER JOIN HumanResources.Employee AS Employee
		ON Person.BusinessEntityID = Employee.BusinessEntityID
		WHERE Employee.JobTitle IN ('Design Engineer', 'Tool Designer' ,'Marketing Assistant');

--4
SELECT Product.Name 'Name',
		Product.Color 'Color'
		FROM Production.Product AS Product
		WHERE Product.Weight = (SELECT MAX(Product.Weight) FROM Production.Product AS PRODUCT);

--5
SELECT SpecialOffer.Description 'Description',
		ISNULL(SpecialOffer.MaxQty,0.0) 'Max Quantity'
		FROM Sales.SpecialOffer AS SpecialOffer;

--6
SELECT AVG(CurrencyRate.AverageRate) 'Average Rate'
		FROM Sales.CurrencyRate AS CurrencyRate
		WHERE CurrencyRate.FromCurrencyCode = 'USD' AND 
			  CurrencyRate.ToCurrencyCode = 'GBP' AND
			  YEAR(CurrencyRate.CurrencyRateDate) = 2005

--7
SELECT ROW_NUMBER() OVER(ORDER BY Person.FirstName) 'ID',
		Person.FirstName 'First Name',
		Person.LastName 'Last Name'
		FROM Person.Person AS Person
		WHERE Person.FirstName LIKE '%ss%';

--8
SELECT SalesPerson.BusinessEntityID 'ID',
		CASE 
			WHEN SalesPerson.CommissionPct = 0.0 THEN 'Band 0'
			WHEN SalesPerson.CommissionPct < 1.0 THEN 'Band 1'
			WHEN SalesPerson.CommissionPct < 1.5 THEN 'Band 2'
			ELSE 'Band 3'
		END 'Commission Band'
		FROM Sales.SalesPerson AS SalesPerson

--9
DECLARE @BusinessEntity int = 
(SELECT P.BusinessEntityID FROM Person.Person AS P
WHERE P.FirstName = 'Ruth' 
AND P.LastName = 'Ellerbrock' 
AND P.PersonType = 'EM');

EXEC uspGetEmployeeManagers @BusinessEntity

--10
SELECT	Product.ProductID
		FROM Production.Product AS Product
		WHERE dbo.ufnGetStock(Product.ProductID) = 
		(SELECT MAX(dbo.ufnGetStock(Product.ProductID)) FROM Production.Product);