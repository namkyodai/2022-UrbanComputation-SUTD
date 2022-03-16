# PLOT!
# basic
ggplot(thedata_BC_Can, aes(x=ref_date, y=value, group=geo)) + 
  geom_line()


#
# with formatting applied
dataplot <- ggplot(thedata_BC_Can, aes(x=ref_date, y=value, colour=geo)) + 
  geom_line(size=1.5) 

plot(dataplot)


dataplot2 <- dataplot +
  scale_x_date(date_breaks = "2 years", labels = year) +
  scale_y_continuous(labels = comma, limits = c(80, 125)) +
  scale_colour_manual(name=NULL,
                      breaks=c("Canada", "British Columbia"),
                      labels=c("Canada", "British Columbia"), 
                      values=c("#325A80", "#CCB550")) +
  bida_chart_theme
#  theme_bw() +
#  theme(
#    panel.border = element_rect(colour="white"),
#    plot.title = element_text(face="bold"),
#    legend.position=c(1,0), 
#    legend.justification=c(1,0),
#    legend.title = element_text(size=12),
#    legend.text = element_text(size=11),
#    axis.line = element_line(colour="black"),
#    axis.title = element_text(size=12),
#    axis.text = element_text(size=12)
#  )
#
plot(dataplot2)


# experiments with ggplot2's new subtitle and caption options
NHPI_title <- as.character("New Housing Price Index, Canada & B.C.")
NHPI_subtitle <- as.character("December 2016 = 100")
NHPI_caption <- as.character("Source: Statistics Canada, CANSIM table 18-10-0205-01")
# add titles / X-Y axis labels
NHPI_plot <- dataplot2 +
  labs(title = NHPI_title,
       subtitle = NHPI_subtitle,
       caption = NHPI_caption, 
       x = NULL, y = "NHPI (Dec. 2016 = 100)")

plot(NHPI_plot)

ggsave(filename = "NHPI_plot.png", plot = NHPI_plot,
       width = 8, height = 6)
