-- ============================================
--      1. BASE (INDEPENDENT) ENTITIES
-- ============================================

-- Create main "User" Entity Table 
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
--           2. DEPENDENT ENTITIES
-- ============================================

CREATE TABLE "User_Profile" (
  "Profile_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "User_Bio" TEXT,
  "Profile_Picture_URL" VARCHAR(255),

  -- Primary Key (PK)
  CONSTRAINT "PK_User_Profile" PRIMARY KEY ("Profile_ID"),

  -- Foreign Key (FK) Child "User_Profile" Table referencing Parent "User" Table
  CONSTRAINT "FK_User_Profile_User" FOREIGN KEY ("User_ID")
    REFERENCES "User" ("User_ID")
    ON DELETE CASCADE 
);

-- ============================================
--             3. CORE ENTITIES
-- ============================================

CREATE TABLE "Accommodation_Listing" (
  "Property_ID" INT GENERATED ALWAYS AS IDENTITY,
  "User_ID" INT NOT NULL,
  "Accommodation_Address" VARCHAR(255) NOT NULL,
  "Accommodation_Type" VARCHAR(50) NOT NULL, -- "Apartment" or "Bedroom"
  "Accommodation_Description" TEXT,
  "Max_Guests" INT NOT NULL DEFAULT 1,


















