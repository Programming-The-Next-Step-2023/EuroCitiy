# check if correct column names
test_that("correct column names", {
  filtered <- filter_QoL_comparison("Berlin", "Amsterdam", "LGBTQI")
  colnames <- colnames(filtered)
  expect_identical(colnames, c("variable", "city", "percentage"))
})

# check if function filters data of 2 cites
test_that("filters 2 cities", {
  filtered <- filter_QoL_comparison("Berlin", "Amsterdam", "LGBTQI")
  expect_identical(nrow(filtered), as.integer(2))
})

# test if function returns correct values for percentages
test_that("filters 2 cities", {
  filtered <- filter_QoL_comparison("Berlin", "Amsterdam", "LGBTQI")
  expect_identical(c(round(filtered$percentage[1], 2), round(filtered$percentage[2], 2)),
                   c(0.87, 0.84))
})
