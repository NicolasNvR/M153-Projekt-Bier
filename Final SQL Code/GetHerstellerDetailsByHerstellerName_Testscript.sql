use Bierverwaltung

-- Test 1 mit Vorhandenem HerstellerName als Input
EXEC sp_GetHerstellerDetailsByHerstellerName 'Feldschlösschen'; 
go

-- Test 2 mit Falschem HerstellerName als Input
EXEC sp_GetHerstellerDetailsByHerstellerName 'NichtVorhandenerHersteller'; 
go

-- Test 3 ohne HerstellerName als Input
EXEC sp_GetHerstellerDetailsByHerstellerName ''; 
go