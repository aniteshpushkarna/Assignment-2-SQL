
Alter trigger UpdateCondition ON dbo.DimProduct
	instead of update
	AS 
	BEGIN
		SET NOCOUNT ON
		IF ( UPDATE(ListPrice) )
		BEGIN
			UPDATE dbo.DimProduct
			SET ListPrice = i.ListPrice
			FROM DELETED AS d inner join INSERTED AS i ON d.ProductKey = i.ProductKey
			WHERE i.ListPrice - d.ListPrice < 0.15*(d.ListPrice)
			AND dbo.DimProduct.ProductKey = i.ProductKey
		END
	END;


update dbo.DimProduct
set ListPrice = 14
where dbo.DimProduct.ProductKey = 1;

select dbo.DimProduct.ProductKey,dbo.DimProduct.ListPrice from dbo.DimProduct;