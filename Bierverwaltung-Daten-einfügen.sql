--********************************************************************
-- Bierverwaltung: Skript zum Einfügen der Daten
--********************************************************************

----------------------------------------------------------------------
-- Auf Bierverwaltung ComputerShop positionieren
----------------------------------------------------------------------
use Bierverwaltung
go

----------------------------------------------------------------------
-- Alle Daten der Tabellen löschen
----------------------------------------------------------------------
delete from Bier;
delete from SorteHersteller;
delete from Hersteller;
delete from Sorte;
delete from Rezeptur;
delete from Standort;

go

----------------------------------------------------------------------
-- Identity zurücksetzen
----------------------------------------------------------------------
dbcc checkident(Bier, reseed, 0);
dbcc checkident(Hersteller, reseed, 0);
dbcc checkident(Sorte, reseed, 0);
dbcc checkident(Rezeptur, reseed, 0);
dbcc checkident(Standort, reseed, 0);
dbcc checkident(SorteHersteller, reseed, 0);
go


----------------------------------------------------------------------
-- Rezeptur abfüllen
----------------------------------------------------------------------
INSERT INTO Rezeptur(Preis, Ablaufsdatum, Herstellungsdatum) 
VALUES
	('5','2023-08-15','2022-12-15'),
	('12','2024-10-15','2022-11-01'),
	('6','2025-11-16','2021-11-12'),
	('3','2025-11-12','2023-02-11'),
	('2','2025-10-06','2020-05-15'),
	('6.50','2024-08-03','2020-05-07'),
	('13','2024-07-08','2020-12-09'),
	('2.50','2024-07-22','2022-02-15'),
	('7','2025-10-21','2022-12-10'),
	('8','2024-01-29','2022-11-11'),
	('7','2024-03-27','2021-04-04'),
	('7','2025-03-30','2021-10-06'),
	('8','2025-11-17','2021-08-06'),
	('9','2026-04-14','2020-09-24'),
	('14','2026-05-30','2020-02-26'),
	('15','2025-08-22','2020-03-27'),
	('6','2023-09-25','2022-03-29'),
	('6','2023-11-24','2023-05-30'),
	('6','2025-08-29','2023-07-30'),
	('6','2025-06-27','2023-08-30'),
	('5','2025-12-22','2023-11-29')
go

----------------------------------------------------------------------
-- Standort abfüllen
----------------------------------------------------------------------
INSERT INTO Standort (Strasse, PLZ, Ortschaft)
VALUES
    ('Musterstrasse 1', '8000', 'Zürich'),
    ('Hauptplatz 5', '3000', 'Bern'),
    ('Bahnhofstrasse 10', '8001', 'Zürich'),
    ('Marktgasse 2', '3011', 'Bern'),
    ('Rue du Lac 8', '1003', 'Lausanne'),
    ('Schlossberg 3', '9000', 'St. Gallen'),
    ('Seestrasse 20', '6004', 'Luzern'),
    ('Neugasse 15', '4001', 'Basel'),
    ('Bergweg 12', '8002', 'Zürich'),
    ('Rathausplatz 7', '3012', 'Bern'),
    ('Avenue des Alpes 6', '1005', 'Lausanne'),
    ('Hauptstrasse 30', '9001', 'St. Gallen'),
    ('Schifflände 1', '6005', 'Luzern'),
    ('Spalenberg 8', '4002', 'Basel'),
    ('Parkweg 3', '8003', 'Zürich'),
    ('Kornhausplatz 2', '3013', 'Bern'),
    ('Rue de Genève 12', '1006', 'Lausanne'),
    ('Am See 5', '9002', 'St. Gallen'),
    ('Mühlenplatz 10', '6006', 'Luzern'),
    ('Rheingasse 15', '4003', 'Basel')
go


----------------------------------------------------------------------
-- Sorte Ort abfüllen
----------------------------------------------------------------------
INSERT INTO Sorte (name) 
VALUES 
    ('Lager'),
    ('Ale'),
    ('Weizen'),
    ('Lambic'),
    ('Stout'),
    ('Porter'),
    ('Koelsch'),
    ('Dunkel'),
    ('Winston'),
    ('Bock'),
    ('Maerzen'),
    ('Saison'),
    ('Witbier'),
    ('Belgian Tripel'),
    ('Scotch Ale'),
    ('Czechvar'),
    ('Berliner Weisse'),
    ('Click'),
    ('Hefeweizen'),
    ('Pilsner')
go

----------------------------------------------------------------------
-- Hersteller Ort abfüllen
----------------------------------------------------------------------
INSERT INTO Hersteller (fk_StandortId, Swissmade, Name)
VALUES
	(13, 1, 'Feldschloesschen'),
	(19, 1, 'Rugenbraeu'),
	(2, 0, 'BrewDog'),
	(3, 1, 'Appenzeller'),
	(4, 1, 'Schlossbrauerei Au'),
	(8, 0, 'Guinness'),
	(1, 1, 'Eichhof'),
	(7, 1, 'Brauerei Falken'),
	(12, 0, 'Heineken'),
	(17, 1, 'Brauerei Locher'),
	(20, 1, 'Feldschloesschen'),
	(9, 0, 'Molson Coors'),
	(11, 1, 'Schlossbrauerei Utenberg'),
	(15, 1, 'Brauerei Schuetzengarten'),
	(10, 0, 'Carlsberg'),
	(14, 1, 'Brauerei Waedenswil'),
	(18, 1, 'Brauerei Baar'),
	(5, 0, 'AB InBev'),
	(16, 1, 'Calanda'),
	(6, 1, 'Brauerei Rosengarten')
go


----------------------------------------------------------------------
-- Bier Ort abfüllen
----------------------------------------------------------------------
INSERT INTO Bier (fk_SorteId, fk_RezepturId, fk_HerstellerId) 
VALUES
	(1, 4, 8),
	(8, 2, 3),
	(4, 1, 4),
	(19, 11, 19),
	(7, 12, 18),
	(7, 16, 16),
	(3, 17, 12),
	(2, 18, 10),
	(3, 19, 11),
	(7, 13, 5),
	(9, 8, 6),
	(12, 9, 5),
	(13, 5, 3),
	(17, 18, 9),
	(18, 10, 16),
	(14, 10, 16),
	(4, 2, 15),
	(8, 3, 12),
	(12, 9, 9),
	(13, 12, 1),
	(10, 14, 1),
	(7, 18, 2),
	(8, 3, 18),
	(8, 3, 19),
	(5, 3, 15),
	(3, 17, 13),
	(2, 19, 8),
	(1, 17, 12)
go



----------------------------------------------------------------------
-- SorteHersteller abfüllen
----------------------------------------------------------------------
INSERT INTO SorteHersteller (fk_SorteId, fk_HerstellerId)
VALUES
    (7, 15),
	(9, 19),
	(19, 3),
	(14, 17),
	(16, 11),
	(8, 10),
	(18, 4),
	(2, 13),
	(10, 2),
	(3, 14),
	(5, 7),
	(4, 5),
	(11, 12),
	(12, 8),
	(6, 18),
	(13, 16),
	(17, 20),
	(20, 9),
	(1, 1),
	(15, 6)
go
