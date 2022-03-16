#Understand
## Visualize table

NHPI_table <- thedata_BC_Can %>%
  filter(geo == "British Columbia") %>%
  mutate(year = year(ref_date),
         month = month(ref_date, label = TRUE)) %>%
  select(year, month, value) %>%
  pivot_wider(names_from = month, values_from = value) %>%
  arrange(desc(year))

# display the table
print(head(NHPI_table))



# how to add annual average
# Julie's genius solution
NHPI_table2 <- NHPI_table %>%
  mutate(annual_avg = rowMeans(NHPI_table[-1], na.rm = TRUE))
print(head(NHPI_table2))



# Stephanie's genius solution
# starts with the raw data table
NHPI_table3 <- thedata_BC_Can %>%
  filter(geo == "British Columbia") %>%
  mutate(year = year(ref_date),
         month = month(ref_date, label = TRUE)) %>%
  select(year, month, value) %>%
  group_by(year) %>%
  mutate(annual_avg = mean(value, na.rm = TRUE)) %>%
  pivot_wider(names_from = month, values_from = value) %>%
  arrange(desc(year))

print(head(NHPI_table3))


NHPI_table4 <- NHPI_table %>%
  rowwise() %>% 
  mutate(annual_avg = mean(c(Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec), na.rm = TRUE))

print(head(NHPI_table4))


#---------------
NHPI_table4 <- NHPI_table %>%
  rowwise() %>% 
  #  use `c_across()` to specify the range of columns
  mutate(annual_avg = mean(c_across(Jan:Dec), na.rm = TRUE))

print(head(NHPI_table4))

