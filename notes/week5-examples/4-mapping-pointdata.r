source("3-mapping-in-R.r")
# load the house prices csv file
#https://dataviz.spatial.ly/worksheets/camden/
houses <- read.csv("Camden/tables/CamdenHouseSales15.csv")

# we only need a few columns for this practical

houses <- houses[,c(1,2,8,9)]
# 2D scatter plot
plot(houses$oseast1m, houses$osnrth1m)

# create a House.Points SpatialPointsDataFrame
House.Points <-SpatialPointsDataFrame(houses[,3:4], houses, proj4string = CRS("+init=EPSG:27700"))

# This plots a blank base map, we have set the transparency of the borders to 0.4
tm_shape(OA.Census) + tm_borders(alpha=.4)

# creates a coloured dot map
tm_shape(OA.Census) + tm_borders(alpha=.4)+
  tm_shape(House.Points) + tm_dots(col = "Price", palette = "Reds", style = "quantile")

# creates a coloured dot map

tm_shape(OA.Census) + tm_borders(alpha=.4) +
  tm_shape(House.Points) + tm_dots(col = "Price", scale = 1.5, palette = "Reds", style = "quantile", title = "Price Paid (£)")

# creates a coloured dot map
tm_shape(OA.Census) + tm_borders(alpha=.4) +
  tm_shape(House.Points) + tm_dots(col = "Price", scale = 1.5, palette = "Purples", style = "quantile", title = "Price Paid (£)")  +
  tm_compass() +
  tm_layout(legend.text.size = 1.1, legend.title.size = 1.4, frame = FALSE)

# creates a proportional symbol map
tm_shape(OA.Census) + tm_borders(alpha=.4) +
  tm_shape(House.Points) + tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)") +
  tm_layout(legend.text.size = 1.1, legend.title.size = 1.4, frame = FALSE)


# creates a proportional symbol map
tm_shape(OA.Census) + tm_fill("Qualification", palette = "Reds", style = "quantile", title = "% Qualification") + tm_borders(alpha=.4) + tm_shape(House.Points) +   tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.1) +  tm_layout(legend.text.size = 0.8, legend.title.size = 1.1, frame = FALSE)


# write the shapefile to your computer (remember to chang the dsn to your workspace)
#writeOGR(House.Points, dsn = "./week1-practice/Camden/", layer =  "Camden_house_sales", driver="ESRI Shapefile")
