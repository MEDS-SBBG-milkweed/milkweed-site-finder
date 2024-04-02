# Define server logic required to draw a histogram
function(input, output, session) {

    # filter survey data ----
    filtered_milkweed_df <- reactive ({

      milkweed_yes |>
        filter(milkweed_sp %in% c(input$species_type_input))

    })
    
    # build leaflet map ----
    output$survey_map_output <- renderLeaflet({
      
      # map elements
      colors <- c("Asclepias californica" = "#F9761D","Asclepias vestita" = "#D6566B","Asclepias eriocarpa" = "#822681","Asclepias erosa" = "#3D358B")
      pal <- colorFactor(colors, domain =filtered_milkweed_df()$milkweed_sp, reverse = TRUE)
      
      
      leaflet() %>% 
        addProviderTiles(providers$Esri.WorldTopoMap) %>%
        
        # add markers
        addCircleMarkers(data = filtered_milkweed_df(),
                         radius = 2,
                         color = ~pal(filtered_milkweed_df()$milkweed_sp),
                         fill = TRUE,
                         fillColor = ~pal(filtered_milkweed_df()$milkweed_sp),
                         opacity = 0.8) %>%
             
        # add polygons
        addPolygons(data = lpnf_boundary,
                    fill = FALSE,
                    color = "black",
                    weight = 2) %>%
        
        # format legend
        leaflet::addLegend("topright", pal = pal, values = filtered_milkweed_df()$milkweed_sp,
                           title = "Milkweed Species",
                           opacity = 0.8) %>%
        addScaleBar()
      
    })
    
}

