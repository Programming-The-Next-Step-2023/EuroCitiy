# R Shiny User Interface
#
# Defining user interface for the "shall I move?" shiny app
#
library(shiny)

source("./R/utils.R")
#source("./R/compare_quality_of_life.R")
#source("./R/compare_life_satisfaction.R")


# load internal datasets


# create user interface
ui <- shiny::fluidPage(
  # INTRODUCTION  -----------------------------
  shiny::titlePanel(title = "Shall I move?"),

  shiny::fluidRow(
    column(12,
           htmlOutput("short_intro"))
  ),

  shiny::hr(),

  # USER INPUT FIRST CITY -------------------
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

           shiny::hr(),

          # choose criteria for comparison
          shiny::radioButtons(inputId  = "criterion",
                       label    = "Which criterion matters most to you?",
                       choices  = c(
                         `Public transport` = "transp",
                         `Nice green spaces` = "greenery",
                         `Air quality` = "air",
                         `Cleanliness` = "clean",
                         `Diverse cultural offer` = "culture",
                         `Sport facilities` = "sport",
                         `LGBTQI+ friendliness` = "LBTQI",
                         `Quality of life racial minorties` = "racial",
                         `Education` = "edu",
                         `Quality of health system` = "health",
                         `Low noise level` = "noise",
                         `Safety` = "safety",
                         `General satisfaction of inhabitants` = "satisfaction"),
                       selected = "transp"),

    ),

    column(8,
           # plot output: line plot countries life satisfaction
           shiny::plotOutput("lineplot1"),

           # plot output: barchart cities quality of life
           shiny::plotOutput("barchart1"),


           # test output: chosen country1
           #shiny::verbatimTextOutput("print_country1"),
           # test output: chosen city1
           #shiny::verbatimTextOutput("print_city1"),

           # test output: chosen country1
           #shiny::verbatimTextOutput("print_country2"),
           # test output: chosen city1
           #shiny::verbatimTextOutput("print_city2")
    )
  ),
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

  # plot line plot countries
  output$lineplot1 <- shiny::renderPlot({
    plot_lifeSat(input$country1, input$country2)
  })

  # plot bar chart cities
  output$barchart1 <- shiny::renderPlot({
    # filter data by chosen cities and criterion
    compared_df <- filter_QoL_comparison(input$city1,
                                         input$city2,
                                         input$criterion)
    # plot comparison
    plot_QoL_comparison(compared_df)
  })


  # test
  #output$print_country1 <- shiny::renderPrint(input$country1)
  #output$print_city1 <- shiny::renderPrint(input$city1)

  #output$print_country2 <- shiny::renderPrint(input$country2)
  #output$print_city2 <- shiny::renderPrint(input$city2)
}

# "connect" ui with server logic and create app
shiny::shinyApp(ui = ui, server = server)

