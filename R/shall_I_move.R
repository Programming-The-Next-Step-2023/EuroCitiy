# Main function of script: start the app
#

#'Start the 'shall I move' shiny app
#'
#'@description This function starts a shiny app which allows for descriptive
#'comparison of european cities regarding their quality of life, life satisfaction
#'of inhabitants, and living expenses.
#'
#'@param NONE
#'
#'@returns A shiny app
#'
#'@examples
#'shall_I_move()
#'
#'@export
shall_I_move <- function(){
  shiny::shinyApp(ui = ui, server = server)
}
