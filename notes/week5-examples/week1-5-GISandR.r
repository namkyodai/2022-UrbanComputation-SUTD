source("week1-4-mapping-pointdata.r")
#proj4string(OA.Census) <- CRS("+init=EPSG:27700")
#proj4string(House.Points) <- CRS("+init=EPSG:27700")

# Declaire points in polygon 
pip <- over(House.Points, OA.Census)

#This is the function of the libarary spover package, used to connect spatial points

# include pip into the dataset
House.Points@data <- cbind(House.Points@data, pip)

View(House.Points@data)

# plot the relationshiop between price and unemployment
plot(log(House.Points@data$Price), House.Points@data$Unemployed)


# because there is many house to be sold in one place (polygon), we now care about the average housing for each polygon

OA <- aggregate(House.Points@data$Price, by = list(House.Points@data$OA11CD), mean)

# rename it
names(OA) <- c("OA11CD", "Price")

# include this into OA.Cencus
OA.Census@data <- merge(OA.Census@data, OA, by = "OA11CD", all.x = TRUE)


head(OA.Census@data)

### plot on the map
tm_shape(OA.Census) + 
  tm_fill(col = "Price", style = "quantile", title = "Mean House Price (£)")

## regression model

model <- lm(OA.Census@data$Price ~ OA.Census@data$Unemployed)
summary(model)

###### Buffer.


# a buffer zone of 200 m diameter 
house_buffers <- gBuffer(House.Points, width = 200, byid = TRUE)

# plot
tm_shape(OA.Census) + tm_borders() +
  tm_shape(house_buffers) + tm_borders(col = "blue") +
  tm_shape(House.Points) + tm_dots(col = "red") 


# ----> unite them
union.buffers <- gUnaryUnion(house_buffers)

# map
tm_shape(OA.Census) + 
  tm_borders() +
  tm_shape(union.buffers) + 
  tm_fill(col = "blue", alpha = .4) + 
  tm_borders(col = "blue") +
  tm_shape(House.Points)+
  tm_dots(col = "red") 

###Interractive map
#tmap_mode("view")

tm_shape(House.Points) + 
  tm_dots(title = "House Prices (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.2, col = "Price", style = "quantile", palette = "Reds")  

tm_shape(House.Points) + 
  tm_bubbles(size = "Price", title.size = "House Prices (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.4, legend.size.show = TRUE)  


tm_shape(OA.Census) + 
  tm_fill("Qualification", palette = "Reds", style = "quantile", title = "% with a Qualification") + 
  tm_borders(alpha=.4) 

#ttm() #stop interactive
## 







