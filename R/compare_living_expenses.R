# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL

library(httr)
library(jsonlite)
library(dplyr)

# Get prices of goods for 2 chosen cities from API
# TODO: export and document
get_prices<- function(city1, city2){
  # API url
  url <- "https://cost-of-living-and-prices.p.rapidapi.com/prices"

  # run request for first city
  queryString <- list(
    city_name = city1,
    country_name = cities[cities$city_english == city1, 1] # get country name
  )
  response1 <- VERB("GET", url,
                   query = queryString,
                   add_headers(
                     'X-RapidAPI-Key' = 'a86b271824msh365c7139200ceafp12e34fjsn180c97e9a813',
                     'X-RapidAPI-Host' = 'cost-of-living-and-prices.p.rapidapi.com'),
                   content_type("application/octet-stream"))

  # repeat request for second city
  queryString <- list(
    city_name = city2,
    country_name = cities[cities$city_english == city2, 1] # get country name
  )
  response2 <- VERB("GET", url,
                    query = queryString,
                    add_headers(
                      'X-RapidAPI-Key' = 'a86b271824msh365c7139200ceafp12e34fjsn180c97e9a813',
                      'X-RapidAPI-Host' = 'cost-of-living-and-prices.p.rapidapi.com'),
                    content_type("application/octet-stream"))

  # convert responses
  prices_city1 <- fromJSON(rawToChar(response1$content), flatten = TRUE)
  prices_city2 <- fromJSON(rawToChar(response2$content), flatten = TRUE)

  # convert both to data frames
  prices_city1 <- prices_city1$prices
  prices_city1 <- prices_city1 %>%
    mutate(city = city1) %>%
    select(city, item_name, min, avg, max)

  prices_city2 <- prices_city2$prices %>%
    mutate(city = city2) %>%
    select(city, item_name, min, avg, max)

  # join data frames into one
  prices <- rbind(prices_city1,
                  prices_city2)

  # add price category column
  prices <- prices %>%
    left_join(price_categories,
              by = join_by(item_name)) %>%
    filter(!is.na(category)) # keep only relevant data


  return(prices)

}


# plot prices
plot_prices <- function(prices, product){
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


