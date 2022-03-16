#pull B.C. values for latest month

# filter a B.C.-only data frame

thedata_BC <- thedata_BC_Can %>%
  filter(geo == "British Columbia") %>%
  arrange(ref_date) %>%
  # calculate percent change stats
  get_mom_stats() %>%
  get_yoy_stats()

# determine most recent month

latest_ref_date <- max(thedata_BC$ref_date)

this_month <- month(latest_ref_date, label = TRUE)
this_year <- year(latest_ref_date)

this_month_nhpi <- thedata_BC %>%
  filter(ref_date == latest_ref_date) %>%
  pull(value)
this_month_mom <- thedata_BC %>%
  filter(ref_date == latest_ref_date) %>%
  pull(mom_chg)
this_month_yoy <- thedata_BC %>%
  filter(ref_date == latest_ref_date) %>%
  pull(yoy_chg)

