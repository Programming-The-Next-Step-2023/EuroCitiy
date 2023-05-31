# Check if function returns data frame
test_that("is data frame", {
  filtered <- filter_prices("Berlin", "Amsterdam")
  expect_type(filtered, "list")
})

# Check if function returns correct column names
test_that("Correct column names", {
  filtered <- filter_prices("Berlin", "Amsterdam")
  colnames <- colnames(filtered)
  expect_identical(colnames, c("city", "item_name", "category", "avg"))
})

# Check if function returns correct subset
test_that("Filters correctly", {
  filtered <- filter_prices("Berlin", "Amsterdam")
  correct <- city_prices[city_prices$city == "Berlin" | city_prices$city == "Amsterdam", c(2,3,4,7)]
  rownames(correct) <- seq(length=nrow(correct))
  expect_identical(filtered, correct)
})
