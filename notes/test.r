library(googlesheets4)
gs4_deauth()
df<-read_sheet("1oQXo505Trl_2gXrAmVEkejGFmwBQl-IqVFuRIscRLps")
library(dplyr)
df<-df %>% 
  rename(Name =2, Background =3, Years =4, DataAnalytics=5, Program=6, SkillLevel=7)%>%
  select(-1)
library(kableExtra)
df %>%
  kbl() %>%
  kable_material_dark()

nrow(df)

df %>%
  kbl() %>%
  kable_paper(full_width = F) %>%
  column_spec(3, color = spec_color(df$Years[1:nrow(df)])) %>%
  column_spec(6, color = "white",
              background = spec_color(df$SkillLevel[1:nrow(df)], end = 0.7))

library(ggplot2)





