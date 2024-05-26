# 
function(input, output, session) {
  
  # filter survey data ----
  filtered_milkweed_df <- reactive ({
    
    milkweed_survey_data |>
      filter(milkweed_sp %in% c(input$species_type_input))
    
  })
  
    # build leaflet map for survey locations ----
    output$survey_map_output <- renderLeaflet({

      # set colors for each species, colors will be assigned in the order they are provided as related between palette and levels
      pal <- colorFactor(palette = c("#99DDFF", "#785EF0", "#DC267F", "#FE6100"), 
                    levels = c("Asclepias californica", "Asclepias eriocarpa", "Asclepias erosa", "Asclepias vestita"),
                    domain = filtered_milkweed_df()$milkweed_sp)
 
        # initialize leaflet
        leaflet() %>% 
          
          # add Esri World terrain basemap
          addProviderTiles(providers$Esri.WorldTerrain) %>%
          
          # add markers for each species selected
          addCircleMarkers(data = filtered_milkweed_df(),
                           radius = 4,
                           weight = 1,
                           fillColor = ~pal(eval(filtered_milkweed_df()$milkweed_sp)),
                           color = "black",
                           opacity = 1,
                           fillOpacity = 0.8
                           ) %>%
          
          # add lpnf boundary polygon
          addPolygons(data = lpnf_boundary,
                      fill = FALSE,
                      color = "black",
                      weight = 2) %>%
          
          # format legend to show species and the associated color when selected
          leaflet::addLegend("topright", pal = pal, values = filtered_milkweed_df()$milkweed_sp,
                             title = "Milkweed Species",
                             opacity = 0.8) %>% 
          
           # set view over LPNF
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

      # initialize leaflet 
      leaflet() %>%
        
        # add Esri World terrain basemap
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add raster layer that is selected by the user
        addRasterImage(filtered_access_raster(), colors = pal_access) %>% 
        
        # add lpnf boundary polygon 
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
        
        # add Esri World terrain basemap
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add raster layer that is selected by the user
        addRasterImage(filtered_priority_raster(), colors = pal_priority) %>% 
        
        # add lpnf boundary polygon 
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
            buttons = c('csv', 'excel'))) %>%
        formatRound(3:7, digits = 3) %>%
        formatRound(1:2, digits = 5) 
      
    })
    
}

