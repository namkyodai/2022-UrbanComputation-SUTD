startdate <- as.Date("2007-01-01")

# filter the original data to have Vancouver
thedata_YVR <- thedata %>%
  filter(ref_date >= startdate) %>%
  filter(geo %in% c("Vancouver, British Columbia"), 
         new_housing_price_indexes %in% c("House only", "Land only")) %>%
  arrange(desc(ref_date))

thedata_YVR

NHPI_title <- as.character("New Housing Price Index, Vancouver: house and land")
NHPI_subtitle <- as.character("December 2016 = 100")
NHPI_caption <- as.character("Source: Statistics Canada, CANSIM table 18-10-0205-01")

# with formatting applied
NHPI_Vancouver_plot <- 
  ggplot(thedata_YVR, aes(x=ref_date, y=value,
                          colour=new_housing_price_indexes)) + 
  geom_line(size=1.5) +
  #
  scale_x_date(date_breaks = "2 years", labels = year) +
  scale_y_continuous(labels = comma, limits = c(80, 125)) +
  scale_colour_manual(name=NULL,
                      breaks=c("House only", "Land only"),
                      labels=c("House only", "Land only"), 
                      values=c("#325A80", "#CCB550")) +
  bida_chart_theme +
  # set chart titles and labels
  labs(title = NHPI_title,
       subtitle = NHPI_subtitle,
       caption = NHPI_caption, 
       x = NULL, y = "NHPI (Dec. 2016 = 100)") 

NHPI_Vancouver_plot


