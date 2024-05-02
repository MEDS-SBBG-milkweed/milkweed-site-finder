# web-dashboard

## Project Description
The web-dashboard repository contains all of the R code in order to build the interactive web dashboard to facilitate field survey planning for the Santa Barbara Botanic Garden staff.

## Data
All data products hosted in this dashboard can be found in the [milkweed-mod](https://github.com/milkweed-mod/milkweed-mod) repository within the milkweed-mod Github organization. 

## Repository Table of Contents
```
|── data_processed
│   ├── lpnf_boundary
│   │   └── lpnf_boundary_buffered
│   │       ├── lpnf_boundary_buffered.dbf
│   │       ├── lpnf_boundary_buffered.prj
│   │       ├── lpnf_boundary_buffered.shp
│   │       └── lpnf_boundary_buffered.shx
│   ├── sdm_outputs
│   	└──californica_bioclim_canopy_solar.qmd
│   	 ├── eriocarpa_bioclim_canopy_solar.qmd
│   	 ├── erosa_bioclim_canopy_solar.qmd
│   	 └── vestita_bioclim_canopy_solar.qmd
│   ├── site_accessibility_outputs
│   └── survey_locations
│       └── survey_location_centroids
│           ├── all_species_points.dbf
│           ├── all_species_points.prj
│           ├── all_species_points.shp
│           └── all_species_points.shx
├── global.R
├── R
│   └── addLegend_decreasing.R
├── raw_data
├── README.md
├── server.R
├── text
│   ├── background-info.md
│   ├── disclaimer.md
│   ├── overview-data.md
│   ├── overview-habitat-suitability.md
│   ├── overview-milkweed-locations.md
│   ├── overview-site-accessibility.md
│   └── overview-site-finder.md
├── ui.R
├── web-dashboard.Rproj
└── www
    ├── fonts
    │   ├── 5cfb33b712cbdaf9310b.woff2
    │   ├── ab9aea6faeaea5115410.woff2
    │   ├── bace964bccc02d90d74e.woff2
    │   ├── da1fdeda6d5756ee6227.ttf
    │   ├── ebec98131cf900cb698e.woff2
    │   └── edfac2e6370304cd74ae.woff2
    ├── green-logo-zoom.png
    ├── monarch_milkweed.jpeg
    ├── santa-barbara-botanic-garden.jpeg
    ├── sass-style.css
    ├── sass-style.scss
    └── SBBG_workcard-projects-1.jpg
