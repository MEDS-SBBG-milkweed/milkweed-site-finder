#........................dashboardHeader.........................
header <- dashboardHeader(
  
  # add title ----
  title = "Milkweed Habitat in Los Padres National Forest",
  titleWidth = 400
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Home", tabName = "home", icon = icon("house-user")),
    menuItem(text = "Milkweed Locations", tabName = "milkweedloc", icon = icon("location-dot")),
    menuItem(text = "Habitat Suitability Model", tabName = "habitatsuit", icon = icon("leaf")),
    menuItem(text = "Site Accessibility", tabName = "siteaccess", icon = icon("universal-access")),
    menuItem(text = "Site Finder", tabName = "sitefinder", icon = icon("magnifying-glass-location"))
    
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
                       
                       "background info here"
                       
                   ), # END background info box
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         
                         "data citation here"
                         
                     ) # END data source box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         "disclaimer here"
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "milkweedloc",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "species selector sliderInputs here"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  "leaflet output here"
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
            
    ) # END dashboard tabItem
    
  ) # END tabItems
  
) # END dashboardBody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)