/*CREATE PROCEDURE Person.usp_FilterFirstName
@Name nvarchar(50) = 'Ruth'
AS
RETURN (SELECT COUNT(*)
		FROM Person.Person AS P
		WHERE P.FirstName = @Name)
*/
DECLARE @FilteredNames INT
EXEC @FilteredNames = Person.usp_FilterFirstName 'Andrew'
PRINT @FilteredNames