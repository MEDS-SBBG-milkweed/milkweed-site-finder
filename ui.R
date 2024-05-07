#........................dashboardHeader.........................
header <- dashboardHeader(
  
  # add title ----
  title = "Milkweed Habitat in the Los Padres National Forest",
  titleWidth = 270
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar( width = 300,
                             
                             # sidebarMenu ----
                             sidebarMenu(
                               
                               tags$a(href = "https://sbbotanicgarden.org/",
                               tags$img(src = "SBBG_workcard-projects-1.jpg", 
                                        alt = "The logo of the santa barabara botanic garden with a white background and green image.",
                                        style = "max-width: 100%;")),
                               menuItem(text = "Home", tabName = "home", icon = icon("house-user")),
                               menuItem(text = "Milkweed Locations", tabName = "milkweedloc", icon = icon("location-dot")),
                               menuItem(text = "Milkweed Habitat Suitability", tabName = "habitatsuit", icon = icon("leaf")),
                               menuItem(text = "Survey Site: Accessibility", tabName = "siteaccess", icon = icon("universal-access")),
                               menuItem(text = "Survey Site: Finder", tabName = "sitefinder", icon = icon("magnifying-glass-location")),
                               menuItem(text = "Data", tabName = "data", icon = icon("database"))
                               
                             ) # END sidebarMenu
                             
) # END dashboardSidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # link stylesheet
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sass-style.css"),
  ),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "home",
            
            
            # first fluid row ----
            fluidRow(
              
              # background info box ----
              box(width = 12,
                  
                  title = tags$h1("Welcome to the Milkweed Site Finder Dashboard"),
                  
                  # insert image of milkweed
                  tags$img(src = "monarch_milkweed.jpeg", 
                           alt = "Imqage of a monarch butterfly on a milkweed plant.",
                           style = "max-width: 100%;"),
                  tags$h6(tags$em(tags$h6(href = "https://www.nps.gov/articles/000/milkweed-and-monarchs.htm", "Yehyun Kim, Friends of Acadia.")),
                          style = "text-align: left;"), # END image of milkweed
                  
                  includeMarkdown("text/background_info.md")
                  
              ) # END background info box
              
            ), # END first fluid row
            
            # second fluidRow ----
            fluidRow(
              
              # disclaimer box ----
              box(width = 12,
                  
                  title = tagList(icon("triangle-exclamation")),
                  includeMarkdown("text/disclaimer.md")
                  
              ) # END disclaimer box
              
            ) # END second fluidRow
            
    ), # END welcome tabItem
    
    # milkweed locations tabItem ----
    tabItem(tabName = "milkweedloc",
            
            # milkweed locations info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_milkweed_locations.md"),
              
            ), # END milkweed locations info box
            
            # milkweed locations sidebar layout
            sidebarLayout(
              
              
              sidebarPanel(
                
                width = 12,
                # species type checkbox Group Buttons ----
                checkboxGroupButtons(inputId = "species_type_input", label = "Select milkweed species:",
                                     choiceNames = c("<em>Asclepias californica</em>", 
                                                     "<em>Asclepias vestita</em>", 
                                                     "<em>Asclepias eriocarpa</em>", 
                                                     "<em>Asclepias erosa</em>"),
                                     choiceValues = c("Asclepias californica", 
                                                      "Asclepias vestita", 
                                                      "Asclepias eriocarpa", 
                                                      "Asclepias erosa"),
                                     # select = "Asclepias californica", 
                                     individual = TRUE,
                                     justified = FALSE,
                                     size = "normal",
                                     direction = "horizontal",
                                     checkIcon = list(yes = icon("circle-check", lib = "font-awesome"), 
                                                      no = icon("circle", lib = "font-awesome"))), #  END checkboxGroupInput for species type
              ),
              
              # leaflet box ----
              box(width = 12,
                  
                  title = tags$strong("Milkweed Survey Locations from 2023 surveys:"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "survey_map_output") %>%  
                    withSpinner()
                  
              ) # END leaflet box
              
            )
            
    ), # END milkweed locations tabItem
    
    # habitat suitability tabItem ----
    tabItem(tabName = "habitatsuit",
            
            # habitat suitability info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_habitat_suitability.md"),
                
                # insert image of milkweed
                tags$img(src = "suitability_legend.png", 
                         alt = "Image depicting color gradient of white to red for legend. White depicting the least likely for habitat suitability",
                         style = "max-width: 100%;")
                
                
            ), # END habitat suitability info box
            
            
            # fluidRow 1 ----
            fluidRow(
              
              # californica model output ----
              # leaflet box 1 ----
              box(width = 6,
                  
                  title = tags$em("Asclepias californica:"),
                  
                  #leaflet output for californica ----
                  californica_leaflet
                  
                  
              ), # END leaflet box 1
              
              # californica model output ----
              # leaflet box 2 ----
              box(width = 6,
                  
                  title = tags$em("Asclepias eriocarpa:"),
                  
                  #leaflet output for californica ----
                  eriocarpa_leaflet
                  
                  
              ), # END leaflet box 2
              
            ), # END FluidRow 1
            
            # FluidRow 2 ----
            fluidRow(
              
              # californica model output ----
              # leaflet box 3 ----
              box(width = 6,
                  
                  title = tags$em("Asclepias vestita:"),
                  
                  #leaflet output for californica ----
                  vestita_leaflet
                  
              ), # END leaflet box 3
              
              # californica model output ----
              # leaflet box 4 ----
              box(width = 6,
                  
                  title = tags$em("Asclepias erosa:"),
                  
                  #leaflet output for californica ----
                  erosa_leaflet
                  
                  
              ) # END leaflet box 4
              
            ), # END FluidRow2
            
            # habitat suitability info box ----
            box(width = NULL,
                
                # replace this with text that describes what all the plots together
                includeMarkdown("text/habitat_suitability_all.md")
                
            ),
            
            # fluidRow 3 ----
            fluidRow(
            
            # leaflet box 4 ----
            box(width = 12,
                
                title = tags$em("Asclepias sp:"),
                
                #leaflet output for all of the species ----
                all_leaflet
                
                
            ) # END leaflet box 4
            
            ) # END fluid row3
            
         
    ), # END habitat suitability tabItem
    
    
    # site access tabItem ----
    tabItem(tabName = "siteaccess",
            
            # site access info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_site_accessibility.md")
                
            ), # END habitat suitability info box
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 6,
                  
                  # species type checkbox Group Buttons ----
                  radioGroupButtons(inputId = "accessibility_layer_input", label = "Select which layer of the accessibility index you would like to examine for the map on the left of the screen:",
                                       choiceNames = c("Distance From Trails", "Distance From Roads", "Vegetation Density", "Land Ownership", "Slope"),
                                       choiceValues = c("Trails", "Roads", "Canopy", "Land", "Slope"),
                                       selected = "Roads", 
                                       individual = TRUE,
                                       justified = FALSE,
                                       size = "normal",
                                       direction = "horizontal",
                                       checkIcon = list(yes = icon("circle-check", lib = "font-awesome"), 
                                                        no = icon("circle", lib = "font-awesome"))), #  END radioGroupButtons for accessibility layer
              
              ), # END input box
              
              # input box ----
              box(width = 6,
                  
                  includeMarkdown("text/siteaccess_title.md")
              
              ) # END input box
              
            ), # END fluidRow
            
            fluidRow(
              
            # input box ----
            box(width = NULL,
                
                # insert image of accessibility legend which lives in www folder
                tags$img(src = "accessibility_legend.png", 
                         alt = "Image depicting color gradient of white to blue for legend. White depicting the least likely for survey site accessibility",
                         style = "max-width: 100%;")
                
                )# END input box
              
            ), # END fluidRow
          
            
            # fluidRow ----
            fluidRow(
              
              # leaflet box 1 with accessibility index ----
              box(width = 6,
                  
                  # "model output here, with site access model applied to map of Los Padres NF" ----
                  leafletOutput(outputId = "accessibility_layer_output") %>%  
                    withSpinner()
                  
              ), # END leaflet box
              
              # leaflet box 2 with static index loaded
              box(width = 6,
                  
                  # site accessibility index applied to map of Los Padres NF
                  accessibility_index_leaflet
                  
              ), # END box with static leaflet
              
            ) # END fluidRow
            
    ), # END site access locations tabItem
    
    # sitefinder tabItem ----
    tabItem(tabName = "sitefinder",
            
            # sitefinder info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_site_finder.md")
                
            ), # END sitefinder info box
              
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 12,
    
                  # species type checkbox Group Buttons ----
                  radioGroupButtons(inputId = "priority_species_input", label = "Select milkweed species:",
                                       choiceNames = c("<em>Asclepias californica</em>", "<em>Asclepias vestita</em>", "<em>Asclepias eriocarpa</em>", "<em>Asclepias erosa</em>"),
                                       choiceValues = c("Asclepias.californica", "Asclepias.vestita", "Asclepias.eriocarpa", "Asclepias.erosa"),
                                    selected = "Asclepias.californica", 
                                    individual = TRUE,
                                    justified = FALSE,
                                    size = "normal",
                                    direction = "horizontal",
                                    checkIcon = list(yes = icon("circle-play", lib = "font-awesome"), 
                                                     no = icon("circle", lib = "font-awesome"))), #  END radioGroupButton for species type
                  
                  # insert image of accessibility legend which lives in www folder
                  tags$img(src = "priority_legend.png", 
                           alt = "Image depicting color gradient of white to purple for legend. White depicting the lowest priority score for surveying priority.",
                           style = "max-width: 100%;")
                  
              ) # END input box
              
            ), # END fluidRow
  
    
            # leaflet box ----
            box(width = 12,
                
                # "model output here, with site access model applied to map of Los Padres NF" ----
                leafletOutput(outputId = "priority_species_output") %>%  
                  withSpinner()
                
            ), # END leaflet box
  
            # fluidRow ----
            fluidRow(

              # input box ----
              box(width = 12,

                  DT::dataTableOutput("priority_species_table") %>% 
                    withSpinner()

              ), # END input box
            

             ) # END fluidRow
            
    ), # END sitefinder locations tabItem
    
    # data tabItem ----
    tabItem(tabName = "data",
            
            # data info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview_data.md")
                
            ) # END data info box
            
    ) # END data tabItem
    
  ) # END tabItems
  
) # END dashboardBody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)