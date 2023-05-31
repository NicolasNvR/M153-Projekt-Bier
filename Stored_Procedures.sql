USE Bierverwaltung
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBeerDetails]') AND type IN (N'P', N'PC'))
    DROP PROCEDURE [dbo].[GetBeerDetails]
GO

CREATE PROCEDURE GetBeerDetails
    @BierId INT
AS
BEGIN
    -- Überprüfen auf ungültige oder leere Argumente
    IF (@BierId IS NULL)
    BEGIN
        RAISERROR ('Ungültiges oder leeres Argument für @BierId angegeben', 16, 1)
        RETURN -1
    END

    -- Variablen deklarieren
    DECLARE @RowCount INT

    -- Bierdetails abrufen
    SELECT B.BierId, S.Name AS Sorte, H.Name AS Hersteller, R.Preis, R.Ablaufsdatum, R.Herstellungsdatum
    INTO #TempBeerDetails
    FROM Bier B
    INNER JOIN Sorte S ON B.fk_SorteId = S.SorteId
    INNER JOIN Hersteller H ON B.fk_HerstellerId = H.HerstellerId
    INNER JOIN Rezeptur R ON B.fk_RezepturId = R.RezepturId
    WHERE B.BierId = @BierId

    -- Anzahl der betroffenen Datensätze ermitteln
    SET @RowCount = @@ROWCOUNT

    -- Überprüfen auf leere Ergebnisse
    IF (@RowCount = 0)
    BEGIN
        -- Nullwert oder benutzerdefinierten Wert zurückgeben, wie gewünscht
        SELECT NULL AS BierId, NULL AS Sorte, NULL AS Hersteller, NULL AS Preis, NULL AS Ablaufsdatum, NULL AS Herstellungsdatum
        RETURN 0
    END

    -- Bierdetails zurückgeben
    SELECT BierId, Sorte, Hersteller, Preis, Ablaufsdatum, Herstellungsdatum
    FROM #TempBeerDetails

    -- Anzahl der betroffenen Datensätze zurückgeben
    RETURN @RowCount
END
GO
