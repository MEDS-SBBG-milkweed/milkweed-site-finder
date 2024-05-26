# milkweed-site-finder

 # **Identifying Priority Survey Sites for Early-Season Milkweed Conservation**

![image of milkweed mod logo which includes california, milkweed, and a butterfly drawing done by Sam Muir](https://github.com/MEDS-SBBG-milkweed/milkweed-site-finder/blob/main/figs/MilkweedMod.jpeg)

## Table of Contents

[Project Description](##project-description)

[Data](#data)

[Usage](#usage)

[Repository Structure](#repository-structure)

[Authors](#authors)

[Client](#client)

## Project Description
The milkweed-site-finder repository contains all of the R code in order to build the Rshiny interactive web dashboard to facilitate field survey planning for the Santa Barbara Botanic Garden staff for identifying high priority survey locations for early-season milkweed in the Los Padres National Forest (LPNF). For additional information regarding the milkweed-site-finder use please visit the technical documentation for this project
 
## Data
All data products hosted in this dashboard can be found in the [milkweed-mod](https://github.com/milkweed-mod/milkweed-mod) repository within the milkweed-mod Github organization. 

## Usage

The **Home** page of the RShiny dashboard contains background information about the project and links to where additional information about the code can be found. The homepage also contains a disclaimer as provided by the Forest Service regarding data collection.

[insert homepage here ]

The **Milkweed Locations** page of the RShiny dashboard contains information regarding the Santa Barbara Botanic Garden’s first year of field surveys. This information is displayed in a map in which a user can select the species or combinations  of early-season milkweed species they would like to see. This map indicates the general location a data point was collected at.

[insert milkweed locations here ]

The **Habitat Suitability Models** page of the RShiny dashboard contains information and the general approach used to create habitat suitability models for each of the four early-season milkweed species. These habitat suitability models are displayed as a heatmap in a grid pattern on this page to allow for visual comparison. Additionally, there is a map of maximum habitat suitability for all four species which represents the overall likelihood of finding any of the early-season milkweed across the LPNF.

[insert habitat suitability models here]

The **Survey Site Accessibility** page of the RShiny dashboard contains information and the general approach used to create a survey site accessibility index for the LPNF. The survey site accessibility index is displayed using two maps. The map on the left side of the dashboard page allows a user to select the layer of the site accessibility index they would like to examine. The map on the right side of the dashboard page shows the total site accessibility index for the LPNF.

[insert survey site accessibility here]

The **high-priority survey sites** page of the RShiny dashboard contains information and the general approach used to the create the survey site priority score for each species of early-season milkweed. The user is able to select which species they would like to visualize the survey site priority score across the LPNF for. Additionally, there is a data table at the bottom of the page which has a row for each raster cell of the LPNF that contains information about the Latitude, Longitude, Priority scores for each species, Site Accessibility Index score, as well as whether or not that location has been visited by the SBBG team. This datatable is able to be downloaded as a csv, or an excel file. 

[insert site finder here]

The **Data** page of the RShiny dashboard contains a general description, citation, and licensing information for the data used to create this project. 


<img src="https://github.com/MEDS-SBBG-milkweed/milkweed-site-finder/blob/main/figs/data.png" width="90" height="90"/>

## Repository Structure
```
├── data_processed
│   ├── lpnf_boundary
│   │   ├── lpnf_boundary.dbf
│   │   ├── lpnf_boundary.prj
│   │   ├── lpnf_boundary.shp
│   │   └── lpnf_boundary.shx
│   ├── priority_sites_outputs
│   │   ├── all_priority.tif
│   │   ├── californica_priority.tif
│   │   ├── eriocarpa_priority.tif
│   │   ├── erosa_priority.tif
│   │   ├── priority_datatable.csv
│   │   └── vestita_priority.tif
│   ├── site_accessibility_outputs
│   │   ├── access_index_final.tif
│   │   ├── canopy_rescaled.tif
│   │   ├── ownership_rescaled.tif
│   │   ├── roads_rescaled.tif
│   │   ├── slope_rescaled.tif
│   │   └── trails_rescaled.tif
│   └── survey_locations
│       └── survey_location_centroids
│           ├── all_species_points.dbf
│           ├── all_species_points.prj
│           ├── all_species_points.shp
│           └── all_species_points.shx
├── figs  # folder containing figures used in README.md
│   ├── data.png
│   ├── habitat_suitability_models.png
│   ├── high_priority.png
│   ├── home.png
│   ├── milkweed_locations.png
│   ├── MilkweedMod.jpeg
│   └── survey_site_accessibility.png
├── global.R
├── milkweed-site-finder.Rproj
├── R
│   └── addLegend_decreasing.R  # function to create legend in leaflet
├── README.md
├── rsconnect  # folder for app deployment
│   └── shinyapps.io
│       └── mwidas
│           └── milkweed-site-finder.dcf
├── server.R
├── session_info.txt  # session_info and operating system information
├── text  # folder containing all markdown files used and where text is stored
│   ├── background_context.md
│   ├── background_info.md
│   ├── disclaimer.md
│   ├── habitat_suitability_all.md
│   ├── overview_data.md
│   ├── overview_habitat_suitability.md
│   ├── overview_milkweed_locations.md
│   ├── overview_site_accessibility.md
│   ├── overview_site_finder.md
│   ├── siteaccess_legend.md
│   └── siteaccess_title.md
├── ui.R
└── www  # graphics folder
    ├── fonts
    │   ├── 5cfb33b712cbdaf9310b.woff2
    │   ├── ab9aea6faeaea5115410.woff2
    │   ├── bace964bccc02d90d74e.woff2
    │   ├── da1fdeda6d5756ee6227.ttf
    │   ├── ebec98131cf900cb698e.woff2
    │   └── edfac2e6370304cd74ae.woff2
    ├── green-logo-zoom.png
    ├── legends  # folder where legend files are stored
    │   ├── accessibility_legend.png
    │   ├── priority_legend.png
    │   └── suitability_legend.png
    ├── monarch_milkweed.jpeg
    ├── sass-style.css
    ├── sass-style.scss  # sass file for styling 
    └── SBBG_logo.png
```

## Authors

 Amanda Herbst { [Github](https://github.com/amandaherbst) | [Website](amandaherbst.github.io) | [LinkedIn](https://www.linkedin.com/in/amanda-herbst/) }

 Anna Ramji { [Github](https://github.com/annaramji) | [Website](https://annaramji.github.io/) | [LinkedIn](https://www.linkedin.com/in/annaramji/) }

 Melissa Widas { [Github](https://github.com/mwidas) | [Website](https://mwidas.github.io/) | [LinkedIn](https://www.linkedin.com/in/mwidas/) }

 Sam Muir { [Github](https://github.com/shmuir) | [Website](https://shmuir.github.io/) | [LinkedIn](https://www.linkedin.com/in/shmuir/) }

## Client
Dr. Sarah Cusser, Terrestrial Invertebrate Conservation Ecologist
Santa Barbara Botanic Garden
1212 Mission Canyon Rd.
Santa Barbara, CA 93105


