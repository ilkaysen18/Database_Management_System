-- ===========================================================
--        QUERY 1:    COMMISSION TRACKING AND REVENUE
-- ===========================================================


-- PURPOSE:         Accounting and Business Intelligence
-- ALIASES:         ft = Financial_Transaction, ab = Accommodation_Booking, eb = Experience_Booking, ap = Accommodation_Price, el = Experience_Listing


SELECT
  ft."Transaction_ID",
    -- Alias for ft = Financial_Transaction
  COALESCE(ab."Booking_Status", eb."Exp_Booking_Status") AS "Transaction_Status",
    -- Alias for ab = Accommodation_Booking, eb = Experience_Booking
    -- Joins ab & eb into one Transaction_Status
  CASE
    WHEN ft."Booking_ID" IS NOT NULL THEN 'Accommodation Stay'
    ELSE 'Guided Experience Tour'
  END AS "Service_Category",
    -- Categorizes services
  
  COALESCE(ap."Nightly_Price", el."Experience_Price") AS "Gross_Price",
    -- Alias for ap = Accommodation_Price, el = Experience_Listing
    -- Joins ap & el into one Gross_Price
  ROUND((COALESCE(ap."Nightly_Price", el."Experience_Price") * 0.03), 2) AS "Platform_Commission",
    -- Calculates commissions for the platform
  ROUND((ap."Nightly_Price", el."Experience_Price") * 0.97, 2) AS "Net_Payout"
    -- Calculates payouts made to Hosts and Locals

-- Joins all the Attributes into a single Table:
FROM
  "Financial_Transaction" ft
LEFT JOIN
  "Accommodation_Booking" ab ON ft."Booking_ID" = ab."Booking_ID"
LEFT JOIN
  "Accommodation_Price" ap ON ab."Property_ID" = ap."Property_ID"
LEFT JOIN
  "Experience_Booking" eb ON ft."Exp_Booking_ID" = eb."Exp_Booking_ID"
LEFT JOIN
  "Experience_Listing" el ON eb."Experience_Listing_ID" = el."Experience_Listing_ID"
ORDER BY
  "Service_Category" ASC, "Gross_Price" DESC;


-- ===========================================================
--           QUERY 2:    ACCOMMODATION PERFORMANCE
-- ===========================================================


-- PURPOSE:         Joins over 3 Tables (Users, Listings, Reviews/Ratings), Displays Hosts with high performance levels
-- ALIASES:         u = user, al = Accommodation_Listing, ar = Accommodation_Review, rate = Accommodation_Rating_Score


SELECT
  u."User_ID" AS "Host_ID"
  u."User_Name" AS "Host_Profile"
-- Changes technical words into more common language for backend users to understand:
  al."Accommodation_Address" AS "Listing_Location"
  ar."Accomm_Review_Content" AS "Guest_Text_Feedback"
  rate."Accomm_Rating_Score" AS "Stars_Assigned"

-- Joins all the Attributes into a single Table:
FROM
  "User" u
    -- Aliases "User" to u
INNER JOIN
  "Accommodation_Listing" al ON u."User_ID" = al."User_ID"
    -- Aliases Accommodation_Listing to al
INNER JOIN
  "Accommodation_Review" ar ON al."Property_ID" = (SELECT "Property_ID" FROM "Accommodation_Booking" WHERE "Booking_ID" = ar."Booking_ID")
    -- Aliases Accommodation_Review to ar
    -- Establishes a Relationship bridge between Properties & Bookings by using a Nested Sub-Query
INNER JOIN
  "Accommodation_Rating" rate ON ar."Booking_ID" = rate."Booking_ID"

-- Establishes the order by displaying higher ratings first:
WHERE
  rate."Accomm_Rating_Score" >= 4
ORDER BY
  rate."Accomm_Rating_Score" DESC, u."User_Name" ASC;


-- ===========================================================
--          QUERY 3:    SECURITY AND VERIFICATION
-- ===========================================================


-- PURPOSE:         Follows 1NF Rule for multiple payment methods; and verifies security clearance before financial transaction can occur
-- ALIASES:         u = user, v = verification, pm = Payment_Method


SELECT
  u."User_ID",
-- Changes technical words to more common language for backend user readability:
  u."User_Name" AS "Account_Holder",
  v."ID_Verification_Status" AS "Identity_Status",
  pm."Payment_Option" AS "Card_Provider",
  pm."Encrypted_Payment_Token" AS "Secure_Gateway_Hash",
  pm."Default_Payment_Option" AS "Is_Primary_Card"

FROM
  "User" u
    -- Aliases "User" to u
-- Joins Verification with User_ID and Payment_Method:
INNER JOIN
  "Verification" v ON u."User_ID" = v."User_ID"
    -- Aliases "Verification" to v
LEFT JOIN
  "Payment_Method" pm ON u."User_ID" = pm."User_ID"
    -- Aliases Payment_Method to pm

WHERE
  v."Email_Verification_Status" = 'Verified'
ORDER BY
  pm."Default_Payment_Option" DESC, u."User_Name" ASC;


-- ===========================================================
--                     QUERIES COMPLETE
-- ===========================================================
