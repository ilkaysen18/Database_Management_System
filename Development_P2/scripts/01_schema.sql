-- =============================================================================================          
--        E N T I T Y   T A B L E S
-- =============================================================================================          

-- ============================================
--       1. BASE (INDEPENDENT) ENTITY
-- ============================================

-- Main "User" Entity Table
CREATE TABLE "User" (
  "User_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_Name" VARCHAR(100) NOT NULL,
  "User_Email" VARCHAR(255) NOT NULL,
  "User_Phone" VARCHAR(30),
  "Password_Hash" VARCHAR(255) NOT NULL,
  
  -- Data Integrity and Key Constraints
  CONSTRAINT "PK_User" PRIMARY KEY ("User_ID"),
  CONSTRAINT "UQ_User_Email" UNIQUE ("User_Email")
);

-- ============================================
--            2. DEPENDENT ENTITY
-- ============================================

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
--              3. CORE ENTITY
-- ============================================

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
--               4. CORE ENTITY
-- ============================================

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
--             5. DEPENDENT ENTITY
-- ============================================

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
  CONSTRAINT "FK_Images_Experience" FOREIGN KEY
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
  -- OFK (Notification_ID) referencing its relevant Entity Table
  CONSTRAINT "FK_Notifications_Booking" FOREIGN KEY ("Notification_ID")
    REFERENCES "Notifications" ("Notification_ID")
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
  CONSTRAINT "PK_Experience_Booking" PRIMARY KEY ("Exp_Booking_ID"),

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
  "Exp_Booking_ID" INT, -- references tours (experiences), OFK (conditional, see Domain Rule below for this Entity Table)

  -- PK Constraint
  CONSTRAINT "PK_Financial_Transaction" PRIMARY KEY ("Transaction_ID"),
  
  -- OFK referencing 
  CONSTRAINT "FK_Financial_Transaction_Booking" FOREIGN KEY ("Booking_ID")
        REFERENCES "Accommodation_Booking" ("Booking_ID")
        ON DELETE CASCADE,
  -- OFK referencing 
  CONSTRAINT "FK_Financial_Transaction_Exp" FOREIGN KEY ("Exp_Booking_ID")
        REFERENCES "Experience_Booking" ("Exp_Booking_ID")
        ON DELETE CASCADE,
  
  -- Domain Rule for (the above) OFK: Prevents transaction from processing without at least 1 service, e.g. either Booking_ID or Exp_Booking_ID, depending on service booked by Guest
  CONSTRAINT "CK_Financial_Transaction_Source_Present" CHECK (
    ("Booking_ID" IS NOT NULL AND "Exp_Booking_ID" IS NULL) OR
    ("Booking_ID" IS NULL AND "Exp_Booking_ID" IS NOT NULL)
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
    ON DELETE CASCADE,
);

-- ============================================
--  12. ACCOUNT & SECURITY (DEPENDENT) ENTITY
-- ============================================

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
--    13. ACCOUNT & TRUST (DEPENDENT) ENTITY
-- ============================================

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
-- 14. ACCOUNT & INTEGRATION (DEPENDENT) ENTITY
-- ============================================

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
    ON DELETE CASCADE,
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
  "Exp_Booking_ID" INT, -- OFK points to Experiences

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
  CONSTRAINT "FK_Notifications_Exp_Booking" FOREIGN KEY ("Exp_Booking_ID")
    REFERENCES "Experience_Booking" ("Exp_Booking_ID")
    ON DELETE CASCADE,
);

-- ============================================
--     18.  DISCOVERY (DEPENDENT) ENTITY
-- ============================================

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
--     19.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

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
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--     20.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Calendar" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--     21.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Property_Block_Dates" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--     22.  SCHEDULING (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Block_Dates" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   23. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Accommodation_Review" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   24. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Accommodation_Rating" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   25. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "User_Review" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   26. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "User_Rating" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   27. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Review" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--   28. RATING & REVIEWS (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "Experience_Rating" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    29.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    30.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);


