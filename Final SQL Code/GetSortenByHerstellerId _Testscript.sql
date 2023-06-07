use Bierverwaltung

--Die Funktion wird mit dem Parameter @HerstellerId aufgerufen, der den Wert 1 enthält.
--Die SELECT-Anweisung gibt die Sortennamen und den Herstellernamen für den Hersteller mit der ID 1 zurück
DECLARE @HerstellerId INT = 1; -- Hersteller mit Id 1 

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go

--Die Funktion wird mit dem Parameter @HerstellerId aufgerufen, der den Wert 0 enthält.
--Die SELECT-Anweisung gibt NULL-Werte für Sortenname und Herstellername zurück, da keine entsprechende Hersteller-ID gefunden wurde.
DECLARE @HerstellerId INT = 0; -- Nicht vorhandene HerstellerId

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go

--Die Funktion wird mit dem Parameter @HerstellerId aufgerufen, der den Wert 2 enthält.
--Die SELECT-Anweisung gibt die Sortennamen und Herstellernamen für den Hersteller mit der ID 2 zurück.
DECLARE @HerstellerId INT = 2;

SELECT SortenName, HerstellerName
FROM dbo.fn_GetSortenByHerstellerId(@HerstellerId);
go
