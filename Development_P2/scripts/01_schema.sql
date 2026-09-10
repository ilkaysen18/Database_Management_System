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
--           2. DEPENDENT ENTITITY
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
--             3. CORE ENTITITY
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
--              4. CORE ENTITITY
-- ============================================

CREATE TABLE "Experience_Listing" (
  "Experience_Listing_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "Experience_Price" VALUE NOT NULL,
  -- NEXT add some currency constraints and other constraints














