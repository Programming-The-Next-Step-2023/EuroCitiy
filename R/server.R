# R Shiny Sever
#
# Defining server for the "shall I move?" shiny app
#

source("./R/utils.R")
source("./R/compare_quality_of_life.R")
source("./R/compare_life_satisfaction.R")
source("./R/compare_living_expenses.R")
source("./R/ui.R")

server <- function(input, output){

  # FOR LIFE SATISFACTION TAB -----------------------------------
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

  # line plot for countries
  output$lineplot1 <- shiny::renderPlot({
    plot_lifeSat(input$country1, input$country2)
  })

  # map of life satisfaction for countries
  output$map <- plotly::renderPlotly({
    lifeSat_map()
  })

  # bar chart for cities
  output$barchart1 <- shiny::renderPlot({
    # filter data by chosen cities and criterion
    compared_df <- filter_QoL_comparison(input$city1,
                                         input$city2,
                                         input$criterion)
    plot_QoL_comparison(compared_df)
  })

  # FOR LIVING EXPENSES TAB ----------------------------------------------

  output$conditional_city1_prices <- shiny::renderUI({
    shiny::conditionalPanel(
      condition = "input.country1_prices != 'Select'",
      shiny::selectInput(inputId = "city1_prices",
                         label = "Choose the first city you want to compare",
                         choices = filter_cities_by_country(input$country1_prices)))
  })

  # conditional panel to choose 2st city based on country 2
  output$conditional_city2_prices <- shiny::renderUI({
    shiny::conditionalPanel(
      condition = "input.country2_prices != 'Select'",
      shiny::selectInput(inputId = "city2_prices",
                         label = "Choose the second city to compare",
                         choices = filter_cities_by_country(input$country2_prices)))
  })

  # conditional panel to choose product based on price category
  output$conditional_product <-  shiny::renderUI({
    shiny::selectInput(inputId = "product",
                       label = "Choose product to compare prices",
                       choices = filter_products_by_category(input$price_category))
  })

  # bar chart of prices for cities
  output$barchart_prices <- shiny::renderPlot({
    # filter data by chosen cities
    prices_for_cities <- filter_prices(city_prices,
                                       input$city1_prices,
                                       input$city2_prices)

    plot_prices(prices_for_cities, input$product)
  })
}

# "connect" ui with server logic and create app
shiny::shinyApp(ui = ui, server = server)
