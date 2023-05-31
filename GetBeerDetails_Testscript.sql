-- Test 1: Gültige ID
DECLARE @RowCount INT

-- Test mit gültiger BierId
EXEC @RowCount = GetBeerDetails @BierId = 1

-- Überprüfen der Anzahl der betroffenen Datensätze
SELECT @RowCount AS 'Anzahl der Datensätze'



-- Test 2: Ungültige ID
DECLARE @RowCount INT

-- Test mit ungültiger BierId (BierId existiert nicht)
EXEC @RowCount = GetBeerDetails @BierId = 100

-- Überprüfen der Anzahl der betroffenen Datensätze
SELECT @RowCount AS 'Anzahl der Datensätze'


-- Test 3: NULL als ID
DECLARE @RowCount INT

-- Test mit NULL als Argument
EXEC @RowCount = GetBeerDetails @BierId = NULL

-- Überprüfen der Anzahl der betroffenen Datensätze
SELECT @RowCount AS 'Anzahl der Datensätze'
