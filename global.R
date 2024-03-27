# load packages
library(shiny)
library(leaflet)
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
milkweed_data_raw <- st_read(here("~/../../capstone/milkweedmod/data/milkweed_polygon_data/"))

# California National Forest boundaries
boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/S_USA_AdministrativeForest.gdb/"))
trails <- st_read(here("~/../../capstone/milkweedmod/data/2023_Regional_Trails_and_Roads_lines/2023_Regional_Trails_and_Roads_lines.shp"))


# filter boundary
lpnf_boundary <- boundary %>% 
  filter(FORESTNAME %in% c("Los Padres National Forest")) %>%
  st_transform("EPSG:4326")

# filter data for mapping
milkweed_map <- milkweed_data_raw |> 
  janitor::clean_names() |> 
  # st_transform(crs(envs_Ac)) %>%
  dplyr::select(milkweed_p, milkweed_sp) %>%
  st_centroid() %>%
  st_transform("EPSG:4326")

milkweed_yes <- milkweed_map %>%
  filter(milkweed_p == "yes",
         milkweed_sp != "Asclepias sp.")