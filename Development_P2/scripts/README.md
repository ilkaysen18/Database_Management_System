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
* GENERATED ALWAYS AS IDENTITY automatically adds new entries ( 1 . . n ) and rejects manual entry ( User_ID GENERATED ALWAYS AS IDENTITY) - this ensures data safety and prevents duplicate records
