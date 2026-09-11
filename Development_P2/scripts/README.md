# 01_schema.sql

### ERM to PostgreSQL
* ERM Entity becomes database table ( CREATE TABLE table_name )
* ERM Attribute becomes database entry/column
* Data Dictionary Entry lists PostgreSQL Data Type ( INT, VARCHAR(200), DATETIME, DECIMAL )
* Data Keys (PK, FK) become relational constraints (PRIMARY KEY, _references_ parent_table(column) )

### Strategy
* First add the independent entity tables ( e.g. User )
* Next add the dependent ones ( e.g. Accommodation_Listing )

### SQL Statements
###### They will generally follow this structure:
<img width="317" height="377" alt="image" src="https://github.com/user-attachments/assets/eabdd12c-9f82-417e-b272-5c09542f1435" />

### PostgreSQL Constraints
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
* (Business) Domain Rules can prevent an entity from being recorded without at least 1 attribute attached
  - e.g. For the Entity Financial_Transaction - either Booking_ID or Exp_Booking_ID must be attached depending on service booked by Guest
  - e.g. **CONSTRAINT** "CK_Financial_Transaction_Source_Present" **CHECK** ( ("x" **IS NOT NULL AND** "y" **IS NULL**) **OR** ("x" **IS NULL AND** "y" **IS NOT NULL**)
* (Structural) Domain Rules can ensure users cannot connect/link with their own account (recursively) - for an Airbnb use-case
  - CONSTRAINT "CK_No_Self_Connection" CHECK ("User_ID" <> "Connection_ID") -- This Inequality Operator ( <> ) is a Self-Loop Blocking CHECK Constraint

# 02_dummy_data.sql

### Strategy
* .....

### SQL Statements
###### They will generally follow this structure:
.....
