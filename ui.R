
#........................dashboardHeader.........................
header <- dashboardHeader(
  
  title = div(
    tags$a(
      href = "https://sbbotanicgarden.org/",
      tags$img(
        src = "SBBG_logo.png",
        alt = "The logo of the Santa Barbara Botanic Garden with a white background and green image.",
        width = "100%"
      )
    ),
    span("Milkweed Site Finder", style = "position: absolute; left: -9999px;"),
    align = "left",
    width = "100%",
    style = "padding-right:0px;"
  ),
  titleWidth = 280
  
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(width = 280,
                            
                            tags$style(".left-side, .main-sidebar {padding-top: 125px}"),
                            
                            # sidebarMenu ----
                            sidebarMenu(
                              
                              # add tabs to sidebar menu
                              menuItem(text = "Home", tabName = "home", icon = icon("house-user")),
                              menuItem(text = "Milkweed Locations", tabName = "milkweedloc", icon = icon("location-dot")),
                              menuItem(text = "Milkweed Habitat Suitability", tabName = "habitatsuit", icon = icon("leaf")),
                              menuItem(text = "Survey Site Accessibility", tabName = "siteaccess", icon = icon("universal-access")),
                              menuItem(text = "High-Priority Survey Sites", tabName = "sitefinder", icon = icon("magnifying-glass-location")),
                              menuItem(text = "Data", tabName = "data", icon = icon("database"))
                              
                            ) # END sidebarMenu
                            
) # END dashboardSidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # add CSS styling
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sass-style.css"),
  ),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "home",
            
            
            # home fluidRow 1----
            fluidRow(
              
              # home background info box ----
              box(width = 12,
                  
                  # add title to home page
                  title = tags$h1("Welcome to the Milkweed Site Finder Dashboard"),
                  
                  # add markdown file that includes project background info
                  includeMarkdown("text/background_info.md"),
                  
                  # insert image of milkweed
                  tags$img(src = "monarch_milkweed.jpeg", 
                           alt = "Imqage of a monarch butterfly on a milkweed plant.",
                           style = "max-width: 100%;"),
                  tags$h6(tags$em(tags$h6(href = "https://www.nps.gov/articles/000/milkweed-and-monarchs.htm", "Yehyun Kim, Friends of Acadia.")),
                          style = "text-align: left;"), # END image of milkweed
                  
                  # add markdown file that includes background context
                  includeMarkdown("text/background_context.md")
                  
              ) # END home background info box
              
            ), # END home fluidRow 1
            
            # home fluidRow 2 ----
            fluidRow(
              
              # disclaimer box ----
              box(width = 12,
                  
                  # add disclaimer icon
                  title = tagList(icon("triangle-exclamation")),
                  # add markdown file that includes disclaimer
                  includeMarkdown("text/disclaimer.md")
                  
              ) # END disclaimer box
              
            ), # END home fluidRow 2
            
            # home fluidRow 3 ----
            fluidRow(
              
              # authors box ----
              box(width = 12,
                  
                  # add disclaimer icon
                  title = tagList(icon("pen")),
                  # add markdown file that includes disclaimer
                  includeMarkdown("text/authors.md")
                  
              ) # END authors box
              
            ) # END home fluidRow 3
            
    ), # END welcome tabItem
    
    # milkweed locations tabItem ----
    tabItem(tabName = "milkweedloc",
            
            # milkweedloc fluidRow 1----
            fluidRow(
              
              # milkweed locations info box ----
              box(width = 12,
                  
                  # add markdown file that includes overview of milkweed locations
                  includeMarkdown("text/overview_milkweed_locations.md"),
                  
                  # species type checkbox Group Buttons ----
                  checkboxGroupButtons(inputId = "species_type_input", label = "Select milkweed species:",
                                       choiceNames = c("<em>Asclepias californica</em>", 
                                                       "<em>Asclepias eriocarpa</em>", 
                                                       "<em>Asclepias erosa</em>",
                                                       "<em>Asclepias vestita</em>"),
                                       choiceValues = c("Asclepias californica", 
                                                        "Asclepias eriocarpa", 
                                                        "Asclepias erosa", 
                                                        "Asclepias vestita"),
                                       select = "Asclepias californica", 
                                       individual = TRUE,
                                       justified = FALSE,
                                       size = "normal",
                                       direction = "horizontal",
                                       checkIcon = list(yes = icon("square-check", lib = "font-awesome", 
                                                                   class = "fa-solid fa-square-check", 
                                                                   style = "color: #3B3B3D"), 
                                                        no = icon("square", lib = "font-awesome"))), #  END checkboxGroupInput for species type
                  
                  # add leaflet output for survey locations ----
                  leafletOutput(outputId = "survey_map_output") %>%  
                    
                    # add loading spinner to leaflet output
                    withSpinner()
                  
              ), # END milkweed locations info box
              
            )  # END milkweedloc fluidRow 1
            
    ), # END milkweed locations tabItem
    
    # habitat suitability tabItem ----
    tabItem(tabName = "habitatsuit",
            
            # habitat suitability info box ----
            box(width = NULL,
                
                # add markdown file that includes overview of habitat suitability 
                includeMarkdown("text/overview_habitat_suitability.md"),
                
                # insert image of habitat suitability legend
                tags$img(src = "https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/suitability_legend.png", 
                         alt = "Image depicting color gradient of white to red for legend. White depicting the least likely for habitat suitability and red depicting the most likely for habitat suitability",
                         style = "max-width: 100%;")
                
            ), # END habitat suitability info box
            
            
            # habitatsuit fluidRow 1 ----
            fluidRow(
              
              # californica model output ----
              # leaflet box 1 ----
              box(width = 6,
                  
                  title = HTML("<b><i>Asclepias californica:</i></b>"),
                  
                  # leaflet output for californica ----
                  californica_leaflet
                  
              ), # END leaflet box 1
              
              # eriocarpa model output ----
              # leaflet box 2 ----
              box(width = 6,
                  
                  title = HTML("<b><i>Asclepias eriocarpa:</i></b>"),
                  
                  # leaflet output for eriocarpa ----
                  eriocarpa_leaflet
                  
              ), # END leaflet box 2
              
            ), # END habitatsuit fluidRow 1
            
            # habitatsuit fluidRow 2 ----
            fluidRow(
              
              # vestita model output ----
              # leaflet box 3 ----
              box(width = 6,
                  
                  title = HTML("<b><i>Asclepias vestita:</i></b>"),
                  
                  # leaflet output for vestita ----
                  vestita_leaflet
                  
              ), # END leaflet box 3
              
              # erosa model output ----
              # leaflet box 4 ----
              box(width = 6,
                  
                  title = HTML("<b><i>Asclepias erosa:</i></b>"),
                  
                  # leaflet output for erosa ----
                  erosa_leaflet
                  
              ) # END leaflet box 4
              
            ), # END habitatsuit fluidRow 2
            
            
            # habitatsuit fluidRow 3 ----
            fluidRow(
              
              # leaflet box 4 ----
              box(width = 12,
                  
                  title = HTML("<b>Milkweed Maximum Suitability</b>"),
                  
                  # add markdown file that includes description of habitat suitability all
                  includeMarkdown("text/habitat_suitability_all.md"),
                  
                  # leaflet output for max habitat suitability for all of the species ----
                  all_leaflet
                  
              ) # END leaflet box 4
              
            ) # END habitatsuit fluidRow 3
            
    ), # END habitat suitability tabItem
    
    # site access tabItem ----
    tabItem(tabName = "siteaccess",
            
            # siteaccess fluidRow 1
            fluidRow(
              
              # site access info box ----
              box(width = 12,
                  
                  # add markdown file that includes an overview of site accessibility
                  includeMarkdown("text/overview_site_accessibility.md"),
                  
                  # insert image of accessibility legend which lives in www folder
                  tags$img(src = "https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/accessibility_legend.png", 
                           alt = "Image depicting color gradient of white to blue for legend. White depicting the least likely for survey site accessibility, and dark blue depicting the most accessible",
                           style = "max-width: 100%;")
                  
              ) # END site access info box
              
            ), # END siteaccess fluidRow 1
            
            # siteaccess fluidRow 2 ----
            fluidRow(
              align = "center",
              
              # leaflet box 1 with accessibility index ----
              box(width = 6,
                  
                  title = tags$strong("Select which layer of the accessibility index you would like to examine:"),
                  
                  # species type checkbox Group Buttons ----
                  radioGroupButtons(inputId = "accessibility_layer_input",
                                    choiceNames = c("Distance From Trails", "Distance From Roads", "Vegetation Density", "Land Ownership", "Slope"),
                                    choiceValues = c("Trails", "Roads", "Canopy", "Land", "Slope"),
                                    selected = "Roads", 
                                    individual = TRUE,
                                    justified = FALSE,
                                    size = "normal",
                                    direction = "horizontal",
                                    checkIcon = list(yes = icon("circle-check", lib = "font-awesome", 
                                                                class = "fa-solid fa-circle-check", 
                                                                style = "color: #3B3B3D"), 
                                                     no = icon("circle", lib = "font-awesome")),
                                    width = "100%"), #  END radioGroupButtons for accessibility layer
                  
                  # leaflet output for user selected site accessibility layer ----
                  leafletOutput(outputId = "accessibility_layer_output") %>%  
                    
                    # add loading spinner
                    withSpinner()
                  
              ), # END leaflet box
              
              # leaflet box 2 with total index loaded
              box(width = 6,
                  
                  title = tags$strong("Total Accessibility Index:"),
                  
                  # leaflet output for total site accessibility index
                  accessibility_index_leaflet
                  
              ), # END box with static leaflet
              
            ) # END siteaccess fluidRow 1
            
    ), # END site access locations tabItem
    
    # sitefinder tabItem ----
    tabItem(tabName = "sitefinder",
            
            # sitefinder fluidRow 1 ----
            fluidRow(
              
              # sitefinder info box ----
              box(width = 12,
                  
                  includeMarkdown("text/overview_site_finder.md"),
                  
                  # insert image of priority legend which lives in www folder
                  tags$img(src = "https://raw.githubusercontent.com/MEDS-SBBG-milkweed/milkweed-mod/main/outputs/dashboard/priority_legend.png", 
                           alt = "Image depicting color gradient of white to purple for legend. White depicting the lowest priority score for surveying priority.",
                           style = "max-width: 100%;")
                  
              ) # END sitefinder info box
              
            ), # END sitefinder fluidRow 1 
            
            
            # leaflet box ----
            box(width = 12,
                # species type checkbox Group Buttons ----
                radioGroupButtons(inputId = "priority_species_input", label = "Select milkweed species:",
                                  choiceNames = c("<em>Asclepias californica</em>", "<em>Asclepias eriocarpa</em>", "<em>Asclepias erosa</em>", "<em>Asclepias vestita</em>"),
                                  choiceValues = c("Asclepias.californica", "Asclepias.eriocarpa", "Asclepias.erosa", "Asclepias.vestita"),
                                  selected = "Asclepias.californica", 
                                  individual = TRUE,
                                  justified = FALSE,
                                  size = "normal",
                                  direction = "horizontal",
                                  checkIcon = list(yes = icon("circle-check", lib = "font-awesome", 
                                                              class = "fa-solid fa-circle-check", 
                                                              style = "color: #3B3B3D"), 
                                                   no = icon("circle", lib = "font-awesome"))), #  END radioGroupButton for species type
                
                # leaflet output of user selected species high priority output ----
                leafletOutput(outputId = "priority_species_output") %>%  
                  
                  # add loading spinner
                  withSpinner()
                
            ), # END leaflet box
            
            # sitefinder fluidRow 2----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  # add data table that summarizes priority information
                  DT::dataTableOutput("priority_species_table") %>% 
                    
                    # add loading spinner
                    withSpinner()
                  
              ), # END input box
              
            ) # END sitefinder fluidRow 2
            
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

#..................combine all in dashboardPage and set dashboard title in open tobs..................
dashboardPage(title = "Milkweed Site Finder", header, sidebar, body)