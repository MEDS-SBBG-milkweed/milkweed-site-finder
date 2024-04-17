# 
function(input, output, session) {

    # filter survey data ----
    filtered_milkweed_df <- reactive ({

      milkweed_survey_data |>
        filter(mlkwd_s %in% c(input$species_type_input))

    })
    
    # build leaflet map for survey locations ----
    output$survey_map_output <- renderLeaflet({
     
      colors <- c("Asclepias californica" = "#F9761D", "Asclepias vestita" = "#D6566B", "Asclepias eriocarpa" = "#822681", "Asclepias erosa" = "#3D358B")

      pal <- colorFactor(colors, domain = filtered_milkweed_df()$mlkwd_s)
 
        leaflet() %>% 
          addProviderTiles(providers$Esri.WorldTopoMap) %>%
          
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
    
    # download button on site finder
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste("dataset-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(mtcars, file)
      })
    

    # filter raster info data ----
    filtered_access_raster <- reactive ({

      stack %>% 
        raster::subset(input$accessibility_layer_input)

    })

    # build leaflet map for site accessibility raster layers ----
    output$accessibility_layer_output <- renderLeaflet({


      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTopoMap) %>%
        
        # add markers
        addRasterImage(filtered_access_raster())

    })
    
    
}

