-----------------------------------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------------------------------

# 01_schema.sql

### PostgreSQL Constraints

###### Constraints:
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

###### Domain Rules:
* (Business) Domain Rules can prevent an entity from being recorded without at least 1 attribute attached
  - e.g. For the Entity Financial_Transaction - either Booking_ID or Exp_Booking_ID must be attached depending on service booked by Guest
  - e.g. **CONSTRAINT** "CK_Financial_Transaction_Source_Present" **CHECK** ( ("x" **IS NOT NULL AND** "y" **IS NULL**) **OR** ("x" **IS NULL AND** "y" **IS NOT NULL**)
* (Structural) Domain Rules can ensure users cannot connect/link with their own account (recursively) - for an Airbnb use-case
  - CONSTRAINT "CK_No_Self_Connection" CHECK ("User_ID" <> "Connection_ID") -- This Inequality Operator ( <> ) is a Self-Loop Blocking CHECK Constraint

###### Database Normalization & First Normal Form (1NF) Rules:
<img width="521" height="202" alt="image" src="https://github.com/user-attachments/assets/d7a09519-e70b-4969-8265-5a54ac684e9d" />

* The last Attribute in the block ( Default_Payment_Option ) exists as Users may want to add more than one Payment_Option
  - Default_Payment_Option will require a Boolean operator (true or false) as the data type
* The DEFAULT Boolean option is FALSE (rather than TRUE); this allows User's first added Payment_Option to be their Default_Payment_Option
  - This maintains Database Normalization & 1NF Rules - so users can add multiple Payment_Options without there having to be separate data rows in the Entity Table for the same Attribute (such as: Payment_Option_1, Payment_Option_2, . . . , Payment_Option_n).

-----------------------------------------------------------------------------------------------------------------------------------

# 02_dummy_data.sql

### Strategy
* .....

### SQL Statements
###### They will generally follow this structure:
.....

-----------------------------------------------------------------------------------------------------------------------------------
