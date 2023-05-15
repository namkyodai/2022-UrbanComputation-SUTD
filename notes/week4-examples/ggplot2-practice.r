# Load ggplot2
library(ggplot2)
library(dplyr)


# The mtcars dataset is natively available
# head(mtcars)

# A really basic boxplot.

# 

#### PART4 : Visualization with ggplot2
#--------------------------------------------------------------

# This libaray was created by Hadley Wickham based on graphical method developed by Leland Wilkison. This defines a standard grammar used to create graphs. Since 2014, ggplots is the most downloadable libaries in R.
# 
# GGplot2 works based on the concept of Layering. Each part of the graph is visualized using a specific layer such as layer for coordinate, layer for size, layer for lable, layer for specific type of graph.. 
# 
# Ok then how can we practice, now if we want to visualize the relationship between low and high temperature, change color according to season and choose size, how can we do.
# 
#  Steps in using ggplot2
# 
# A graph is created using ggplot() function, and right after this, we can add layer. 
# 
# data <- data.frame(data1)
# 
# 
# ggplot(data = dataframe, aes(x = var1, y= var2, colour = var3, size = var4))
# 
# geom_xxx()   ---> this layer is added after ggplot() and used to create type of graph such as boxplot, histogram, etc. Note that if we do not specify anything inside the bracket, R will create a default graph, but if we want to decorate, we can declare inside the bracket what attributes we want for our graph. When we add attribute, new layer will be added on top of the previous declared attribute. that is how it works.
# 
# ggplot(data, coordinate)+
#   layer1+
#   layer2+
#   layer3





mtcars <-data.frame(mtcars)



ggplot(mtcars, aes(x="", y=mpg))+
  geom_boxplot()


ggplot(mtcars, aes(x="", y=mpg)) +
  geom_boxplot() +
  xlab("")+
  ylab("Mile per gallon")


ggplot(mtcars, aes(x="", y=mpg)) +
  geom_boxplot(alpha=0.5, colour = "red", fill = "blue") +
  xlab("")

ggplot(mtcars, aes(x="", y=mpg)) +
  geom_boxplot(fill="yellow", alpha=0.3, colour = "blue") +
  xlab("")+
  labs(title="Boxplot for variable mpg",
       subtitle="Example of adding collor to the graph",
       y = "Distance km/1 gallon ")

#http://applied-r.com/colors-in-ggplot/
#
ggplot(mtcars, aes(x="", y=mpg)) +
  geom_boxplot(fill="slateblue", alpha=0.2) +
  xlab("")+
  ylab("Distance km/1 gallon")

# same graphs but adding more variable

#http://www.sthda.com/english/wiki/ggplot2-point-shapes
#http://applied-r.com/rcolorbrewer-palettes/


library(RColorBrewer)

ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) +
  geom_boxplot(fill="red", alpha=0.6)+
  xlab("cylinder")+
  ylab("Distance km/1 gallon")+
  stat_summary(fun=mean, geom="point", shape=23, size=10, color="yellow", fill="yellow")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set1")



ggplot(mtcars, aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7) +
  xlab("cylinder")+
  ylab("Distance km/1 gallon")+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set1")



ggplot(mtcars, aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7) +
  xlab("Cylinder")+
  ylab("Distance km/1 gallon")+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")


#about palette http://rstudio-pubs-static.s3.amazonaws.com/5312_98fc1aba2d5740dd849a5ab797cc2c8d.html

cbPalette <- c("#999999", "#E69F00", "#56B4E9")

# The palette with black:
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
scale_fill_manual(values=cbPalette)

# To use for line and point colors, add
scale_colour_manual(values=cbPalette)



ggplot(mtcars, aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7) +
  xlab("Cylinder")+
  ylab("Distance/Gallon")+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="cbPalette")


# 
p <- ggplot(mtcars, aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7, color ="red")+
  xlab("Cylinder")+
  ylab("Distance/Gallon")+
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")



# background

p+theme_gray(base_size = 14)

p+theme_bw()

p + theme_minimal()

p + theme_classic()

p + theme_void()

p + theme_dark()



q<-ggplot(mtcars, aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7, color ="red") +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")


ggplot(mtcars%>%
         filter(mpg>20),aes(x=as.factor(cyl), y=mpg, fill = as.factor(cyl))) +
  geom_boxplot(alpha=0.7, color ="red") +
  stat_summary(fun=mean, geom="point", shape=20, size=4, color="red", fill="red")+
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")

q


q+
  labs(title="Boxplot Example",
       subtitle = "Another example uusing xlab and ylab",
       x ="Cylinder",
       y ="Distance/Gallon",
       caption = "(Data source from ...)",fill="Legends")+
      theme(legend.position="bottom")+
      scale_fill_manual(values = c("#d8b365", "#f5f5f5", "#5ab4ac"))

#http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/


# display values on the graph

means <- aggregate(mpg ~  cyl, mtcars, mean)
means


q+
  geom_text(data = means, aes(label = mpg, y = mpg))

#### trang trí thêm một chút

means <-round(means,2)

means



q+ geom_text(data = means, aes(label = mpg, y = mpg + 0.08))

q+ geom_text(data = means, aes(label = mpg, y = mpg + 1))

# Annotation

#http://www.sthda.com/english/wiki/ggplot2-texts-add-text-annotations-to-a-graph-in-r-software

#https://ggplot2.tidyverse.org/reference/annotate.html
q+ geom_text(data = means, aes(label = mpg, y = mpg + 1))+
  annotate(geom="text", x=3, y=30, label="This is an annotation",
           color="red", size =5)

# Some additional library

library(tidyverse)
library(hrbrthemes)
library(viridis)
library(dplyr)

# create a dataset
data <- data.frame(
  name=c( rep("A",500), rep("B",500), rep("B",500), rep("C",20), rep('D', 100)  ),
  value=c( rnorm(500, 10, 5), rnorm(500, 13, 1), rnorm(500, 18, 1), rnorm(20, 25, 4), rnorm(100, 12, 1) )
)


# biểu đồ đàn vĩ cầm, dùng biểu đồ này khi dữ liệu của chúng ta khá nhiều và phân tán

data %>%
  ggplot(aes(x=name, y=value, fill=name)) +
  geom_violin() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6, option="A") +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Violin chart") +
  xlab("")

# back to car data

# method 
mtcars %>%
  ggplot( aes(x=as.factor(cyl), y=mpg, fill=as.factor(cyl))) +
  geom_violin() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6, option="A") +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Violin chart") +
  xlab("")


# Reprensing data on boxplot

# Plot
data %>%
  ggplot( aes(x=name, y=value, fill=name)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("A boxplot with jitter") +
  xlab("")

# data mtcars

z<-mtcars %>%
  ggplot(aes(x=as.factor(cyl), y=mpg, fill=as.factor(cyl))) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Example with jitter") +
  xlab("")


z















# another example - Density

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/1_OneNum.csv", header=TRUE)
data <- data.frame(data)
view(data)
# Make the histogram

ggplot(data, aes(x=price)) +
  geom_boxplot()

# method 1
ggplot(data, aes(x=price)) +
  geom_density(fill="yellow", color="blue", alpha=0.8)


## method 2
data %>%
  # filter( price<300 ) %>%
  ggplot( aes(x=price)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)


ggplot(data, aes(x=price)) +
  geom_boxplot()

data %>%
  ggplot( aes(x=price)) +
  geom_boxplot()


data %>%
   filter(price<300) %>%
  ggplot( aes(x=price)) +
  geom_boxplot()


quantile(data$price,probs=seq(0,1,0.05)) #quantile from 0 to 1 with a step of 5%
quantile(data$price,probs=seq(0.95,1,0.01)) #quantilte from 0.95 to 1 with a step of 1%

data %>%
  # filter( price<300 ) %>%
  ggplot( aes(x=price)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)



p<-data %>%
  filter( price<300 ) %>%
  ggplot( aes(x=price)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)

p

p+labs(title = "Density Plot",
       y = "Density",
       x = "Price in USD"
       
)

q<-data %>%
  filter( price<300 ) %>%
  ggplot( aes(x=price))+
  geom_histogram(fill="red",alpha=0.4) #fill="#69b3a2", color="#e9ecef", alpha=0.8

q


p  +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white")

p
q

p  +
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "yellow", alpha = 0.2)

q +
  annotate("text", x=250, y=500, label= "Example 1", cex=5, colour = "blue", angle = 0)
# draw a line

q +
  annotate("text", x=250, y=750, label= "Ví dụ 1", cex=5, colour = "red", angle = 90)+
  geom_vline(xintercept = 200, colour="blue", lwd = 1)

library(plotly)

p

a1<-ggplotly(p)
a1

a2<-ggplotly(q)

a1

a2

