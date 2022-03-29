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
  select(Items,System, Cause, Operated_by, Vendors, Area, Level, Zone, Facility, Discipline, YearBuilt, S, CO, SE, HE,R,Findings,Interventions,IS, Quantity, Unit, InterPer, Cost, Probability, Year, Binary_highrisk, Binary_option, NPV, NPV_HighRisk, NPV_Option)%>%
  filter(Discipline != "OPEX")

#glimpse(df)

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


###EDA

# IMMEDIATE

df_shortterm <- df%>%
  select(Items,System, Cause, Area, Level, Zone, Facility, Discipline, S,Findings,Interventions, Quantity, Unit, Year, NPV, NPV_HighRisk)%>%
  filter(Discipline != "OPEX")%>%
  mutate(NPV_shorterm = (NPV + NPV_HighRisk))


df_shortterm_disc <- aggregate(df_shortterm$NPV_shorterm, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)
df_shortterm_disc
write.csv(df_shortterm_disc, file = "df_shortterm_disc.csv")

df_shortterm_summary<-df_shortterm %>%
  group_by(Discipline, Area) %>%
  summarize(NPV = sum(NPV_shorterm))%>%
  filter(NPV>0)

df_shortterm_summary <-cast(df_shortterm_summary,Discipline~Area,sum)
df_shortterm_summary
write.csv(df_shortterm_summary, file = "df_shortterm_summary.csv")



g_df_shortterm<-df_shortterm %>%
  filter(NPV_shorterm >0 & Year < 1)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_shorterm, sum),y=NPV_shorterm, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_shortterm_disc$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV_shorterm, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
g_df_shortterm
ggsave("g_df_shortterm.png",width = 10, height = 6, dpi = 200, units = "in", device='png')




# Perdiscipline for NPV
df_disc <- aggregate(df$NPV, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)
df_disc
write.csv(df_disc, file = "df_disc.csv")

df_disc_summary<-df %>%
  group_by(Discipline, Area) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)

df_disc_summary <-cast(df_disc_summary,Discipline~Area,sum)
df_disc_summary
write.csv(df_disc_summary, file = "df_disc_summary.csv")


df_disc_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_disc_t1
write.csv(df_disc_t1, file = "df_disc_t1.csv")



df_disc_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_disc_t2
write.csv(df_disc_t2, file = "df_disc_t2.csv")

df_disc_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_disc_airside
write.csv(df_disc_airside, file = "df_disc_airside.csv")

df_disc_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_disc_landside
write.csv(df_disc_landside, file = "df_disc_landside.csv")


df_disc_general <- df %>%
  filter(Area == "General")%>%
  group_by(Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_disc_general
write.csv(df_disc_general, file = "df_disc_general.csv")


# draw graph

g_df_disc<-df %>%
  filter(NPV >0 & Year < 1)%>%
  ggplot(aes(x=reorder(Discipline,-NPV, sum),y=NPV, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_disc$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
g_df_disc
ggsave("g_df_disc.png",width = 10, height = 6, dpi = 200, units = "in", device='png')


# Perdiscipline for NPV_highrisk
df_risk <- aggregate(df$NPV_HighRisk, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0)
df_risk
write.csv(df_risk, file = "df_risk.csv")

df_risk_summary<-df %>%
  group_by(Discipline, Area) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)

df_risk_summary <-cast(df_risk_summary,Discipline~Area,sum)
df_risk_summary
write.csv(df_risk_summary, file = "df_risk_summary.csv")


# highrisk

g_risk<-df %>%
  filter(NPV_HighRisk >0)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_HighRisk, sum),y=NPV_HighRisk, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_risk$x)*1.2, by = epsilon),1))+
  geom_text(aes(Discipline, NPV_HighRisk, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )
g_risk

ggsave("g_risk.png",width = 10, height = 6, dpi = 200, units = "in", device='png')


# ----Risk

df_risk_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
df_risk_t1

write.csv(df_risk_t1, file = "df_risk_t1.csv")

df_risk_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
df_risk_t2
write.csv(df_risk_t2, file = "df_risk_t2.csv")

df_risk_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
df_risk_airside
write.csv(df_risk_airside, file = "df_risk_airside.csv")

df_risk_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
df_risk_landside
write.csv(df_risk_landside, file = "df_risk_landside.csv")


df_risk_general <- df %>%
  filter(Area == "General")%>%
  group_by(Discipline) %>%
  summarize(NPV_HighRisk = sum(NPV_HighRisk))%>%
  filter(NPV_HighRisk>0)
df_risk_general
write.csv(df_risk_general, file = "df_risk_general.csv")


## CAUSE
df_cause <- aggregate(df$NPV, by=list(Cause = df$Cause), FUN=sum)%>%filter(x>0)
df_cause
write.csv(df_cause, file = "df_cause.csv")


df_cause_summary<-df %>%
  group_by(Cause, Area) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)

df_cause_summary <-cast(df_cause_summary,Cause~Area,sum)
df_cause_summary
write.csv(df_cause_summary, file = "df_cause_summary.csv")





df_cause_t1 <- df %>%
  filter(Area == "Terminal 1")%>%
  group_by(Cause) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_cause_t1
write.csv(df_cause_t1, file = "df_cause_t1.csv")

df_cause_t2 <- df %>%
  filter(Area == "Terminal 2")%>%
  group_by(Cause) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_cause_t2
write.csv(df_cause_t2, file = "df_cause_t2.csv")

df_cause_airside <- df %>%
  filter(Area == "Airside")%>%
  group_by(Cause) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_cause_airside
write.csv(df_cause_airside, file = "df_cause_airside.csv")

df_cause_landside <- df %>%
  filter(Area == "Landside")%>%
  group_by(Cause) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_cause_landside
write.csv(df_cause_landside, file = "df_cause_landside.csv")


df_cause_general <- df %>%
  filter(Area == "General")%>%
  group_by(Cause) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)
df_cause_general
write.csv(df_cause_general, file = "df_cause_general.csv")


# draw graph

g_df_cause<-df %>%
  filter(NPV >0 & Year < 1)%>%
  ggplot(aes(x=reorder(Cause,-NPV, sum),y=NPV, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_cause$x)*1.2, by = epsilon),1))+
  geom_text(aes(Cause, NPV, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Cause), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Cause",
    y = "Capex (Peso)"
  )
g_df_cause
ggsave("g_df_cause.png",width = 10, height = 6, dpi = 200, units = "in", device='png')



df_cause_summary_d<-df %>%
  group_by(Cause, Discipline) %>%
  summarize(NPV = sum(NPV))%>%
  filter(NPV>0)

df_cause_summary_d <-cast(df_cause_summary_d,Cause~Discipline,sum)
df_cause_summary_d
write.csv(df_cause_summary_d, file = "df_cause_summary_d.csv")




g_df_cause_d<-df %>%
  filter(NPV >0 & Year < 1)%>%
  ggplot(aes(x=reorder(Cause,-NPV, sum),y=NPV, fill=Discipline))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_cause$x)*1.2, by = epsilon),1))+
  geom_text(aes(Cause, NPV, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Cause), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Cause",
    y = "Capex (Peso)"
  )
g_df_cause_d
ggsave("g_df_cause_d.png",width = 10, height = 6, dpi = 200, units = "in", device='png')




### Summaring the cause table

df_typhoon <- df_shortterm%>%
  select(Items, Findings, Cause, Area, Discipline, S, Interventions, NPV_shorterm)%>%
  filter(Cause =="Typhoon" & NPV_shorterm > 0)%>%
  arrange(Area,desc(NPV_shorterm),Discipline )
df_typhoon
write.csv(df_typhoon, file = "df_typhoon.csv")



df_aging <- df_shortterm%>%
  select(Items, Findings, Cause, Area, Discipline, S, Interventions, NPV_shorterm)%>%
  filter(Cause =="Aging" & NPV_shorterm > 0)%>%
  arrange(Area,Discipline, desc(NPV_shorterm))
df_aging
write.csv(df_aging, file = "df_aging.csv")

df_damage <- df_shortterm%>%
  select(Items, Findings, Cause,Area, Discipline, S, Interventions, NPV_shorterm)%>%
  filter(Cause =="Damage" & NPV_shorterm > 0)%>%
  arrange(Area,Discipline, desc(NPV_shorterm))
df_damage
write.csv(df_damage, file = "df_damage.csv")

df_deterioration <- df_shortterm%>%
  select(Items, Findings, Cause, Area, Discipline, S, Interventions, NPV_shorterm)%>%
  filter(Cause =="Deterioration" & NPV_shorterm > 0)%>%
  arrange(Area,Discipline, desc(NPV_shorterm))
df_deterioration
write.csv(df_deterioration, file = "df_deterioration.csv")
##END OF CAUSE
##---END OF IMMEDIATE







## START of 5 YEARS PLAN

df_option <- aggregate(df$NPV_Option, by=list(Discipline = df$Discipline), FUN=sum)%>%filter(x>0 & Discipline != "OPEX")
df_option
write.csv(df_option, file = "df_option.csv")

# --- Option

df_option_summary<-df %>%
  group_by(Discipline, Area) %>%
  summarize(NPV_Option = sum(NPV_Option))%>%
  filter(NPV_Option>0)

df_option_summary

df_option_summary <-cast(df_option_summary,Discipline~Area,sum)
df_option_summary
write.csv(df_option_summary, file = "df_option_summary.csv")



### START
# 5 years

g_5<-df %>%
  filter(NPV_Option >0 & Year < 6)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_Option, sum),y=NPV_Option, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_option$x)*1.2, by = epsilon*10),1))+
    geom_text(aes(Discipline, NPV_Option, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )+
  theme(axis.text.x = element_text(angle = 25,hjust=1))
g_5

ggsave("g_5.png",width = 10, height = 6, dpi = 200, units = "in", device='png')

df_5<-df %>%
  filter(NPV_Option >0 & Year < 6)%>%
  group_by(Discipline, Area) %>%
  summarize(NPV = sum(NPV_Option))


df_5

df_5 <-cast(df_5,Discipline~Area,sum)
df_5
write.csv(df_5, file = "df_5.csv")


# 10 years

g_10<-df %>%
  filter(NPV_Option >0 & Year >= 6 & Year <=10)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_Option, sum),y=NPV_Option, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_option$x)*1.2, by = epsilon*10),1))+
  geom_text(aes(Discipline, NPV_Option, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )+
  theme(axis.text.x = element_text(angle = 0,hjust=1))
g_10
ggsave("g_10.png",width = 10, height = 6, dpi = 200, units = "in", device='png')

df_10<-df %>%
  filter(NPV_Option >5 & Year < 11)%>%
  group_by(Discipline, Area) %>%
  summarize(NPV = sum(NPV_Option))


df_10

df_10 <-cast(df_10,Discipline~Area,sum)
df_10
write.csv(df_10, file = "df_10.csv")





# 10-30 years

g_15<-df %>%
  filter(NPV_Option >0 & Year >= 11 & Year <=30)%>%
  ggplot(aes(x=reorder(Discipline,-NPV_Option, sum),y=NPV_Option, fill=Area))+
  geom_col()+
  scale_y_continuous(labels=comma,breaks = round(seq(0, max(df_option$x)*1.2, by = epsilon*10),1))+
  geom_text(aes(Discipline, NPV_Option, label = stat(prettyNum(y, big.mark = ",", scientific = FALSE)), group = Discipline), stat = 'summary', fun=sum, vjust = -1)+
  # theme(legend.position = "none")+
  labs(
    x="Discipline",
    y = "Capex (Peso)"
  )+
  theme(axis.text.x = element_text(angle = 45,hjust=1))
g_15
ggsave("g_15.png",width = 15, height = 6, dpi = 200, units = "in", device='png')


df_15<-df %>%
  filter(NPV_Option >10 & Year < 31)%>%
  group_by(Discipline, Area) %>%
  summarize(NPV = sum(NPV_Option))


df_15

df_15 <-cast(df_15,Discipline~Area,sum)
df_15
write.csv(df_15, file = "df_15.csv")






###
