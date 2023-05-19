
# Check if function throws error when invalid country is given as argument
test_that("Error message works", {
  expect_error(plot_lifeSat("Hello"),
               "Hello is not a valid input. Check documentation to see which countries can be selected for comparison.")
})

# Check if function does not return error message when one argument is "Select"
test_that("No error for 'Select' input", {
  expect_no_error(plot_lifeSat("Select", "Select"),
                  message = NULL,
                  class = NULL)
})

# Check if labels, title, and caption are correct
test_that("Labels, title, and caption correct", {
  p <- plot_lifeSat("Netherlands", "Greece")
  expect_identical(p$labels$y, "Self-reported life satisfaction")
  expect_identical(p$labels$x, "Year")
  expect_identical(p$labels$title, "Self-reported life satisfaction in Netherlands and Greece (2003 - 2021)")
  expect_identical(p$labels$caption, "source: World Happines Report (Helliwell et al., 2023)")
})


