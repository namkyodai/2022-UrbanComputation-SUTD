source("week1-5-GISandR.r")
library(sp)
library(raster)
library(adehabitatHR)
library(tmap)


#### 

# 
tm_shape(OA.Census) + 
  tm_fill("Qualification", palette = "Reds", style = "quantile", title = "% Qualification") + tm_borders(alpha=.4) + 
  tm_shape(House.Points) +   
  tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.1) +  
  tm_layout(legend.text.size = 0.8, legend.title.size = 1.1, frame = FALSE)

## how many points in a polygon

library(GISTools)

house.count <- poly.counts(House.Points, OA.Census) 

choropleth(OA.Census,house.count/poly.areas(OA.Census))

head(house.count)

names(house.count)

### calculating area

## change to sf

library(sf)

OA.Census.sf <- st_as_sf(OA.Census)
House.Points.sf <- st_as_sf(House.Points)

poly.areas(OA.Census) #  sp
st_area(OA.Census.sf) # sf

### KDE
kde.output <- kernelUD(House.Points, h="href", grid = 1000)
plot(kde.output)

## Raster KDE

kde <- raster(kde.output)
# sets projection to British National Grid
projection(kde) <- CRS("+init=EPSG:27700")

# density map and raster, ud is the parameter of kde
tm_shape(kde) + tm_raster("ud")

bounding_box <- bbox(Output.Areas) # zoom in an area using box
tm_shape(kde, bbox = bounding_box) + 
  tm_raster("ud") #plotting the density

# add raster kde on targettted area
masked_kde <- mask(kde, Output.Areas)

# mapping kde, then add polygon layer
tm_shape(masked_kde, bbox = bounding_box) + 
  tm_raster("ud", style = "quantile", n = 100, legend.show = FALSE, palette = "YlGnBu") +
  tm_shape(Output.Areas) + tm_borders(alpha=.3, col = "white") +
  tm_layout(frame = FALSE)

# compute homeranges for 75%, 50%, 25% of points, objects are returned as spatial polygon data frames
range75 <- getverticeshr(kde.output, percent = 75)
range50 <- getverticeshr(kde.output, percent = 50)
range25 <- getverticeshr(kde.output, percent = 25)

# the code below creates a map of several layers using tmap
tm_shape(Output.Areas) + 
  tm_fill(col = "#f0f0f0") + 
  tm_borders(alpha=.8, col = "white") +
  tm_shape(House.Points) + 
  tm_dots(col = "blue") +
  tm_shape(range75) + 
  tm_borders(alpha=.7, col = "#fb6a4a", lwd = 2) + 
  tm_fill(alpha=.1, col = "#fb6a4a") +
  tm_shape(range50) + 
  tm_borders(alpha=.7, col = "#de2d26", lwd = 2) + 
  tm_fill(alpha=.1, col = "#de2d26") +
  tm_shape(range25) + 
  tm_borders(alpha=.7, col = "#a50f15", lwd = 2) + tm_fill(alpha=.1, col = "#a50f15") +
  tm_layout(frame = FALSE)

##writeRaster(masked_kde, filename = "kernel_density.grd")

