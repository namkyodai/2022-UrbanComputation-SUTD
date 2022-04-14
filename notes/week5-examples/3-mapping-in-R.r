library(rgdal) #
library(rgeos) #

### Đọc 
Output.Areas<- readOGR("./Camden_oa11", "Camden_oa11")
plot(Output.Areas)


source("2-EDA.r")


OA.Census <- merge(Output.Areas, Census.Data, by.x="OA11CD", by.y="OA")

#setting coordinate system

# sets the coordinate system to the British National Grid
proj4string(OA.Census) <- CRS("+init=EPSG:27700")


#Mapping Data 

# loads packages
library(tmap)
library(leaflet)

# this will prodyce a quick map of our qualification variable
qtm(OA.Census, fill = "Qualification")

# Creates a simple choropleth map of our qualification variable
tm_shape(OA.Census)+tm_fill("Qualification")

library(RColorBrewer)

#display.brewer.all()

tm_shape(OA.Census) + tm_fill("Qualification", palette = "-Greens") 

# changing the intervals 
tm_shape(OA.Census) + tm_fill("Qualification", style = "quantile", palette = "Reds")

# number of levels
tm_shape(OA.Census) + tm_fill("Qualification", style = "quantile", n = 7, palette = "-Greens")


# includes a histogram in the legend
tm_shape(OA.Census) + tm_fill("Qualification", style = "quantile", n = 5, palette = "Reds", legend.hist = TRUE) 

# add borders
tm_shape(OA.Census) + tm_fill("Qualification", palette = "Reds") + 
  tm_borders(alpha=.4)

# north arrow
tm_shape(OA.Census) + tm_fill("Qualification", palette = "Reds") + 
  tm_borders(alpha=.4) +
  tm_compass()


# adds in layout, gets rid of frame
tm_shape(OA.Census) + tm_fill("Qualification", palette = "Reds", style = "quantile", title = "% with a Qualification") + 
  tm_borders(alpha=.4) + 
  tm_compass() + 
  tm_layout(title = "Camden, London", legend.text.size = 1.1, legend.title.size = 1.4, legend.position = c("right", "top"), frame = FALSE) 

#writeOGR(OA.Census, dsn = "./week1-practice/Camden", layer =  "Census_OA_Shapefile", driver="ESRI Shapefile")

#library(raster)
#OA.Census$area <- area(OA.Census)


