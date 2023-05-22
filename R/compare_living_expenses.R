# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL

library(httr)
library(jsonlite)
library(dplyr)


# function to filter city_prices data frame by 2 chosen cities
filter_prices <- function(prices_df, city1, city2){
  prices_df <- prices_df %>%
    filter(city == city1 | city == city2)

  return(prices_df)
}



# plot prices
plot_prices <- function(prices, product){
  # Input:
  #   `prices`: city_prices data frame, filtered for 2 cities

  # filter data by chosen product
  product_price <- prices %>%
    filter(item_name == product)

  # plot minimum, maximum and average price for both cities
  plot_title <- paste("Average price for", product, "(in €)")
  plot_subtitle <- paste("Comparing", product_price$city[1],
                         "and", product_price$city[2])

  ggplot(product_price, aes(x = city,
                            y = avg,
                            fill = city)) +
    geom_bar(stat="identity", width=.5, fill=c("#004346", "#49BEAA")) +
    labs(title = plot_title,
         subtitle= plot_subtitle,
         caption="source: https://cost-of-living-and-prices.p.rapidapi.com",
         x = " ",
         y = "EURO") +
    theme_light()
}


