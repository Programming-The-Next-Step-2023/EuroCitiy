# R Shiny User Interface
#
# Defining user interface for the "shall I move?" shiny app
#
source("./R/utils.R")
library(shiny)

# load internal datasets


# create user interface
ui <- shiny::fluidPage(
  # INTRODUCTION  -----------------------------
  shiny::titlePanel(title = "Shall I move?"),

  fluidRow(
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
           uiOutput("conditional_city1"),

           shiny::hr(),

           # choose country of second city
           shiny::selectInput(inputId = "country2",
                              label = "Choose country of second city",
                              choices = c("Select",sort(european_countries))),

           # choose city2 based on chosen second country
           uiOutput("conditional_city2"),

           shiny::hr(),

          # choose criteria for comparison
          radioButtons(inputId  = "criterion",
                       label    = "Which criterion matters most to you?",
                       choices  = c(
                         `Public transport` = "transp",
                         `Nice green spaces` = "greenery",
                         `Air quality` = "air",
                         `Cleanliness` = "clean",
                         `Diverse cultural offer` = "culture",
                         `Sport facilities` = "sport",
                         `LGBTQI+ friendlyness` = "LGBTQI",
                         `Acceptance of racial minorties` = "racial",
                         `Education` = "edu",
                         `Quality of health system` = "health",
                         `Low noise level` = "noise",
                         `Safety` = "safety",
                         `General satisfaction of inhabitants` = "satisfaction"),
                       selected = "transp"),

    ),

    column(8,
           # test output: chosen country1
           shiny::verbatimTextOutput("print_country1"),
           # test output: chosen city1
           shiny::verbatimTextOutput("print_city1"),

           # test output: chosen country1
           shiny::verbatimTextOutput("print_country2"),
           # test output: chosen city1
           shiny::verbatimTextOutput("print_city2")
    )
  ),
)

# "server logic"; calculate output from user input
server <- function(input, output){
  # print short introduction
  output$short_intro <- renderUI({
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

  # test
  output$print_country1 <- shiny::renderPrint(input$country1)
  output$print_city1 <- shiny::renderPrint(input$city1)

  output$print_country2 <- shiny::renderPrint(input$country2)
  output$print_city2 <- shiny::renderPrint(input$city2)
}

# "connect" ui with server logic and create app
shiny::shinyApp(ui = ui, server = server)

