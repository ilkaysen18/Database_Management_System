-- =============================================================================================          
--                                 E N T I T Y    T A B L E S
-- =============================================================================================          

-- ===============================================================================================================================================================================
-- IMPORTANT PROCESSES/CHANGES (UPDATES) UNDERGONE DURING TESTING: 
-- ===============================================================================================================================================================================
-- After some run errors on Supabase: Some Entities were reordered due to FK not existing or Child Table existing prior to Parent Table.
-- There were also some Circular Loops that ran errors, thus one FK (Property_Calendar_ID) was removed from Property_Block_Dates, given there were 2 similar keys in this Entity.
-- All the Calendar and Booking related Entities were grouped together, one after the other, after reordering, as they kept running errors -
-- additionally, some FK Constraints were removed from these Entities and placed straight after the next Entity (after their FK was actually created as a PK in that next Table).
-- Lastly, some additional Keys and further Constraints were added, such as User_Type and User_Type_ID,
-- as the User_ID was unable to be defined in the Dummy Data properly and this was a solution that worked, after trying multiple other ways.
-- Also, adding specific User_Type (standardized) options was particularly useful when the data became unorganized when running the Dummy Data Tables on Supabase - 
-- as all of the separate ID keys in other Entities pointed to separate Users, where readers would not understand who is who; 
-- and many of those 25+ ID Keys kept running errors, as the system either couldn't point to which User the IDs belonged to, 
-- and/or (more often than that) the same Users appeared in conflicting Actions in the Dummy Data (such as Hosts and Locals interacting with each other,
-- however the main User should have been Guests interacting with either Hosts or Locals); thus specifying a User_Type was crucial in the database's normalization.
-- ===============================================================================================================================================================================

-- ============================================
--       1. BASE (INDEPENDENT) ENTITY
-- ============================================

-- Main "User" Entity Table :

CREATE TABLE "User" (
  "User_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_Type" VARCHAR(50) NOT NULL, -- e.g. 'Host', 'Guest', 'Local'
  "User_Type_ID" INT NOT NULL, -- Links to User_ID, Needs to be defined for its Dummy Data Table
  "User_Name" VARCHAR(100) NOT NULL,
  "User_Email" VARCHAR(255) NOT NULL,
  "User_Phone" VARCHAR(30),
  "Password_Hash" VARCHAR(255) NOT NULL,
  
  -- Data Integrity and Key Constraints
  CONSTRAINT "PK_User" PRIMARY KEY ("User_ID"),
  CONSTRAINT "UQ_User_Email" UNIQUE ("User_Email"),

  -- Domain Rule (Technical): Standardizes User_Type, required for the User Dummy Data Table
  CONSTRAINT "CK_User_Type_Standardized" CHECK (
    "User_Type" IN (
      'Host',
      'Guest',
      'Local'
    )
  )
);

-- ============================================
--            2. DEPENDENT ENTITY
-- ============================================

-- "User_Profile" Entity Table :

CREATE TABLE "User_Profile" (
  "Profile_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "User_Bio" TEXT,
  "Profile_Picture_URL" VARCHAR(255),

  -- Define Primary Key (PK)
  CONSTRAINT "PK_User_Profile" PRIMARY KEY ("Profile_ID"),

  -- Foreign Key (FK) Child "User_Profile" Table references Parent "User" Table
  CONSTRAINT "FK_User_Profile_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE 
);

-- ============================================
--  3. ACCOUNT & SECURITY (DEPENDENT) ENTITY
-- ============================================

-- "Verification" Entity Table :

CREATE TABLE "Verification" (
  "Verification_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "User_ID" INT NOT NULL, -- FK
  "Email_Verification_Status" VARCHAR(50) NOT NULL DEFAULT 'Unverified',
  "Phone_Verification_Status" VARCHAR(50) NOT NULL DEFAULT 'Unverified',
  "ID_Verification_Status" VARCHAR(50) NOT NULL DEFAULT 'Not Retained',

  -- PK Constraint
  CONSTRAINT "PK_Verification" PRIMARY KEY ("Verification_ID"),

  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Verification_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule: Standardizes auditing/verification status
  CONSTRAINT "CK_Email_Status_Valid" CHECK (
    "Email_Verification_Status" IN ('Verified', 'Unverified')
    ),
  CONSTRAINT "CK_Phone_Status_Valid" CHECK (
    "Phone_Verification_Status" IN ('Verified', 'Unverified')
    ),
  CONSTRAINT "CK_ID_Status_Valid" CHECK (
    "ID_Verification_Status" IN ('Verified', 'Not Retained')
    )
);

-- ============================================
-- 4. ACCOUNT & INTEGRATION (DEPENDENT) ENTITY
-- ============================================

-- "Payment_Method" Entity Table :

CREATE TABLE "Payment_Method" (
  "Payment_Method_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "User_ID" INT NOT NULL, -- FK
  "Payment_Option" VARCHAR(50) NOT NULL DEFAULT 'Credit Card', -- e.g., Credit Card or PayPal, also a new attribute
  "Encrypted_Payment_Token" VARCHAR(512) NOT NULL, -- For payment security, also new attribute
  "Billing_Address" VARCHAR(255), -- new attribute 
  "Default_Payment_Option" BOOLEAN NOT NULL DEFAULT FALSE, -- new attribute
  
  -- PK Constraint
  CONSTRAINT "PK_Payment_Method" PRIMARY KEY ("Payment_Method_ID"),

  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Payment_Method_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE
);

-- ============================================
--    5. ACCOUNT & TRUST (DEPENDENT) ENTITY
-- ============================================

-- "Social_Media_Connection" Entity Table :

CREATE TABLE "Social_Media_Connection" (
  "SMP_Token" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "User_ID" INT NOT NULL, -- Points to user's own User_ID, FK
  "Connection_ID" INT NOT NULL, -- Points to user's Social Media Platform (SMP) Connection's User_ID, FK

  -- PK Constraint
  CONSTRAINT "PK_Social_Media_Connection" PRIMARY KEY ("SMP_Token"),

  -- FK referencing "User" Table's ("User_ID") PK Attribute, for the Source (Original) User connecting
  CONSTRAINT "FK_SMP_Source_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing "User" Table's ("User_ID") PK Attribute, for the Target Peer (the User's Connection)
  CONSTRAINT "FK_SMP_Target_Peer" FOREIGN KEY ("Connection_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule (Structural): Users cannot connect/link with their own account (recursively)
  CONSTRAINT "CK_No_Self_Connection" CHECK ("User_ID" <> "Connection_ID") -- This Inequality Operator ( <> ) is a Self-Loop Blocking CHECK Constraint
);

-- ============================================
--              6. CORE ENTITY
-- ============================================

-- "Accommodation_Listing" Entity Table :

CREATE TABLE "Accommodation_Listing" (
  "Property_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "Accommodation_Address" VARCHAR(255) NOT NULL, -- new attribute added
  "Accommodation_Type" VARCHAR(50) NOT NULL, -- "Apartment" or "Bedroom", newly added attribute
  "Accommodation_Description" TEXT, -- new attribute added
  "Max_Guests" INT NOT NULL DEFAULT 1, -- new attribute added

  -- Define Primary Key (PK) and Constraints
  CONSTRAINT "PK_Accommodation_Listing" PRIMARY KEY ("Property_ID"),

  -- Foreign Key (FK) referencing Primary Key (PK)
  CONSTRAINT "FK_Accommodation_Listing_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,

  -- Domain rule constraint added to ensure Max_Guests attribute isn't recorded as below 0 or a negative valule
  CONSTRAINT "CK_Max_Guests_Positive" CHECK ("Max_Guests" > 0)
);

-- ============================================
--               7. CORE ENTITY
-- ============================================

-- "Experience_Listing" Entity Table :

CREATE TABLE "Experience_Listing" (
  "Experience_Listing_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "Experience_Price" DECIMAL(20,8) NOT NULL, -- limit = 20 total digits, with fixed 8 decimal places
  "Currency_Code" VARCHAR(3) NOT NULL DEFAULT 'EUR', -- new attribute added

  -- Primary Key (PK) Constraint
  CONSTRAINT "PK_Experience_Listing" PRIMARY KEY ("Experience_Listing_ID"),

  -- Foreign Key (FK) referencing Primary Key (PK)
  CONSTRAINT "FK_Experience_Listing_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,

  -- Domain Rule 1: Price is greater than 0
  CONSTRAINT "CK_Experience_Price_Positive" CHECK ("Experience_Price" > 0.00),
  -- Domain Rule 2: Forces European currency validation
  CONSTRAINT "CK_Experience_Currency_EUR" CHECK ("Currency_Code" = 'EUR')
);

-- =============================================================================================         
--                             D E P E N D E N T    E N T I T I E S
-- =============================================================================================         

-- ============================================
--             8. DEPENDENT ENTITY
-- ============================================

-- "Accommodation_Price" Entity Table :

CREATE TABLE "Accommodation_Price" (
  "Price_ID" INT GENERATED ALWAYS AS IDENTITY,
  "Property_ID" INT NOT NULL, -- FK
  "Host_ID" INT NOT NULL, -- FK
  "Nightly_Price" DECIMAL(20,8) NOT NULL, -- limit of 20 total digits, with 8 decimal places fixed
  "Currency_Code" VARCHAR(3) NOT NULL DEFAULT 'EUR', -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_Accommodation_Price" PRIMARY KEY ("Price_ID"),
  
  -- FK (Host_ID) references PK (User_ID)
  CONSTRAINT "FK_Accommodation_Price_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK (Property_ID) references PK Entity (Accommodation_Listing)
  CONSTRAINT "FK_Accommodation_Price_Property" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,

  -- Domain Rule 1: Price is non-negative
  CONSTRAINT "CK_Nightly_Price_Positive" CHECK ("Nightly_Price" >= 0.00), -- allows 0.00 EUR for promotional/free nights or block dates
  -- Domain Rule 2: Enforces European currency for standardization
  CONSTRAINT "CK_Accommodation_Currency_EUR" CHECK ("Currency_Code" = 'EUR')
);

-- ============================================
--     18.  DISCOVERY (DEPENDENT) ENTITY
-- ============================================

-- "Accommodation_Price" Entity Table :9

CREATE TABLE "Amenity" (
  "Amenity_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Property_ID" INT NOT NULL, -- FK links to Accommodation_Listing Entity/Table
  "Amenity_Name" VARCHAR(50) NOT NULL, -- e.g., 'Wi-Fi', 'Pool', 'Kitchen', also a new attribute
  "Amenity_Description" TEXT, -- new attribute

  -- PK Constraint
  CONSTRAINT "PK_Amenity" PRIMARY KEY ("Amenity_ID"),

  -- FK referencing
  CONSTRAINT "FK_Amenity_Property" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule: Standardizes Amenity_Name entries
  CONSTRAINT "CK__Amenity_Name_Standardized" CHECK (
    "Amenity_Name" IN (
      'Free Parking',
      'Breakfast',
      'Wi-Fi',
      'TV',
      'Air Conditioning',
      'Heating',
      'Washing Machine',
      'Kitchen',
      'Pool',
      'Pet-Friendly'
    )
  )
);

















































































-- ============================================
--             6. DEPENDENT ENTITY
-- ============================================

CREATE TABLE "Images" (
  "Image_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL, -- FK
  "Accommodation_Listing_ID" INT, -- Optional Foreign Key (OFK) mapping to stays, newly added attribute 
  "Experience_Listing_ID" INT, -- OFK mapping to tours (Experiences)
  "Property_ID" INT NOT NULL, -- FK
  "Image_URL" VARCHAR(255) NOT NULL,
  "Image_Caption" VARCHAR(150),

  -- Defines PK
  CONSTRAINT "PK_Images" PRIMARY KEY ("Image_ID"),

  -- FK references User who uploaded the image
  CONSTRAINT "FK_Images_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK (Property_ID) references PK Entity (Accommodation_Listing)
  CONSTRAINT "FK_Accommodation_Price_Property" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,

  -- OFK (Accommodation_Listing_ID) referencing PK Entity Table (Accommodation_Listing)
  CONSTRAINT "FK_Images_Accommodation" FOREIGN KEY ("Accommodation_Listing_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,
  -- OFK (Experience_Listing_ID) referencing PK Entity Table (Experience_Listing)
  CONSTRAINT "FK_Images_Experience" FOREIGN KEY ("Experience_Listing_ID")
    REFERENCES "Experience_Listing" ("Experience_Listing_ID")
    ON DELETE CASCADE
);

-- ============================================
--    7.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Accommodation_Booking" (
  "Booking_ID" INT GENERATED ALWAYS AS IDENTITY,
  "Guest_ID" INT NOT NULL, -- Links to User_ID of guest, FK
  "Host_ID" INT NOT NULL, -- Links to User_ID of host, new data attribute, FK
  "Property_ID" INT NOT NULL, -- FK
  "Property_Calendar_ID" INT NOT NULL, -- FK
  "Notification_ID" INT, -- OFK for tracking system notifications sent to Users
  "CI_CO_Date" TIMESTAMP NOT NULL, -- Check-In / Check-Out date tracking
  "Booking_Status" VARCHAR(20) NOT NULL DEFAULT 'Pending', 

  -- Define PK Constraint
  CONSTRAINT "PK_Accommodation_Booking" PRIMARY KEY ("Booking_ID"),

  -- FK (Guest) references User
  CONSTRAINT "FK_Booking_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK (Host) references User
  CONSTRAINT "FK_Booking_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK (Property_ID) referencing PK Entity Table (Accommodation_Listing)
  CONSTRAINT "FK_Booking_Property" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,

  -- Domain Rule: Standardizes Booking_Status options as a Validation CHECK Constraint
  CONSTRAINT "CK_Booking_Status_Valid" CHECK (
    "Booking_Status" IN ('Pending', 'Confirmed', 'Canceled', 'Accepted', 'Rejected')
  )
);

-- ============================================
--    8.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Booking" (
  "Experience_Booking_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Experience_Listing_ID" INT NOT NULL, -- FK
  "Guest_ID" INT NOT NULL, -- Links to User_ID, FK
  "Experience_Calendar_ID" INT NOT NULL, -- FK
  "Notification_ID" INT, -- Tracks notifications, OFK
  "Exp_Booking_Status" VARCHAR(20) NOT NULL DEFAULT 'Pending',

  -- PK Constraint
  CONSTRAINT "PK_Experience_Booking" PRIMARY KEY ("Experience_Booking_ID"),

  -- FK referencing Experience_Listing 
  CONSTRAINT "FK_Exp_Booking_Listing" FOREIGN KEY ("Experience_Listing_ID")
        REFERENCES "Experience_Listing" ("Experience_Listing_ID")
        ON DELETE CASCADE,
  -- FK referencing User
  CONSTRAINT "FK_Exp_Booking_Guest" FOREIGN KEY ("Guest_ID")
        REFERENCES "User" ("User_ID")
        ON DELETE CASCADE,

  -- Domain Rule: Standardizes Exp_Booking_Status options as a Validation CHECK Constraint
   CONSTRAINT "CK_Exp_Booking_Status_Valid" CHECK (
        "Exp_Booking_Status" IN ('Pending', 'Confirmed', 'Canceled', 'Accepted', 'Rejected')
  )
);

-- ============================================
--    9.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Financial_Transaction" (
  "Transaction_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Booking_ID" INT, -- references stays, OFK (conditional, see Domain Rule below for this Entity Table)
  "Experience_Booking_ID" INT, -- references tours (experiences), OFK (conditional, see Domain Rule below for this Entity Table)

  -- PK Constraint
  CONSTRAINT "PK_Financial_Transaction" PRIMARY KEY ("Transaction_ID"),
  
  -- OFK referencing 
  CONSTRAINT "FK_Financial_Transaction_Booking" FOREIGN KEY ("Booking_ID")
        REFERENCES "Accommodation_Booking" ("Booking_ID")
        ON DELETE CASCADE,
  -- OFK referencing 
  CONSTRAINT "FK_Financial_Transaction_Exp" FOREIGN KEY ("Experience_Booking_ID")
        REFERENCES "Experience_Booking" ("Experience_Booking_ID")
        ON DELETE CASCADE,
  
  -- Domain Rule for (the above) OFK: Prevents transaction from processing without at least 1 service, e.g. either Booking_ID or Experience_Booking_ID, depending on service booked by Guest
  CONSTRAINT "CK_Financial_Transaction_Source_Present" CHECK (
    ("Booking_ID" IS NOT NULL AND "Experience_Booking_ID" IS NULL) OR
    ("Booking_ID" IS NULL AND "Experience_Booking_ID" IS NOT NULL)
  )
);

-- ============================================
--    10.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================
CREATE TABLE "Host_Payout" (
  "Host_Payout_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Transaction_ID" INT NOT NULL, -- FK
  "Host_ID" INT NOT NULL, -- Links to User_ID, FK
  "Guest_ID" INT NOT NULL, -- Links to User_ID, FK

  -- PK Constraint
  CONSTRAINT "PK_Host_Payout" PRIMARY KEY ("Host_Payout_ID"),

  -- FK referencing "Financial_Transaction" Table's ("Transaction_ID") PK Attribute
  CONSTRAINT "FK_Host_Payout_Transaction" FOREIGN KEY ("Transaction_ID")
    REFERENCES "Financial_Transaction" ("Transaction_ID")
    ON DELETE CASCADE,
  
  -- FK referencing Host (User)
  CONSTRAINT "FK_Host_Payout_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- Foreign Key referencing Guest (User)
  CONSTRAINT "FK_Host_Payout_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE
);

-- ============================================
--    11.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Local_Payout" (
  "Local_Payout_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Transaction_ID" INT NOT NULL, -- FK
  "Local_ID" INT NOT NULL, -- Links to User_ID, FK
  "Guest_ID" INT NOT NULL, -- Links to User_ID, FK

  -- PK Constraint
  CONSTRAINT "PK_Local_Payout" PRIMARY KEY ("Local_Payout_ID"),

  -- FK referencing "Financial_Transaction" Table's ("Transaction_ID") PK Attribute
  CONSTRAINT "FK_Local_Payout_Transaction" FOREIGN KEY ("Transaction_ID")
    REFERENCES "Financial_Transaction" ("Transaction_ID")
    ON DELETE CASCADE,
  
  -- FK referencing Local / Tour Creator (User)
  CONSTRAINT "FK_Local_Payout_Local" FOREIGN KEY ("Local_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing Guest / Tour Booker (User)
  CONSTRAINT "FK_Local_Payout_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE
);

-- ============================================
--    15.  COMMUNICATION (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Message_Thread" (
  "Thread_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Booking_ID" INT NOT NULL, -- FK
  "Thread_Subject" VARCHAR(100),
  "Thread_Date" TIMESTAMP NOT NULL,
  "Thread_Status" VARCHAR(20) NOT NULL DEFAULT 'Active', 
  "Guest_ID" INT NOT NULL, -- FK links to User_ID
  "Host_ID" INT NOT NULL, -- FK links to User_ID

  -- PK Constraint
  CONSTRAINT "PK_Message_Thread" PRIMARY KEY ("Thread_ID"),

  -- FK referencing "Accommodation_Booking" Table's ("Booking_ID") PK Attribute
  CONSTRAINT "FK_Message_Thread_Booking" FOREIGN KEY ("Booking_ID")
    REFERENCES "Accommodation_Booking" ("Booking_ID")
    ON DELETE CASCADE,
  
  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Message_Thread_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Message_Thread_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule: Standardized / Validation Rules for Thread_Status
  CONSTRAINT "CK_Thread_Status_Valid" CHECK (
    "Thread_Status" IN ('Active', 'Archived', 'Deleted')
  )
);

-- ============================================
--    16.  COMMUNICATION (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Message_Log" (
  "Msg_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Thread_ID" INT NOT NULL, -- FK from Message_Thread Entity/Table
  "Sender_ID" INT NOT NULL, -- FK links to User_ID
  "Receiver_ID" INT NOT NULL, -- FK links to User_ID
  "Msg_Content" TEXT NOT NULL,
  "Msg_Timestamp" TIMESTAMP NOT NULL,

  -- PK Constraint
  CONSTRAINT "PK_Message_Log" PRIMARY KEY ("Msg_ID"),

  -- FK referencing "Message_Thread" Table's ("Thread_ID") PK Attribute
  CONSTRAINT "FK_Message_Log_Thread" FOREIGN KEY ("Thread_ID")
    REFERENCES "Message_Thread" ("Thread_ID")
    ON DELETE CASCADE,
  
  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Message_Log_Sender" FOREIGN KEY ("Sender_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing "User" Table's ("User_ID") PK Attribute
  CONSTRAINT "FK_Message_Log_Receiver" FOREIGN KEY ("Receiver_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule (Technical): Prevents user account from sending the messages to itself
  CONSTRAINT "CK_No_Self_Messaging" CHECK ("Sender_ID" <> "Receiver_ID") -- Inequality Operator ( <> ) as a Self-Loop Blocking CHECK Constraint
);

-- ============================================
-- 17. ACCOUNT & INTEGRATION (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Notifications" (
  "Notification_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Notification_Type" VARCHAR(50) NOT NULL, -- Context Categories e.g. 'Booking', 'CI', 'Payout'
  "Message_Body" TEXT NOT NULL,
  "Is_Read" BOOLEAN NOT NULL DEFAULT FALSE, -- Boolean rule for True or False
  "User_ID" INT NOT NULL, -- FK links to User_ID
  "Booking_ID" INT, -- OFK points to Stays
  "Experience_Booking_ID" INT, -- OFK points to Experiences

  -- PK Constraint
  CONSTRAINT "PK_Notifications" PRIMARY KEY ("Notification_ID"),

  -- FK referencing
  CONSTRAINT "FK_Notifications_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  
  -- OFK referencing
  CONSTRAINT "FK_Notifications_Booking" FOREIGN KEY ("Booking_ID")
    REFERENCES "Accommodation_Booking" ("Booking_ID")
    ON DELETE CASCADE,
  -- OFK referencing
  CONSTRAINT "FK_Notifications_Exp_Booking" FOREIGN KEY ("Experience_Booking_ID")
    REFERENCES "Experience_Booking" ("Experience_Booking_ID")
    ON DELETE CASCADE
);

-- ====================================================
--       19.1.  SCHEDULING (DEPENDENT) ENTITY
-- ====================================================

CREATE TABLE "Property_Calendar" (
  "Property_Calendar_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Property_ID" INT NOT NULL, -- FK from Accommodation_Listing Entity/Table
  "Prop_Availability_ID" INT NOT NULL, -- FK links to availability blocks
  "Booking_ID" INT, -- OFK for booking records

  -- PK Constraint
  CONSTRAINT "PK_Property_Calendar" PRIMARY KEY ("Property_Calendar_ID"),

  -- FK referencing 
  CONSTRAINT "FK_Prop_Calendar_Listing" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE
  
  -- To prevent a Circular Compilation Loop Error in Supabase:
  -- The other 2 FK Constraints are not added yet, as their PK Tables haven't been CREATE(d) yet;
  -- They will be added in the next Entity as ALTER TABLE command.
);

-- ============================================
--     20.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Property_Block_Dates" (
  "Prop_Availability_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Property_ID" INT NOT NULL, -- FK
  "Property_Calendar_ID" INT NOT NULL, -- FK
  "Prop_Blocked_Date" DATE NOT NULL, -- new Attribute added 

  -- PK Constraint
  CONSTRAINT "PK_Property_Block_Dates" PRIMARY KEY ("Prop_Availability_ID"),

  -- FK referencing
  CONSTRAINT "FK_Prop_Block_Listing" FOREIGN KEY ("Property_ID")
    REFERENCES "Accommodation_Listing" ("Property_ID")
    ON DELETE CASCADE,
  
  -- FK referencing
  CONSTRAINT "FK_Prop_Block_Calendar" FOREIGN KEY ("Property_Calendar_ID")
    REFERENCES "Property_Calendar" ("Property_Calendar_ID")
    ON DELETE CASCADE
);

-- ====================================================
--     19.2.  SAFE RELATIONSHIP CONSTRAINTS LAYER
-- ====================================================

-- Can now add the remaining 2 FK Constraints (safely with ALTER TABLE) for Entity #19.

-- FK referencing 
ALTER TABLE "Property_Calendar" -- Entity #19.
    ADD CONSTRAINT "FK_Prop_Calendar_Block" FOREIGN KEY ("Prop_Availability_ID")
    REFERENCES "Property_Block_Dates" ("Prop_Availability_ID")
    ON DELETE CASCADE;

-- FK referencing Accommodation_Booking Table
ALTER TABLE "Property_Calendar" -- Entity #19.
    ADD CONSTRAINT "FK_Prop_Calendar_Booking" FOREIGN KEY ("Booking_ID")
    REFERENCES "Accommodation_Booking" ("Booking_ID")
    ON DELETE CASCADE;
-- "Accommodation_Booking" Table was CREATE(d) already, though it still did not exist yet;
-- as it required [ "Accommodation_Booking" ("Booking_ID") ] first,
-- which required [ "Property_Calendar" ("Property_Calendar_ID") ] first.

-- ====================================================
--       21.1.  SCHEDULING (DEPENDENT) ENTITY
-- ====================================================

CREATE TABLE "Experience_Calendar" (
  "Experience_Calendar_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Experience_Listing_ID" INT NOT NULL, -- FK
  "Exp_Availability_ID" INT NOT NULL, -- FK to a "Experience_Block_Dates" Table, which hasn't been CREATE(d) yet
  "Experience_Booking_ID" INT, -- OFK for experience booking records, which requires "Experience_Block_Dates" Table first

  -- PK Constraint
  CONSTRAINT "PK_Experience_Calendar" PRIMARY KEY ("Experience_Calendar_ID"),

  -- FK referencing
  CONSTRAINT "FK_Exp_Calendar_Listing" FOREIGN KEY ("Experience_Listing_ID")
    REFERENCES "Experience_Listing" ("Experience_Listing_ID")
    ON DELETE CASCADE
);

-- ============================================
--     22.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Block_Dates" (
  "Exp_Availability_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Experience_Listing_ID" INT NOT NULL, -- FK
  "Exp_Blocked_Date" DATE NOT NULL, -- new Attribute added

  -- PK Constraint
  CONSTRAINT "PK_Experience_Block_Dates" PRIMARY KEY ("Exp_Availability_ID"),

  -- FK referencing
  CONSTRAINT "FK_Exp_Block_Listing" FOREIGN KEY ("Experience_Listing_ID")
    REFERENCES "Experience_Listing" ("Experience_Listing_ID")
    ON DELETE CASCADE
);

-- ====================================================
--     21.2.  SAFE RELATIONSHIP CONSTRAINTS LAYER
-- ====================================================

-- Can add remaining 2 FK Constraints (safely with ALTER TABLE) for Entity #21.

-- FK referencing
ALTER TABLE "Experience_Calendar"
  ADD CONSTRAINT "FK_Exp_Calendar_Block" FOREIGN KEY ("Exp_Availability_ID")
  REFERENCES "Experience_Block_Dates" ("Exp_Availability_ID")
  ON DELETE CASCADE;

-- FK referencing
ALTER TABLE "Experience_Calendar"
  ADD CONSTRAINT "FK_Exp_Calendar_Booking" FOREIGN KEY ("Experience_Booking_ID")
  REFERENCES "Experience_Booking" ("Experience_Booking_ID")
  ON DELETE CASCADE;

-- ============================================
--   23. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Accommodation_Review" (
  "Property_Review_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Property_Rating_ID" INT NOT NULL, -- FK
  "Booking_ID" INT NOT NULL, -- FK
  "Host_ID" INT NOT NULL, -- FK links to User_ID
  "Guest_ID" INT NOT NULL, -- FK links to User_ID
  "Accomm_Review_Content" TEXT NOT NULL, -- new attribute added
  "Accomm_Review_Date" TIMESTAMP NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_Accommodation_Review" PRIMARY KEY ("Property_Review_ID"),

  -- FK referencing
  CONSTRAINT "FK_Acc_Review_Booking" FOREIGN KEY ("Booking_ID")
    REFERENCES "Accommodation_Booking" ("Booking_ID")
    ON DELETE CASCADE,
  
  -- FK referencing
  CONSTRAINT "FK_Acc_Review_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_Acc_Review_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE 
);

-- ============================================
--   24. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Accommodation_Rating" (
  "Property_Rating_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Property_Review_ID" INT NOT NULL, -- FK
  "Booking_ID" INT NOT NULL, -- FK
  "Host_ID" INT NOT NULL, -- FK links to User_ID
  "Guest_ID" INT NOT NULL, -- FK links to User_ID
  "Accomm_Rating_Score" INT NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_Accommodation_Rating" PRIMARY KEY ("Property_Rating_ID"),

  -- FK referencing
  CONSTRAINT "FK_Acc_Rating_Booking" FOREIGN KEY ("Booking_ID")
    REFERENCES "Accommodation_Booking" ("Booking_ID")
    ON DELETE CASCADE,
  
  -- FK referencing
  CONSTRAINT "FK_Acc_Rating_Host" FOREIGN KEY ("Host_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_Acc_Rating_Guest" FOREIGN KEY ("Guest_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule: Standardized/Validation Rule for 5-star rating scale
  CONSTRAINT "CK_Acc_Rating_Range" CHECK ("Accomm_Rating_Score" BETWEEN 1 AND 5)
);

-- ============================================
--   25. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Review" (
  "Exp_Review_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Exp_Rating_ID" INT NOT NULL, -- FK, new attribute added
  "Author_ID" INT NOT NULL, -- FK links to User_ID
  "Receiver_ID" INT NOT NULL, -- FK links to User_ID
  "Experience_Booking_ID" INT NOT NULL, -- FK
  "Exp_Review_Content" TEXT NOT NULL, -- new attribute added
  "Exp_Review_Date" TIMESTAMP NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_Experience_Review" PRIMARY KEY ("Exp_Review_ID"),

  -- FK referencing
  CONSTRAINT "FK_Exp_Review_Booking" FOREIGN KEY ("Experience_Booking_ID")
    REFERENCES "Experience_Booking" ("Experience_Booking_ID")
    ON DELETE CASCADE,

  -- FK referencing
  CONSTRAINT "FK_Exp_Review_Author" FOREIGN KEY ("Author_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_Exp_Review_Receiver" FOREIGN KEY ("Receiver_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE
);

-- ============================================
--   26. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Rating" (
  "Exp_Rating_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "Exp_Review_ID" INT NOT NULL, -- FK, new attribute added
  "Author_ID" INT NOT NULL, -- FK links to User_ID
  "Receiver_ID" INT NOT NULL, -- FK links to User_ID
  "Experience_Booking_ID" INT NOT NULL, -- FK
  "Exp_Rating_Score" INT NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_Experience_Rating" PRIMARY KEY ("Exp_Rating_ID"),

  -- FK referencing
  CONSTRAINT "FK_Exp_Rating_Booking" FOREIGN KEY ("Experience_Booking_ID")
    REFERENCES "Experience_Booking" ("Experience_Booking_ID")
    ON DELETE CASCADE,

  -- FK referencing
  CONSTRAINT "FK_Exp_Rating_Author" FOREIGN KEY ("Author_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_Exp_Rating_Receiver" FOREIGN KEY ("Receiver_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule: Standardized/Validation Rule for 5-star rating scale
  CONSTRAINT "CK_Exp_Rating_Range" CHECK ("Exp_Rating_Score" BETWEEN 1 AND 5)
);

-- ============================================
--   27. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "User_Review" (
  "User_Review_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "User_Rating_ID" INT NOT NULL, -- FK
  "Author_ID" INT NOT NULL, -- FK links to User_ID
  "Receiver_ID" INT NOT NULL,  -- FK links to User_ID
  "Booking_ID" INT, -- OFK linking review about a User to a Stay
  "Experience_Booking_ID" INT, -- OFK linking review about a User to a Tour/Experience
  "User_Review_Content" TEXT NOT NULL, -- new attribute added
  "User_Review_Date" TIMESTAMP NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_User_Review" PRIMARY KEY ("User_Review_ID"),

  -- FK referencing
  CONSTRAINT "FK_User_Review_Author" FOREIGN KEY ("Author_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_User_Review_Receiver" FOREIGN KEY ("Receiver_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule (Technical): Prevents account from leaving a self-review
  CONSTRAINT "CK_No_Self_Review" CHECK ("Author_ID" <> "Receiver_ID") 
);

-- ============================================
--   28. RATINGS & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "User_Rating" (
  "User_Rating_ID" INT GENERATED ALWAYS AS IDENTITY, -- PK
  "User_Review_ID" INT NOT NULL, -- FK
  "Author_ID" INT NOT NULL, -- FK links to User_ID
  "Receiver_ID" INT NOT NULL, -- FK links to User_ID
  "Booking_ID" INT, -- OFK linking rating about a User to a Stay
  "Experience_Booking_ID" INT, -- OFK linking rating about a User to a Tour/Experience
  "User_Rating_Score" INT NOT NULL, -- new attribute added

  -- PK Constraint
  CONSTRAINT "PK_User_Rating" PRIMARY KEY ("User_Rating_ID"),

  -- FK referencing
  CONSTRAINT "FK_User_Rating_Author" FOREIGN KEY ("Author_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_User_Rating_Receiver" FOREIGN KEY ("Receiver_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE,
 
  -- Domain Rule (Business): Standardized/Validation Rule for 5-star rating scale
  CONSTRAINT "CK_User_Rating_Range" CHECK ("User_Rating_Score" BETWEEN 1 AND 5),
  -- Domain Rule (Technical): Prevents account from leaving a self-rating
  CONSTRAINT "CK_No_Self_Rating" CHECK ("Author_ID" <> "Receiver_ID")
);

-- ============================================
--     SAFE RELATIONSHIP CONSTRAINTS LAYER
-- ============================================

-- FK referencing
ALTER TABLE "Accommodation_Booking" 
    ADD CONSTRAINT "FK_Notifications_Booking_Link" FOREIGN KEY ("Notification_ID") 
    REFERENCES "Notifications" ("Notification_ID") ON DELETE CASCADE;

-- FK referencing
ALTER TABLE "Experience_Booking" 
    ADD CONSTRAINT "FK_Notifications_Experience_Link" FOREIGN KEY ("Notification_ID") 
    REFERENCES "Notifications" ("Notification_ID") ON DELETE CASCADE;


-- =============================================================================================          
--                    2 8   E N T I T Y   T A B L E S   C O M P L E T E
-- =============================================================================================          
