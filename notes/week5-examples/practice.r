x2 <- seq(0,2*pi,len=100)
y2 <- sin(x2)
y4 <- cos(x2)
par(mfrow = c(1,2))
plot(y2,y4)
polygon(y2,y4,col='lightgreen')
plot(y2,y4, asp=1, type='n')
polygon(y2,y4,col='lightgreen')
#install.packages("GISTools", depend = T)
library(GISTools)
data(georgia)
georgia
appling <- georgia.polys[[1]]
View(georgia@data)

plot.new()
plot(appling, asp=1, type='n', xlab="Easting", ylab="Northing")

polygon(appling, density=10, angle=145)

View(appling[[1]])
colours()
polygon(appling, col=rgb(0,0.5,0.7))
polygon(appling, col=rgb(0,0.5,0.7,0.4))

# set the plot extent
plot(appling, asp=1, type='n', xlab="Easting", ylab="Northing")
# plot the points
points(x = runif(500,126,132)*10000,
       y = runif(500,103,108)*10000, pch=16, col='red')
# plot the polygon with a transparency factor
polygon(appling, col=rgb(0,0.5,0.7,0.4))




plot(c(-1.5,1.5),c(-1.5,1.5),asp=1, type='n')
# plot the green/blue rectangle
rect(-0.5,-0.5,0.5,0.5, border=NA, col=rgb(0,0.5,0.5,0.7))
# then the second one
rect(0,0,1,1, col=rgb(1,0.5,0.5,0.7))


data(meuse.grid)

mat = SpatialPixelsDataFrame(points = meuse.grid[c("x", "y")],
                             data = meuse.grid)
image(mat, "dist")
library(RColorBrewer)

greenpal <- brewer.pal(7,'Greens')

image(mat, "dist", col=greenpal)
library(ggplot2)
theme_bw()
theme_dark()
library(gridExtra)

appling <- data.frame(appling)
colnames(appling) <- c("X", "Y")
p1 <- qplot(X, Y, data = appling, geom = "polygon", asp = 1,
            colour = I("black"),
            fill=I(rgb(0,0.5,0.7,0.4))) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=20))
# create a data.frame to hold the points

p1

df <- data.frame(x = runif(500,126,132)*10000,
                 y = runif(500,103,108)*10000)

p2 <- ggplot(appling, aes(x = X, y= Y)) +
  geom_polygon(fill = I(rgb(0,0.5,0.7,0.4))) +
  geom_point(data = df, aes(x, y),col=I('red')) +
  coord_fixed() +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=20))
p2

grid.arrange(p1, p2, ncol = 2)


is.element("sf", installed.packages())

#install.packages("sf", dep = TRUE)
#help(sf)
#??sf
data(newhaven)

ls()
class(breach)
class(appling)
class(Rooms)
class(roads)
head(data.frame(blocks))
head(blocks@data)

plot(blocks)

par(mar = c(0,0,0,0))
plot(roads, col="red")
plot(blocks, add = T)

library(sf)
vignette(package = "sf")
vignette("sf1", package = "sf")

# load the georgia data
data(georgia)
# conversion to sf
georgia_sf = st_as_sf(georgia)
class(georgia_sf)
georgia_sf
georgia@data

# all attributes
plot(georgia_sf)
# selected attribute
plot(georgia_sf[, 6])
# selected attributes
plot(georgia_sf[,c(4,5)])



georgia_sf[,c(4,5)]
georgia_sf

## sp SpatialPolygonDataFrame object
head(data.frame(georgia))
## sf polygon object
head(data.frame(georgia_sf))


roads_sf <- st_as_sf(roads)
class(roads_sf)
r2 <- as(roads_sf, "Spatial")
class(r2)

library(rgdal)

writeOGR(obj=georgia, dsn="./test", layer="georgia",
         driver="ESRI Shapefile", overwrite_layer=T)
new.georgia <- readOGR("test/georgia.shp")

class(new.georgia)

writeOGR(new.georgia, dsn = "./test", layer = "georgia",
         driver="ESRI Shapefile", overwrite_layer = T)

#st_read()
#st_write()

g2 <- st_read("test/georgia.shp")

st_write(g2, "test/georgia.shp", delete_layer = T)

st_write(g2, dsn = "test/georgia.shp", layer = "georgia.shp",
         driver = "ESRI Shapefile", delete_layer = T)


#mapping
rm(list=ls())

data(georgia)

georgia_sf <- st_as_sf(georgia)

library(tmap)

qtm(georgia, fill = "red", style = "natural")

qtm(georgia_sf, fill="MedInc", text="Name", text.size=1,
    format="World_wide", style="classic",
    text.root=5, fill.title="Median Income")

g <- st_union(georgia_sf)

tm_shape(georgia_sf) +
  tm_fill("tomato")


tm_shape(georgia_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold")


tm_shape(georgia_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold") +
  tm_style("natural", bg.color = "grey90")

tm_shape(georgia_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold") +
  tm_style("natural", bg.color = "grey90") +
  # now add the outline
  tm_shape(g) +
  tm_borders(lwd = 2)

tm_shape(georgia_sf) +
  tm_fill("tomato") +
  tm_borders(lty = "dashed", col = "gold") +
  tm_style("natural", bg.color = "grey90") +
  # now add the outline
  tm_shape(g) +
  tm_borders(lwd = 2) +
  tm_layout(title = "The State of Georgia",
            title.size = 1, title.position = c(0.55, "top"))

# 1st plot of georgia
t1 <- tm_shape(georgia_sf) +
  tm_fill("coral") +
  tm_borders() +
  tm_layout(bg.color = "grey85")
# 2nd plot of georgia2
t2 <- tm_shape(georgia2) +
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


data.frame(georgia_sf)[,13]


tm_shape(georgia_sf) +
  tm_fill("white") +
  tm_borders() +
  tm_text("Name", size = 0.3) +
  tm_layout(frame = FALSE)

index <- c(81, 82, 83, 150, 62, 53, 21, 16, 124, 121, 17)
georgia_sf.sub <- georgia_sf[index,]

tm_shape(georgia_sf.sub) +
  tm_fill("gold1") +
  tm_borders("grey") +
  tm_text("Name", size = 1) +
  # add the outline
  tm_shape(g) +
  tm_borders(lwd = 2) +
  # specify some layout parameters
  tm_layout(frame = FALSE, title = "A subset of Georgia",
            title.size = 1.5, title.position = c(0., "bottom"))


# the 1st layer
tm_shape(georgia_sf) +
  tm_fill("white") +
  tm_borders("grey", lwd = 0.5) +
  # the 2nd layer
  tm_shape(g) +
  tm_borders(lwd = 2) +
  # the 3rd layer
  tm_shape(georgia_sf.sub) +
  tm_fill("lightblue") +
  tm_borders() +
  # specify some layout parameters
  tm_layout(frame = T, title = "Georgia with a subset of counties",
            title.size = 1, title.position = c(0.02, "bottom"))



library(OpenStreetMap)
# define upper left, lower right corners
georgia.sub <- georgia[index,]
ul <- as.vector(cbind(bbox(georgia.sub)[2,2],
                      bbox(georgia.sub)[1,1]))
lr <- as.vector(cbind(bbox(georgia.sub)[2,1],
                      bbox(georgia.sub)[1,2]))
# download the map tile
MyMap <- openmap(ul,lr)
# now plot the layer and the backdrop
par(mar = c(0,0,0,0))
plot(MyMap, removeMargin=FALSE)
plot(spTransform(georgia.sub, osm()), add = TRUE, lwd = 2)





# load the package
library(RgoogleMaps)
# convert the subset
shp <- SpatialPolygons2PolySet(georgia.sub)
# determine the extent of the subset
bb <- qbbox(lat = shp[,"Y"], lon = shp[,"X"])
# download map data and store it
MyMap <- GetMap.bbox(bb$lonR, bb$latR, destfile = "DC.jpg")
# now plot the layer and the backdrop
par(mar = c(0,0,0,0))
PlotPolysOnStaticMap(MyMap, shp, lwd=2,
                     col = rgb(0.25,0.25,0.25,0.025), add = F)


tmap_mode('view')

tm_shape(georgia_sf.sub) +
  tm_polygons(col = "#C6DBEF80" )

tmap_mode("plot")


# load package and data
library(GISTools)
data(newhaven)
proj4string(roads) <- proj4string(blocks)
# plot spatial data
tm_shape(blocks) +
  tm_borders() +
  tm_shape(roads) +
  tm_lines(col = "red") +
  # embellish the map
  tm_scale_bar(width = 0.22) +
  tm_compass(position = c(0.8, 0.07)) +
  tm_layout(frame = F, title = "New Haven, CT",
            title.size = 1.5,
            title.position = c(0.55, "top"),
            legend.outside = T)

# load package and data

pts_sf <- st_centroid(georgia_sf)
pts_sf

plot(pts_sf)

png(filename = "centroid.png", w = 5, h = 7, units = "in", res = 150)


tm_shape(georgia_sf) +
  tm_fill("olivedrab4") +
  tm_borders("grey", lwd = 1) +
  # the points layer
  tm_shape(pts_sf) +
  tm_bubbles("PctBlack", title.size = "% Black", col = "gold")

# clear workspace
rm(list = ls())
# load & list the data
data(newhaven)
ls()
# convert to sf
blocks_sf <- st_as_sf(blocks)
breach_sf <- st_as_sf(breach)
tracts_sf <- st_as_sf(tracts)
# have a look at the attributes and object class
summary(blocks_sf)
class(blocks_sf)
summary(breach_sf)
class(breach_sf)
summary(tracts_sf)
class(tracts_sf)

data.frame(blocks_sf)

head(data.frame(blocks_sf))
colnames(data.frame(blocks_sf))
names(blocks_sf)
colnames(blocks@data)
head(blocks@data)

data.frame(blocks_sf$P_VACANT)
blocks$P_VACANT

attach(data.frame(blocks_sf)) #attach() function in R Language is used to access the variables present in the data framework without calling the data frame.

hist(P_VACANT)

detach(data.frame(blocks_sf))
breach.dens = st_as_sf(kde.points(breach,lims=tracts)) #kde is to create kernel density surface
summary(breach.dens)

breach.dens
plot(breach.dens)
blocks_sf$RandVar <- rnorm(nrow(blocks_sf))

tmap_mode('plot')
tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC")

tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", breaks=seq(0, 100, by=25))

tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", breaks=c(10, 40, 60, 90))


tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ") +
  tm_layout(legend.title.size = 1,
            legend.text.size = 1,
            legend.position = c(0.1, 0.1))
display.brewer.all()
brewer.pal(5,'Blues')

tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ", palette = "Reds") +
  tm_layout(legend.title.size = 1)

tm_shape(blocks_sf) +
  tm_fill("P_OWNEROCC", title = "Owner Occ", palette = "Blues") +
  tm_layout(legend.title.size = 1)

# with equal intervals: the tmap default
p1 <- tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ", palette = "Blues") +
  tm_layout(legend.title.size = 0.7)
# with style = kmeans
p2 <- tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ", palette = "Oranges",
              style = "kmeans") +
  tm_layout(legend.title.size = 0.7)
# with quantiles
p3 <- tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ", palette = "Greens",
              breaks = c(0, round(quantileCuts(blocks$P_OWNEROCC, 6), 1))) +
  tm_layout(legend.title.size = 0.7)
p3


library(grid)
grid.newpage()

pushViewport(viewport(layout=grid.layout(1,3)))

print(p1, vp=viewport(layout.pos.col = 1, height = 5))
print(p2, vp=viewport(layout.pos.col = 2, height = 5))
print(p3, vp=viewport(layout.pos.col = 3, height = 5))




tm_shape(blocks_sf) +
  tm_polygons("P_OWNEROCC", title = "Owner Occ", palette = "-GnBu",
              breaks = c(0, round(quantileCuts(blocks$P_OWNEROCC, 6), 1)),
              legend.hist = T) +
  tm_scale_bar(width = 0.22) +
  tm_compass(position = c(0.8, 0.07)) +
  tm_layout(frame = F, title = "New Haven",
            title.size = 2, title.position = c(0.55, "top"),
            legend.hist.size = 0.5)


# add a projection to tracts data and convert tracts data to sf
proj4string(tracts) <- proj4string(blocks)
tracts_sf <- st_as_sf(tracts)
tracts_sf <- st_transform(tracts_sf, "+proj=longlat +ellps=WGS84")
# plot
tm_shape(blocks_sf) +
  tm_fill(col="POP1990", convert2density=TRUE,
          style="kmeans", title=expression("Population (per " * km^2 * ")"),
          legend.hist=F, id="name") +
  tm_borders("grey25", alpha=.5) +
  # add tracts context
  tm_shape(tracts_sf) +
  tm_borders("grey40", lwd=2)

# add an area in km^2 to blocks
blocks_sf$area = st_area(blocks_sf) / (1000*1000)
# calculate population density manually
summary(blocks_sf$POP1990/blocks_sf$are)


tm_shape(blocks_sf) +
  tm_fill(c("P_RENTROCC", "P_BLACK")) +
  tm_borders() +
  tm_layout(legend.format = list(digits = 0),
            legend.position = c("left", "bottom"),
            legend.text.size = 0.5,
            legend.title.size = 0.8)

### Mapping Point and Atttribute


tm_shape(blocks_sf) +
  tm_polygons("white") +
  tm_shape(breach_sf) +
  tm_dots(size = 0.5, shape = 19, col = "red", alpha = 1)


tm_shape(breach_sf) +
  tm_dots(size = 0.5, shape = 19, col = "red", alpha = 0.5)


# load the data
data(quakes)
# look at the first 6 records
head(quakes)

# define the coordinates
coords.tmp <- cbind(quakes$long, quakes$lat)
# create the SpatialPointsDataFrame
quakes.sp <- SpatialPointsDataFrame(coords.tmp,
                                    data = data.frame(quakes),
                                    proj4string = CRS("+proj=longlat "))
# convert to sf
quakes_sf <- st_as_sf(quakes.sp)


tm_shape(quakes_sf) +
  tm_dots(size = 0.5, alpha = 0.3)


library(grid)
# by size
p1 <- tm_shape(quakes_sf) +
  tm_bubbles("depth", scale = 1, shape = 19, alpha = 0.3,
             title.size="Quake Depths")
# by colour
p2 <- tm_shape(quakes_sf) +
  tm_dots("depth", shape = 19, alpha = 0.5, size = 0.6,
          palette = "PuBuGn",
          title="Quake Depths")
# Multiple plots using the grid package
grid.newpage()
# set up the layout
pushViewport(viewport(layout=grid.layout(1,2)))
# plot using he print command
print(p1, vp=viewport(layout.pos.col = 1, height = 5))

print(p2, vp=viewport(layout.pos.col = 2, height = 5))


# create the index
index <- quakes_sf$mag > 5.5
summary(index)
# select the subset assign to tmp
tmp <- quakes_sf[index,]
# plot the subset
tm_shape(tmp) +
  tm_dots(col = brewer.pal(5, "Reds")[4], shape = 19,
          alpha = 0.5, size = 1) +
  tm_layout(title="Quakes > 5.5",
            title.position = c("centre", "top"))

library(RgoogleMaps)
# define Lat and Lon
Lat <- as.vector(quakes$lat)
Long <- as.vector(quakes$long)
# get the map tiles
# you will need to be online
MyMap <- MapBackground(lat=Lat, lon=Long, zoom = 10,
                       maptype = "satellite")



# define a size vector
tmp <- 1+(quakes$mag - min(quakes$mag))/max(quakes$mag)
PlotOnStaticMap(MyMap,Lat,Long,cex=tmp,pch=1,col='#FB6A4A30')


### Mapping line and attribute

data(newhaven)
proj4string(roads) <- proj4string(blocks)
xmin <- bbox(roads)[1,1]
ymin <- bbox(roads)[2,1]

xmax <- xmin + diff(bbox(roads)[1,]) / 2
ymax <- ymin + diff(bbox(roads)[2,]) / 2

xx = as.vector(c(xmin, xmin, xmax, xmax, xmin))
yy = as.vector(c(ymin, ymax, ymax, ymin, ymin))

crds <- cbind(xx,yy)
Pl <- Polygon(crds)
ID <- "clip"
Pls <- Polygons(list(Pl), ID=ID)
Pls
SPls <- SpatialPolygons(list(Pls))
df <- data.frame(value=1, row.names=ID)
clip.bb <- SpatialPolygonsDataFrame(SPls, df)
proj4string(clip.bb) <- proj4string(blocks)
# 3. convert to sf
# convert the data to sf
clip_sf <- st_as_sf(clip.bb)
roads_sf <- st_as_sf(roads)
# 4. clip out the roads and the data frame
roads_tmp <- st_intersection(st_cast(clip_sf), roads_sf)

tm_shape(clip_sf) +
  tm_polygons("white") +
  tm_shape(roads_sf) +
  tm_lines(size = 0.5, shape = 19, col = "red", alpha = 1)+
  tm_shape(roads_tmp)+
  tm_lines(size = 0.5, shape = 19, col = "red", alpha = 1)
