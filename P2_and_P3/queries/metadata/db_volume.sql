-- ===========================================================
--           SYSTEM METADATA QUERY: DB SIZE/VOLUME
-- ===========================================================


-- PURPOSE:         To extract metadata regarding the size/volume of the database.


-- Gets the total database size/volume:
SELECT
  pg_size_pretty(pg_database_size(current_database())) AS database_size;
    -- pg = PostgreSQL built-in functions 
    -- pretty = Transforms the value (e.g. bytes) into a readable value (e.g. MBs)


-- ===========================================================
--                       END OF QUERY 4
-- ===========================================================
