#--------------------------------------------------------------
#--------------------------------------------------------------
library(rstudioapi) 
setwd(dirname(getActiveDocumentContext()$path))

library(readxl)
library(DT)
library(dplyr) # grammar of data munipulation
library(pander)
library(writexl)
epsilon=10000000
library(reshape)
library(ggplot2) # for graphs --> 
library(psych)
library(lubridate)
library(scales)
library(tidyr)

# read rawdata
df=read_excel("data.xlsx",sheet="Capex",skip = 0)


df = df%>%
  select(Items,System, Cause, Operated_by, Vendors, Area, Level, Zone, Facility, Discipline, YearBuilt, S, CO, SE, HE,R,Findings,Interventions,IS, Quantity, Unit, InterPer, Cost, Probability, Year, Binary_highrisk, Binary_option, NPV, NPV_HighRisk, NPV_Option)

df1 <- df%>%
  select(Items,System, Cause)

glimpse(df)

df$System <- as.factor(df$System)
library(purrr) #
df <- df %>%
  purrr::modify_at(c(3:10), factor)
df <- df %>%
  purrr::modify_at(c(12:16,19), factor)

# check for missing data

x1 <- map_df(df, function(x){sum(is.na(x))}) 
x1

missing <- x1 %>% gather(key = "Variable") %>% filter(value > 0) %>% mutate(value = value/nrow(df))
missing

ggplot(missing, aes(x = reorder(Variable, -value),y = value)) + 
  geom_bar(stat = "identity", fill = "salmon") + 
  coord_flip()


###
# 
df1 <- aggregate(df$NPV, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)




df2 <- aggregate(df$NPV_HighRisk, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)

df3 <- aggregate(df$NPV_Option, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)

write.csv(df1, file = "df1.csv")



write.csv(df2, file = "df2.csv")
write.csv(df3, file = "df3.csv")


df1_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
write.csv(df1_t1, file = "df1_t1.csv")




df1_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
write.csv(df1_t2, file = "df1_t2.csv")

df1_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
write.csv(df1_airside, file = "df1_airside.csv")

df1_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
write.csv(df1_landside, file = "df1_landside.csv")


df1_general <- df %>%
  filter(Area == "General")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
write.csv(df1_general, file = "df1_general.csv")

# ----Risk

df2_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
write.csv(df2_t1, file = "df2_t1.csv")

df2_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
write.csv(df2_t2, file = "df2_t2.csv")

df2_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
write.csv(df2_airside, file = "df2_airside.csv")

df2_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
write.csv(df2_landside, file = "df2_landside.csv")


df2_general <- df %>%
  filter(Area == "General")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
write.csv(df2_general, file = "df2_general.csv")

# --- Option

df3_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Discipline) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)
write.csv(df3_t1, file = "df3_t1.csv")

df3_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Discipline) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)
write.csv(df3_t2, file = "df3_t2.csv")

df3_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Discipline) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)
write.csv(df3_airside, file = "df3_airside.csv")

df3_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Discipline) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)
write.csv(df3_landside, file = "df3_landside.csv")


df3_general <- df %>%
  filter(Area == "General")%>%
  group_by(Discipline) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)
write.csv(df3_general, file = "df3_general.csv")





NPV_discipline <- df %>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)



# df %>% 
#   group_by(Discipline) %>% 
#   summarise(NPV = sum(NPV))%>%
#   filter(NPV >0)%>%
#   ggplot(aes(x=reorder(Discipline,-NPV),y=NPV, color = Discipline))+
#   geom_bar(stat = "identity",fill='steelblue', alpha = 0.3)+
#   scale_y_continuous(labels=comma)+
#   geom_text(aes(label = prettyNum(NPV, big.mark = ",", scientific = FALSE)), vjust = -0.5)+
#   theme(legend.position = "none")+
#   labs(
#     x="Discipline",
#     y = "Capex (Peso)"
#   )


df %>% 
  filter(NPV >0)%>%
  ggplot(aes(x=reorder(Discipline,-NPV, sum),y=NPV, fill=Area))+
  geom_bar(position="stack", stat="identity")+
#  scale_y_continuous(labels=comma)+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df1$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV, label = prettyNum(NPV, big.mark = ",", scientific = FALSE), fill = NULL), data = NPV_discipline,vjust = -0.5)+
 # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )

# Immediate

p1<-df %>% 
  filter(NPV >0)%>%
  ggplot(aes(x=reorder(Discipline,-NPV, sum),y=NPV, fill=Area))+
  geom_col()+
   scale_y_continuous(labels=comma,breaks = round(seq(0, max(df1$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
p1

ggsave("NPV_discipline.png",width = 10, height = 6, dpi = 200, units = "in", device='png')






# highrisk

p2<-df %>% 
  filter(NPV_HighRisk >0)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_HighRisk, sum),y=NPV_HighRisk, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df2$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV_HighRisk, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
p2
ggsave("NPV_risk_discipline.png",width = 10, height = 6, dpi = 200, units = "in", device='png')

# Option

p3<-df %>% 
  filter(NPV_Option >0)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_Option, sum),y=NPV_Option, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df3$x)*1.2, by = epsilon),1))+
    geom_text(aes(Discipline, NPV_Option, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
p3
ggsave("NPV_option_discipline.png",width = 10, height = 6, dpi = 200, units = "in", device='png')


