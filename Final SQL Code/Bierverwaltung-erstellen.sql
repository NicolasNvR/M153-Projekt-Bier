--********************************************************************
-- Bierverwaltung: Skript zum Erstellen der Datenbank mit allen Tabellen
--********************************************************************

----------------------------------------------------------------------
-- Datenbank erstellen
----------------------------------------------------------------------

use master
go
drop database if exists Bierverwaltung
go
create database Bierverwaltung
go
use Bierverwaltung
go

----------------------------------------------------------------------
-- Tabellen erstellen (alphabetisch, ohne Beziehungen)
----------------------------------------------------------------------

create table Bier (
  BierId integer identity,
  fk_SorteId integer,
  fk_HerstellerId integer,
  fk_RezepturId integer,
  primary key(BierId)
);

create table Hersteller (
  HerstellerId integer identity,
  fk_StandortId integer,
  SwissMade bit,
  Name varchar(50),
  primary key(HerstellerId)
);

create table Rezeptur (
  RezepturId integer identity,
  Preis decimal(9,2),
  Ablaufsdatum date,
  Herstellungsdatum date,
  primary key(RezepturId)
);

create table Sorte (
  SorteId integer identity,
  Name varchar(50),
  primary key(SorteId)
);

create table SorteHersteller (
  SorteHerstellerId integer identity,
  fk_SorteId integer,
  fk_HerstellerId integer,
  primary key(SorteHerstellerId)
);

create table Standort (
  StandortId integer identity,
  Strasse varchar(40),
  PLZ varchar(10),
  Ortschaft varchar(40),
  primary key(StandortId)
);
go 

----------------------------------------------------------------------
-- Beziehungen erstellen
----------------------------------------------------------------------
alter table Bier add
  foreign key(fk_SorteId) references Sorte(SorteId),
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId),
  foreign key(fk_RezepturId) references Rezeptur(RezepturId);

alter table SorteHersteller add
  foreign key(fk_SorteId) references Sorte(SorteId),
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId);

alter table Hersteller add
  --foreign key(fk_SorteId) references SorteHersteller(SorteId),
  foreign key(fk_StandortId) references Standort(StandortId);

--alter table Sorte add
  --foreign key(fk_HerstellerId) references SorteHersteller(HerstellerId);


go


----------------------------------------------------------------------
-- Stored Prozedure sp_GetBeerDetails erstellen
----------------------------------------------------------------------

USE Bierverwaltung
GO

DROP PROCEDURE IF EXISTS [dbo].[sp_GetBeerDetails]
GO

CREATE PROCEDURE sp_GetBeerDetails
    @BierId INT
AS
BEGIN
    -- Überprüfen auf ungültige oder leere Argumente
    IF (@BierId IS NULL OR NOT EXISTS (SELECT 1 FROM Bier WHERE BierId = @BierId))
    BEGIN
        RAISERROR ('BierId ist ungültig', 16, 1)
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



----------------------------------------------------------------------
-- Stored Prozedure sp_GetHerstellerDetailsByHerstellerName erstellen
----------------------------------------------------------------------

DROP PROCEDURE IF EXISTS [dbo].[sp_GetHerstellerDetailsByHerstellerName]
GO

CREATE PROCEDURE sp_GetHerstellerDetailsByHerstellerName
    @HerstellerName VARCHAR(50)
AS
BEGIN
	-- Überprüfen, ob ein Herstellername mitgegeben wurde
    IF @HerstellerName = ''
    BEGIN
        -- Kein Hersteller mitgegeben
        SELECT 'Kein Hersteller mitgegeben' AS Message;
        RETURN;
    END

    -- HerstellerId basierend auf dem Hersteller Namen abrufen
    DECLARE @HerstellerId INT;
    SELECT @HerstellerId = HerstellerId FROM Hersteller WHERE Name = @HerstellerName;

    -- Wenn HerstellerId gefunden wurde, Sorte und Standort Details abrufen
    IF @HerstellerId IS NOT NULL
    BEGIN
        -- Sorte und Standort Details abrufen
        SELECT Hersteller.Name AS HerstellerName, Sorte.Name AS SortenName, Standort.Strasse, Standort.PLZ, Standort.Ortschaft
        FROM Sorte
        INNER JOIN SorteHersteller ON Sorte.SorteId = SorteHersteller.fk_SorteId
        INNER JOIN Hersteller ON SorteHersteller.fk_HerstellerId = Hersteller.HerstellerId
        INNER JOIN Standort ON Hersteller.fk_StandortId = Standort.StandortId
        WHERE Hersteller.HerstellerId = @HerstellerId;
    END
    ELSE
    BEGIN
        -- Kein Hersteller gefunden
        SELECT 'Kein Hersteller gefunden' AS Message;
    END
END;


----------------------------------------------------------------------
-- Function fn_GetSwissMadeCount erstellen
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS fn_GetSwissMadeCount
go

-- Funktion erstellen, um die Anzahl der Swiss-Made-Biere für eine bestimmte Sorte zu erhalten
CREATE FUNCTION fn_GetSwissMadeCount (@SorteId INT)
RETURNS INT
AS
BEGIN
    DECLARE @SwissMadeCount INT;
    
    IF @SorteId = 0
        SET @SwissMadeCount = NULL; -- Wenn SorteId 0 ist, wird NULL zurückgegeben
    ELSE
        SELECT @SwissMadeCount = COUNT(Bier.BierId)
        FROM Bier
        INNER JOIN Hersteller ON Bier.fk_HerstellerId = Hersteller.HerstellerId
        INNER JOIN SorteHersteller ON SorteHersteller.fk_HerstellerId = Hersteller.HerstellerId
        WHERE SorteHersteller.fk_SorteId = @SorteId
        AND Hersteller.SwissMade = 1;
    
    RETURN @SwissMadeCount;
END;
GO


----------------------------------------------------------------------
-- Function fn_GetSortenByHerstellerId erstellen
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS fn_GetSortenByHerstellerId;
go

-- Funktion erstellen, um Sorten mit Herstellernamen und Sortennamen basierend auf HerstellerId zu erhalten
CREATE FUNCTION fn_GetSortenByHerstellerId (@HerstellerId INT)
RETURNS @Result TABLE (SortenName VARCHAR(50), HerstellerName VARCHAR(50))
AS
BEGIN
    IF @HerstellerId = 0 OR @HerstellerId IS NULL
    BEGIN
        INSERT INTO @Result (SortenName, HerstellerName)
        VALUES (NULL, NULL);
    END
    ELSE
    BEGIN
        INSERT INTO @Result (SortenName, HerstellerName)
        SELECT Sorte.Name AS SortenName, Hersteller.Name AS HerstellerName
        FROM Sorte
        INNER JOIN SorteHersteller ON Sorte.SorteId = SorteHersteller.fk_SorteId
        INNER JOIN Hersteller ON SorteHersteller.fk_HerstellerId = Hersteller.HerstellerId
        WHERE Hersteller.HerstellerId = @HerstellerId;
    END;

    RETURN;
END;

