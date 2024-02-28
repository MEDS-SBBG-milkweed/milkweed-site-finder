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

# COMPILE CSS ----
sass(
  input = sass_file("www/sass-style.scss"),
  output = "www/sass-style.css",
  options = sass_options(output_style = "compressed") # OPTIONAL, but speeds up page load time by removing white-space & line-breaks that make css files more human-readable
)
