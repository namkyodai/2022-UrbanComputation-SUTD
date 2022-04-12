source("week1-1-loadingdata-in-R.r")
head(Census.Data)
library(dplyr)
library(ggplot2)

str(Census.Data)
summary(Census.Data)

#EDA

boxplot(Census.Data[,2:5])

library(vioplot)
vioplot(Census.Data$Unemployed, Census.Data$Qualification, Census.Data$White_British, Census.Data$Low_Occupancy, ylim=c(0,100), col = "dodgerblue", rectCol="dodgerblue3", colMed="dodgerblue4")

vioplot(Census.Data$Unemployed, Census.Data$Qualification, Census.Data$White_British, Census.Data$Low_Occupancy, ylim=c(0,100), col = "dodgerblue", rectCol="dodgerblue3", colMed="dodgerblue4", names=c("Unemployed", "Qualifications", "White British", "Occupancy"))


#boxplot
library(reshape)
library(reshape2)
Census.Data.Vi <- melt(Census.Data,id.vars ='OA',measure.vars =c('White_British','Low_Occupancy','Unemployed','Qualification'))
head(Census.Data.Vi)


ggplot(Census.Data.Vi , aes(x= variable, y=value, color = variable))+
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", shape=20, size=1, color="red", fill="red")+
  theme(axis.text.x = element_text(angle=0, vjust=0.5,hjust=0.5))+
  theme(legend.position = "none")




p <- ggplot(Census.Data, aes(Unemployed,Qualification))

p + geom_point(aes(colour = White_British, size = Low_Occupancy))

#correlallation



# Runs a Pearson's correlation
cor(Census.Data$Unemployed, Census.Data$Qualification)

data1 <- Census.Data[,2:5]

cor(data1)
round(cor(data1),2)

corr <- cor(data1)


# creates a qplot from our corr matrix
qplot(x=Var1, y=Var2, data=melt(corr), fill=value, geom="tile") +
  scale_fill_gradient2(limits=c(-1, 1))

library(corrplot)

# creates a lower triangular corrplot from our corr matrix
corrplot(corr, type="lower", tl.col="black", tl.srt=45)

# runs a regressions model (y ~ x, data frame)
model_1 <- lm(Qualification~ Unemployed, Census.Data)

plot(Census.Data$Unemployed, Census.Data$Qualification, xlab="% Unemployed", ylab="% With a Qualification") + abline (model_1)


summary(model_1)

predict(model_1,data.frame(Unemployed= 10), interval = "confidence")

# a multiple regression model
model_2 <- lm(Qualification ~ Unemployed + White_British, Census.Data)

summary(model_2)

