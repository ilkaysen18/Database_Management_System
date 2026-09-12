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


--  10  "Property_Calendar" Table

INSERT INTO "Property_Calendar" ("Property_ID", "Prop_Availability_ID", "Booking_ID") VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, NULL),
(4, 4, NULL),
(5, 5, NULL),
(6, 6, NULL),
(7, 7, NULL),
(8, 8, NULL),
(9, 9, NULL),
(10, 10, NULL),
(11, 11, NULL),
(12, 12, NULL),
(13, 13, NULL),
(14, 14, NULL),
(15, 15, NULL),
(16, 16, NULL),
(17, 17, NULL),
(18, 18, NULL),
(19, 19, NULL),
(20, 20, NULL);


--  11  "Experience_Calendar" Table

INSERT INTO "Experience_Calendar" ("Experience_Listing_ID", "Exp_Availability_ID", "Exp_Booking_ID") VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, NULL),
(4, 4, NULL),
(5, 5, NULL),
(6, 6, NULL),
(7, 7, NULL),
(8, 8, NULL),
(9, 9, NULL),
(10, 10, NULL),
(11, 11, NULL),
(12, 12, NULL),
(13, 13, NULL),
(14, 14, NULL),
(15, 15, NULL),
(16, 16, NULL),
(17, 17, NULL),
(18, 18, NULL),
(19, 19, NULL),
(20, 20, NULL);


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


--  14  "Accommodation_Booking" Table

INSERT INTO "Accommodation_Booking" ("Guest_ID", "Host_ID", "Property_ID", "Property_Calendar_ID", "Notification_ID", "CI_CO_Date", "Booking_Status") VALUES
(11, 1, 1, 1, NULL, '2026-10-10 14:00:00', 'Confirmed'),
(12, 1, 2, 2, NULL, '2026-10-15 15:00:00', 'Confirmed'),
(13, 2, 3, 3, NULL, '2026-10-18 14:00:00', 'Confirmed'),
(14, 2, 4, 4, NULL, '2026-10-22 16:00:00', 'Accepted'),
(15, 3, 5, 5, NULL, '2026-10-25 14:00:00', 'Confirmed'),
(16, 3, 6, 6, NULL, '2026-11-01 15:00:00', 'Pending'),
(17, 4, 7, 7, NULL, '2026-11-05 14:00:00', 'Confirmed'),
(18, 4, 8, 8, NULL, '2026-11-12 14:00:00', 'Rejected'),
(19, 5, 9, 9, NULL, '2026-11-15 15:00:00', 'Confirmed'),
(20, 5, 10, 10, NULL, '2026-11-20 14:00:00', 'Confirmed'),
(11, 6, 11, 11, NULL, '2026-11-25 14:00:00', 'Canceled'),
(12, 6, 12, 12, NULL, '2026-12-01 15:00:00', 'Confirmed'),
(13, 7, 13, 13, NULL, '2026-12-05 14:00:00', 'Confirmed'),
(14, 7, 14, 14, NULL, '2026-12-10 14:00:00', 'Accepted'),
(15, 8, 15, 15, NULL, '2026-12-15 15:00:00', 'Confirmed'),
(16, 8, 16, 16, NULL, '2026-12-20 14:00:00', 'Confirmed'),
(17, 9, 17, 17, NULL, '2026-12-23 14:00:00', 'Pending'),
(18, 10, 18, 18, NULL, '2026-12-28 15:00:00', 'Confirmed'),
(19, 10, 19, 19, NULL, '2027-01-03 14:00:00', 'Confirmed'),
(20, 9, 20, 20, NULL, '2027-01-10 14:00:00', 'Confirmed');


--  15  "Experience_Booking" Table

INSERT INTO "Experience_Booking" ("Experience_Listing_ID", "Guest_ID", "Experience_Calendar_ID", "Notification_ID", "Exp_Booking_Status") VALUES
(1, 1, 1, NULL, 'Confirmed'),
(2, 2, 2, NULL, 'Confirmed'),
(3, 3, 3, NULL, 'Accepted'),
(4, 4, 4, NULL, 'Confirmed'),
(5, 5, 5, NULL, 'Pending'),
(6, 6, 6, NULL, 'Confirmed'),
(7, 7, 7, NULL, 'Rejected'),
(8, 8, 8, NULL, 'Confirmed'),
(9, 9, 9, NULL, 'Confirmed'),
(10, 10, 10, NULL, 'Canceled'),
(11, 1, 11, NULL, 'Confirmed'),
(12, 2, 12, NULL, 'Confirmed'),
(13, 3, 13, NULL, 'Accepted'),
(14, 4, 14, NULL, 'Confirmed'),
(15, 5, 15, NULL, 'Confirmed'),
(16, 6, 16, NULL, 'Pending'),
(17, 7, 17, NULL, 'Confirmed'),
(18, 8, 18, NULL, 'Confirmed'),
(19, 9, 19, NULL, 'Confirmed'),
(20, 10, 20, NULL, 'Confirmed');


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
