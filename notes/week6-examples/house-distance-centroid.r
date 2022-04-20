#We will calculate the following

# Diversity index

# shortest distance of one POI layers to other POI layer

# shortest distance to nearby road

#loading in library
library(dplyr)
library(ggplot2)
library(reshape2)
library(rgdal)
library(sf)
library(rgeos)
library(tmap)
library(RColorBrewer)




#reading the shapefile

OA.Census <- st_read("Camden/Census_OA_Shapefile.shp")
plot(OA.Census)
House.Points <- st_read("Camden/Camden_house_sales.shp")
plot(House.Points)



#calculate centroid points

cent_sf <- st_centroid(OA.Census)
cent_sf
plot(cent_sf)

tm_shape(OA.Census) +
  tm_fill("olivedrab4") +
  tm_borders("grey", lwd = 1) +
  # the points layer
  tm_shape(cent_sf) +
  tm_bubbles("Lw_Occp", title.size = "% Occupancy", col = "gold")

## now we want to estimate the distance from every house to the Centroid --> pretending that the POIs is like Metro, Bus Stop or House White :)

## we can do this separately

House.Points

plot(House.Points)

house.cordinate <-data.frame(st_coordinates(House.Points))
cent.cordinate <-data.frame(st_coordinates(cent_sf))

head(house.cordinate)
head(cent.cordinate)

coordinates(house.cordinate) <- ~X + Y


str(house.cordinate)

proj4string(house.cordinate)

proj4string(house.cordinate) <- CRS("+init=epsg:27700")



class(house.cordinate)
house.cordinate <- spTransform(house.cordinate, CRS("+init=epsg:4326"))
head(house.cordinate@coords)
head(house.cordinate@coords)

coordinates(cent.cordinate) <- ~X + Y
str(cent.cordinate)
proj4string(cent.cordinate)
proj4string(cent.cordinate) <- CRS("+init=epsg:27700")
class(cent.cordinate)
cent.cordinate <- spTransform(cent.cordinate, CRS("+init=epsg:4326"))


head(cent.cordinate@coords)



plot.new()
plot(house.cordinate, col ="red")
points(cent.cordinate, col = "blue")

cent.cordinate@coords
library(geosphere)

distance.house.cent <- distm(house.cordinate@coords[,c('X','Y')], cent.cordinate@coords[,c('X','Y')], fun=distVincentyEllipsoid)

distance.house.cent

row <- length(distance.house.cent[,1])
column <- length(distance.house.cent[1,])


x1<-matrix(double(1),nrow=row,ncol=1)
x2<-matrix(double(1),nrow=row,ncol=1)
for (i in 1:row){
  #  for (j in 1: column){
  x1[i] <- which.min(distance.house.cent[i,])
  x2[i] <- distance.house.cent[i,x1[i]]
  #  }
}
x1.x2 <- cbind(x1,x2)
head(x1.x2)

head(x1.x2[,1])
head(x1.x2[,2])

House.Points <-House.Points%>%
  mutate(cent.index = x1.x2[,1], dist.cent = x1.x2[,2])

# for calculation of the same layer

#https://www.seascapemodels.org/rstats/2020/02/08/calculating-distances-in-R.html

#https://stackoverflow.com/questions/59674971/r-for-a-dataframe-of-locations-find-the-nearest-member-from-another-dataframe

#https://stackoverflow.com/questions/21977720/r-finding-closest-neighboring-point-and-number-of-neighbors-within-a-given-rad



#---------THE END ------------- do not use the code below
# how is about to combine with original data
# cent_sf.coordinate <- cent_sf %>%
#   mutate(lat = unlist(map(cent_sf$geometry,1)),
#          lon = unlist(map(cent_sf$geometry,2)))
# # but we want to combine with the original dataset
# library(tidyverse)
# cent_sf.coordinate <- cent_sf %>%
#   mutate(lat = unlist(map(cent_sf$geometry,1)),
#          long = unlist(map(cent_sf$geometry,2)))
# 
# cent_sf.coordinate
# 
# House.Points <- House.Points %>%
#   mutate(lat = unlist(map(House.Points$geometry,1)),
#          long = unlist(map(House.Points$geometry,2)))

# library(geosphere)
# 
# str(House.Points)
# str(cent_sf.coordinate)
# 
# dist.01 <- distm(House.Points[,c('long','lat')], cent_sf.coordinate[,c('long','lat')], fun=distVincentyEllipsoid)

### Error: (list) object cannot be coerced to type 'double'
# how to fix it --> the value shall be numeric instead of double.
#x_num <- as.numeric(unlist(x))

# glimpse(House.Points)
# glimpse(cent_sf.coordinate)
# 
# House.Points$lat <- as.numeric(unlist(House.Points$lat))
# House.Points$long <- as.numeric(unlist(House.Points$long))
# 
# cent_sf.coordinate$lat <- as.numeric(unlist(cent_sf.coordinate$lat))
# cent_sf.coordinate$long <- as.numeric(unlist(cent_sf.coordinate$long))
# 
# 
# dist.01 <- distm(House.Points[,c('long','lat')], cent_sf.coordinate[,c('long','lat')], fun=distVincentyEllipsoid)




