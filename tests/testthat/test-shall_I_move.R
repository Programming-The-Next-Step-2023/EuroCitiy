#'@import shinytest2

test_that("Shiny app runs", {
  shinytest2::test_app("shall_I_move.R")
})
