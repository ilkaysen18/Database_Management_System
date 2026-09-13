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


-- ALIASES:         u = user, v = verification, pm = Payment_Method, 


-
