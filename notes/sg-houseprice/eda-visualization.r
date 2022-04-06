#--------------------------------------------------------------
#--------------------------------------------------------------
library(rstudioapi) # setting working directory
setwd(dirname(getActiveDocumentContext()$path)) 
library(tidyverse)
library(dplyr)
library(ggplot2)


df <- data.frame(read.csv("sg-housing-resale-data.csv",sep=",",skip = "0"))

### EDA AND VISUALIZATION

### USING DPLYR


df%>%
  filter(year> 2015, flat_type =="2 ROOM")


df%>%
  filter(year> 2015, flat_type %in% c("2 ROOM","5 ROOM"))


df%>%
  filter(year> 2015, flat_type %in% c("2 ROOM","5 ROOM"))%>%
  arrange(desc(resale_price))





# 
df%>%
  group_by(year)%>%
  summarise(
    resale_price = mean(resale_price)
  )%>%
  ggplot( aes(x=year, y=resale_price)) +
  geom_line(color="darkorchid4")+
  scale_y_continuous(labels = comma)
# 


ggplot(df , aes(x= as.factor(year), y=resale_price, color = as.factor(year)))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=1, color="red", fill="red")+
  scale_y_continuous(breaks = round(seq(0, max(df$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")



ggplot(df , aes(x= as.factor(year), y=price_m2, color = as.factor(year)))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=1, color="red", fill="red")+
  scale_y_continuous(breaks = round(seq(0, 15000, by = 500),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")+
  labs(
         x= "Year",
         y = "Price/m2"
       )


#we notice that for prediction data prior to 2010 might be not relevant.
df1 <- df %>%
  filter(year >= 2010)

# df1 %>% 
#   ggplot( aes(x=date, y=resale_price)) +
#   geom_line(color="#69b3a2") +
#   scale_y_continuous(labels = comma,breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
#   labs(
#     x= "Date",
#     y = "Resale Price"
#   )

# another way to calculate and plot the mean.
df1%>%
  group_by(year)%>%
  summarise(
    resale_price = mean(resale_price)  
  )%>%
  ggplot( aes(x=year, y=resale_price)) +
  geom_line(color="darkorchid4")+
  scale_x_continuous(breaks = round(seq(2010, 2022, by = 1),1))+
  scale_y_continuous(labels = comma)

# another way

# df1 %>% 
#   ggplot( aes(x=date, y=resale_price)) +
#   geom_line(color="#69b3a2") +
#   labs(
#     x= "Date",
#     y = "Resale Price"
#   )+
#   scale_y_continuous(labels = comma,breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
#   scale_x_date(NULL, date_labels = "%b %y", breaks = "year")

# this is another way to draw the value.



#we can see the the value shown in the graph are all observation in every month (as the data is month in year). We might need to summary this data and plot only the average value.


ggplot(df1 , aes(x= as.factor(year), y=resale_price, color = as.factor(year)))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=1, color="red", fill="red")+
  scale_y_continuous(labels = comma,breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")


ggplot(df1 , aes(x= as.factor(year), y=price_m2, color = as.factor(year)))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=1, color="red", fill="red")+
  scale_y_continuous(labels=comma,breaks = round(seq(0, 15000, by = 500),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")



# it is very difficult to narrate meaningful narrative on this, as it seems the prices keep changed up and down even within a short period, the reason for this is that our data is a mixed data and spready in a long time. Let break it down.


# draw a histogram of price/m2
ggplot(df1, aes(x=resale_price))+
  geom_histogram(fill="deepskyblue2")+
  scale_x_continuous(breaks = round(seq(0, max(df$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))

# density plot


ggplot(df1, aes(x=resale_price))+
  geom_density(fill="deepskyblue2")+
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white",alpha=0.2)+
  scale_x_continuous(labels=comma,breaks = round(seq(0, max(df$resale_price), by = 50000),1))+
  scale_y_continuous(labels=comma)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))


# draw a histogram of price/m2
ggplot(df1, aes(x=price_m2))+
  geom_histogram(fill="deepskyblue2")+
  scale_x_continuous(labels=comma,breaks = round(seq(0, max(df$price_m2), by = 500),1))+
  scale_y_continuous(labels=comma)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))

# density plot


ggplot(df1, aes(x=price_m2))+
  geom_density(fill="deepskyblue2")+
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white",alpha=0.2)+
  scale_x_continuous(labels=comma,breaks = round(seq(0, max(df$price_m2), by = 500),1))+
  scale_y_continuous(labels=comma)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))

# as we can see from this graph there is a wide variety of price. This is because we consider all observations in the graph and observations are mixed of flat_type and flat_model, town, streat, blocks and floor ranges. We need later to separate them.


#one way to separate them is to use boxplot.

#bloxplot for flatype
ggplot(df1 , aes(x= flat_type, y=price_m2, color = flat_type))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels=comma,breaks = round(seq(0, 15000, by = 1000),1))+
  theme(legend.position = "none")

#we can see from this graph that the price/m2 keep increase with number of room. The means of price for all flat types are on the higher side of the price in most of cases.

# The most expensive flat type is executive. Multiple-generation flat types also have high price compared to other. Probably in Singapore, multiple generation flat type have multiple rooms as well, therefore it should be more expensive.


vtree(df1, "flat_type", palette = 3, sortfill = TRUE,horiz = TRUE)

# histogram for flat_type
ggplot(df1,aes(x=price_m2)) +
  geom_histogram(colour = "firebrick") +
  # geom_smooth(size = 0.75, se = F) +
  facet_wrap(~flat_type)
# in term of number, we can see that people prefers to have 3-5 bed rooms and executive flats. 


ggplot(df1%>%
         count(flat_type),aes(x=flat_type,y=n, color = flat_type)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")+
  labs(
    x="flat type",
    y = "Number"
  )
  



#reorder the graph and put in color.
ggplot(df1%>%
         count(flat_type),aes(x=reorder(flat_type,-n),y=n, color = flat_type)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  labs(
    x="Flat Type",
    y="Number"
  )+
  theme(legend.position = "none")


# type of room vs price

df1%>%
  group_by(flat_type)%>%
  summarise(
    resale_price = mean(resale_price)  
  ) %>%
  ggplot(aes(x=reorder(flat_type,-resale_price), y=resale_price,color = flat_type)) +
  geom_bar(stat = "identity", fill='steelblue', alpha = 0.3)+
  scale_y_continuous(labels = comma)+
  geom_text(aes(label = prettyNum(resale_price, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  labs(
    x="Flat Type",
    y="Mean value of resale price"
  )+
  theme(legend.position = "none")

#we repeat this for other factors

#boxplot for flat_model

ggplot(df1 , aes(x= reorder(flat_model,-resale_price), y=resale_price, color = flat_model))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")


ggplot(df1 , aes(x= reorder(flat_model,-resale_price), y=resale_price))+
  geom_bar(position ="dodge", stat = "summary", fun.y ="mean", fill="blue", alpha=0.4) +
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")



ggplot(df1 , aes(x= reorder(flat_model,-price_m2), y=price_m2, color = flat_model))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels=comma,breaks = round(seq(0, 15000, by = 1000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")

#facet type
ggplot(df1,aes(x=price_m2)) +
  geom_histogram(colour = "firebrick") +
  scale_y_continuous(labels=comma)+
  facet_wrap(~flat_model) 

#barplots
ggplot(df1,aes(x=price_m2,y=flat_model,fill=flat_type)) +
  scale_x_continuous(labels=comma)+
  geom_bar(position="stack", stat="identity") 


head(df1%>%
  filter(flat_model == "Model A"))%>%
  ggplot(aes(price_m2,flat_type, fill=flat_type))+
  geom_bar(stat="identity")

head(df1%>%
  filter(year >= 2021))

tail(df1%>%
       filter(year >= 2021))

df1%>%
  count(block)%>%
  tally()

df1%>%
  count(street_name)%>%
  tally()


df1%>%
  count(town)%>%
  tally()

## plot for town
# counting
ggplot(df1%>%
         count(town),aes(x=reorder(town,-n),y=n, color = town)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  labs(
    x="Town",
    y="Number"
  )+
  theme(legend.position = "none")



# mean
ggplot(df1 , aes(x= reorder(town,-resale_price), y=resale_price, color = town))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")


ggplot(df1 , aes(x= reorder(town,-resale_price), y=resale_price, color = town))+
  geom_bar(position ="dodge", stat = "summary", fun.y ="mean", fill="blue", alpha=0.4) +
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")

## Story range

# counting
ggplot(df1%>%
         count(storey_range),aes(x=reorder(storey_range,-n),y=n, color = storey_range)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  labs(
    x="storey_range",
    y="Number"
  )+
  theme(legend.position = "none")



# mean
ggplot(df1 , aes(x= reorder(storey_range,-resale_price), y=resale_price, color = storey_range))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")


ggplot(df1 , aes(x= reorder(storey_range,-resale_price), y=resale_price, color = storey_range))+
  geom_bar(position ="dodge", stat = "summary", fun.y ="mean", fill="blue", alpha=0.4) +
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df1$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  theme(legend.position = "none")

# how is about remaining lease

df2 <- na.omit(df1)

# counting
ggplot(df2%>%
         count(remaining_lease),aes(x=reorder(remaining_lease,-n),y=n, color = remaining_lease)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
  theme(axis.text.x = element_text(angle=45, vjust=1,hjust=1))+
  labs(
    x="remaining_lease",
    y="Number"
  )+
  theme(legend.position = "none")

## what is the problem here? this is because the remaining lease contains characters --> this needs to be corrected.

library(stringr)
library(purrr)

df2_1 <- df2%>%
        mutate(remaining_lease01 = gsub(" years", "", remaining_lease), .after = remaining_lease )%>%
        mutate(remaining_lease02 = gsub(" year", "", remaining_lease01), .after = remaining_lease01 )%>%
        mutate(remaining_lease03 = gsub(" months", "", remaining_lease02), .after = remaining_lease02 )%>%
        mutate(remaining_lease04 = gsub(" month", "", remaining_lease03), .after = remaining_lease03)%>%
        mutate(remaining_lease05 = gsub(" ", ".", remaining_lease04), .after = remaining_lease04)%>%
        mutate(remaining_lease06 = gsub("..0", ".", remaining_lease05), .after = remaining_lease05)%>%
        mutate(remaining_lease07 = round(as.numeric(remaining_lease06),0), .after = remaining_lease06)

df3 <- df2%>%
  mutate(remaining_lease = gsub(" years", "", remaining_lease))%>%
  mutate(remaining_lease = gsub(" year", "", remaining_lease))%>%
  mutate(remaining_lease = gsub(" months", "", remaining_lease))%>%
  mutate(remaining_lease = gsub(" month", "", remaining_lease))%>%
  mutate(remaining_lease = gsub(" ", ".", remaining_lease))%>%
  mutate(remaining_lease = gsub("..0", ".", remaining_lease))%>%
  mutate(remaining_lease = round(as.numeric(remaining_lease),0))



ggplot(df3%>%
         count(remaining_lease),aes(x=reorder(remaining_lease,-n),y=n, color = remaining_lease)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
 # geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5, angle=90)+
  theme(axis.text.x = element_text(angle=90, vjust=1,hjust=1))+
  labs(
    x="remaining_lease",
    y="Number"
  )+
  theme(legend.position = "none")



# mean
ggplot(df3 , aes(x= reorder(remaining_lease,-resale_price), y=resale_price, color = remaining_lease))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df3$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=90, vjust=1,hjust=1))+
  theme(legend.position = "none")


ggplot(df3 , aes(x= reorder(remaining_lease,-resale_price), y=resale_price, color = remaining_lease))+
  geom_bar(position ="dodge", stat = "summary", fun.y ="mean", fill="blue", alpha=0.4) +
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df3$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=90, vjust=1,hjust=1))+
  theme(legend.position = "none")

### Commenced dates


ggplot(df3%>%
         count(lease_commence_date),aes(x=reorder(lease_commence_date,-n),y=n, color = lease_commence_date)) +
  geom_bar(stat = "identity",fill='steelblue', alpha = 0.3) +
  scale_y_continuous(labels=comma)+
  # geom_text(aes(label = prettyNum(n, big.mark = ",", scientific = FALSE)), vjust = -0.5, angle=90)+
  theme(axis.text.x = element_text(angle=90, vjust=1,hjust=1))+
  labs(
    x="remaining_lease",
    y="Number"
  )+
  theme(legend.position = "none")




ggplot(df3 , aes(x= reorder(lease_commence_date,-resale_price), y=resale_price, color = lease_commence_date))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  scale_y_continuous(labels = comma, breaks = round(seq(0, max(df3$resale_price), by = 50000),1))+
  theme(axis.text.x = element_text(angle=90, vjust=1,hjust=1))+
  theme(legend.position = "none")


## correlation analysis

cor(df3%>%
      select(floor_area_sqm,lease_commence_date,remaining_lease),use = "all.obs")
glimpse(df3)

### TABLE PIVOTING
library(reshape)
library(reshape2)


df4 <- aggregate(df3$resale_price, by=list(flat_type = df3$flat_type), FUN=sum)%>%filter(x>0)

df3 %>%
  group_by(town, flat_type) %>%
  summarize(resale_price = sum(resale_price))%>%
  filter(resale_price>0)

df3 %>%
  group_by(town, flat_type) %>%
  summarize(resale_price = mean(resale_price))%>%
  filter(resale_price>0)


cast(df3 %>%
       group_by(town, flat_type) %>%
       summarize(resale_price = sum(resale_price))%>%
       filter(resale_price>0),
     town~flat_type,sum)

epsilon <- 1000000

p<-df3%>% 
  filter(resale_price >0)%>%
  ggplot(aes(x=reorder(town,resale_price, sum),y=resale_price, fill=flat_type))+
  geom_col()+
 # scale_y_continuous(labels=comma,breaks = round(seq(0, max(df4$x)*1.2, by = epsilon),1))+
  scale_y_continuous(labels=comma)+
  geom_text(aes(town, resale_price, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = town), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="town",
    y = "Singaporean Dollars"
  )+
  coord_flip()
  
p



