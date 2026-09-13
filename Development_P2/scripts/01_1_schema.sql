  -- Domain Rule for (the above) OFK: Prevents transaction from processing without at least 1 service, e.g. either Booking_ID or Experience_Booking_ID, depending on service booked by Guest
  CONSTRAINT "CK_Financial_Transaction_Source_Present" CHECK (
    ("Booking_ID" IS NOT NULL AND "Experience_Booking_ID" IS NULL) OR
    ("Booking_ID" IS NULL AND "Experience_Booking_ID" IS NOT NULL)
  )
);
