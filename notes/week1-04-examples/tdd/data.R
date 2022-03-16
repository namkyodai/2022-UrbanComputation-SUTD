#--------------------------------------------------------------
#--------------------------------------------------------------
library(rstudioapi) 
setwd(dirname(getActiveDocumentContext()$path))

library(readxl)
library(DT)
library(dplyr)
library(pander)
library(writexl)
epsilon=1000000
library(reshape)
library(ggplot2)
library(psych)
library(lubridate)


df=read_excel("2022-mactan-tdd-airport.xlsx",sheet="Capex",skip = 0)


df = df%>%
  select(Items,System, Operated_by, Vendors, Area, Level, Zone, Facility, Discipline, YearBuilt, S, CO, SE, HE,R,Findings,Interventions,IS, Quantity, Unit, InterPer, Cost, Probability, Year, Binary_highrisk, Binary_option, NPV, NPV_HighRisk, NPV_Option)

glimpse(df)

df$System <- as.factor(df$System)
library(purrr) #
df <- df %>%
  purrr::modify_at(c(3:9), factor)
df <- df %>%
  purrr::modify_at(c(11:15,18), factor)

# check for missing data

x1 <- map_df(df, function(x){sum(is.na(x))}) 
x1

missing <- x1 %>% gather(key = "Variable") %>% filter(value > 0) %>% mutate(value = value/nrow(df))
missing

ggplot(missing, aes(x = reorder(Variable, -value),y = value)) + 
  geom_bar(stat = "identity", fill = "salmon") + 
  coord_flip()




df1<-df%>%
  select(Year,Discipline,NPV)%>%
  filter(!is.na(Year))  %>%
  group_by(Discipline)
df2<-melt(df1,id=c("Year","Discipline"))
df3<-cast(df2,Discipline~Year,sum,na.rm = TRUE)

