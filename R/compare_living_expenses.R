# SCRIPT TO COMPARE LIFE LIVING EXPENSES


# TODO: update available cities in documentation.

#' Get living expenses of two European cities
#'
#' @description This function returns a data frame containing the prices of
#' various goods in 2 European cities of your choice. Prices are provided in €
#' and were taken from the Cost of living and prices:
#' https://rapidapi.com/traveltables/api/cost-of-living-and-prices/#
#'
#' @param city1 First city to be retrieved.
#'
#'    Valid city names are:
#'    Aalborg, Amsterdam, Antwerp, Athens, Barcelona, Belfast, Berlin, Białystok,
#'    Bologna, Bordeaux, Braga, Bratislava, Brussels, Bucharest, Budapest,
#'    Burgas, Cardiff, Copenhagen, Dortmund, Dublin, Essen, Gdańsk, Geneva,
#'    Glasgow, Graz, Groningen, Hamburg, Helsinki, Heraklion, Košice, Leipzig,
#'    Liège, Lille, Lisbon, Ljubljana, London, Madrid, Málaga, Malmö,
#'    Manchester, Marseille, Miskolc, Munich, Naples, Nicosia, Oslo, Ostrava,
#'    Oulu, Oviedo, Palermo, Paris, Podgorica, Prague, Rennes, Reykjavík,
#'    Riga, Rome, Rostock, Rotterdam, Skopje, Sofia, Stockholm, Strasbourg,
#'    Tallinn, Tirana, Turin, Valletta, Verona, Vienna, Vilnius, Warsaw,
#'    Zagreb, Zurich
#'
#' @param city2 Second city to be retrieved
#'
#' @returns A data frame containing city name, price category, product name, and
#' price in euros
#'
#'
#' @export
# function to filter city_prices data frame by 2 chosen cities
filter_prices <- function(city1, city2){

  select_prices <- city_prices %>%
    dplyr::filter(city == city1 | city == city2) %>%
    dplyr::select(city, item_name, category, avg)

  return(select_prices)
}



# plot prices
plot_prices <- function(select_prices, product){
  # Input:
  #   `prices`: city_prices data frame, filtered for 2 cities
  #       can also be "No second city" if 2nd city is not chosen yet
  #   `product`: product name, as recorded in price_categories data frame

  # filter data by chosen product
  product_price <- select_prices %>%
    dplyr::filter(item_name == product)

  # plot minimum, maximum and average price for both cities
  plot_title <- paste("Average price for", product, "(in €)")
  plot_subtitle <- paste("Comparing", product_price$city[1],
                         "and", product_price$city[2])
  x_axis_order <- as.factor(c(product_price$city[1],  product_price$city[2]))

  ggplot2::ggplot(product_price, ggplot2::aes(x = factor(city, x_axis_order),
                                              y = avg,
                                              fill = city)) +
    ggplot2::geom_bar(stat="identity", width=.5, fill=c("#004346", "#49BEAA")) +
    ggplot2::labs(title = plot_title,
                  subtitle= plot_subtitle,
                  caption="source: https://cost-of-living-and-prices.p.rapidapi.com",
                  x = " ",
                  y = "EURO") +
    ggplot2::theme_light()

}


