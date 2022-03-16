#filtering BC & Canada

startdate <- as.Date("2007-01-01")
# filter to have BC and Canada
thedata_BC_Can <- thedata %>%
  filter(ref_date >= startdate) %>%
  filter(geo %in% c("British Columbia", "Canada"), 
         new_housing_price_indexes == "Total (house and land)") %>%
  select(ref_date, geo, new_housing_price_indexes, value)
head(thedata_BC_Can)
