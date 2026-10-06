-- ===========================================================
--             SYSTEM METADATA QUERY: TOTAL TABLES
-- ===========================================================


-- PURPOSE:         To extract metadata from the tables.


-- Gets the total number of tables from the schema file:
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE';         -- Extracts number of actual tables, excludes 'views' (as tables) 


-- ===========================================================
--                       END OF QUERY 2
-- ===========================================================
