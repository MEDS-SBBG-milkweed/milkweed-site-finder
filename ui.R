#........................dashboardHeader.........................
header <- dashboardHeader(
  
  # add title ----
  title = "Milkweed Habitat in Los Padres National Forest",
  titleWidth = 525
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar( width = 300,
                             
                             # sidebarMenu ----
                             sidebarMenu(
                               
                               tags$a(href = "https://sbbotanicgarden.org/",
                               tags$img(src = "SBBG_workcard-projects-1.jpg", 
                                        alt = "The logo of the santa barabara botanic garden with a white background and green image.",
                                        style = "max-width: 100%;")),
                               # tags$h6(tags$em("Source:", tags$a(href = "https://sbbotanicgarden.org/", "SBBG")),
                               #         style = "text-align: center;"),
                               
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
                  
                  includeMarkdown("text/background-info.md")
                  
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
                
                includeMarkdown("text/overview-milkweed-locations.md")
                
            ), # END milkweed locations info box
            
            # milkweed locations sidebar layout
            sidebarLayout(
              
              sidebarPanel(
                
                width = 12,
                # species type checkbox Group Buttons ----
                checkboxGroupButtons(inputId = "species_type_input", label = "Select milkweed species:",
                                     choices = c("Asclepias californica", "Asclepias vestita", "Asclepias eriocarpa", "Asclepias erosa"),
                                     select = "Asclepias californica", 
                                     individual = FALSE,
                                     justified = FALSE,
                                     size = "normal",
                                     direction = "horizontal",
                                     checkIcon = list(yes = icon("circle-check", lib = "font-awesome"), 
                                                      no = icon("circle-xmark", lib = "font-awesome"))), #  END checkboxGroupInput for species type
              ),
              
              # leaflet box ----
              box(width = 12,
                  
                  title = tags$strong("Milkweed Survey Locations from 2023 surveys:"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "survey_map_output") |> 
                    withSpinner(type = 1, color = "#4287f5")
                  
              ) # END leaflet box
              
            )
            
    ), # END milkweed locations tabItem
    
    # habitat suitability tabItem ----
    tabItem(tabName = "habitatsuit",
            
            # habitat suitability info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview-habitat-suitability.md")
                
            ), # END habitat suitability info box
            
            # habitat suitability sidebar layout
            sidebarLayout(
              
              sidebarPanel(
                # species type checkbox Group Buttons ----
                checkboxGroupButtons(inputId = "species_type_input", label = "Select milkweed species:",
                                     choices = c("All Species", "A. californica", "A. vestita", "A. eriocarpa", "A. erosa"),
                                     selected = c("all"), 
                                     individual = FALSE,
                                     justified = FALSE,
                                     size = "normal",
                                     direction = "horizontal",
                                     checkIcon = list(yes = icon("circle-check", lib = "font-awesome"), 
                                                      no = icon("circle-xmark", lib = "font-awesome"))), #  END checkboxGroupInput for species type
              ),
              
              mainPanel(
                
                
                # plot output will go here
                
                
              ) # END mainPanel
              
            ), # END habitat suitability sidebar panel
            
            # leaflet box ----
            box(width = 8,

                "model output here showing modeled habitat suitability here"

            ), # END leaflet box
# 
#             # second fluidRow ----
#             fluidRow(
# 
#               # model parameter box ----
#               box(width = 12,
# 
#                   "model parameters used to calculate this model"
# 
#               ) # END model parameter box
# 
#             ) # END fluidRow
#             
    ), # END habitat suitability tabItem
    
    
    # site access tabItem ----
    tabItem(tabName = "siteaccess",
            
            # site access info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview-site-accessibility.md")
                
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
                
                includeMarkdown("text/overview-site-finder.md")
                
            ), # END sitefinder info box
            
            # fluidRow ----
            fluidRow(
              
              # habitat suitability sidebar layout
              sidebarLayout(
                
                sidebarPanel(
                  # species type checkbox Group Buttons ----
                  checkboxGroupButtons(inputId = "species_type_input", label = "Select milkweed species:",
                                       choices = c("All Species", "A. californica", "A. vestita", "A. eriocarpa", "A. erosa"),
                                       selected = c("all"), 
                                       individual = FALSE,
                                       justified = FALSE,
                                       size = "normal",
                                       direction = "horizontal",
                                       checkIcon = list(yes = icon("circle-check", lib = "font-awesome"), 
                                                        no = icon("circle-xmark", lib = "font-awesome"))), #  END checkboxGroupInput for species type
                ),
                
                mainPanel(
                  
                  
                  # plot output will go here
                  
                  
                ) # END mainPanel
                
              ), # END habitat suitability sidebar panel
              
              
              # input box ----
              box(width = 4,
                  
                  # Input: Accessibility Slider ----
                  sliderInput("integer", "Accessibility Index:",
                              min = 0, max = 1,
                              value = 0.8, step = 0.1)
                  
              ) # END input box
              
            #   # leaflet box ----
            #   box(width = 8,
            #       
            #       "interactive map here that you can zoom to the area you want specified"
            #       
            #   ) # END leaflet box
            #   
            # ), # END fluidRow
            # 
            # # fluidRow ----
            # fluidRow(
            #   
            #   # input box ----
            #   box(width = 4,
            #       
            #       "reactive datatable output here that lists coordinates based off of zoom and slider inputs"
            #       
            #   ) # END input box
            #   
             ) # END fluidRow
            
    ), # END sitefinder locations tabItem
    
    # data tabItem ----
    tabItem(tabName = "data",
            
            # data info box ----
            box(width = NULL,
                
                includeMarkdown("text/overview-data.md")
                
            ) # END data info box
            
    ) # END data tabItem
    
  ) # END tabItems
  
) # END dashboardBody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)