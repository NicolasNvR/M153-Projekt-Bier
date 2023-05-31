-- Test 1: G�ltige ID
DECLARE @RowCount INT

-- Test mit g�ltiger BierId
EXEC @RowCount = GetBeerDetails @BierId = 1

-- �berpr�fen der Anzahl der betroffenen Datens�tze
SELECT @RowCount AS 'Anzahl der Datens�tze'



-- Test 2: Ung�ltige ID
DECLARE @RowCount INT

-- Test mit ung�ltiger BierId (BierId existiert nicht)
EXEC @RowCount = GetBeerDetails @BierId = 100

-- �berpr�fen der Anzahl der betroffenen Datens�tze
SELECT @RowCount AS 'Anzahl der Datens�tze'


-- Test 3: NULL als ID
DECLARE @RowCount INT

-- Test mit NULL als Argument
EXEC @RowCount = GetBeerDetails @BierId = NULL

-- �berpr�fen der Anzahl der betroffenen Datens�tze
SELECT @RowCount AS 'Anzahl der Datens�tze'
