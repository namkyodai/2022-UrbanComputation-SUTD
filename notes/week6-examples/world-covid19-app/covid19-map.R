#--------------------------------------------------------------
#--------------------------------------------------------------
library(rstudioapi) # setting working directory
setwd(dirname(getActiveDocumentContext()$path)) 


library(xts)
library(leaflet)
leaflet() %>% 
  setView(lng = 103.81, lat = 1.35, zoom = 11) %>% 
  addTiles()

##let try with other Tiles provider from https://leaflet-extras.github.io/leaflet-providers/preview/index.html

leaflet() %>% 
  setView(lng = 103.81, lat = 1.35, zoom = 11) %>% 
  addProviderTiles("Stamen.Watercolor")%>%
  addProviderTiles("Stamen.TonerHybrid")%>%
  addProviderTiles("Stamen.Terrain")



##loading data
library(rgdal)

#download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="world_shape_file.zip")



#loading the world borders spatial polygons data frame
world_spdf <- readOGR("world_shape_file/TM_WORLD_BORDERS_SIMPL-0.3.shp")
  
  
plot(world_spdf)

class(world_spdf)

head(world_spdf@data)

world_spdf@polygons[[1]]


covidData <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv", fileEncoding="UTF-8-BOM", stringsAsFactors = FALSE)

covidData <- na.omit(covidData)

head(covidData)


library(RColorBrewer)

#select a certain date
selectedData <- covidData[covidData$Date_reported == "2022-03-30", ]

head(selectedData)


#is there another way??? to to the same things above --> how is about using merged function
df <- merge(world_spdf, selectedData, by.x="ISO2", by.y="Country_code")
head(df@data)

#match cases and spatial data via ISO2/Country Code
world_spdf$Cases <- selectedData$Cumulative_cases[match(world_spdf$ISO2, selectedData$Country_code)]




#create label texts
world_spdf@data$LabelText <- paste0(
  "<b>Country:</b> ", world_spdf@data$NAME,"<br>", 
  "<b>Cases:</b> ", format(world_spdf@data$Cases, nsmall=0, big.mark=","))

#define colorpalette for chart legend
paletteBins <- c(0, 50000, 100000, 250000, 500000, 1000000, 2500000, 5000000, 10000000)
colorPalette <- colorBin(palette = "YlOrBr", domain = covidData$Cumulative_cases, na.color = "transparent", bins = paletteBins)


leaflet(world_spdf) %>% 
  addTiles()  %>% 
  setView(lat = 0, lng = 0, zoom=2)%>%
  addCircleMarkers(lng = ~LON,
                   lat = ~LAT,
                   radius = ~log(Cases) * 2,
                   weight = 1,
                   opacity = 1,
                   color = ~ifelse(Cases > 0, "black", "transparent"),
                   fillColor = ~ifelse(Cases > 0, colorPalette(Cases), "transparent"),
                   fillOpacity = 0.8,
                   label = ~lapply(LabelText, htmltools::HTML))%>% 
   addLegend(pal = colorPalette, values = covidData$Cumulative_cases, opacity=0.9, title = "Cases", position = "bottomleft")


leaflet(world_spdf) %>% 
  addTiles()  %>% 
  setView(lat = 0, lng = 0, zoom=2) %>%
  
  addPolygons( 
    layerId = ~ISO2,
    fillColor = ~colorPalette(Cases),
    stroke = TRUE, 
    fillOpacity = 1, 
    color = "white", 
    weight = 1,
    label = ~lapply(LabelText, htmltools::HTML)) %>%
  
  addLegend(pal = colorPalette, values = covidData$Cumulative_cases, opacity=0.9, title = "Cases", position = "bottomleft")


