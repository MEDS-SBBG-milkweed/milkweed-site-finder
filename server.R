# 
function(input, output, session) {
  
  # change_window_title(session, "Milkweed Site Finder")
  
  # filter survey data ----
  filtered_milkweed_df <- reactive ({
    
    milkweed_survey_data |>
      filter(milkweed_sp %in% c(input$species_type_input))
    
  })
  
    # build leaflet map for survey locations ----
    output$survey_map_output <- renderLeaflet({

      # set colors for each species
      pal <- colorFactor(palette = c("#99DDFF", "#785EF0", "#DC267F", "#FE6100"), 
                    levels = c("Asclepias californica", "Asclepias eriocarpa", "Asclepias erosa", "Asclepias vestita"),
                    domain = filtered_milkweed_df()$milkweed_sp)
 
        leaflet() %>% 
          addProviderTiles(providers$Esri.WorldTerrain) %>%
          
          # add markers
          addCircleMarkers(data = filtered_milkweed_df(),
                           radius = 4,
                           weight = 1,
                           fillColor = ~pal(eval(filtered_milkweed_df()$milkweed_sp)),
                           color = "black",
                           opacity = 1,
                           fillOpacity = 0.8
                           ) %>%
          
          # add polygons
          addPolygons(data = lpnf_boundary,
                      fill = FALSE,
                      color = "black",
                      weight = 2) %>%
          
          # format legend
          leaflet::addLegend("topright", pal = pal, values = filtered_milkweed_df()$milkweed_sp,
                             title = "Milkweed Species",
                             opacity = 0.8) %>% 
          
           # set view over LPNF # default appears to be best option so far
           setView(lng = -119.547729, lat = 34.556335, zoom = 6.5) %>% 
        
          addScaleBar()
      
    })
    
    # filter raster site accessibility info data ----
    filtered_access_raster <- reactive ({

      stack %>% 
        raster::subset(input$accessibility_layer_input) 

    })

    # build leaflet map for site accessibility raster layers ----
    output$accessibility_layer_output <- renderLeaflet({

      # initialize leaflet map
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add markers
        addRasterImage(filtered_access_raster(), colors = pal_access) %>% 
        
        #add boundary polygon 
        addPolygons(data = lpnf_boundary, fill = FALSE,
                    weight = 2, color = "black", group = 'xfer')

    })
    
    # filter priority sites info data ----
    filtered_priority_raster <- reactive ({
      
      priority_stack %>% 
        raster::subset(input$priority_species_input) 
        
    })
    
    # build leaflet map for site priority raster layers ----
    output$priority_species_output <- renderLeaflet({
      
      # initialize leaflet
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add rasterImage with designated color scale
        addRasterImage(filtered_priority_raster(), colors = pal_priority) %>% 
        
        #add boundary polygon 
        addPolygons(data = lpnf_boundary, fill = FALSE,
                    weight = 2, color = "black", group = 'xfer')
      
    })
    
    # data table for priority sites ----
    output$priority_species_table <- DT::renderDataTable({

        DT::datatable(
          priority_datatable,
          extensions = c('Buttons'), 
          options = list(
            scrollX=TRUE,
            scrollY="300px",
            paging = FALSE,
            searching = TRUE,
            fixedColumns = TRUE,
            autoWidth = FALSE,
            ordering = TRUE,
            dom = 'Bfrtip',
            buttons = list(list(extend = 'csv', filename = 'Milkweed Site Finder Locations')))) %>%
        formatRound(3:7, digits = 3) %>%
        formatRound(1:2, digits = 5) 
      
    })
    
}

