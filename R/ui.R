# R Shiny User Interface
#
# Defining user interface for the "shall I move?" shiny app
#
library(shiny)
library(plotly)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Shall I move? - Comparing European Cities"),

                # Introduction -----------------------------------
                fluidRow(
                  br(),

                  column(h4("What is this about?"),
                         p("This shiny app will relief some of your stress caused by ruminating whether
                           you should move to another city (and if: where?)."),
                         p("Just choose two cities you would like to compare and those criteria that matter most to you."),
                         p(" The app will show you how these cities compare to each other in nice graphs and plots"),
                         style="text-align:justify;color:black;background-color:
                             lightcyan;padding:15px;border-radius:10px",
                         width = 12),
                ),

                # TABS
                tabsetPanel(
                  # Life satisfaction tab -----------------------
                  tabPanel(
                    title = "Life Satisfaction",
                    icon = icon("smile"),

                    sidebarLayout(
                      # Life satisfaction side panel ---
                      sidebarPanel(

                        # choose country of first city
                        shiny::selectInput(inputId = "country1",
                                           label = "Choose country of first city",
                                           choices = c("Select",sort(european_countries))),

                        # choose city1 based on chosen first country
                        shiny::uiOutput("conditional_city1"),

                        shiny::hr(),

                        # choose country of second city
                        shiny::selectInput(inputId = "country2",
                                           label = "Choose country of second city",
                                           choices = c("Select",sort(european_countries))),

                        # choose city2 based on chosen second country
                        shiny::uiOutput("conditional_city2"),

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
                                              `Nice public spaces` = "publicsp",
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
                      mainPanel(
                        fluidRow(
                          column(6,
                                 # plot output: line plot countries life satisfaction
                                 shiny::plotOutput("lineplot1")),
                          column(6,
                                 # plotly map output
                                 plotlyOutput(outputId = "map")
                          )
                        ),

                        fluidRow(
                          # plot output: barchart cities quality of life
                          shiny::plotOutput("barchart1")
                        )
                      )
                    ), # end sidebar settings
                  ), # end tab

                  # Living expenses tab -------------------------
                  tabPanel(
                    title = "Living Expenses",
                    icon = icon("euro"),

                    sidebarLayout(
                      # Living expenses side panel ---
                      sidebarPanel(
                        # repeat choice of country and city (different selection than above)
                        # choose country of first city
                        shiny::selectInput(inputId = "country1_prices",
                                           label = "Choose country of first city",
                                           choices = c("Select",sort(european_countries))),

                        # choose city1 based on chosen first country
                        shiny::uiOutput("conditional_city1_prices"),

                        shiny::hr(),

                        # choose country of second city
                        shiny::selectInput(inputId = "country2_prices",
                                           label = "Choose country of second city",
                                           choices = c("Select",sort(european_countries))),

                        # choose city2 based on chosen second country
                        shiny::uiOutput("conditional_city2_prices"),

                        shiny::hr(),

                        # choose price category
                        shiny::selectInput(inputId = "price_category",
                                           label = "Choose price category",
                                           choices = c("Select", unique(price_categories$category)),
                        ),

                        # choose product based on chosen price category
                        shiny::uiOutput("conditional_product"),
                      ), # end of sidebar

                      # Living expenses main panel ---
                      mainPanel(
                        # plot output: barchart cities quality of life
                        shiny::plotOutput("barchart_prices")
                      ) # end main panel
                    )
                  ) # end tab
                )# end tabsetPanel

) # end UI
