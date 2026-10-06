-- ===========================================================
--            SYSTEM METADATA QUERY: TOTAL ENTRIES
-- ===========================================================


-- PURPOSE:         To extract metadata from the data entries.


-- Gets the total number of entries (row counts) from each table:
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


-- ===========================================================
--                       END OF QUERY 3
-- ===========================================================
