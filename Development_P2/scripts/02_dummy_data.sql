-- =============================================================================================          
--       D U M M Y   D A T A :   2 0   U N I Q U E   R E C O R D S   -   U S I N G   D M L
-- =============================================================================================          


-- 01_schema.sql          :  This first file has each Entity's PK set to GENERATED ALWAYS AS IDENTITY
-- 02_dummy_data.sql      :  Thus, in this second file, each record's PK is left unfilled


-- ============================
--  BASE (INDEPENDENT) RECORDS
-- ============================


--  1  "User" Table

INSERT INTO "User" ("User_Name", "User_Email", "User_Phone", "Password_Hash") VALUES
('Max Mustermann', 'max.mustermann@email.de', '+491701111111', '$2b$12$K7vRnx8B92e1mWS...'),
('Anna Schmidt', 'anna.schmidt@email.de', '+491702222222', '$2b$12$L8wSny9C93f2nXT...'),
('Lukas Weber', 'lukas.weber@email.de', '+491703333333', '$2b$12$M9xTnz0D94g3oYU...'),
('Laura Wagner', 'laura.wagner@email.de', '+491704444444', '$2b$12$N0yUoa1E95h4pZV...'),
('Tim Becker', 'tim.becker@email.de', '+491705555555', '$2b$12$O1zVpb2F96i5qXW...'),
('Julia Hoffmann', 'julia.hoffmann@email.de', '+491706666666', '$2b$12$P2aWqc3G97j6rYX...'),
('Jonas Fischer', 'jonas.fischer@email.de', '+491707777777', '$2b$12$Q3bXqd4H88k7sZY...'),
('Sarah Meyer', 'sarah.meyer@email.de', '+491708888888', '$2b$12$R4cYqe5I99l8tAZ...'),
('Felix Bauer', 'felix.bauer@email.de', '+491709999999', '$2b$12$S5dZrf6J00m9uBA...'),
('Emma Richter', 'emma.richter@email.de', '+491701010101', '$2b$12$T6eAsg7K11n0vCB...'),
('David Schulz', 'david.schulz@email.de', '+491701212121', '$2b$12$U7fBth8L22o1wDC...'),
('Marie Krause', 'marie.krause@email.de', '+491701313131', '$2b$12$V8gCui9M33p2xED...'),
('Simon Kohler', 'simon.kohler@email.de', '+491701414141', '$2b$12$W9hDvj0N44q3yFE...'),
('Elena Vogt', 'elena.vogt@email.de', '+491701515151', '$2b$12$X0iEwk1O55r4zGF...'),
('Paul Werner', 'paul.werner@email.de', '+491701616161', '$2b$12$Y1jFxl2P66s5aHG...'),
('Clara Fuchs', 'clara.fuchs@email.de', '+491701717171', '$2b$12$Z2kGym3Q77t6bIH...'),
('Ben Schwarz', 'ben.schwarz@email.de', '+491701818181', '$2b$12$A3lHzn4R88u7cJI...'),
('Lea Hahn', 'lea.hahn@email.de', '+491701919191', '$2b$12$B4mIao5S99v8dKJ...'),
('Noah Wolf', 'noah.wolf@email.de', '+491702020202', '$2b$12$C5nJbp6T00w9eLK...'),
('Mia Berger', 'mia.berger@email.de', '+491702121212', '$2b$12$D6oKcq7U11x0fML...');


-- ============================
--  PROFILE & INVENTORY RECORDS
-- ============================

--  2  "User_Profile" Table

--  3  "Verification" Table

--  4  "Social_Media_Platform" Table

--  5  "Payment_Method" Table

--  6  "Accommodation_Listing" Table

--  7  "Experience_Listing" Table

-- ============================
--  PRICING & CALENDAR RECORDS
-- ============================

--  8  "Accommodation_Price" Table

--  9  "Amenity" Table

--  10  "Property_Calendar" Table

--  11  "Experience_Calendar" Table

-- ============================
-- SCHEDULING & BOOKING RECORDS
-- ============================

--  12  "Property_Block_Dates" Table

--  13  "Experience_Block_Dates" Table

--  14  "Accommodation_Booking" Table

--  15  "Experience_Booking" Table

-- ============================
--    COMMUNICATIONS RECORDS
-- ============================

--  16  "Message_Thread" Table

--  17  "Message_Log" Table

--  18  "Notifications" Table

--  19  "Financial_Transactions" Table

-- ============================
--   PAYOUTS & REVIEW RECORDS
-- ============================

--  20  "Host_Payout" Table

--  21  "Local_Payout" Table

--  22  "Accommodation_Review" Table

--  23  "Accommodation_Rating" Table

--  24  "Experience_Review" Table

--  25  "Experience_Rating" Table

--  26  "User_Review" Table

--  27  "User_Rating" Table

-- =============================================================================================          
--              D M L   W I T H   D U M M Y   R E C O R D S   C O M P L E T E
-- =============================================================================================          
