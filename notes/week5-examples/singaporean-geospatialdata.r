#--------------------------------------------------------------
library(rstudioapi) # We load this libary in order to use the below command to set the working directory to the file --> path
setwd(dirname(getActiveDocumentContext()$path))



#loading geospatial R libararies
library(GISTools)
library(sf)
library(rgdal)
library(tmap)
library(rgeos)

#reading the shapefiles

pop.plan.gender<- readOGR("../sg-gis/singapore-residents-by-planning-area-age-group-and-sex-june-2010-gender", "PLAN_BDY_AGE_GENDER_2010")


pop.plan.gender <- st_read("../sg-gis/singapore-residents-by-planning-area-age-group-and-sex-june-2010-gender/PLAN_BDY_AGE_GENDER_2010.shp")

pop.plan.gender_sf <- st_as_sf(pop.plan.gender)

qtm(pop.plan.gender, fill = "red", style = "natural")

qtm(pop.plan.gender_sf, fill="TOTAL", text="PLN_AREA_N", text.size=1,
    format="World_wide", style="classic",
    text.root=2, fill.title="Population")

tm_shape(pop.plan.gender_sf) +
  tm_fill("tomato")

tm_shape(pop.plan.gender_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold")

tm_shape(pop.plan.gender_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold") +
  tm_style("natural", bg.color = "grey90")

tm_shape(pop.plan.gender_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold") +
  tm_style("natural", bg.color = "grey90") +
  # now add the outline
  tm_layout(title = "Singaporean Planning Zone",
            title.size = 1, title.position = c(0.55, "top"))


t1 <- tm_shape(pop.plan.gender_sf) +
  tm_fill("coral") +
  tm_borders() +
  tm_layout(bg.color = "grey85")
# 2nd plot of georgia2
t2 <- tm_shape(pop.plan.gender_sf) +
  tm_fill("orange") +
  tm_borders() +
  # the asp paramter controls aspect
  # this is makes the 2nd plot align
  tm_layout(asp = 0.86,bg.color = "grey95")

library(grid)
# open a new plot page
grid.newpage()
# set up the layout
pushViewport(viewport(layout=grid.layout(1,2)))
# plot using the print command
print(t1, vp=viewport(layout.pos.col = 1, height = 5))
print(t2, vp=viewport(layout.pos.col = 2, height = 5))

##calculating the centroin













mydata <- structure(
  list(pond = c("A10", "AA006", "Blacksmith", "Borrow.Pit.1", 
                "Borrow.Pit.2", "Borrow.Pit.3", "Boulder"), 
       lat = c(41.95928, 41.96431, 41.95508, 41.95601, 41.95571, 41.95546, 
               41.918223), 
       long = c(-72.14605, -72.121, -72.123803, -72.15419, -72.15413, 
                -72.15375, -72.14978), 
       area = c(1500L, 250L, 361L, 0L, 0L, 0L, 1392L), 
       canopy = c(66L, 0L, 77L, 0L, 0L, 0L, 98L), 
       avg.depth = c(60.61538462, 57.77777778, 71.3125, 41.44444444, 
                     37.7, 29.22222222, 43.53333333)), 
  class = "data.frame", row.names = c(NA, -7L))


library(sf)
data_sf <- st_as_sf(mydata, coords = c("long", "lat"),
                    # Change to your CRS
                    crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
st_is_longlat(data_sf)



#Dataframe 1
df1<-structure(list(lat = c(54L, 55L, 51L, 54L, 53L, 50L, 47L, 51L, 
                       49L, 54L), lon = c(14L, 8L, 15L, 7L, 6L, 5L, 13L, 5L, 13L, 11L
                       ), PPP2000_40 = c(4606, 6575, 6593, 7431, 9393, 10773, 11716, 
                                         12226, 13544, 14526)), .Names = c("lat", "lon", "PPP2000_40"), row.names =c(6764L, 8796L, 8901L, 9611L, 11649L, 12819L, 13763L, 14389L, 15641L, 
                                                                                                                     16571L), class = "data.frame")

# Dataframe 2
df2<-structure(list(lat = c(47, 47, 47, 47, 47, 47, 48, 48, 48, 48
), lon = c(7, 8, 9, 10, 11, 12, 7, 8, 9, 10), GDP = c(19.09982, 
                                                      13.31977, 14.95925, 6.8575635, 23.334565, 6.485748, 24.01197, 14.30393075, 21.33759675, 9.71803675)), .Names = c("lat", "lon", "GDP"), row.names = c(NA,  10L), class = "data.frame")

library(geosphere)
mat <- distm(df1[,c('lon','lat')], df2[,c('lon','lat')], fun=distVincentyEllipsoid)
df1$GDP <- df2$GDP[apply(mat, 1, which.min)]

df1
df2



