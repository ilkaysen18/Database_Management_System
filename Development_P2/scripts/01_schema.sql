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










