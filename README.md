
--------------------------------------------------------------------------------------------------

### Database_Management_System
[DBMS](https://github.com/ilkaysen18/Database_Management_System)

--------------------------------------------------------------------------------------------------

### Navigation:
* For the Tables (SQL Statements), see: [01_schema.sql](scripts/01_schema.sql)
* For the Dummy Data, see: [02_dummy_data.sql](scripts/02_dummy_data.sql)
* For the Test Cases, see: [03_security_verification.sql](queries/test_cases/03_security_verification.sql)
* For Database Metadata, see:
  - [04_total_tables.sql](queries/metadata/04_total_tables.sql)
  - [05_total_entries.sql](queries/metadata/05_total_entries.sql)
  - [06_db_volume.sql](queries/metadata/06_db_volume.sql)
  - _Note:_ Metadata was added in Phase 3 (P3).

--------------------------------------------------------------------------------------------------

### Installation and Run Instructions:

**1.** Go to Supabase at [https://supabase.com](https://supabase.com) and either login or create a new account.
  - Select the free plan/tier.

**2.** Click to Start a New Project:

  <img width="136" height="26" alt="image" src="https://github.com/user-attachments/assets/6964e5d7-f119-41dd-8d0a-fcd9623010a3" />   →   <img width="104" height="26" alt="image" src="https://github.com/user-attachments/assets/138a2f9e-34fa-46bb-9846-6c49d012de3f" />

  ↓

  <img width="542" height="195" alt="image" src="https://github.com/user-attachments/assets/aa3b33c5-d13e-48e8-b831-7917fe55c334" />


**3.** Go to SQL Editor by selecting it from the left Menu:

  <img width="172" height="26" alt="image" src="https://github.com/user-attachments/assets/4b95e683-3567-437d-896b-6f63938d926a" />

**4.** Open a New Query. It will look like this:

  <img width="802" height="405" alt="image" src="https://github.com/user-attachments/assets/2356574a-20bb-4756-8f98-a0faef9a2db8" />


**5.** For the **Tables**, directly copy and paste the [_01_schema.sql_](scripts/01_schema.sql) file from this GitHub Repository (Repo) onto that New Query on Supabase.
  - Save and Click Run to execute query.
    - (Can select Run without RLS).
    - (Can also rename the query by locating it from the left SQL Editor queries list > right-click > then Rename Query).

**6.** Once successful, go to Table Editor by selecting it from the left Menu:

  <img width="160" height="26" alt="image" src="https://github.com/user-attachments/assets/645b88a7-1b29-4954-9607-158a02624aa1" /> 

  - Select table names to view them.

**7.** Now that the Tables are complete, do the same for the **Dummy Data**:
  - Go to SQL Editor by selecting it from the left Menu.
  - Open a New Query.
  - Directly copy and paste the [_02_dummy_data.sql_](scripts/02_dummy_data.sql) file from this GitHub Repo onto that New Query on Supabase.
  - Save and Click Run to execute query.
  - Once successful, go to Table Editor by selecting it from the left Menu.
  - Select table names to view the mock data records.

**8.** Now that the Dummy Data is complete, do the same for the Test Cases and Metadata:

**Test Cases**:
  - Go to SQL Editor by selecting it from the left Menu.
  - Open a New Query.
  - Directly copy and paste the [_03_security_verification.sql_](queries/test_cases/03_security_verification.sql) file from this GitHub Repo onto that New Query on Supabase.
  - Save and Click Run to execute query.
  - Once successful, the table will be displayed below the query in Results.

**Metadata**:

**Metadata-A:**
  - Open a New Query.
  - Directly copy and paste the [_04_total_tables.sql_](queries/metadata/04_total_tables.sql) file from this GitHub Repo onto that New Query on Supabase.
  - Save and Click Run to execute query.
  - Once successful, the table will be displayed below the query in Results.

**Metadata-B:**
  - Open a New Query.
  - Directly copy and paste the [_05_total_entries.sql_](queries/metadata/05_total_entries.sql) file from this GitHub Repo onto that New Query on Supabase.
  - Save and Click Run to execute query.
  - Once successful, the table will be displayed below the query in Results.

**Metadata-C:**
  - Open a New Query.
  - Directly copy and paste the [_06_db_volume.sql_](queries/metadata/06_db_volume.sql) file from this GitHub Repo onto that New Query on Supabase.
  - Save and Click Run to execute query.
  - Once successful, the table will be displayed below the query in Results.

--------------------------------------------------------------------------------------------------
