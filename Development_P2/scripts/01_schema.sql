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

-- ============================================
--     D E P E N D E N T   E N T I T I E S
-- ============================================

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
--    12.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    13.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    14.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    15.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    16.  TRANSACTIONAL (DEPENDENT) ENTITY
-- ============================================

CREATE TABLE "" (
  "" GENERATED ALWAYS AS IDENTITY, -- PK
  "" , -- FK
  "" ,

  -- PK Constraint
  CONSTRAINT "PK_" PRIMARY KEY (""),

  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
  -- FK referencing "" Table's ("") PK Attribute
  CONSTRAINT "FK_" FOREIGN KEY ("")
    REFERENCES "" ("")
    ON DELETE CASCADE,
 
  -- Domain Rule:
  CONSTRAINT "CK_" CHECK
 
);

-- ============================================
--    17.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    18.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    19.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    20.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    21.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    22.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    23.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    24.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    25.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    26.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    27.  TRANSACTIONAL (DEPENDENT) ENTITY
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
--    28.  TRANSACTIONAL (DEPENDENT) ENTITY
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


