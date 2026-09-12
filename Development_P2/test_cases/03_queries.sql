-- ===========================================================
--        QUERY 1:    COMMISSION TRACKING AND REVENUE
-- ===========================================================


-- ALIASES:    ft = Financial_Transaction, ab = Accommodation_Booking, eb = Experience_Booking, ap = Accommodation_Price, el = Experience_Listing


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
    -- Joins all the Attributes into a single Table
ORDER BY
  "Service_Category" ASC, "Gross_Price" DESC;


-- ===========================================================
--           QUERY 2:    ACCOMMODATION PERFORMANCE
-- ===========================================================
-- ALIASES: al = Accommodation_Listing, ar = Accommodation_Review


-- ===========================================================
--          QUERY 3:    SECURITY AND VERIFICATION
-- ===========================================================
-- ALIASES: 

