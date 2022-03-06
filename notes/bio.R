library(ggplot2)
library(plotly)
# read excel file
library(readxl) 
library(reshape)
library(reshape2)
df=read_excel("program.xlsx",sheet="bio",skip = 0)
df<-melt(df,id="activity")
# Grouped
p<-ggplot(df, aes(fill=activity, y=value, x=variable)) + 
  geom_bar(position="dodge", stat="identity")+
  labs(title = "Average Weekly Hours Spent on Activity", x = "Period",y = "Hours")+
  theme(axis.text.x=element_text(angle=0, hjust=0.5))+ 
  geom_text(aes(label=value), position=position_dodge(width=0.9), vjust=-0.25)

q<-ggplot(df, aes(fill=variable, y=value, x=activity)) + 
  geom_bar(position="dodge", stat="identity")+
  labs(title = "Average Weekly Hours Spent on Activity", x = "Activities",y = "Hours")+
  theme(axis.text.x=element_text(angle=0, hjust=0.5))+ 
  geom_text(aes(label=value), position=position_dodge(width=0.9), vjust=-0.25)



w<-ggplot(df, aes(fill=variable, y=value, x=reorder(activity,value))) + 
  geom_bar(position="dodge", stat="identity")+
  coord_flip() +
  labs(title = "Average Weekly Hours Spent on Activity", x = "Activities",y = "Hours")+
  theme(axis.text.x=element_text(angle=0, hjust=0.5))
 # geom_text(aes(label=value), position=position_dodge(width=1), vjust=0.25)







