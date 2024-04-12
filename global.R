# load packages
library(shiny)
library(leaflet)
library(wallace)
library(shinydashboard)
library(shinycssloaders)
library(DT)
library(markdown)
library(fontawesome)
library(shinyWidgets)
library(sass)
library(tidyverse)
library(janitor)
library(sf)
library(terra)
library(ggspatial)
library(here)
library(basemaps)

# COMPILE CSS ----
sass(
  input = sass_file("www/sass-style.scss"),
  output = "www/sass-style.css",
  options = sass_options(output_style = "compressed") # OPTIONAL, but speeds up page load time by removing white-space & line-breaks that make css files more human-readable
)

# LOAD IN DATA FOR LEAFLET SURVEY LOCATIONS ----
# survey data
milkweed_survey_data <- st_read("data_processed/survey_locations/survey_location_centroids/")

# California National Forest boundaries
lpnf_boundary <- st_read("data_processed/lpnf_boundary/lpnf_boundary_buffered/")


# LOAD IN DATA FOR HABITAT SUITABILITY MODEL OUTPUTS ----
# Asclepias Californica model
californica <- rast("data_processed/sdm_outputs/californica_bioclim_canopy_dem.tif")

# static californica output
# leaflet output ----
#Get values of prediction
mapPredVals_Ac <- getRasterVals(californica) # change for different types
# 
# #Define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')
rasPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')

californica_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  # addLegend_decreasing("bottomleft", pal = legendPal, values = mapXferVals_Ac, layerId = "xfer",
  #                      labFormat = reverseLabel(), decreasing = FALSE,
  #                      title = "<em>Asclepias californica</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  # clearMarkers() %>% clearShapes() %>% removeImage('xferRas') %>%
  addRasterImage(californica, colors = rasPal, opacity = 0.7,
                 method = "ngb") %>% 
##add transfer polygon (user drawn area)
addPolygons(data = lpnf_boundary, fill = FALSE,
            weight = 2, color = "black", group = 'xfer')
# addCircleMarkers(data = occs_Ac, lat = ~latitude, lng = ~longitude,
#                  radius = 2, color = 'black', fill = TRUE, fillColor = "black",
#                  fillOpacity = 0.2, weight = 2) %>%

