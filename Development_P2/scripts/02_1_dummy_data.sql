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

INSERT INTO "User_Profile" ("User_ID", "User_Bio", "Profile_Picture_URL") VALUES
(1, 'Hi, I am an architecture student living in Berlin. Love hosting global travelers!', 'https://supabase.storage'),
(2, 'Passionate gourmet chef based in Munich. Always happy to share local restaurant tips.', 'https://supabase.storage'),
(3, 'Frequent business traveler and digital nomad. Cleanliness is my top priority.', 'https://supabase.storage'),
(4, 'Musician and coffee enthusiast from Frankfurt. Looking forward to exploring new cities.', 'https://supabase.storage'),
(5, 'Art gallery curator in Düsseldorf. Enjoying minimalist spaces and quiet neighborhoods.', 'https://supabase.storage'),
(6, 'History teacher from Dresden. Love historical buildings and classical music tours.', 'https://supabase.storage'),
(7, 'Graphic designer living near the Cologne Cathedral. Always out taking street photos.', 'https://supabase.storage'),
(8, 'Engineering consultant based in Stuttgart. Big fan of clean lines and smart homes.', 'https://supabase.storage'),
(9, 'Bookstore owner from Bremen. Quiet, respectful guest who loves traveling with books.', 'https://supabase.storage'),
(10, 'Software engineer from Hannover. Remote worker looking for reliable Wi-Fi spaces.', 'https://supabase.storage'),
(11, 'Freelance journalist based in Leipzig. Exploring regional cultures and festivals.', 'https://supabase.storage'),
(12, 'Sailing instructor from Kiel. Loving ocean views, fresh air, and outdoor activities.', 'https://supabase.storage'),
(13, 'Baking enthusiast from Augsburg. Finding cozy places to stay with family.', 'https://supabase.storage'),
(14, 'Gardener from Hamm. Enjoying peaceful countryside getaways and green spaces.', 'https://supabase.storage'),
(15, 'Medical resident working in Cologne. Simple commuter looking for a quiet bed.', 'https://supabase.storage'),
(16, 'Boutique hotel reviewer from Munich. Focused on interior design and comfort.', 'https://supabase.storage'),
(17, 'Event coordinator from Hamburg. Love the vibrant city life and modern lofts.', 'https://supabase.storage'),
(18, 'Retired professor from Berlin. Traveling to historic towns across Germany.', 'https://supabase.storage'),
(19, 'Photography blogger based in Heidelberg. Capturing old castles and landscapes.', 'https://supabase.storage'),
(20, 'Museum tour guide from Weimar. Deeply interested in classic literature and theater.', 'https://supabase.storage');


--  3  "Verification" Table

INSERT INTO "Verification" ("User_ID", "Email_Verification_Status", "Phone_Verification_Status", "ID_Verification_Status") VALUES
(1, 'Verified', 'Verified', 'Verified'),
(2, 'Verified', 'Verified', 'Verified'),
(3, 'Verified', 'Unverified', 'Not Retained'),
(4, 'Verified', 'Verified', 'Verified'),
(5, 'Verified', 'Verified', 'Verified'),
(6, 'Verified', 'Unverified', 'Not Retained'),
(7, 'Verified', 'Verified', 'Verified'),
(8, 'Verified', 'Verified', 'Verified'),
(9, 'Unverified', 'Unverified', 'Not Retained'),
(10, 'Verified', 'Verified', 'Verified'),
(11, 'Verified', 'Verified', 'Verified'),
(12, 'Verified', 'Verified', 'Verified'),
(13, 'Verified', 'Unverified', 'Not Retained'),
(14, 'Verified', 'Verified', 'Verified'),
(15, 'Verified', 'Verified', 'Verified'),
(16, 'Verified', 'Unverified', 'Not Retained'),
(17, 'Verified', 'Verified', 'Verified'),
(18, 'Verified', 'Verified', 'Verified'),
(19, 'Unverified', 'Verified', 'Not Retained'),
(20, 'Verified', 'Verified', 'Verified');


--  4  "Payment_Method" Table

INSERT INTO "Payment_Method" ("User_ID", "Payment_Option", "Encrypted_Payment_Token", "Billing_Address", "Default_Payment_Option") VALUES
(1, 'Credit Card', 'mock_token_cc_v7181', 'Friedrichstraße 12, Berlin', TRUE),
(2, 'PayPal', 'mock_token_pp_m8291', 'Kaufingerstraße 4, Munich', TRUE),
(3, 'Credit Card', 'mock_token_cc_a1029', 'Mönckebergstraße 8, Hamburg', TRUE),
(4, 'Apple Pay', 'mock_token_ap_s8301', 'Zeil 15, Frankfurt', TRUE),
(5, 'Credit Card', 'mock_token_cc_d9302', 'Königsallee 22, Düsseldorf', TRUE),
(6, 'PayPal', 'mock_token_pp_k4829', 'Prager Straße 9, Dresden', TRUE),
(7, 'Credit Card', 'mock_token_cc_c7391', 'Hohe Straße 14, Cologne', TRUE),
(8, 'Apple Pay', 'mock_token_ap_e8391', 'Königstraße 3, Stuttgart', TRUE),
(9, 'PayPal', 'mock_token_pp_w7391', 'Böttcherstraße 6, Bremen', TRUE),
(10, 'Credit Card', 'mock_token_cc_z8391', 'Georgstraße 11, Hannover', TRUE),
(11, 'Credit Card', 'mock_token_cc_x3912', 'Karl-Liebknecht-Str. 5, Leipzig', TRUE),
(12, 'PayPal', 'mock_token_pp_q9201', 'Holstenstraße 18, Kiel', TRUE),
(13, 'Credit Card', 'mock_token_cc_b4829', 'Ludwigstraße 14, Augsburg', TRUE),
(14, 'Apple Pay', 'mock_token_ap_v2019', 'Ostenallee 44, Hamm', TRUE),
(15, 'Credit Card', 'mock_token_cc_n3921', 'Schildergasse 21, Cologne', TRUE),
(16, 'PayPal', 'mock_token_pp_r8392', 'Sendlinger Str. 30, Munich', TRUE),
(17, 'Credit Card', 'mock_token_cc_m3910', 'Reeperbahn 88, Hamburg', TRUE),
(18, 'Apple Pay', 'mock_token_ap_p1029', 'Kurfürstendamm 150, Berlin', TRUE),
(19, 'PayPal', 'mock_token_pp_o3910', 'Hauptstraße 12, Heidelberg', TRUE),
(20, 'Credit Card', 'mock_token_cc_y8301', 'Markt 1, Weimar', TRUE);


--  5  "Accommodation_Listing" Table

INSERT INTO "Accommodation_Listing" ("User_ID", "Accommodation_Address", "Accommodation_Type", "Accommodation_Description", "Max_Guests") VALUES
(1, 'Müllerstraße 44, 13353 Berlin', 'Apartment', 'Cozy industrial loft located in the heart of Berlin-Wedding. Perfect for city explorers.', 2),
(1, 'Schönhauser Allee 10, 10435 Berlin', 'Apartment', 'Bright penthouse with an incredible view over Prenzlauer Berg skyline. Free high-speed Wi-Fi.', 4),
(2, 'Theresienwiese 3, 80336 Munich', 'Bedroom', 'Private premium bedroom right next to the Oktoberfest grounds. Quiet and clean space.', 1),
(2, 'Leopoldstraße 102, 80802 Munich', 'Apartment', 'Charming boutique studio apartment in vibrant Schwabing. Close to English Garden.', 2),
(3, 'Neuer Wall 15, 20354 Hamburg', 'Apartment', 'Luxury waterfront studio space near historic Alster. Top tier business travel amenities.', 3),
(3, 'Hafenstraße 88, 20359 Hamburg', 'Bedroom', 'Cozy private room with beautiful harbor view windows near St. Pauli piers.', 2),
(4, 'Mainzer Landstraße 200, 60326 Frankfurt', 'Apartment', 'Modern skyscraper flat with sweeping views of the Frankfurt banking district.', 2),
(4, 'Berger Straße 45, 60316 Frankfurt', 'Bedroom', 'Quaint private bedroom in a historic half-timbered house setting in Bornheim.', 1),
(5, 'Immermannstraße 33, 40210 Düsseldorf', 'Apartment', 'Stylish modern flat located directly inside the famous Japanese Quarter.', 2),
(5, 'Rheinuferpromenade 4, 40213 Düsseldorf', 'Apartment', 'Elegant premium penthouse offering a direct visual look over the historic Rhine river.', 4),
(6, 'Hauptstraße 12, 01097 Dresden', 'Bedroom', 'Charming historical guest suite situated inside Neustadt artistic quarters.', 2),
(6, 'Prager Straße 101, 01069 Dresden', 'Apartment', 'Minimalist central urban apartment ideal for weekend museum travelers.', 3),
(7, 'Aachener Straße 55, 50674 Cologne', 'Apartment', 'Vibrant urban flat surrounded by popular local cafes in the Belgian Quarter.', 2),
(7, 'Hohenzollernbrücke 2, 50667 Cologne', 'Bedroom', 'Quiet, secure private room located within walking distance of Cologne Cathedral.', 1),
(8, 'Königstraße 12, 70173 Stuttgart', 'Apartment', 'Smart-home automated downtown studio setup designed for engineering professionals.', 2),
(8, 'Neckarhalde 14, 70372 Stuttgart', 'Bedroom', 'Peaceful, cozy private room close to local vineyard walking paths.', 2),
(9, 'Schnoor 5, 28195 Bremen', 'Apartment', 'Fairytale cottage space situated in Bremens oldest historic alleyway district.', 2),
(10, 'Lister Meile 22, 30161 Hannover', 'Apartment', 'Spacious home office ready apartment with dedicated high-speed infrastructure lines.', 4),
(10, 'Herrenhäuser Str. 4, 30419 Hannover', 'Bedroom', 'Serene and quiet private room overlooking the palace garden grounds area.', 1),
(9, 'Am Wall 140, 28195 Bremen', 'Apartment', 'Modern renovated loft space overlooking the local old-town windmills.', 2);


--  6  "Experience_Listing" Table

INSERT INTO "Experience_Listing" ("User_ID", "Experience_Price", "Currency_Code") VALUES
(11, 45.00000000, 'EUR'),    -- Local Berlin Underground Graffiti Art Tour
(11, 65.00000000, 'EUR'),    -- Historical Third Reich Walking Seminar
(12, 120.00000000, 'EUR'),   -- Private Baltic Sailing Lesson on Kiel Fjord
(12, 40.00000000, 'EUR'),    -- Sunset Coastal Photography Workshop
(13, 35.00000000, 'EUR'),    -- Bavarian Pretzel Artisan Baking Class
(13, 50.00000000, 'EUR'),    -- Traditional Swabian Dumpling Workshop
(14, 25.00000000, 'EUR'),    -- Botanical Garden Greenhouse Photography Walk
(15, 30.00000000, 'EUR'),    -- Cologne Old Town Brewery History Walk
(15, 55.00000000, 'EUR'),    -- Nighttime Ghost Stories of the Cathedral Vaults
(16, 95.00000000, 'EUR'),    -- Munich Fine Wine and Cheese Tasting Masterclass
(16, 75.00000000, 'EUR'),    -- Neuschwanstein Castle Secret Vantage Point Trek
(17, 60.00000000, 'EUR'),    -- Hamburg Elbphilharmonie Architectural Deep-Dive
(17, 45.00000000, 'EUR'),    -- St. Pauli Midnight Street Food Exploration Run
(18, 50.00000000, 'EUR'),    -- Cold War Berlin Wall Border Security Lecture Walk
(18, 40.00000000, 'EUR'),    -- Potsdam Sanssouci Palace Gardens History Bike Ride
(19, 70.00000000, 'EUR'),    -- Heidelberg Romantic Castle Landscape Photography Workshop
(19, 30.00000000, 'EUR'),    -- Black Forest Nature and Wilderness Hiking Trail Guide
(20, 40.00000000, 'EUR'),    -- Weimar Classical Era Goethe & Schiller Literature Tour
(20, 50.00000000, 'EUR'),    -- Bauhaus Minimalist Design Movement Architecture Walk
(14, 35.00000000, 'EUR');    -- Organic Urban Agriculture Herb Cultivation Seminar


--  7  "Social_Media_Connection" Table

INSERT INTO "Social_Media_Connection" ("User_ID", "Connection_ID") VALUES
(1, 2),         -- Max linked to Anna
(1, 3),         -- Max linked to Lukas
(2, 4),         -- Anna linked to Laura
(2, 5),         -- Anna linked to Tim
(3, 6),         -- Lukas linked to Julia
(4, 7),         -- Laura linked to Jonas
(5, 8),         -- Tim linked to Sarah
(6, 9),         -- Julia linked to Felix
(7, 10),        -- Jonas linked to Emma
(8, 11),        -- Sarah linked to David
(9, 12),        -- Felix linked to Marie
(10, 13),       -- Emma linked to Simon
(11, 14),       -- David linked to Elena
(12, 15),       -- Marie linked to Paul
(13, 16),       -- Simon linked to Clara
(14, 17),       -- Elena linked to Ben
(15, 18),       -- Paul linked to Lea
(16, 19),       -- Clara linked to Noah
(17, 20),       -- Ben linked to Mia
(18, 1);        -- Old Professor Paul linked back to Max


-- ============================
--  PRICING & CALENDAR RECORDS
-- ============================


--  8  "Accommodation_Price" Table

INSERT INTO "Accommodation_Price" ("Property_ID", "Host_ID", "Nightly_Price", "Currency_Code") VALUES
(1, 1, 85.00000000, 'EUR'),
(2, 1, 145.00000000, 'EUR'),
(3, 2, 60.00000000, 'EUR'),
(4, 2, 95.00000000, 'EUR'),
(5, 3, 120.00000000, 'EUR'),
(6, 3, 55.00000000, 'EUR'),
(7, 4, 190.00000000, 'EUR'),
(8, 4, 45.00000000, 'EUR'),
(9, 5, 110.00000000, 'EUR'),
(10, 5, 250.00000000, 'EUR'),
(11, 6, 65.00000000, 'EUR'),
(12, 6, 80.00000000, 'EUR'),
(13, 7, 75.00000000, 'EUR'),
(14, 7, 40.00000000, 'EUR'),
(15, 8, 130.00000000, 'EUR'),
(16, 8, 50.00000000, 'EUR'),
(17, 9, 70.00000000, 'EUR'),
(18, 10, 90.00000000, 'EUR'),
(19, 10, 35.00000000, 'EUR'),
(20, 9, 105.00000000, 'EUR');


--  9  "Amenity" Table

INSERT INTO "Amenity" ("Property_ID", "Amenity_Name", "Amenity_Description") VALUES
(1, 'Wi-Fi', 'High-speed fiber optic connection layout suitable for video calls.'),
(1, 'Kitchen', 'Fully equipped cooking space with a modern induction stove.'),
(2, 'Air Conditioning', 'Central climate control unit with manual thermostat adjustments.'),
(2, 'TV', '55-inch smart television setup with pre-configured streaming applications.'),
(3, 'Heating', 'Reliable central radiator heating system optimized for winter.'),
(4, 'Washing Machine', 'Front-loading laundry washer located inside the bathroom space.'),
(5, 'Wi-Fi', 'Complimentary wireless internet coverage across all rooms.'),
(6, 'Free Parking', 'Dedicated residential underground parking spot assigned to guests.'),
(7, 'Kitchen', 'Compact kitchenette containing a refrigerator and microwave layout.'),
(8, 'Breakfast', 'Fresh local bakery basket provided daily by the listing host.'),
(9, 'Pet-Friendly', 'Welcome accommodations suitable for small dogs or domestic cats.'),
(10, 'Pool', 'Access to the private heated courtyard lap pool facilities.'),
(11, 'Wi-Fi', 'Basic broadband wireless connection details provided on arrival.'),
(12, 'Heating', 'Energy efficient climate heating panels installed throughout.'),
(13, 'Washing Machine', 'Shared washing machine facilities accessible in the basement corridor.'),
(14, 'Free Parking', 'Open driveway parking space situated directly in front of the entry.'),
(15, 'TV', 'Wall-mounted flat-screen television with localized cable channels.'),
(16, 'Breakfast', 'Continental breakfast layout options served in the dining hall.'),
(17, 'Kitchen', 'Spacious open-plan kitchen complete with basic spices and utensils.'),
(18, 'Air Conditioning', 'Standalone cooling fan appliance provided for summer comfort.');


--  13  "Experience_Block_Dates" Table

INSERT INTO "Experience_Block_Dates" ("Experience_Listing_ID", "Exp_Blocked_Date") VALUES
(1, '2026-12-24'),
(2, '2026-12-25'),
(3, '2026-12-26'),
(4, '2026-12-31'),
(5, '2027-01-01'),
(6, '2026-10-03'),
(7, '2026-05-01'),
(8, '2026-12-24'),
(9, '2026-12-25'),
(10, '2026-12-31'),
(11, '2027-01-01'),
(12, '2026-10-03'),
(13, '2026-11-01'),
(14, '2026-12-24'),
(15, '2026-12-25'),
(16, '2026-12-31'),
(17, '2027-01-01'),
(18, '2026-10-03'),
(19, '2026-05-01'),
(20, '2026-11-01');


--  11  "Experience_Calendar" Table

INSERT INTO "Experience_Calendar" ("Experience_Listing_ID", "Exp_Availability_ID") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);


-- ============================
-- SCHEDULING & BOOKING RECORDS
-- ============================


--  12  "Property_Block_Dates" Table

INSERT INTO "Property_Block_Dates" ("Property_ID", "Property_Calendar_ID", "Prop_Blocked_Date") VALUES
(1, 1, '2026-11-01'),
(2, 2, '2026-11-02'),
(3, 3, '2026-11-03'),
(4, 4, '2026-11-04'),
(5, 5, '2026-11-05'),
(6, 6, '2026-11-06'),
(7, 7, '2026-11-07'),
(8, 8, '2026-11-08'),
(9, 9, '2026-11-09'),
(10, 10, '2026-11-10'),
(11, 11, '2026-11-11'),
(12, 12, '2026-11-12'),
(13, 13, '2026-11-13'),
(14, 14, '2026-11-14'),
(15, 15, '2026-11-15'),
(16, 16, '2026-11-16'),
(17, 17, '2026-11-17'),
(18, 18, '2026-11-18'),
(19, 19, '2026-11-19'),
(20, 20, '2026-11-20');


--  10  "Property_Calendar" Table

INSERT INTO "Property_Calendar" ("Property_ID", "Prop_Availability_ID") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);


--  14  "Accommodation_Booking" Table

INSERT INTO "Accommodation_Booking" ("Guest_ID", "Host_ID", "Property_ID", "Property_Calendar_ID", "CI_CO_Date", "Booking_Status") VALUES
(11, 1, 1, 1, '2026-10-10 14:00:00', 'Confirmed'),
(12, 1, 2, 2, '2026-10-15 15:00:00', 'Confirmed'),
(13, 2, 3, 3, '2026-10-18 14:00:00', 'Confirmed'),
(14, 2, 4, 4, '2026-10-22 16:00:00', 'Accepted'),
(15, 3, 5, 5, '2026-10-25 14:00:00', 'Confirmed'),
(16, 3, 6, 6, '2026-11-01 15:00:00', 'Pending'),
(17, 4, 7, 7, '2026-11-05 14:00:00', 'Confirmed'),
(18, 4, 8, 8, '2026-11-12 14:00:00', 'Rejected'),
(19, 5, 9, 9, '2026-11-15 15:00:00', 'Confirmed'),
(20, 5, 10, 10, '2026-11-20 14:00:00', 'Confirmed'),
(11, 6, 11, 11, '2026-11-25 14:00:00', 'Canceled'),
(12, 6, 12, 12, '2026-12-01 15:00:00', 'Confirmed'),
(13, 7, 13, 13, '2026-12-05 14:00:00', 'Confirmed'),
(14, 7, 14, 14, '2026-12-10 14:00:00', 'Accepted'),
(15, 8, 15, 15, '2026-12-15 15:00:00', 'Confirmed'),
(16, 8, 16, 16, '2026-12-20 14:00:00', 'Confirmed'),
(17, 9, 17, 17, '2026-12-23 14:00:00', 'Pending'),
(18, 10, 18, 18, '2026-12-28 15:00:00', 'Confirmed'),
(19, 10, 19, 19, '2027-01-03 14:00:00', 'Confirmed'),
(20, 9, 20, 20, '2027-01-10 14:00:00', 'Confirmed');


--  15  "Experience_Booking" Table

INSERT INTO "Experience_Booking" ("Experience_Listing_ID", "Guest_ID", "Experience_Calendar_ID", "Exp_Booking_Status") VALUES
(1, 1, 1, 'Confirmed'),
(2, 2, 2, 'Confirmed'),
(3, 3, 3, 'Accepted'),
(4, 4, 4, 'Confirmed'),
(5, 5, 5, 'Pending'),
(6, 6, 6, 'Confirmed'),
(7, 7, 7, 'Rejected'),
(8, 8, 8, 'Confirmed'),
(9, 9, 9, 'Confirmed'),
(10, 10, 10, 'Canceled'),
(11, 1, 11, 'Confirmed'),
(12, 2, 12, 'Confirmed'),
(13, 3, 13, 'Accepted'),
(14, 4, 14, 'Confirmed'),
(15, 5, 15, 'Confirmed'),
(16, 6, 16, 'Pending'),
(17, 7, 17, 'Confirmed'),
(18, 8, 18, 'Confirmed'),
(19, 9, 19, 'Confirmed'),
(20, 10, 20, 'Confirmed');


-- ============================
--    COMMUNICATIONS RECORDS
-- ============================


--  16  "Message_Thread" Table

INSERT INTO "Message_Thread" ("Booking_ID", "Thread_Subject", "Thread_Date", "Thread_Status", "Guest_ID", "Host_ID") VALUES
(1, 'Check-In Details Müllerstraße', '2026-10-01 10:00:00', 'Active', 11, 1),
(2, 'Parking near Schönhauser Allee', '2026-10-02 11:30:00', 'Active', 12, 1),
(3, 'Oktoberfest Stay Inquiries', '2026-10-03 14:15:00', 'Active', 13, 2),
(4, 'Studio Key Lockbox Code', '2026-10-04 09:00:00', 'Active', 14, 2),
(5, 'Waterfront Loft Arrival Time', '2026-10-05 16:45:00', 'Active', 15, 3),
(6, 'Harbor View Room Wi-Fi', '2026-10-06 18:20:00', 'Active', 16, 3),
(7, 'Skyscraper Apartment Views', '2026-10-07 12:10:00', 'Active', 17, 4),
(8, 'Bornheim Historic House Stay', '2026-10-08 10:05:00', 'Archived', 18, 4),
(9, 'Japanese Quarter Food Tips', '2026-10-09 15:30:00', 'Active', 19, 5),
(10, 'Rhine Penthouse Balcony Access', '2026-10-10 11:00:00', 'Active', 20, 5),
(12, 'Dresden Central Urban Flat WiFi', '2026-10-11 13:40:00', 'Active', 12, 6),
(13, 'Belgian Quarter Coffee Machine', '2026-10-12 17:15:00', 'Active', 13, 7),
(14, 'Cologne Cathedral Proximity Room', '2026-10-13 19:50:00', 'Active', 14, 7),
(15, 'Stuttgart Downtown Automation', '2026-10-14 08:25:00', 'Active', 15, 8),
(16, 'Vineyard Path Walking Guide', '2026-10-15 14:12:00', 'Active', 16, 8),
(18, 'Hannover High-Speed Internet', '2026-10-16 10:55:00', 'Active', 18, 10),
(19, 'Palace Garden View Room Entry', '2026-10-17 11:20:00', 'Active', 19, 10),
(20, 'Bremen Windmill Loft Directions', '2026-10-18 16:05:00', 'Active', 20, 9),
(1, 'Müllerstraße Check-Out Rules', '2026-10-12 09:00:00', 'Archived', 11, 1),
(3, 'Theresienwiese Lost and Found', '2026-10-21 10:30:00', 'Deleted', 13, 2);


--  17  "Message_Log" Table

INSERT INTO "Message_Log" ("Thread_ID", "Sender_ID", "Receiver_ID", "Msg_Content", "Msg_Timestamp") VALUES
(1, 11, 1, 'Hello Max, where can I find the door code?', '2026-10-01 10:05:00'),
(1, 1, 11, 'Hi! The door code is 1234#.', '2026-10-01 10:10:00'),
(2, 12, 1, 'Is there underground parking available?', '2026-10-02 11:32:00'),
(2, 1, 12, 'Yes, spot number 14 is yours.', '2026-10-02 11:40:00'),
(3, 13, 2, 'Can I bring my family along for the weekend?', '2026-10-03 14:20:00'),
(4, 14, 2, 'The key is inside the black lockbox.', '2026-10-04 09:05:00'),
(5, 15, 3, 'We are arriving an hour later due to train delays.', '2026-10-05 16:50:00'),
(6, 16, 3, 'What is the Wi-Fi network password?', '2026-10-06 18:22:00'),
(7, 17, 4, 'The view from the high floor is breathtaking!', '2026-10-07 12:15:00'),
(8, 18, 4, 'Thank you for hosting me in Bornheim.', '2026-10-08 10:12:00'),
(9, 19, 5, 'Do you recommend any sushi places nearby?', '2026-10-09 15:35:00'),
(10, 20, 5, 'Can we access the balcony at night?', '2026-10-10 11:05:00'),
(11, 12, 6, 'Is the router located in the main hallway?', '2026-10-11 13:45:00'),
(12, 13, 7, 'Does the machine take regular pods?', '2026-10-12 17:20:00'),
(13, 14, 7, 'Can I check in early around noon?', '2026-10-13 19:55:00'),
(14, 15, 8, 'How do I operate the smart blinds?', '2026-10-14 08:30:00'),
(15, 16, 8, 'Are the paths well-lit after sunset?', '2026-10-15 14:18:00'),
(16, 18, 10, 'The connection speed is perfect for work.', '2026-10-16 11:00:00'),
(17, 19, 10, 'Which bus line goes straight to downtown?', '2026-10-17 11:25:00'),
(18, 20, 9, 'We left the keys on the kitchen counter.', '2026-10-18 16:10:00');


--  18  "Notifications" Table

INSERT INTO "Notifications" ("Notification_Type", "Message_Body", "Is_Read", "User_ID", "Booking_ID", "Experience_Booking_ID") VALUES
('Booking', 'Your reservation request for Berlin Loft has been sent.', TRUE, '11', 1, NULL),
('Booking', 'New booking request received for Munich Bedroom.', FALSE, '1', 2, NULL),
('Payout', 'Your payout for the stay at Hamburg Studio has been initiated.', TRUE, '3', 5, NULL),
('CI', 'Friendly reminder: Your check-in time starts at 14:00 tomorrow.', FALSE, '14', 4, NULL),
('Booking', 'Your tour booking for Graffiti Art has been confirmed!', TRUE, '1', NULL, 1),
('Booking', 'A new participant registered for the Third Reich Seminar.', FALSE, '11', NULL, 2),
('Payout', 'Tour distribution successfully processed into your bank vault.', TRUE, '12', NULL, 3),
('CI', 'Get ready for your Sunset Coastal Photography workshop today.', FALSE, '4', NULL, 4),
('Booking', 'Your reservation request for Frankfurt Highrise has been sent.', TRUE, '17', 7, NULL),
('Booking', 'Your tour request for Munich Wine Tasting is pending approval.', FALSE, '5', NULL, 5),
('Booking', 'Host accepted your reservation request for Düsseldorf Flat.', TRUE, '15', 5, NULL),
('Booking', 'Your reservation request for Dresden Suite was declined.', TRUE, '11', 11, NULL),
('Booking', 'New booking confirmed for Cologne central room space.', FALSE, '7', 13, NULL),
('Booking', 'Your reservation request for Stuttgart paths was approved.', TRUE, '15', 15, NULL),
('Booking', 'Your tour booking for Castle Vantage Trek has been accepted.', FALSE, '2', NULL, 12),
('Booking', 'New participant registered for the Elbphilharmonie Tour.', TRUE, '17', NULL, 12),
('Booking', 'Your tour request for Midnight Street Food is pending approval.', FALSE, '4', NULL, 14),
('Booking', 'Host accepted your reservation request for Hannover Flat.', TRUE, '18', 18, NULL),
('Booking', 'Your reservation request for Bremen old loft was confirmed.', FALSE, '20', 20, NULL),
('Booking', 'Your tour booking for Bauhaus Minimalist Walk has been accepted.', TRUE, '10', NULL, 19);


--  19  "Financial_Transactions" Table

INSERT INTO "Financial_Transaction" ("Booking_ID", "Experience_Booking_ID") VALUES
(1, NULL),      -- Stay Transaction 1
(2, NULL),      -- Stay Transaction 2
(3, NULL),      -- Stay Transaction 3
(4, NULL),      -- Stay Transaction 4
(5, NULL),      -- Stay Transaction 5
(7, NULL),      -- Stay Transaction 6
(10, NULL),     -- Stay Transaction 7
(12, NULL),     -- Stay Transaction 8
(13, NULL),     -- Stay Transaction 9
(15, NULL),     -- Stay Transaction 10
(NULL, 1),      -- Tour Transaction 11
(NULL, 2),      -- Tour Transaction 12
(NULL, 3),      -- Tour Transaction 13
(NULL, 4),      -- Tour Transaction 14
(NULL, 6),      -- Tour Transaction 15
(NULL, 8),      -- Tour Transaction 16
(NULL, 9),      -- Tour Transaction 17
(NULL, 11),     -- Tour Transaction 18
(NULL, 12),     -- Tour Transaction 19
(NULL, 14);     -- Tour Transaction 20


-- ============================
--   PAYOUTS & REVIEW RECORDS
-- ============================


--  20  "Host_Payout" Table

INSERT INTO "Host_Payout" ("Transaction_ID", "Host_ID", "Guest_ID") VALUES
(1, 1, 11),
(2, 1, 12),
(3, 2, 13),
(4, 2, 14),
(5, 3, 15),
(6, 4, 17),
(7, 5, 20),
(8, 6, 12),
(9, 7, 13),
(10, 8, 15),
(1, 1, 11),
(2, 1, 12),
(3, 2, 13),
(4, 2, 14),
(5, 3, 15),
(6, 4, 17),
(7, 5, 20),
(8, 6, 12),
(9, 7, 13),
(10, 8, 15);


--  21  "Local_Payout" Table

INSERT INTO "Local_Payout" ("Transaction_ID", "Local_ID", "Guest_ID") VALUES
(11, 11, 1),
(12, 11, 2),
(13, 12, 3),
(14, 12, 4),
(15, 13, 6),
(16, 14, 8),
(17, 15, 9),
(18, 16, 1),
(19, 16, 2),
(20, 17, 4),
(11, 11, 1),
(12, 11, 2),
(13, 12, 3),
(14, 12, 4),
(15, 13, 6),
(16, 14, 8),
(17, 15, 9),
(18, 16, 1),
(19, 16, 2),
(20, 17, 4);


--  22  "Accommodation_Review" Table

INSERT INTO "Accommodation_Review" ("Property_Rating_ID", "Booking_ID", "Host_ID", "Guest_ID", "Accomm_Review_Content", "Accomm_Review_Date") VALUES
(1, 1, 1, 11, 'Beautiful loft apartment! The industrial details were stunning and checking in was seamless.', '2026-10-12 11:00:00'),
(2, 2, 1, 12, 'Amazing panoramic views of the city. Clean rooms and very comfortable mattress setup.', '2026-10-18 10:30:00'),
(3, 3, 2, 13, 'Perfect location right next to the event festival fields. Host was extremely polite.', '2026-10-21 09:15:00'),
(4, 4, 2, 14, 'Cozy boutique room in a quiet historic neighborhood. Highly recommend for solo travelers.', '2026-10-26 12:00:00'),
(5, 5, 3, 15, 'Stunning waterfront view. Modern kitchen setup made cooking easy and enjoyable.', '2026-10-29 11:45:00'),
(6, 7, 4, 17, 'The central high-rise view was beautiful. Clean lines and close to local public transport.', '2026-11-09 10:00:00'),
(7, 10, 5, 20, 'Luxurious penthouse space. The balcony setup was an absolute highlight of our trip.', '2026-11-24 14:20:00'),
(8, 12, 6, 12, 'Quiet and very tidy urban room. Great Wi-Fi speed for finishing up remote work.', '2026-12-04 09:30:00'),
(9, 13, 7, 13, 'Loved the local vibe of the neighborhood. Fantastic coffee spots right down the street.', '2026-12-08 11:10:00'),
(10, 15, 8, 15, 'Excellent automated features inside the apartment. Very high tech and comfortable.', '2026-12-18 10:05:00'),
(11, 1, 1, 11, 'Second stay here was just as good as the first. Consistency is top tier.', '2026-10-13 09:00:00'),
(12, 2, 1, 12, 'Clean and bright space. Max was an exceptionally communicative host throughout.', '2026-10-19 15:40:00'),
(13, 3, 2, 13, 'Clean bed sheets and fresh towels were ready on arrival. A very neat experience.', '2026-10-22 10:12:00'),
(14, 4, 2, 14, 'Convenient key collection via lockbox. Clean bathroom and quiet workspace.', '2026-10-27 08:50:00'),
(15, 5, 3, 15, 'Central location with quick walking access to the main harbor boardwalk.', '2026-10-30 11:22:00'),
(16, 7, 4, 17, 'Stunning skyline sights at night. Flat was warm, clean, and perfectly situated.', '2026-11-10 13:14:00'),
(17, 10, 5, 20, 'Host provided amazing recommendations for regional dining options nearby.', '2026-11-25 17:05:00'),
(18, 12, 6, 12, 'Functional layout containing all necessary amenities for a fast weekend trip.', '2026-12-05 10:44:00'),
(19, 13, 7, 13, 'Safe building with peaceful surroundings. Will definitely book this flat again.', '2026-12-09 09:25:00'),
(20, 15, 8, 15, 'Smart lighting system was incredibly cool. Great property management standard.', '2026-12-19 12:15:00');


--  23  "Accommodation_Rating" Table

INSERT INTO "Accommodation_Rating" ("Property_Review_ID", "Booking_ID", "Host_ID", "Guest_ID", "Accomm_Rating_Score") VALUES
(1, 1, 1, 11, 5),
(2, 2, 1, 12, 4),
(3, 3, 2, 13, 5),
(4, 4, 2, 14, 4),
(5, 5, 3, 15, 5),
(6, 7, 4, 17, 5),
(7, 10, 5, 20, 5),
(8, 12, 6, 12, 4),
(9, 13, 7, 13, 5),
(10, 15, 8, 15, 5),
(11, 1, 1, 11, 5),
(12, 2, 1, 12, 4),
(13, 3, 2, 13, 4),
(14, 4, 2, 14, 5),
(15, 5, 3, 15, 4),
(16, 7, 4, 17, 5),
(17, 10, 5, 20, 5),
(18, 12, 6, 12, 4),
(19, 13, 7, 13, 5),
(20, 15, 8, 15, 5);


--  24  "Experience_Review" Table

INSERT INTO "Experience_Review" ("Exp_Rating_ID", "Author_ID", "Receiver_ID", "Experience_Booking_ID", "Exp_Review_Content", "Exp_Review_Date") VALUES
(1, 1, 11, 1, 'Incredible graffiti tour! Learned so much about the underground street art scene in Berlin.', '2026-12-25 10:00:00'),
(2, 2, 11, 2, 'A very informative historic walk. The guide was articulate and deeply knowledgeable.', '2026-12-26 14:30:00'),
(3, 3, 12, 3, 'Fantastic private sailing lesson on the Fjord! The instructor was calm and clear.', '2026-12-27 16:15:00'),
(4, 4, 12, 4, 'Beautiful photography workshop spots at sunset. Caught amazing coastal frames.', '2027-01-02 18:20:00'),
(5, 5, 13, 5, 'Highly enjoyable baking class. The pretzel dough instructions were perfect to copy.', '2027-01-02 11:00:00'),
(6, 6, 13, 6, 'Delicious dumpling workshop setup! Great tasting session at the end of the class.', '2026-10-04 13:45:00'),
(7, 8, 15, 8, 'A fantastic historical stroll down Cologne old town lanes. Highly informative.', '2026-12-25 15:00:00'),
(8, 9, 15, 9, 'Spooky, engaging stories inside the cathedral vaults. An absolute highlight night!', '2026-12-26 22:30:00'),
(9, 1, 16, 11, 'Premium fine wine pairings and premium cheese selection. Very elite masterclass.', '2027-01-02 19:10:00'),
(10, 2, 16, 12, 'Unbelievable castle vantage spots. Definitely worth the moderate hillside hike.', '2027-01-02 14:00:00'),
(11, 3, 17, 13, 'Brilliant architectural structural tour inside the Elbphilharmonie concert hall.', '2026-12-25 12:00:00'),
(12, 4, 17, 14, 'Excellent street food recommendations across St. Pauli district lanes.', '2026-12-26 01:15:00'),
(13, 5, 18, 15, 'A sobering and exceptionally educational lecture walking track by the old wall.', '2026-12-26 11:30:00'),
(14, 7, 19, 17, 'Breathtaking landscape frames captured near the old castle hillsides.', '2027-01-02 10:05:00'),
(15, 8, 18, 18, 'Relaxing palace gardens bike cruise. Perfect outdoor weekend trip.', '2026-10-04 14:20:00'),
(16, 9, 19, 19, 'Peaceful Black Forest wilderness tracking run. Guide kept everyone safe.', '2027-01-04 15:30:00'),
(17, 10, 20, 20, 'Fascinating literature walk tracing classic historical theater spaces.', '2026-11-02 11:00:00'),
(18, 1, 11, 1, 'Brought some colleagues out for a second run, graffiti route was updated nicely!', '2026-12-26 09:00:00'),
(19, 2, 11, 2, 'Highly recommended educational experience layout for travelers to Berlin.', '2026-12-27 10:45:00'),
(20, 3, 12, 3, 'Safe boat handling tips. Perfect for beginner sailors looking for confidence.', '2026-12-28 11:00:00');


--  25  "Experience_Rating" Table

INSERT INTO "Experience_Rating" ("Exp_Review_ID", "Experience_Booking_ID", "Author_ID", "Receiver_ID", "Exp_Rating_Score") VALUES
(1, 1, 1, 11, 5),
(2, 2, 2, 11, 5),
(3, 3, 3, 12, 4),
(4, 4, 4, 12, 5),
(5, 5, 5, 13, 5),
(6, 6, 6, 13, 4),
(7, 8, 8, 15, 5),
(8, 9, 9, 15, 5),
(9, 11, 1, 16, 5),
(10, 12, 2, 16, 5),
(11, 13, 3, 17, 4),
(12, 14, 4, 17, 5),
(13, 15, 5, 18, 5),
(14, 17, 7, 19, 5),
(15, 18, 8, 18, 4),
(16, 19, 9, 19, 5),
(17, 20, 10, 20, 5),
(18, 1, 1, 11, 5),
(19, 2, 2, 11, 5),
(20, 3, 3, 12, 4);


--  26  "User_Review" Table

INSERT INTO "User_Review" ("User_Rating_ID", "Author_ID", "Receiver_ID", "Booking_ID", "User_Review_Content", "User_Review_Date") VALUES
(1, 11, 1, 1, 'Max was a spectacular landlord! Exceptionally friendly, clean, and helpful.', '2026-10-12 12:00:00'),
(2, 1, 11, 1, 'Max is a polite guest who left the rooms pristine. Highly recommended.', '2026-10-12 12:15:00'),
(3, 12, 1, 2, 'Max made our travel logistics simple. Communication was pristine.', '2026-10-18 11:00:00'),
(4, 1, 12, 2, 'Pristine guest habits. Quiet, neat, and highly communicative.', '2026-10-18 11:30:00'),
(5, 13, 2, 3, 'Anna is a top-tier host! Had a wonderful experience during festival week.', '2026-10-21 10:00:00'),
(6, 2, 13, 3, 'Respectful and neat tenant. Would happily host them again anytime.', '2026-10-21 10:20:00'),
(7, 14, 2, 4, 'Clean space and quick checking tools. Excellent local guidance tips.', '2026-10-26 13:00:00'),
(8, 2, 14, 4, 'Very nice guest, left the kitchen spotless. A+ profile.', '2026-10-26 13:40:00'),
(9, 15, 3, 5, 'Lukas provided detailed notes on regional transport and dynamic maps.', '2026-10-29 12:00:00'),
(10, 3, 15, 5, 'Quiet, tidy commuter. Excellent platform communication throughout.', '2026-10-29 12:15:00'),
(11, 17, 4, 7, 'Laura went out of her way to make our city stay cozy. Great host.', '2026-11-09 11:00:00'),
(12, 4, 17, 7, 'Delightful traveler. Followed all checkout guidelines perfectly.', '2026-11-09 11:30:00'),
(13, 20, 5, 10, 'Tim was very accommodating with our unusual train arrival schedule.', '2026-11-24 15:00:00'),
(14, 5, 20, 10, 'Wonderful tenant who treated the high-rise flat with great respect.', '2026-11-24 15:30:00'),
(15, 12, 6, 12, 'Julia has a marvelous historic property setup. Clean and cozy.', '2026-12-04 10:00:00'),
(16, 6, 12, 12, 'Fantastic guest profile. Courteous, friendly, and punctual tracking.', '2026-12-04 10:30:00'),
(17, 13, 7, 13, 'Jonas was super helpful during our weekend checking cycles.', '2026-12-08 12:00:00'),
(18, 7, 13, 13, 'Wonderful family guests. Left everything in fantastic shape.', '2026-12-08 12:45:00'),
(19, 15, 8, 15, 'Sarah is an exceptionally organized property manager. High tech setup.', '2026-12-18 11:00:00'),
(20, 8, 15, 15, 'Highly recommended guest profile. Friendly, neat, and highly reliable.', '2026-12-18 11:20:00');


--  27  "User_Rating" Table

INSERT INTO "User_Rating" ("User_Review_ID", "Author_ID", "Receiver_ID", "Booking_ID", "User_Rating_Score") VALUES
(1, 11, 1, 1, 5),
(2, 1, 11, 1, 5),
(3, 12, 1, 2, 5),
(4, 1, 12, 2, 5),
(5, 13, 2, 3, 5),
(6, 2, 13, 3, 4),
(7, 14, 2, 4, 5),
(8, 2, 14, 4, 5),
(9, 15, 3, 5, 5),
(10, 3, 15, 5, 4),
(11, 17, 4, 7, 5),
(12, 4, 17, 7, 5),
(13, 20, 5, 10, 5),
(14, 5, 20, 10, 5),
(15, 12, 6, 12, 4),
(16, 6, 12, 12, 5),
(17, 13, 7, 13, 5),
(18, 7, 13, 13, 5),
(19, 15, 8, 15, 5),
(20, 8, 15, 15, 5);


-- =============================================================================================          
--              D M L   W I T H   D U M M Y   R E C O R D S   C O M P L E T E
-- =============================================================================================          
