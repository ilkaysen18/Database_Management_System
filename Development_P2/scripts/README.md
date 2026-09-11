# ERM to PostgreSQL
* ERM Entity becomes database table ( CREATE TABLE table_name )
* ERM Attribute becomes database entry/column
* Data Dictionary Entry lists PostgreSQL Data Type ( INT, VARCHAR(200), DATETIME, DECIMAL )
* Data Keys (PK, FK) become relational constraints (PRIMARY KEY, _references_ parent_table(column) )

# Strategy
* First add the independent entity tables ( User )
* Next add the dependent ones ( Accommodation_Listing )

# PostgreSQL Constraints
* NOT NULL forces database reject NULL entries ( Password_Hash NOT NULL )
* UNIQUE instructs database to reject duplicate entries ( User_Email UNIQUE )
* GENERATED ALWAYS AS IDENTITY automatically adds new entries ( 1 . . n ) and rejects manual entry
  - ( User_ID GENERATED ALWAYS AS IDENTITY ) - ensures data safety and prevents duplicate records
  - Can be used for Primary Keys
* ON DELETE CASCADE automatically handles data cleanup when records are deleted from Parent Tables
  - When Parent record (PK) is deleted, system deletes corresponding Child records (FK)
* DEFAULT value ensures system sets a record as the default if missing ( Max_Guests DEFAULT 1 )
* CHECK constraint rejects system from accepting a value above (>) or below (<) the predefined value
  - (CHECK (Max_Guests > 0)) - creates a data validation rule
*  Domain Rules can prevent an entity from being recorded without at least 1 attribute attached
  - e.g. For the Entity Financial_Transaction, either Booking_ID **_or_** Exp_Booking_ID must be attached, depending on the service booked by the Guest
  - **CONSTRAINT** "CK_Financial_Transaction_Source_Present" **CHECK** ( ("x" **IS NOT NULL AND** "y" **IS NULL**) **OR** ("x" **IS NULL AND** "y" **IS NOT NULL**)
