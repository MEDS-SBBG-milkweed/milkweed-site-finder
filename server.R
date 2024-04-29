# 
function(input, output, session) {

    # filter survey data ----
    filtered_milkweed_df <- reactive ({

      milkweed_survey_data |>
        filter(mlkwd_s %in% c(input$species_type_input))

    })
    
    # build leaflet map for survey locations ----
    output$survey_map_output <- renderLeaflet({

      # set colors for each species
      pal <- colorFactor(palette = c("#F9761D", "#D6566B", "#822681", "#3D358B"), 
                    levels = c("Asclepias californica", "Asclepias vestita", "Asclepias eriocarpa", "Asclepias erosa"),
                    domain = filtered_milkweed_df()$mlkwd_s)
 
        leaflet() %>% 
          addProviderTiles(providers$Esri.WorldTerrain) %>%
          
          # add markers
          addCircleMarkers(data = filtered_milkweed_df(),
                           radius = 2,
                           color = ~pal(filtered_milkweed_df()$mlkwd_s),
                           fill = TRUE,
                           fillColor = ~pal(eval(filtered_milkweed_df()$mlkwd_s)),
                           opacity = 0.8) %>%
          
          # add polygons
          addPolygons(data = lpnf_boundary,
                      fill = FALSE,
                      color = "black",
                      weight = 2) %>%
          
          # format legend
          leaflet::addLegend("topright", pal = pal, values = filtered_milkweed_df()$mlkwd_s,
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


      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add markers
        addRasterImage(filtered_access_raster())
        
        # format legend
        # leaflet::addLegend("bottomleft", pal = filtered_access_raster(), values = filtered_access_raster(),
        #                    title = "filtered_access_raster()",
        #                    opacity = 0.8) 

    })
    
    # filter priority sites info data ----
    filtered_priority_raster <- reactive ({
      
      priority_stack %>% 
        raster::subset(input$priority_species_input)
      
    })
    
    # build leaflet map for site accessibility raster layers ----
    output$priority_species_output <- renderLeaflet({
      
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain) %>%
        
        # add markers
        addRasterImage(filtered_priority_raster())
      
    })
    
    # build leaflet map for site accessibility raster layers ----
    output$priority_species_table <- DT::renderDataTable({

        DT::datatable(
          priority_stack_df,
          extensions = 'Buttons', 
          options = list(scrollX=TRUE, lengthMenu = c(5,10,15),
                         paging = TRUE, searching = TRUE,
                         fixedColumns = TRUE, autoWidth = TRUE,
                         ordering = TRUE, dom = 'tB',
                         buttons = c('copy', 'csv', 'excel','pdf')))
      
    })
    
    # # download button on site finder
    # output$downloadData <- downloadHandler(
    #   filename = function() { 
    #     paste("dataset-", Sys.Date(), ".csv", sep="")
    #   },
    #   content = function(file) {
    #     write.csv(mtcars, file)
    #   })
}

