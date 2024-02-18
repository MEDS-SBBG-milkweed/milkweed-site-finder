#........................dashboardHeader.........................
header <- dashboardHeader(
  
  # add title ----
  title = "Milkweed Habitat in Los Padres National Forest",
  titleWidth = 400
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar( width = 300,
                             
                             # sidebarMenu ----
                             sidebarMenu(
                               
                               tags$a(href = "https://sbbotanicgarden.org/",
                               tags$img(src = "santa-barbara-botanic-garden.jpeg", 
                                        alt = "The logo of the santa barabara botanic garden with a white background and green image.",
                                        style = "max-width: 100%;")),
                               tags$h6(tags$em("Source:", tags$a(href = "https://sbbotanicgarden.org/", "SBBG")),
                                       style = "text-align: center;"),
                               
                               menuItem(text = "Home", tabName = "home", icon = icon("house-user")),
                               menuItem(text = "Milkweed Locations", tabName = "milkweedloc", icon = icon("location-dot")),
                               menuItem(text = "Habitat Suitability Model", tabName = "habitatsuit", icon = icon("leaf")),
                               menuItem(text = "Site Accessibility", tabName = "siteaccess", icon = icon("universal-access")),
                               menuItem(text = "Site Finder", tabName = "sitefinder", icon = icon("magnifying-glass-location")),
                               menuItem(text = "Data", tabName = "data", icon = icon("database"))
                               
                             ) # END sidebarMenu
                             
) # END dashboardSidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "home",
            
            # left-hand column ----
            column(width = 6,
                   
                   # background info box ----
                   box(width = NULL,
                       
                       "background info here, use markdown text for this "
                       
                   ), # END background info box
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         
                         "data information? or should we make a new tab?, use markdown text for this"
                         
                     ) # END data source box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         "disclaimer here, use markdown text here"
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END welcome tabItem
    
    # milkweed locations tabItem ----
    tabItem(tabName = "milkweedloc",
            
            # milkweed locations info box ----
            box(width = NULL,
                
                "description for what map is showing, use markdown text for this "
                
            ), # END milkweed locations info box
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "species selector pickerInput here"
                  
              ), # END input box
              
            ), # END fluid row
            
            # fluid row ----
            fluidRow(
              
              # leaflet box ----
              box(width = 8,
                  
                  "leaflet output here, with markers showing centroids of site surveys that have occurred"
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
            
    ), # END milkweed locations tabItem
    
    # habitat suitability tabItem ----
    tabItem(tabName = "habitatsuit",
            
            # habitat suitability info box ----
            box(width = NULL,
                
                "description for what model is showing and instructions for slider inputs, use markdown text for this "
                
            ), # END habitat suitability info box
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "species pickerInput here, message indicating you must choose 1 species"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  "model output here showing modeled habitat suitability here"
                  
              ), # END leaflet box
              
            ), # END fluidRow 1
            
            # second fluidRow ----
            fluidRow(
              
              # model parameter box ----
              box(width = 12,
                  
                  "model parameters used to calculate this model"
                  
              ) # END model parameter box
              
            ) # END fluidRow 2
            
    ), # END habitat suitability tabItem
    
    
    # site access tabItem ----
    tabItem(tabName = "siteaccess",
            
            # site access info box ----
            box(width = NULL,
                
                "description for what model is showing and instructions for pickerInput, use markdown text for this "
                
            ), # END habitat suitability info box
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "pickerInput here, have model output pre-selected and user can choose whether they want to categorize by roads or by trail access"
                  
              ) # END input box
              
            ), # END fluidRow
            
            # fluidRow ----
            fluidRow(
              
              # leaflet box ----
              box(width = 8,
                  
                  "model output here, with site access model applied to map of Los Padres NF"
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ), # END site access locations tabItem
    
    # sitefinder tabItem ----
    tabItem(tabName = "sitefinder",
            
            # sitefinder info box ----
            box(width = NULL,
                
                "description for what map is showing and what inputs needs to be entered, use markdown text for this "
                
            ), # END sitefinder info box
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "species pickerInput here, user must select at least 1 species"
                  
              ), # END input box
              
              # input box ----
              box(width = 4,
                  
                  "accessibility sliderInputs here, user must enter index number for accessibility"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  "interactive map here that you can zoom to the area you want soecified"
                  
              ) # END leaflet box
              
            ), # END fluidRow
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "reactive datatable output here that lists coordinates based off of zoom and slider inputs"
                  
              ) # END input box
              
            ) # END fluidRow
            
    ), # END sitefinder locations tabItem
    
    # data tabItem ----
    tabItem(tabName = "data",
            
            # data info box ----
            box(width = NULL,
                
                "data information here, and information about technical documentation, use markdown text for this"
                
            ) # END data info box
            
    ) # END data tabItem
    
  ) # END tabItems
  
) # END dashboardBody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)