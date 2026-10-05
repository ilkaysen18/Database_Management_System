-- ===========================================================
--             SECURITY AND VERIFICATION QUERY
-- ===========================================================


-- PURPOSE:         Follows 1NF Rule for multiple payment methods; and verifies security clearance before financial transaction can occur
-- ALIASES:         u = user, v = verification, pm = Payment_Method


SELECT
  u."User_ID",
-- Changes technical words to more common language for backend user readability:
  u."User_Name" AS "Account_Holder",
  v."ID_Verification_Status" AS "Identity_Status",
  pm."Payment_Option" AS "Card_Provider",
  pm."Encrypted_Payment_Token" AS "Secure_Gateway_Hash",
  pm."Default_Payment_Option" AS "Is_Primary_Card"

FROM
  "User" u
    -- Aliases "User" to u
-- Joins Verification with User_ID and Payment_Method:
INNER JOIN
  "Verification" v ON u."User_ID" = v."User_ID"
    -- Aliases "Verification" to v
LEFT JOIN
  "Payment_Method" pm ON u."User_ID" = pm."User_ID"
    -- Aliases Payment_Method to pm

WHERE
  v."Email_Verification_Status" = 'Verified'
ORDER BY
  pm."Default_Payment_Option" DESC, u."User_Name" ASC;



-- ===========================================================
--                  SYSTEM METADATA QUERY
-- ===========================================================


-- PURPOSE:         To extract metadata from the tables, their entries, and the size/volume of the database


-- Gets the TOTAL NUMBER OF TABLES from the schema file:
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE';         -- Extracts number of actual tables, excludes 'views' (as tables) 


-- Gets the TOTAL NUMBER OF ENTRIES (row counts) from each table:
SELECT 'User' AS table_name, COUNT(*) AS row_count FROM "User"
UNION ALL

-- Lists all tables and their corresponding number of entries:
SELECT 'User_Profile', COUNT(*) FROM "User_Profile"
UNION ALL
SELECT 'Verification', COUNT(*) FROM "Verification"
UNION ALL
SELECT 'Payment_Method', COUNT(*) FROM "Payment_Method"
UNION ALL
SELECT 'Social_Media_Connection', COUNT(*) FROM "Social_Media_Connection"
UNION ALL
SELECT 'Accommodation_Listing', COUNT(*) FROM "Accommodation_Listing"
UNION ALL
SELECT 'Experience_Listing', COUNT(*) FROM "Experience_Listing"
UNION ALL
SELECT 'Accommodation_Price', COUNT(*) FROM "Accommodation_Price"
UNION ALL
SELECT 'Amenity', COUNT(*) FROM "Amenity"
UNION ALL
SELECT 'Property_Calendar', COUNT(*) FROM "Property_Calendar"
UNION ALL
SELECT 'Property_Block_Dates', COUNT(*) FROM "Property_Block_Dates"
UNION ALL
SELECT 'Accommodation_Booking', COUNT(*) FROM "Accommodation_Booking"
UNION ALL
SELECT 'Experience_Calendar', COUNT(*) FROM "Experience_Calendar"
UNION ALL
SELECT 'Experience_Block_Dates', COUNT(*) FROM "Experience_Block_Dates"
UNION ALL
SELECT 'Experience_Booking', COUNT(*) FROM "Experience_Booking"
UNION ALL
SELECT 'Message_Thread', COUNT(*) FROM "Message_Thread"
UNION ALL
SELECT 'Message_Log', COUNT(*) FROM "Message_Log"
UNION ALL
SELECT 'Notifications', COUNT(*) FROM "Notifications"
UNION ALL
SELECT 'Financial_Transaction', COUNT(*) FROM "Financial_Transaction"
UNION ALL
SELECT 'Host_Payout', COUNT(*) FROM "Host_Payout"
UNION ALL
SELECT 'Local_Payout', COUNT(*) FROM "Local_Payout"
UNION ALL
SELECT 'Accommodation_Review', COUNT(*) FROM "Accommodation_Review"
UNION ALL
SELECT 'Accommodation_Rating', COUNT(*) FROM "Accommodation_Rating"
UNION ALL
SELECT 'Experience_Review', COUNT(*) FROM "Experience_Review"
UNION ALL
SELECT 'Experience_Rating', COUNT(*) FROM "Experience_Rating"
UNION ALL
SELECT 'User_Review', COUNT(*) FROM "User_Review"
UNION ALL
SELECT 'User_Rating', COUNT(*) FROM "User_Rating"
UNION ALL
SELECT 'Images', COUNT(*) FROM "Images"

-- Orders the table entry values:
ORDER BY row_count DESC;


-- Gets the TOTAL DATABASE SIZE/VOLUME:
SELECT
  pg_size_pretty(pg_database_size(current_database())) AS database_size;
    -- pg = PostgreSQL built-in functions 
    -- pretty = Transforms the value (e.g. bytes) into a readable value (e.g. MBs)
