# R Shiny User Interface
#
# Defining user interface for the "shall I move?" shiny app
#
library(shiny)
library(plotly)
library(shinythemes)

source("./R/utils.R")
source("./R/compare_quality_of_life.R")
source("./R/compare_life_satisfaction.R")
source("./R/compare_living_expenses.R")


# create user interface
ui <- shiny::fluidPage(
  theme = shinythemes::shinytheme("lumen"),

  # INTRODUCTION  -----------------------------
  shiny::titlePanel(title = "Shall I move?"),

  shiny::fluidRow(
    column(12,
           htmlOutput("short_intro"))
  ),

  shiny::hr(),

  # USER INPUT CITIES AND COUNTRIES -------------------
  shiny::fluidRow(
    column(4,
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


           shiny::br(),
           shiny::hr(),

           # USER INPUT QUALITY OF LIFE CRITERIA ----------------

          # choose criteria for comparison
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

    ),

    column(4,
           # plot output: line plot countries life satisfaction
           shiny::plotOutput("lineplot1")
    ),

    column(4,
           # plotly map output
           plotlyOutput(outputId = "map")
           ),

    column(8,
           # plot output: barchart cities quality of life
           shiny::plotOutput("barchart1"),
    ),

    # USER INPUT LIVING EXPENSES ----------------
    # choose country of first city
    shiny::selectInput(inputId = "price_category",
                       label = "Choose price category",
                       choices = c("Select", unique(price_categories$category)),
                       ),

    # choose product based on chosen price category
    shiny::uiOutput("conditional_product"),


    #column(8,
    #       # plot output: barchart cities quality of life
    #       shiny::plotOutput("barchart_prices"),
    #),


  )
)



# "server logic"; calculate output from user input
server <- function(input, output){
  # print short introduction
  output$short_intro <- shiny::renderUI({
    HTML(paste(
      "This shiny app will relief some of your stress caused by ruminating whether
      you should move to another city (and if: where?).
      Just choose two cities you would like to compare and those criteria that
      matter most to you.
      The app will show you how these cities compare to each other in nice
      graphs and plots.",
      " ", " ", sep="<br/>"))
  })

  # conditional panel to choose 1st city based on country 1
  output$conditional_city1 <- shiny::renderUI({
    shiny::conditionalPanel(
      condition = "input.country1 != 'Select'",
      shiny::selectInput(inputId = "city1",
                         label = "Choose the first city you want to compare",
                         choices = filter_cities_by_country(input$country1)))
  })

  # conditional panel to choose 2st city based on country 2
  output$conditional_city2 <- shiny::renderUI({
    shiny::conditionalPanel(
      condition = "input.country2 != 'Select'",
      shiny::selectInput(inputId = "city2",
                         label = "Choose the second city to compare",
                         choices = filter_cities_by_country(input$country2)))
  })


  # line plot countries
  output$lineplot1 <- shiny::renderPlot({
    plot_lifeSat(input$country1, input$country2)
  })

  # map life satisfaction countries
  output$map <- plotly::renderPlotly({
    lifeSat_map()
  })

  # bar chart cities
  output$barchart1 <- shiny::renderPlot({
    # filter data by chosen cities and criterion
    compared_df <- filter_QoL_comparison(input$city1,
                                         input$city2,
                                         input$criterion)
    plot_QoL_comparison(compared_df)
  })

  # conditional panel to choose product based on price category
  output$conditional_product <-  shiny::renderUI({
    shiny::selectInput(inputId = "product",
                       label = "Choose product to compare prices",
                       choices = filter_products_by_category(input$price_category))
  })

  # bar chart prices
  #output$barchart_prices <- shiny::renderPlot({
  #  # filter data by chosen cities
  #  prices_for_cities <- get_prices(input$city1,
  #                                  input$city2)
#
  #  plot_prices(prices_for_cities, input$product)
  #})




}

# "connect" ui with server logic and create app
shiny::shinyApp(ui = ui, server = server)

