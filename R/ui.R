# R Shiny User Interface
#
# Defining user interface for the "shall I move?" shiny app
#

#'@import shinythemes
#'@import shinyWidgets

data("city_prices")
data("life_satisfaction")
data("price_categories")
data("cities")
data("qualityOL")

# Define European countries to be included in the data ------------
european_countries <- c("Denmark","Netherlands","Turkey","Belgium","Greece","Spain",
                        "Northern Ireland","Serbia","Germany","Poland","Italy","France",
                        "Portugal","Slovakia","Romania","Hungary","Bulgaria","Wales",
                        "Ireland","Switzerland","Scotland","Austria","Finland","Cyprus",
                        "Slovenia","England","Sweden","Norway","Czechia","Montenegro",
                        "Iceland","Latvia","North Macedonia", "Estonia","Albania","Malta",
                        "Lithuania","Croatia","Luxembourg")

ui <- shiny::fluidPage(theme = shinythemes::shinytheme("lumen"),
                shiny::fluidRow(
                shiny::column(shiny::h1("Shall I move? - Comparing European Cities",
                           style= "color:white"),
                       style = "text-align:justify;color:black;background-color:
                            #987D7C;padding:15px;border-radius:10px",
                       width = 12
                       ),

                # this is for styling of the UK warning (see below)
                shiny::tags$head(shiny::tags$style("#warning_UK{color: red;
                                font-size: 12px;
                                }"
                )),
                shiny::tags$head(shiny::tags$style("#warning_UK2{color: red;
                                 font-size: 12px;
                                 }"
                )),


                # Introduction -----------------------------------

                  shiny::br(),

                  shiny::column(shiny::h4("What is this about?",
                            style="color:black"),
                            shiny::p("This shiny app will relief some of your stress caused by ruminating whether
                           you should move to another city (and perhaps more importantly: where to?)."),
                            shiny::p("Just choose two cities you would like to compare and those criteria that matter most to you."),
                            shiny::p(" The app will show you how these cities compare to each other in nice graphs and plots"),
                         style="text-align:justify;color:black;background-color:
                            #FCEFF9;padding:15px;border-radius:10px",
                         width = 12),
                ),

                # TABS
                shiny::tabsetPanel(
                  type = "pills",

                  # Life satisfaction tab -----------------------
                  shiny::tabPanel(
                    title = "Life Satisfaction",
                    icon = shiny::icon("smile"),


                    shiny::sidebarLayout(
                      # Life satisfaction side panel ---
                      shiny::sidebarPanel(
                        style = "text-align:justify;color:black;background-color:
                             #9AC6C5;padding:15px;border-radius:10px",

                        # choose country of first city
                        shiny::selectInput(inputId = "country1",
                                           label = "Choose country of first city",
                                           choices = c("Select",sort(european_countries)),
                                           selected = "Select"),

                        # choose city1 based on chosen first country
                        shiny::uiOutput("conditional_city1"),

                        # if country1 is in UK, inform user that no life satifsfaction data available
                        shiny::conditionalPanel(
                          condition = "input.country1 == 'England' | input.country1 == 'Scotland' |
                          input.country1 == 'Northern Ireland' | input.country1 == 'Wales'",
                          shiny::htmlOutput("warning_UK")
                        ),

                        shiny::hr(),

                        # choose country of second city
                        shiny::selectInput(inputId = "country2",
                                           label = "Choose country of second city",
                                           choices = c("Select",sort(european_countries)),
                                           selected = "Select"),

                        # choose city2 based on chosen second country
                        shiny::uiOutput("conditional_city2"),

                        # if country2 is in UK, inform user that no life satifsfaction data available
                        shiny::conditionalPanel(
                          condition = "input.country2 == 'England' | input.country2 == 'Scotland' |
                          input.country2 == 'Northern Ireland' | input.country2 == 'Wales'",
                          shiny::htmlOutput("warning_UK2")
                        ),

                        shiny::hr(),

                        # choose quality of life criteria
                        shiny::radioButtons(inputId  = "criterion",
                                            label    = "Which criterion matters most to you?",
                                            choices  = c(
                                              `Public transport` = "transp",
                                              `Nice green spaces` = "greenery",
                                              `Air quality` = "air",
                                              `Cleanlness` = "clean",
                                              `Diverse cultural offer` = "culture",
                                              `Sport facilities` = "sport",
                                              `LGBTQI+ friendliness` = "LGBTQI",
                                              `Quality of life for ethnic minorties` = "racial",
                                              `Education` = "edu",
                                              `Quality of health system` = "health",
                                              `Low noise level` = "noise",
                                              `Safety` = "safety",
                                              `General satisfaction of inhabitants` = "satisfaction"),
                                            selected = "transp"),
                      ),  # end sidepanel

                      # Life satisfaction main panel ---
                      shiny::mainPanel(
                        shiny::fluidRow(
                          shiny::column(6,
                                 # plot output: line plot countries life satisfaction
                                 shiny::plotOutput("lineplot1")),
                          shiny::column(6,
                                 # plotly map output
                                 plotly::plotlyOutput(outputId = "map")
                          )
                        ),

                        shiny::fluidRow(
                          # plot output: barchart cities quality of life
                          shiny::plotOutput("barchart1")
                        )
                      )
                    ), # end sidebar settings
                  ), # end tab

                  # Living expenses tab -----------------------------------
                  shiny::tabPanel(
                    title = "Living Expenses",
                    icon = shiny::icon("euro"),

                    shiny::sidebarLayout(
                      # Living expenses side panel ---
                      shiny::sidebarPanel(
                        style = "text-align:justify;color:black;background-color:
                             #9AC6C5;padding:15px;border-radius:10px",

                        # repeat choice of country and city (different selection than above)
                        # choose country of first city
                        shiny::selectInput(inputId = "country1_prices",
                                           label = "Choose country of first city",
                                           choices = c("Select", sort(unique(city_prices$country))),
                                           selected = "Select"),

                        # choose city1 based on chosen first country
                        shiny::uiOutput("conditional_city1_prices"),

                        shiny::hr(),

                        # choose country of second city
                        shiny::selectInput(inputId = "country2_prices",
                                           label = "Choose country of second city",
                                           choices = c("Select", sort(unique(city_prices$country))),
                                           selected = "Select"),

                        # choose city2 based on chosen second country
                        shiny::uiOutput("conditional_city2_prices"),

                        shiny::hr(),

                        # choose price category
                        shiny::selectInput(inputId = "price_category",
                                           label = "Choose price category",
                                           choices = c("Select", unique(price_categories$category)),
                                           selected = "Select"
                        ),

                        # choose product based on chosen price category
                        shiny::uiOutput("conditional_product"),
                      ), # end of sidebar

                      # Living expenses main panel ---
                      shiny::mainPanel(
                        # plot output: barchart cities quality of life
                        shiny::plotOutput("barchart_prices")
                      ) # end main panel
                    ) # end sidebarpanel
                  ) # end sidebarlayout
                ) # end tab
                ) # end tabsetPanel

