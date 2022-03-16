#importing data

table_id <- "18-10-0205-01"
thedata <- get_cansim(table_id)
get_cansim_table_overview(table_id)
ls.str(thedata)

thedata %>%
  group_by(GEO, GeoUID) %>%
  tally()

tail(thedata)
