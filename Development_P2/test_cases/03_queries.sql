-- ===========================================================
--           QUERY:    SECURITY AND VERIFICATION
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
--                      QUERY COMPLETE
-- ===========================================================
