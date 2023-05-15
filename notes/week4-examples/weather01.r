library(rstudioapi) #
setwd(dirname(getActiveDocumentContext()$path))
#

library(readxl)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(rpart)
library(rpart.plot)


weather <-data.frame(read_excel("weather.xlsx",sheet="01",skip = 0)) #

weather$temp.d <- cut(weather$temp, breaks = c(-Inf,20,26,Inf),
                        labels = c("cool","mild","hot"),include.lowest = F)

weather$humi.d <- cut(weather$humi, breaks = c(-Inf,80,Inf),
                        labels = c("normal","high"),include.lowest = F)

weather$wind.d <- cut(weather$wind, breaks = c(-Inf,20,Inf),
                        labels = c("weak","strong"),include.lowest = F)

weather$outlook <- factor(weather$outlook, levels = c("sunny","overcast","rain"))
weather$temp.d <- factor(weather$temp.d, levels = c("hot","mild","cool"))
weather$humi.d <- factor(weather$humi.d, levels = c("high","normal"))
weather$wind.d <- factor(weather$wind.d, levels = c("strong","weak"))
weather$play <- factor(weather$play, levels = c("yes","no"))

3*3*2*2

write.csv(weather,"weather01-factor.csv", row.names = FALSE)


names(weather) #

number.weather <- length(unique(weather$outlook))*length(unique(weather$temp.d))*length(unique(weather$wind.d))*length(unique(weather$play)) #
number.weather
table(weather$outlook)
table(weather$temp.d)
table(weather$humi.d)
table(weather$wind.d)

library(vtree) #https://www.infoworld.com/article/3573577/how-to-count-by-groups-in-r.html

vtree(weather, "outlook", palette = 3, sortfill = TRUE)

vtree(weather, "temp.d", palette = 3, sortfill = TRUE)

vtree(weather, "humi.d", palette = 3, sortfill = TRUE)
vtree(weather, "wind.d", palette = 3, sortfill = TRUE)
vtree(weather, "play", palette = 3, sortfill = TRUE)
vtree(weather, c("outlook", "temp.d"),horiz = FALSE)
vtree(weather, c("outlook", "play"),horiz = FALSE)
vtree(weather, c("outlook", "temp.d","humi.d"),horiz = FALSE)
vtree(weather, c("outlook", "temp.d","humi.d", "play"),horiz = FALSE)

vtree(weather, c("temp.d", "outlook","humi.d", "play"),horiz = FALSE)




library(vtree)
table(weather$play)
vtree(weather, c("play"),horiz = FALSE)
h.s = -5/14*log(5/14) - 9/14*log(9/14)
h.s


vtree(weather, c("outlook", "play"),horiz = FALSE)

weather %>%
  filter(outlook == "sunny")

h.s.sunny = -2/5*log(2/5) - 3/5*log(3/5)
h.s.sunny

weather %>%
       filter(outlook == "overcast")
h.s.overcast = -4/4*log(4/4) - 0/4*log(0.000000001/4)
h.s.overcast

weather %>%
       filter(outlook == "rain")
h.s.rain = -2/5*log(2/5) - 3/5*log(3/5)
h.s.rain

h.outlook.s <- 5/14*h.s.sunny + 4/14*h.s.overcast + 5/14*h.s.rain
h.outlook.s

vtree(weather, c("temp.d", "play"),horiz = FALSE)

weather %>%
  filter(temp.d == "cool")

h.s.cool = -3/4*log(3/4) - 1/4*log(1/4)
h.s.cool

weather %>%
  filter(temp.d == "mild")
h.s.mild = -2/6*log(2/6) - 4/6*log(4/6)
h.s.mild

weather %>%
  filter(temp.d == "hot")
h.s.hot = -2/4*log(2/4) - 2/4*log(2/4)
h.s.hot

h.temp.s <- 4/14*h.s.cool + 6/14*h.s.mild + 4/14*h.s.hot
h.temp.s


vtree(weather, c("wind.d", "play"),horiz = FALSE)

weather %>%
  filter(wind.d == "strong")

h.s.strong = -3/6*log(3/6) - 3/6*log(3/6)
h.s.strong

weather %>%
  filter(wind.d == "weak")

h.s.weak = -2/8*log(2/8) - 6/8*log(6/8)
h.s.weak

h.wind.s <- 6/14*h.s.strong + 8/14*h.s.weak
h.wind.s




vtree(weather, c("humi.d", "play"),horiz = FALSE)

weather %>%
  filter(humi.d == "high")

h.s.high = -4/7*log(4/7) - 3/7*log(3/7)
h.s.high

weather %>%
  filter(humi.d == "normal")

h.s.normal = -1/7*log(1/7) - 6/7*log(6/7)
h.s.normal

h.humi.s <- 7/14*h.s.high + 7/14*h.s.normal
h.humi.s

##
c(h.outlook.s,h.temp.s,h.wind.s,h.humi.s)



###


glimpse(weather)
str(weather)


control <- rpart.control(minsplit = 2,
                         minbucket = 1,
                         maxdepth = 4,
                         cp = 0.01)

# building the classification tree with rpart
tree <- rpart(play~ outlook + temp.d + humi.d + wind.d,
              data=weather,
              parms=list(split='information'),
              control = control,
              method = "class")
tree
rpart.plot(tree, nn=TRUE)

