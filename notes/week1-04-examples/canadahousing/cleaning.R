# Cleaning the data

thedata <- janitor::clean_names(thedata)
thedata <- thedata %>%
  mutate(ref_date = ymd(ref_date, truncated = 2)) 
head(thedata)

