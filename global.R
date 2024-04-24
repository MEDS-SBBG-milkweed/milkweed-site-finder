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
milkweed_survey_data <- st_read("data_processed/survey_locations/survey_location_centroids/all_species_points.shp") %>% 
  filter(mlkwd_s != "Asclepias sp.") %>% 
  sf::st_transform('+proj=longlat +datum=WGS84')


# California National Forest boundaries
lpnf_boundary <- st_read("data_processed/lpnf_boundary/lpnf_boundary_buffered/")


# LOAD IN DATA FOR HABITAT SUITABILITY MODEL OUTPUTS ----
# Asclepias californica model
californica <- rast("data_processed/sdm_outputs/californica_sdm.tif")
# Asclepias eriocarpa model
eriocarpa <- rast("data_processed/sdm_outputs/eriocarpa_sdm.tif")
# Asclepias erosa model
erosa <- rast("data_processed/sdm_outputs/erosa_sdm.tif")
# Asclepias vestita model
vestita <- rast("data_processed/sdm_outputs/vestita_sdm.tif")
# Asclepias species model
all <- rast("data_processed/sdm_outputs/max_suitable_sdm.tif")

# load in legend functionality for leaflet models
source("R/addLegend_decreasing.R")



# LOAD Habitat Suitability Maps ----

# static californica output
# leaflet output
#Get values of prediction
mapPredVals_californica <- getRasterVals(californica) # change for different types
# 
# #Define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal_californica <- colorNumeric(rasCols, mapPredVals_californica, na.color = 'transparent')
rasPal_californica <- colorNumeric(rasCols, mapPredVals_californica, na.color = 'transparent')

californica_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_californica, values = mapPredVals_californica,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias californica</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  # clearMarkers() %>% clearShapes() %>% removeImage('xferRas') %>%
  addRasterImage(californica, colors = rasPal_californica, opacity = 0.7,
                 method = "ngb") %>% 
#add transfer polygon (user drawn area)
addPolygons(data = lpnf_boundary, fill = FALSE,
            weight = 2, color = "black", group = 'xfer')

# static eriocarpa output ----
# leaflet output
#Get values of prediction
mapPredVals_eriocarpa <- getRasterVals(eriocarpa) # change for different types
# 
# #Define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal_eriocarpa <- colorNumeric(rasCols, mapPredVals_eriocarpa, na.color = 'transparent')
rasPal_eriocarpa <- colorNumeric(rasCols, mapPredVals_eriocarpa, na.color = 'transparent')

eriocarpa_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_eriocarpa, values = mapPredVals_eriocarpa,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias eriocarpa</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  # clearMarkers() %>% clearShapes() %>% removeImage('xferRas') %>%
  addRasterImage(eriocarpa, colors = rasPal_eriocarpa, opacity = 0.7,
                 method = "ngb") %>% 
  #add transfer polygon (user drawn area)
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static vestita output ----
# leaflet output 
# get values of prediction
mapPredVals_vestita <- getRasterVals(vestita) # change for different types

# define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal_vestita <- colorNumeric(rasCols, mapPredVals_vestita, na.color = 'transparent')
rasPal_vestita <- colorNumeric(rasCols, mapPredVals_vestita, na.color = 'transparent')

vestita_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_vestita, values = mapPredVals_vestita,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias vestita</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  addRasterImage(vestita, colors = rasPal_vestita, opacity = 0.7,
                 method = "ngb") %>% 
  #add transfer polygon (user drawn area)
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static erosa output ----
# leaflet output 
# get values of prediction
mapPredVals_erosa <- getRasterVals(erosa) # change for different types

# define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal_erosa <- colorNumeric(rasCols, mapPredVals_erosa, na.color = 'transparent')
rasPal_erosa <- colorNumeric(rasCols, mapPredVals_erosa, na.color = 'transparent')

erosa_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_erosa, values = mapPredVals_erosa,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias erosa</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  addRasterImage(erosa, colors = rasPal_erosa, opacity = 0.7,
                 method = "ngb") %>% 
  #add transfer polygon (user drawn area)
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static all suitable output ----
# leaflet output 
# get values of prediction
mapPredVals_all <- getRasterVals(all) # change for different types

# define colors and legend  
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")

legendPal_all <- colorNumeric(rasCols, mapPredVals_all, na.color = 'transparent')
rasPal_all <- colorNumeric(rasCols, mapPredVals_all, na.color = 'transparent')

all_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_all, values = mapPredVals_all,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias species</em><br>Predicted Suitability<br>") %>%
  # map model prediction raster and transfer polygon
  addRasterImage(all, colors = rasPal_all, opacity = 0.7,
                 method = "ngb") %>% 
  #add transfer polygon (user drawn area)
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')



# LOAD IN DATA FOR Site Accessibility ----

# load roads data ----
Roads <- rast("data_processed/site_accessibility_outputs/roads.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load trails data ----
Trails <- rast("data_processed/site_accessibility_outputs/trails.tif") %>%
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load slope data ----
Slope <- rast("data_processed/site_accessibility_outputs/slope.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load land ownership data ----
Land <- rast("data_processed/site_accessibility_outputs/trails.tif") %>%
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load canopy cover data ----
Canopy <- rast("data_processed/site_accessibility_outputs/slope.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# rename raster layers so they retain their names within the raster stack
names(Canopy) <- "Canopy"
names(Land) <- "Land"
names(Roads) <- "Roads"
names(Trails) <- "Trails"
names(Slope) <- "Slope"

# create raster stack to iterate through
stack <- stack(Roads, Trails, Slope, Canopy, Land)

# LOAD IN DATA for Site Finder Priority Outputs ----
# Asclepias californica model
californica_priority <- rast("data_processed/priority_outputs/californica_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()
# Asclepias eriocarpa model
eriocarpa_priority <- rast("data_processed/priority_outputs/eriocarpa_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()
# Asclepias erosa model
erosa_priority <- rast("data_processed/priority_outputs/erosa_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()
# Asclepias vestita model
vestita_priority <- rast("data_processed/priority_outputs/vestita_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# rename raster layers so they retain their names within the raster stack
names(californica_priority) <- "Asclepias californica"
names(eriocarpa_priority) <- "Asclepias eriocarpa"
names(erosa_priority) <- "Asclepias erosa"
names(vestita_priority) <- "Asclepias vestita"

# create raster stack to iterate through
priority_stack <- stack(californica_priority, eriocarpa_priority, erosa_priority, vestita_priority)

# extract data frames from each species priorty output
priority_stack_df <- raster::as.data.frame(priority_stack, xy=TRUE) %>%
  rename(Longitude = x, Latitude = y) %>%
  drop_na()


# # california priority data table
# californica_priority_df <- raster::as.data.frame(californica_priority, xy=TRUE) %>%
#   rename(`Priority Score` = californica_sdm, Longitude = x, Latitude = y) %>%
#   drop_na() %>%
#   mutate("Species" = "A. californica")
# 
# # eriocarpa priority data table
# eriocarpa_priority_df <- raster::as.data.frame(eriocarpa_priority, xy=TRUE) %>%
#   rename(`Priority Score` = eriocarpa_sdm, Longitude = x, Latitude = y) %>%
#   drop_na() %>%
#   mutate("Species" = "A. eriocarpa")
# 
# # eriocarpa priority data table
# erosa_priority_df <- raster::as.data.frame(erosa_priority, xy=TRUE) %>%
#   rename(`Priority Score` = erosa_sdm, Longitude = x, Latitude = y) %>%
#   drop_na() %>%
#   mutate("Species" = "A. erosa")
# 
# # vestita priority data table
# vestita_priority_df <- raster::as.data.frame(vestita_priority, xy=TRUE) %>%
#   rename(`Priority Score` = vestita_sdm, Longitude = x, Latitude = y) %>%
#   drop_na() %>%
#   mutate("Species" = "A. vestita")
# 
