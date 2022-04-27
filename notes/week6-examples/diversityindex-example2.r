## using vegan package
library(vegan)
library(dplyr)
library(reshape2) #
library(rgdal)
library(sf)
library(rgeos)
library(tmap)
library(ggplot2)
#reading data csv
df <- data.frame(read.csv("../week5-examples/Camden/tables/CT0010_oa11.csv",sep = ",", skip = 0))


df1 <- df%>%
        select(-CT00100001)

head(df1)
glimpse(df1)

#reshape --> 


df1<-melt(df1,ID = 'GeographyCode')


df1<-df1%>%
  filter(GeographyCode =="E00004120")
#calculate diversity for this regions

diversity(df1$value,'shannon')

##how to calculate this for the entire files for each geographic regions
df2<-df%>%
  select(-CT00100001)

nrow(df2[1])

H1 <- matrix(double(1),nrow=nrow(df2[1]),ncol=1)


###
for (i in 1:nrow(df2[1])){
  df3 <- melt(df2[i,],ID='GeographyCode')
  H1[i] <- diversity(df3$value,'shannon')
}




H1
head(H1)
###

df4 <- df%>%
  mutate(shannon = H1,.after = CT00100001)

df4
#adding this to spatial data
OA.Census <- readOGR("Camden/Census_OA_Shapefile.shp")

plot(OA.Census)

head(OA.Census@data)

OA.Census <- merge(OA.Census, df4, by.x="OA11CD", by.y="GeographyCode")

OA.Census_sf <- st_as_sf(OA.Census)

class(OA.Census)

st_write(OA.Census_sf, "Camden/new_OA_cencus.shp", delete_layer = T)



## extra reading materials
#https://rdrr.io/cran/spatialEco/man/shannons.html

