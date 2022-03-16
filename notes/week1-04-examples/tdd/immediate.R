library(readxl)
library(DT)
library(dplyr)
library(pander)
library(writexl)

 df1=read_excel("../data/REP-TDD-ARCADIS-HANKYU-CITI-202110.xlsx",sheet="Capex",skip = 0)


df2 = df1%>%
  select(Items,S, R,C1, Interventions,NPV,Year)%>%
  filter(Year == 0)%>%
  filter(NPV>0)%>%
  filter(Items != 'Annual O&M Cost')

write_xlsx(df2,"../data/summary-year0.csv")


