#--------------------------------------------------------------
#--------------------------------------------------------------
library(rstudioapi) # We load this libary in order to use the below command to set the working directory to the file --> path
setwd(dirname(getActiveDocumentContext()$path))


#### PART 1: Introduction to data on weather recorded in on station

#--------------------------------------------------------------
#--------------------------------------------------------------
library(readxl)

#weather <-data.frame(read_excel("weather.xlsx",sheet="02", skip = 0)) # if your data is recorded in excel file

#read from csv file
weather <- data.frame(read.csv("weather.csv",sep=";",stringsAsFactors=FALSE))
str(weather)
library(dplyr)
glimpse(weather)

#--------------------------------------------------------------
#--------------------------------------------------------------
#### PART 2: Data Wrangling
#--------------------------------------------------------------
#--------------------------------------------------------------

dim(weather) # Explore the dimension of data

names(weather) # see name of variables (columns)

head(weather) # view the first 10 rows of the data

str(weather) # see the type of each variable


# Check missing data
sum(is.na(weather))

# check number of observations
nrow(weather)
sum(complete.cases(weather))

nrow(weather) == sum(complete.cases(weather))


#############        CREATE FACTORS
# Variables can be convertted into Factors type by simply using as.factor() function. THis function is a function of factor() functional family. When using this function, R will arrange automatically based on alphabetic order if the data is STRING type. 

class(weather$season) # check the class type for season variables
summary(weather$season)

weather$season <- factor(weather$season, levels = c("Spring","Summer","Autumn","Winter"))

class(weather$season) # now we have this variable as factor types instead of character type.
summary(weather$season)

#similarly we us as.factor() to convert data type for other columns.
weather$day <- as.factor(weather$day)
weather$month <- as.factor(weather$month)
weather$dir.wind <- as.factor(weather$dir.wind)

#we check our data again
str(weather)

# Examine and correct variables concerning windspeed

# we note that there are several ways in the world to categorize wind directions, 8, 16 or 32. SO we need to check which category they were recorded. Is this 16 directions or more or less.

length(unique(weather$dir.wind))
#https://www.pinterest.com/pin/606226799819409300/

# We count total numbers of days for each directions.
table(weather$dir.wind)
#
rel <- round(prop.table(table(weather$dir.wind))*100,1)
rel

# We arrange this variable 
sort(rel,decreasing = TRUE)

# We now can convert 16 wind directions to 8 directions
weather$dir.wind.8 <- weather$dir.wind

weather$dir.wind.8 <- ifelse(weather$dir.wind %in%  c("NNE","ENE"),"NE",as.character(weather$dir.wind.8))


weather$dir.wind.8 <- ifelse(weather$dir.wind %in% c("NNW","WNW"),"NW",as.character(weather$dir.wind.8))

weather$dir.wind.8 <- ifelse(weather$dir.wind %in% c("WSW","SSW"),"SW",as.character(weather$dir.wind.8))

weather$dir.wind.8 <- ifelse(weather$dir.wind %in% c("ESE","SSE"),"SE",as.character(weather$dir.wind.8))

weather$dir.wind.8 <- factor(weather$dir.wind.8,levels = c("N","NE","E","SE","S","SW","W","NW"))


# We check again if now we have 8 directions
table(weather$dir.wind.8)
length(unique(weather$dir.wind.8))



# We create a proportion table for wind direction and season
round(prop.table(table(weather$dir.wind.8,weather$season),margin = 2)*100,1)



##### CHANGE DATA

first.day <- "2021-01-01"
class(first.day)
first.day <- as.Date(first.day)
class(first.day)

weather$date  <- first.day + weather$day.count - 1 # create a formulate to modify date

##### ROUNDING HOURS

# In R, working with date and time is quite hard so it requires patient. 


### for low temperature
l.temp.time.date <- as.POSIXlt(paste(weather$date,weather$l.temp.time)) # declare new variable
head(l.temp.time.date)
l.temp.time.date <- round(l.temp.time.date,"hours")# rounding to the nearest hours
head(l.temp.time.date)
attributes(l.temp.time.date) # check the attribute
weather$l.temp.hour <- l.temp.time.date$hour # take out only hours
head(weather$l.temp.hour) # 
weather$l.temp.hour <- as.factor(weather$l.temp.hour) # change it to factor
head(weather$l.temp.hour)

### for high temperature

h.temp.time.date <- as.POSIXlt(paste(weather$date,weather$h.temp.time))
head(h.temp.time.date)
h.temp.time.date <- round(h.temp.time.date,"hours")# 
head(h.temp.time.date)
attributes(h.temp.time.date) # 
weather$h.temp.hour <- h.temp.time.date$hour #
head(weather$h.temp.hour) # 
weather$h.temp.hour <- as.factor(weather$h.temp.hour) # 
head(weather$h.temp.hour)



gust.wind.time.date <- as.POSIXlt(paste(weather$date,weather$gust.wind.time))
head(gust.wind.time.date)
gust.wind.time.date <- round(gust.wind.time.date,"hours")# 
head(gust.wind.time.date)
attributes(gust.wind.time.date) # 
weather$gust.wind.hour <- gust.wind.time.date$hour # 
head(weather$gust.wind.hour) # 
weather$gust.wind.hour <- as.factor(weather$gust.wind.hour) # 

head(weather$gust.wind.hour)

str(weather) # 

## Note

# we see from the above code that data cleaning is a must before we analyze them. In fact, when we have tidydata, pivoting, visualization and analyze them will be done in less time. Efforst in cleaning data take most of the time of people.


# We note that R is quite powerful to visualize and modelling. but R is not the only language used to clean data, alternatively, you can use different way to do data cleaning.

### You can use excel with several useful function to do the same jobs, especially when data is small. 


### Using other language like Python


### Using several cooked libraries for cleaning such as lubricate library.


#--------------------------------------------------------------
#--------------------------------------------------------------
#### PART4 : Visualization with ggplot2
#--------------------------------------------------------------

# This libaray was created by Hadley Wickham based on graphical method developed by Leland Wilkison. This defines a standard grammar used to create graphs. Since 2014, ggplots is the most downloadable libaries in R.

#GGplot2 works based on the concept of Layering. Each part of the graph is visualized using a specific layer such as layer for coordinate, layer for size, layer for lable, layer for specific type of graph.. 

# Ok then how can we practice, now if we want to visualize the relationship between low and high temperature, change color according to season and choose size, how can we do.

# Steps in using ggplot2

## A graph is created using ggplot() function, and right after this, we can add layer. 


#### ggplot(data = dataframe, aes(x = var1, y= var2, colour = var3, size = var4))

### geom_xxx()   ---> this layer is added after ggplot() and used to create type of graph such as boxplot, histogram, etc. Note that if we do not specify anything inside the bracket, R will create a default graph, but if we want to decorate, we can declare inside the bracket what attributes we want for our graph. When we add attribute, new layer will be added on top of the previous declared attribute. that is how it works.

library(ggplot2)
ggplot(data = weather, aes(x = l.temp, y= h.temp, colour = season)) +
        geom_point()  
#--> create graph and type of graph

ggplot(data = weather, aes(x = l.temp, y= h.temp, colour = season)) + 
         geom_point(aes(colour=dir.wind))#  --> same as before but add in some decoration


ggplot(data = weather, aes(x = h.temp, y= l.temp)) + 
         geom_point(colour = "blue")  #---> change for single colour

ggplot(data = weather, aes(x = l.temp, y= h.temp)) + 
         geom_point(aes(size=rain), colour = "blue")  #--> change the size of dot

#--------------------------------------------------------------


ggplot(weather,aes(x = date,y = ave.temp))+
  geom_point(colour = "green")+
  geom_smooth(colour = "red",size = 1)+
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5))+
  labs(
    x = "Date",
    y = "Average Temperature (C)"
  )




ggplot(weather,aes(x = date,y = ave.temp)) +
  geom_point(aes(colour = ave.temp)) +
  scale_colour_gradient2(low = "blue", mid = "green" , high = "red", midpoint = 16) +
  geom_smooth(color = "red",size = 1) +
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5))

### Analyze temperature per seasons

ggplot(weather,aes(x = ave.temp+10, colour = season)) +
  geom_density() +
  scale_x_continuous(limits = c(5,30), breaks = seq(5,30,5))+
  xlab("Average Temperature () ºC )") +  ylab ("Prob/Density")+
  labs(title = "Distribution of Temp/Season") +
  scale_color_manual(name = "Seasons",labels = c("Spring", "Summer", "Autumn", "Winter"), values = c("red", "blue","green","gray"))



#### Monthly Temperature - Using different type of graphs

ggplot(weather,aes(x = month, y = ave.temp+10)) +
  geom_violin(fill = "orange") +
  geom_point(aes(size = rain), colour = "blue", position = "jitter") +
  ggtitle ("Monthly Distribution of Temperature") +
  xlab("Month") +  ylab ("Average Temperature ( ºC )")+
  labs(size="Rain")


## Analyze the relationship between high and low temp. 

ggplot(weather,aes(x = l.temp, y = h.temp)) +
  geom_point(colour = "firebrick", alpha = 0.3) +
  geom_smooth(aes(colour = season),se= F, size = 1.1) +
   xlab("Low Temp. ( ºC )") +  ylab ("High Temp ( ºC )")+
  labs(title = "Low Temp. and High Temp. relations") +
  scale_color_manual(name = "Seasons",labels = c("Spring", "Summer", "Autumn", "Winter"), values = c("red", "blue","green","gray"))


## Distribution of low and high temp. in daily hoursl. 


library(reshape2) # Use this libarary to change from wide to long table

temperatures <- weather[c("day.count","h.temp.hour","l.temp.hour")] # only select necessary variables (day and temp) and set new name for this table. 
head(temperatures)
head(temperatures)
tail(temperatures)

temperatures <- melt(temperatures,id.vars = "day.count",
                     variable.name = "l.h.temp", value.name = "hour")

temperatures$hour <- factor(temperatures$hour,levels=0:23) # Necessary to arrange the order 

ggplot(temperatures) +
  geom_bar(aes(x = hour, fill = l.h.temp)) +
  scale_fill_discrete(name= "", labels = c("High","Low")) +
  scale_y_continuous(limits = c(0,100)) +
  ggtitle ("Daily templ. low and high") +
  xlab("Hours") +  ylab ("Freq")


# what can we see from this graph

#--------------------------------------------------------------
#--------------------------------------------------------------
#### PART 4: Using EDA and ggplot2
#--------------------------------------------------------------
#--------------------------------------------------------------

# In this section, we will do visualization and table pivoting to understand more on our data. but first let try to make some questions

#question 1: Why we need to explore --> because we want to know how to use some variables to predict the probability of raining that can happen in anytime. We can understand that the rain is the dependent variable or output. The other variables are then input and independent variables, these variables are also name explainable variables or predictive variables.


# EDA is method to visualize data for us to understand the data

# Step 1: Analyze dependent variables (continous variable) --> we need to draw the frequency graph of this variable, and also plot again time to see the tendency. Will this variable be transformed into binary variable? or transform into multiple factors such as no rain, litle rain, moderate, heavy rain???


# Step 2: --> finding relationshop among input and out put variables --> is it linear or non-linear. 

# Step 3: Repeat the same steps but for other variables in the tables. 


# Step 4 4: Find the correlation or relationship between output and inputs in factor types. How is outliners and how to deal with it.


# Let start

# Output variables are RAIN

# 
ggplot(weather, aes(date,rain)) +
  geom_point(aes(colour = rain)) +
  geom_smooth(colour = "blue", size = 1) +
  scale_colour_gradient2(low = "green", mid = "orange",high = "red", midpoint = 20) +
  scale_y_continuous(breaks = seq(0,80,20))


# Histogram 

ggplot(weather,aes(rain)) +
  geom_histogram(binwidth = 1,colour = "blue", fill = "darkgrey") +
  scale_x_continuous(breaks = seq(0,80,5)) +
  scale_y_continuous(breaks = seq(0,225,25)) 

summary(weather$rain) # độ lệch sang phải rất cao
summary(subset(weather, rain > 0)$rain) # độ lệch vẫn còn cao

#Boxplot

ggplot(weather,aes(rain)) +
  geom_boxplot()

ggplot(weather, aes(x="", y=rain)) +
  geom_boxplot(fill="red", alpha=0.2)+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set1")

library(dplyr)

weather %>% filter(rain >0)

ggplot(weather %>% filter(rain >0), aes(x="", y=rain)) +
  geom_boxplot(fill="red", alpha=0.2)+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set1")


library(e1071) # Use this to estimate the srewness
skewness(weather$rain)
skewness(subset(weather, rain >0)$rain)

# Create binary variable

nrow(subset(weather, rain == 0)) # check no. of days without rain

nrow(subset(weather, rain <1 & rain >0)) # check no. of days with little rain

weather$rained <- ifelse(weather$rain >= 1, "Rain", "No Rain") # biến mới

table(rained = weather$rained) # 

prop.table(table(rained = weather$rained)) # 

# Continous variables


ggplot(weather, aes(season,rain)) +
  geom_jitter(aes(colour=rain), position = position_jitter(width = 0.2)) +
  scale_colour_gradient2(low = "blue", mid = "red",high = "black", midpoint = 30) +
  scale_y_continuous(breaks = seq(0,80,20)) 

# Quick estimate the rain per season
tapply(weather$rain,weather$season,summary)


# Using binary 


# 
ggplot(weather,aes(season)) +
  geom_bar(aes(fill = rained), position = "fill") +
  geom_hline(aes(yintercept = prop.table(table(weather$rained))["No"]),
             colour = "blue",linetype = "dashed", size = 1) +
  annotate("text", x = 1, y = 0.65, label = "yr. w/o = 0.60", colour = "blue") 


round(prop.table(table(season = weather$season, rained= weather$rained),1),2)

#

weather.num <- weather[c("rain","l.temp","h.temp","ave.temp","ave.wind","gust.wind", "l.temp.hour","h.temp.hour","gust.wind.hour")]


weather.num$l.temp.hour <- as.numeric(weather.num$l.temp.hour)
weather.num$h.temp.hour <- as.numeric(weather.num$h.temp.hour)
weather.num$gust.wind.hour <- as.numeric(weather.num$gust.wind.hour)


str(weather.num)

round(cor(weather.num),2)

# 
round(cor(weather.num),2)[1,] # 


weather.num.season <- split(weather.num,weather$season)


class(weather.num.season) # 

length(weather.num.season) #

summary(weather.num.season) # 


attributes(weather.num.season) # 

sapply(weather.num.season, function (x) round(cor(x)["rain",],2))

lapply(weather.num.season, function (x) round(cor(x)["rain",],2))


ggplot(weather,aes(gust.wind,rain)) +
  geom_point(colour = "firebrick") +
  geom_smooth(size = 0.75, se = F) +
  facet_wrap(~season) 

quantile(weather$h.temp)

weather$h.temp.quant <- cut(weather$h.temp, breaks = quantile(weather$h.temp),
                            labels = c("Cold","Cool","Warm","Hot"),include.lowest = T)

table(weather$h.temp.quant)

ggplot(weather,aes(rained,gust.wind)) +
  geom_boxplot(aes(colour=rained)) +
  facet_grid(h.temp.quant~season) 


#EDA --> Exploratory Data Analysis


#--------------------------------------------------------------
#--------------------------------------------------------------
#### PART 5: Modelling
#--------------------------------------------------------------
#--------------------------------------------------------------

set.seed(123) # 

index <- sample(1:nrow(weather),size = 0.7*nrow(weather))

# 
train <- weather[index,]
# 
test <- weather [-index,]

nrow(train)
nrow(test)

# 
group <- rep(NA,365)
group <- ifelse(seq(1,365) %in% index,"Train","Test")

df <- data.frame(date=weather$date,rain=weather$rain,group)

ggplot(df,aes(x = date,y = rain, color = group)) +
  geom_point() +
  scale_color_discrete(name="") +
  theme(legend.position="top")



# 

write.csv(train,"weather02-train.csv", row.names = FALSE)
write.csv(test,"weather02-test.csv", row.names = FALSE)


#library(rattle)
#rattle()
## https://gmd.copernicus.org/articles/7/1247/2014/gmd-7-1247-2014.pdf


# Base model
best.guess <- mean(train$rain)
best.guess
# RMSE and MAE value
RMSE.baseline <- sqrt(mean((best.guess-test$rain)^2))

RMSE.baseline


MAE.baseline <- mean(abs(best.guess-test$rain))
MAE.baseline


# Multiple linear regression

# 
lin.reg <- lm(log(rain+1) ~ season +  h.temp + ave.temp + ave.wind + gust.wind +
                dir.wind + as.numeric(gust.wind.hour), data = train)

summary(lin.reg)

# 
exp(lin.reg$coefficients["gust.wind"])

test.pred.lin <- exp(predict(lin.reg,test))-1


RMSE.lin.reg <- sqrt(mean((test.pred.lin-test$rain)^2))
RMSE.lin.reg

MAE.lin.reg <- mean(abs(test.pred.lin-test$rain))
MAE.lin.reg

## Decision Tree Analysis

library(rpart) # 
library(rpart.plot)
library(rattle) # 

#rattle()

rt <- rpart(rain ~ month + season + l.temp + h.temp + ave.temp + ave.wind +
              gust.wind + dir.wind + dir.wind.8 + as.numeric(h.temp.hour)+
              as.numeric(l.temp.hour)+ as.numeric(gust.wind.hour), data=train)

rt

rpart.plot(rt)
fancyRpartPlot(rt)


#plot(rt)
#
test.pred.rtree <- predict(rt,test)

RMSE.rtree <- sqrt(mean((test.pred.rtree-test$rain)^2))

RMSE.rtree

MAE.rtree <- mean(abs(test.pred.rtree-test$rain))
MAE.rtree

printcp(rt)


min.xerror <- rt$cptable[which.min(rt$cptable[,"xerror"]),"CP"]
min.xerror

rt.pruned <- prune(rt,cp = min.xerror)

fancyRpartPlot(rt.pruned)

test.pred.rtree.p <- predict(rt.pruned,test)
RMSE.rtree.pruned <- sqrt(mean((test.pred.rtree.p-test$rain)^2))
RMSE.rtree.pruned

MAE.rtree.pruned <- mean(abs(test.pred.rtree.p-test$rain))
MAE.rtree.pruned

### RANDOM FOREST

library(randomForest)

train$h.temp.hour <- as.numeric(train$h.temp.hour)
train$l.temp.hour <- as.numeric(train$l.temp.hour)
train$gust.wind.hour <- as.numeric(train$gust.wind.hour)
test$h.temp.hour <- as.numeric(test$h.temp.hour)
test$l.temp.hour <- as.numeric(test$l.temp.hour)
test$gust.wind.hour <- as.numeric(test$gust.wind.hour)

# For reproducibility; 123 has no particular meaning
# Run this immediately before creating the random forest
set.seed(123)

library(randomForest)

rf <- randomForest(rain ~ month + season + l.temp + h.temp + ave.temp + ave.wind +
                     gust.wind + dir.wind + dir.wind.8 + h.temp.hour + l.temp.hour +
                     gust.wind.hour, data = train, importance = TRUE, ntree=1000)

which.min(rf$mse)

plot(rf)


imp <- as.data.frame(sort(importance(rf)[,1],decreasing = TRUE),optional = T)
names(imp) <- "% Inc MSE"
imp

test.pred.forest <- predict(rf,test)
RMSE.forest <- sqrt(mean((test.pred.forest-test$rain)^2))
RMSE.forest


MAE.forest <- mean(abs(test.pred.forest-test$rain))
MAE.forest


# SUMMARY of all above steps

accuracy <- data.frame(Method = c("Baseline","Linear Regression","Full tree","Pruned tree","Random forest"),
                       RMSE   = c(RMSE.baseline,RMSE.lin.reg,RMSE.rtree,RMSE.rtree.pruned,RMSE.forest),
                       MAE    = c(MAE.baseline,MAE.lin.reg,MAE.rtree,MAE.rtree.pruned,MAE.forest))

accuracy$RMSE <- round(accuracy$RMSE,2)
accuracy$MAE <- round(accuracy$MAE,2)
accuracy


all.predictions <- data.frame(actual = test$rain,
                              baseline = best.guess,
                              linear.regression = test.pred.lin,
                              full.tree = test.pred.rtree,
                              pruned.tree = test.pred.rtree.p,
                              random.forest = test.pred.forest)

head(all.predictions)

library(tidyr) #

all.predictions <- gather(all.predictions,key = model,value = predictions,2:6)

head(all.predictions)

tail (all.predictions)

ggplot(data = all.predictions,aes(x = actual, y = predictions)) +
  geom_point(colour = "blue") +
  geom_abline(intercept = 0, slope = 1, colour = "red") +
  geom_vline(xintercept = 23, colour = "green", linetype = "dashed") +
  facet_wrap(~ model,ncol = 2) +
  coord_cartesian(xlim = c(0,70),ylim = c(0,70)) +
  ggtitle("Predicted vs. Actual, by model")


#--------------------------------------------------------------
#### Continue with Decision Tree Analysis for Categorical variables
#--------------------------------------------------------------

# rename the table

weather_xl <-weather

summary(weather_xl$ave.temp) #
weather_xl$ave.temp.c = cut(weather_xl$ave.temp, breaks = c(-Inf,14,21,Inf), labels = c("cold", "mild", "warm"), include.lowest = TRUE)

summary(weather_xl$rain) 
weather_xl$rain.c = cut(weather_xl$rain, breaks = c(-Inf, 25, 50, Inf), labels = c("low", "moderate", "high"), include.lowest = TRUE)

summary(weather_xl$ave.wind)
weather_xl$ave.wind.c = cut(weather_xl$ave.wind, breaks = c(-Inf, 3.5, 5.2, Inf), labels = c("light", "moderate", "strong"), include.lowest =  TRUE)

summary(weather_xl$gust.wind)
weather_xl$gust.wind.c = cut(weather_xl$gust.wind, breaks = c(-Inf, 22.5, 38.6, Inf), labels = c("light", "medium", "strong"), include.lowest =  TRUE)

weather_xl_tree = weather_xl %>%
  select(season, dir.wind, ave.temp.c, rain.c, ave.wind.c, gust.wind.c)
str(weather_xl_tree)

weather_xl_tree = weather_xl_tree %>%
  mutate_if(is.character, as.factor)
str(weather_xl_tree) #ok

names(weather_xl_tree)

num_weather = length(unique(weather_xl_tree$season)) *  length(unique(weather_xl_tree$dir.wind)) * length(unique(weather_xl_tree$ave.temp.c)) * length(unique(weather_xl_tree$ave.wind.c)) * length(unique(weather_xl_tree$rain.c)) * length(unique(weather_xl_tree$gust.wind.c))
num_weather

table(weather_xl_tree$season)
table(weather_xl_tree$dir.wind)                                                                                                                                                                                                                                         
table(weather_xl_tree$ave.temp.c)
table(weather_xl_tree$rain.c)
table(weather_xl_tree$ave.wind.c)
table(weather_xl_tree$gust.wind.c)

library(vtree)

vtree(weather_xl_tree, "season", palette = 6, sortfill= TRUE)
vtree(weather_xl_tree, "dir.wind", palette = 6, sortfill= TRUE) #lưu ý: có nhánh 1%
vtree(weather_xl_tree, "ave.temp.c", palette = 6, sortfill= TRUE)
vtree(weather_xl_tree, "rain.c", palette = 6, sortfill= TRUE)
vtree(weather_xl_tree, "ave.wind.c", palette = 6, sortfill= TRUE)
vtree(weather_xl_tree, "gust.wind.c", palette = 6, sortfill= TRUE)

total = nrow(weather_xl_tree)
table(weather_xl_tree$rain.c)
vtree(weather_xl_tree, c("rain.c"), horiz = FALSE)
h.s = -342/total*log(342/total) -14/total*log(14/total) -9/total*log(9/total) 
h.s #

#
table(weather_xl_tree$gust.wind.c)
vtree(weather_xl_tree, c("gust.wind.c"), horiz = FALSE)
h.s = -100/total*log(100/total) -185/total*log(185/total) -80/total*log(80/total) 
h.s #

#
table(weather_xl_tree$ave.wind.c)
vtree(weather_xl_tree, c("ave.wind.c"), horiz = FALSE)
h.s = -186/total*log(186/total) -88/total*log(88/total) -91/total*log(91/total) 
h.s #

table(weather_xl_tree$dir.wind)                                                                                                                                                                                                                                         

table(weather_xl_tree$ave.temp.c)

table(weather_xl_tree$season)

table(weather_xl_tree$ave.wind.c)

table(weather_xl_tree$gust.wind.c)

control <- rpart.control(minsplit = 2, #
                         minbucket = 1, #
                         maxdepth = 6, #
                         cp = 0.01) #

tree <- rpart(rain.c~ season + ave.temp.c + ave.wind.c +  gust.wind.c + dir.wind , #
              data=weather_xl_tree, #
              parms=list(split='information'), 
              control = control, 
              method = "class") 
tree
rpart.plot(tree, nn=TRUE)

## the end



