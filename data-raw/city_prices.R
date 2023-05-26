## code to prepare `city_prices` dataset

library(dplyr)

city_prices <-  read.csv("city_prices.csv") %>%
  select(-1)

usethis::use_data(city_prices, overwrite = TRUE)



