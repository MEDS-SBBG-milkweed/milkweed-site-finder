#........................load packages........................

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
library(raster)
library(scales)

#........................styling........................

# COMPILE CSS for styling ----
sass(
  input = sass_file("www/sass-style.scss"),
  output = "www/sass-style.css",
  # removes white-space & line-breaks that make css files more human-readable
  options = sass_options(output_style = "compressed")
)

# Set Spinner Options
options(spinner.type = 6, spinner.color = "#244E2A")

#........................Los Padres National Forest (LPNF) boundary data........................

# load in data for LPNF boundary ----
lpnf_boundary <- st_read("data_processed/lpnf_boundary/")


#.......................survey locations data........................

# load in data for milkweed survey locations
milkweed_survey_data <- read_rds("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/all_species_points.rda") %>% 
  filter(milkweed_sp != "Asclepias sp.") %>%
  sf::st_transform('+proj=longlat +datum=WGS84')


#........................Habitat Suitability Model data........................

# load in data for habitat suitability model outputs ----

# Asclepias californica model
californica <- rast("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/californica_sdm.tif")

# Asclepias eriocarpa model
eriocarpa <- rast("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/eriocarpa_sdm.tif")

# Asclepias erosa model
erosa <- rast("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/erosa_sdm.tif")

# Asclepias vestita model
vestita <- rast("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/vestita_sdm.tif")

# Asclepias species model
all <- rast("https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/max_suitable_sdm.tif")

# load in legend functionality for leaflet models
source("R/addLegend_decreasing.R")


#........................Habitat Suitability Model Maps........................

# load habitat suitability maps ----

# define colors and legend for habitat suitability maps
pal_habitat <- c("#FFFFFF", "#EFCCCC", "#DF9999", "#D06666", "#C03333", "#B00000")

# static californica output ----
# leaflet output
# get values of predictions for californica
mapPredVals_californica <- getRasterVals(californica) 

# set color palette of raster values to pal_habitat
rasPal_californica <- colorNumeric(pal_habitat, mapPredVals_californica, na.color = 'transparent')

# initialize leaflet with World Terrain basemap from Esri
californica_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%
  
  # add habitat suitability model raster
  addRasterImage(californica, colors = rasPal_californica,
                 method = "ngb") %>% 
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static eriocarpa output ----
# leaflet output
# get values of predictions for eriocarpa
mapPredVals_eriocarpa <- getRasterVals(eriocarpa) 

# set color palette of raster values to pal_habitat
rasPal_eriocarpa <- colorNumeric(pal_habitat, mapPredVals_eriocarpa, na.color = 'transparent')

# initialize leaflet with World Terrain basemap from Esri
eriocarpa_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%
  
  # add habitat suitability model raster
  addRasterImage(eriocarpa, colors = rasPal_eriocarpa,
                 method = "ngb") %>% 
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static vestita output ----
# leaflet output 
# get values of predictions for vestita
mapPredVals_vestita <- getRasterVals(vestita) 

# set color palette of raster values to pal_habitat
rasPal_vestita <- colorNumeric(pal_habitat, mapPredVals_vestita, na.color = 'transparent')

# initialize leaflet with World Terrain basemap from Esri
vestita_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%

  # add habitat suitability model raster
  addRasterImage(vestita, colors = rasPal_vestita,
                 method = "ngb") %>% 
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static erosa output ----
# leaflet output 
# get values of predictions for erosa
mapPredVals_erosa <- getRasterVals(erosa)

# set color palette of raster values to pal_habitat
rasPal_erosa <- colorNumeric(pal_habitat, mapPredVals_erosa, na.color = 'transparent')

# initialize leaflet with World Terrain basemap from Esri
erosa_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%

  # add habitat suitability model raster
  addRasterImage(erosa, colors = rasPal_erosa,
                 method = "ngb") %>% 
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')

# static all suitable output ----
# leaflet output 
# get values of predictions for the max suitability
mapPredVals_all <- getRasterVals(all)

# set legend and raster color palettes to pal_habitat
legendPal_all <- colorNumeric(pal_habitat, mapPredVals_all, na.color = 'transparent')
rasPal_all <- colorNumeric(pal_habitat, mapPredVals_all, na.color = 'transparent')

# initialize leaflet with World Terrain basemap from Esri
all_leaflet <- leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%
  addLegend_decreasing("bottomleft", pal = legendPal_all, values = mapPredVals_all,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "Predicted Suitability") %>%
  
  # add habitat suitability model raster
  addRasterImage(all, colors = rasPal_all,
                 method = "ngb") %>% 
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')


#........................Site Accessibility Data........................

# load in data for Site Accessibility ----

# load total site accessibility data ----
index <- rast("data_processed/site_accessibility_outputs/access_index_final.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load roads data ----
Roads <- rast("data_processed/site_accessibility_outputs/roads_rescaled.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load trails data ----
Trails <- rast("data_processed/site_accessibility_outputs/trails_rescaled.tif") %>%
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load slope data ----
Slope <- rast("data_processed/site_accessibility_outputs/slope_rescaled.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load land ownership data ----
Land <- rast("data_processed/site_accessibility_outputs/ownership_rescaled.tif") %>%
  project('+proj=longlat +datum=WGS84') %>% 
  raster() %>% 
  mask(lpnf_boundary)

# load canopy cover data ----
Canopy <- rast("data_processed/site_accessibility_outputs/canopy_rescaled.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()


#........................Site Accessibility Raster Stack........................

# rename raster layers so they retain their names within the raster stack
names(Canopy) <- "Canopy"
names(Land) <- "Land"
names(Roads) <- "Roads"
names(Trails) <- "Trails"
names(Slope) <- "Slope"

# create raster stack to iterate through for site accessibility layers
stack <- stack(Roads, Trails, Slope, Canopy, Land)

#........................Total Site Accessibility Map........................

# define colors and legend for site accessibility
pal_access <- leaflet::colorNumeric(palette = c("#FFFFFF","#CCD4EF", "#99A9DF", "#667FD0", "#3354C0", "#0029B0"),
                                   domain = NULL,
                                   na.color = "transparent")

# static total accessibility index output ----
# leaflet output 
# initialize leaflet 
accessibility_index_leaflet <- leaflet() %>%
  
  # add Esri Wrold terrain basemap
  addProviderTiles(providers$Esri.WorldTerrain) %>%

  # add site accessibility index raster
  addRasterImage(index, colors = pal_access,
                 method = "ngb") %>%
  
  # add lpnf boundary polygon
  addPolygons(data = lpnf_boundary, fill = FALSE,
              weight = 2, color = "black", group = 'xfer')


#........................High Priority Site Data........................
# load in data for Site Finder Priority Outputs ----

# load in Asclepias californica priority raster
californica_priority <- rast("data_processed/priority_sites_outputs/californica_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load in Asclepias eriocarpa priority raster
eriocarpa_priority <- rast("data_processed/priority_sites_outputs/eriocarpa_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load in Asclepias erosa priority raster
erosa_priority <- rast("data_processed/priority_sites_outputs/erosa_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

# load in Asclepias vestita priority raster
vestita_priority <- rast("data_processed/priority_sites_outputs/vestita_priority.tif") %>% 
  project('+proj=longlat +datum=WGS84') %>% 
  raster()

#........................High Priority Site Raster Stack........................

# rename raster layers so they retain their names within the raster stack
names(californica_priority) <- "Asclepias californica"
names(eriocarpa_priority) <- "Asclepias eriocarpa"
names(erosa_priority) <- "Asclepias erosa"
names(vestita_priority) <- "Asclepias vestita"

# create raster stack to iterate through for priority outputs
priority_stack <- stack(californica_priority, eriocarpa_priority, erosa_priority, vestita_priority)

#........................High Priority Site Data Table........................

# extract data frames from each species priorty output
priority_datatable <- read_csv("data_processed/priority_sites_outputs/priority_datatable.csv")

#........................High Priority Site Maps........................

# define color palette to be used for priority sites
pal_priority <- leaflet::colorNumeric(palette = c("#FFFFFF", "#E1CCEF", "#C399DF", "#A666D0", "#8833C0", "#6A00B0"),
                             domain = NULL,
                             na.color = "transparent")

