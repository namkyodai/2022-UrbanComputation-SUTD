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









