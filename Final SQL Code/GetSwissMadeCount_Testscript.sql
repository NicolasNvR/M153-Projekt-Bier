use Bierverwaltung


--Die Funktion wird mit dem Parameter @SorteId aufgerufen, der den Wert 1 enthält.
--Ausführung der SELECT-Anweisung, um das Ergebnis der Funktion anzuzeigen, das die Anzahl der SwissMade-Biere für die Sorte mit der ID 1 enthält.
DECLARE @SorteId INT = 1; -- Sorte mit SwissMade Biere

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go

--Die Funktion wird mit dem Parameter @SorteId aufgerufen, der den Wert 3 enthält.
--Ausführung der SELECT-Anweisung, um das Ergebnis der Funktion anzuzeigen, das die Anzahl der SwissMade-Biere für die Sorte mit der ID 3 enthält.
DECLARE @SorteId INT = 3; -- Sorte ohne SwissMade Biere

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go

--Die Funktion wird mit dem Parameter @SorteId aufgerufen, der den Wert 0 enthält.
--Ausführung der SELECT-Anweisung, um das Ergebnis der Funktion anzuzeigen, das NULL enthält, da die Sorte-ID falsch ist und keine entsprechenden SwissMade-Biere gefunden werden können.
DECLARE @SorteId INT = 0; -- Falsche Sorte Id

SELECT dbo.fn_GetSwissMadeCount(@SorteId) AS SwissMadeCount;
go
