use Bierverwaltung

DECLARE @SorteId INT = 1; -- Sorte mit SwissMade Biere

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go

DECLARE @SorteId INT = 3; -- Sorte ohne SwissMade Biere

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go

DECLARE @SorteId INT = 0; -- Falsche Sorte Id

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go
