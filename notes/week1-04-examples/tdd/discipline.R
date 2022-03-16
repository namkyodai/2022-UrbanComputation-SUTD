epsilon=1000000
library(reshape)
library(ggplot2)

df4<-df3%>%
  select(Year,Discipline,NPV)%>%
  filter(!is.na(Year))  %>%
  group_by(Discipline)
df5<-melt(df4,id=c("Year","Discipline"))
df6<-cast(df5,Discipline~Year,sum,na.rm = TRUE)

#df2<-matrix(nrow=16,ncol = 26 )

x<-df6
immediate=x[,2] #0
shortterm=rowSums(x[,c(3:4)],na.rm = TRUE) # 1,2,3
mediumterm=rowSums(x[,c(5:7)],na.rm = TRUE) # 4, 5, 6, 7
longterm=rowSums(x[,c(8:12)],na.rm = TRUE) # 8, 9, 10, 11, 12,13
visionary=rowSums(x[,c(13:ncol(x))],na.rm = TRUE) #, 14
NPV=rowSums(x[,c(2:ncol(x))],na.rm = TRUE)

library(janitor)
y<-x%>%
  mutate(immediate,shortterm,mediumterm,longterm,visionary, NPV)%>%
  mutate(freq = round(100*NPV / sum(NPV),2))%>%
  arrange(desc(NPV))%>%
  adorn_totals()

yy=y%>%
  select(Discipline,immediate,shortterm,mediumterm,longterm,visionary,NPV)%>%
  filter(NPV >0)

write_xlsx(yy,"../data/summary-discpline.csv")


z <- df3 %>%filter(Year < 27)%>%
  group_by(Year) %>%
  summarize(total = sum(NPV/epsilon,na.rm = TRUE)) %>%
  arrange(desc(total))
z=mutate(z,weight_pct=100*total/sum(total))

#plot the graph for yearly CApex distribution per level 4

#Discipline
cashflow <- ggplot(df3%>%filter(Year < 27))+
  geom_bar(aes(x = Year, y = NPV/epsilon,fill=Discipline),
           stat='identity',width =1)+
  labs(title = "", x = "Year",y = "PhP (1 millions)")+
  theme(axis.text.x=element_text(angle=0, hjust=1))+ 
  scale_x_continuous(name = "Year", breaks=function(x) pretty(x, n=12))+
  geom_text(aes(Year, total+50, label = round(total,2), fill = NULL), data = z,cex=3,angle=90, na.rm=TRUE)
cashflow


#ggsave("../../pics/cashflow-discipline.png",width = 10, height = 6) #This is optional





