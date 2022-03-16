library(readxl)
library(DT)
library(dplyr)
library(pander)
library(writexl)

 df1=read_excel("../data/REP-TDD-ARCADIS-BOUSTEAD-2020-YP1.xlsx",sheet="Capex",skip = 0)


df2 = df1%>%
  select(Items,Interventions,S, R,NPV_HighRisk,Facility,Discipline, Findings, Binary_highrisk)%>%
  filter(Binary_highrisk == 1)%>%
  filter(NPV_HighRisk >0 )
  

write_xlsx(df2,"../data/summary-risk.csv")


