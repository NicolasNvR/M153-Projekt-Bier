use Bierverwaltung

DECLARE @HerstellerId INT = 1; -- Hersteller mit Id 1 

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go

DECLARE @HerstellerId INT = 0; -- Nicht vorhandene HersellerId

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go

DECLARE @HerstellerId INT = 2; -- Hersteller mit Id 2

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go