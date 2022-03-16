#COMMUNICATE - table



# print table with {flextable} formatting  
NHPI_table4 %>%
  flextable() %>% 
  #  add_footer(glue::glue("Source: Statistics Canada, Table {table_id}"))
  add_footer_row(values = glue::glue("Source: Statistics Canada, Table {table_id}"),
                 colwidths = 14)

print(NHPI_table4)

#table: monthly summary

# create summary table
tbl_month_BC <-
  thedata_BC_Can %>%
  filter(geo == "British Columbia") %>%
  arrange(ref_date) %>%
  # calculate percent change stats
  get_mom_stats() %>%
  get_yoy_stats() %>%
  # pull year and month
  mutate(year = year(ref_date),
         month = month(ref_date, label = TRUE)) %>%
  # select relevant columns, rename as necessary
  select(year, month, value, 
         "from previous month" = mom_chg, 
         "from same month, previous year" = yoy_chg) %>%
  arrange(desc(year), desc(month)) %>%
  # just print rows 1 to 13
  slice(1:13)

print(tbl_month_BC)

# print table with {kableExtra} formatting  
tbl_month_BC %>%
  kable(caption = "NHPI, British Columbia", digits = 1) %>%
  kable_styling(bootstrap_options = "striped") %>%
  row_spec(0, bold = T, font_size = 14) %>%
  row_spec(1, bold = T) %>%
  add_header_above(c(" " = 3, "index point change" = 2), font_size = 14)

print(tbl_month_BC)
