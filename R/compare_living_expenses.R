# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL


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
#'    Valid city names are: "Barcelona", "Athens", "Amsterdam", "Bologna" "Bordeaux", "Brussels", "Helsinki"
#'    "Copenhagen", "Lisbon", "Dublin", "Hamburg", "Groningen", "Berlin", "Aalborg",
#'    "Bratislava", "Bucharest", "Budapest", "Madrid", "Rome", "Oslo", "Paris",
#'    "Prague", "Stockholm", "Sofia", "Rotterdam", "Tallinn", "Vilnius", "Zagreb",
#'    "Warsaw", "Verona", "Zurich", "Vienna", "Ljubljana", "Lille", "Malmö",
#'    "Munich", "Riga", "Reykjavík", "Valletta", "Gdańsk", "Oulu", "Leipzig",
#'    "Braga", "Marseille", "Antwerp", "Tirana", "Strasbourg", "Skopje", "Podgorica",
#'    "Białystok", "Nicosia", "Miskolc", "Málaga", "Košice", "Graz", "Heraklion",
#'    "Oviedo", "Geneva", "Burgas", "Ostrava", "Turin", "Rostock", "Rennes",
#'    "Palermo", "Naples", "Manchester", "London", "Glasgow", "Cardiff", "Belfast",
#'    "Dortmund", "Essen", "Liège"
#'
#' @param city2 Second city to be retrieved
#'
#' @returns A data frame containing city name, price category, product name, and
#' price in euros
#'
#'
#' @export
filter_prices <- function(city1, city2){
  # Return informative error if both selected cities are the same
  if(city1 == city2){
    stop("Please select two non-identical cities to compare.")
  }

  # only execute this once the second city is chosen (to avoid error in console)
  if(city2 != "Select"){
    # filter data frame by provided city names
    prices_df <- prices_df %>%
      dplyr::filter(city == city1 | city == city2)

    return(prices_df)
  } else {
    return("No second city")
  }
}



# plot prices
plot_prices <- function(prices, product){
  # Input:
  #   `prices`: city_prices data frame, filtered for 2 cities
  #       can also be "No second city" if 2nd city is not chosen yet
  #   `product`: product name, as recorded in price_categories data frame

  # If 2nd city is not yet chosen: give informative error
  if(prices == "No second city"){
    stop("Please choose second city for comparison")

    # once chosen: filter and plot
  } else {
    # filter data by chosen product
    product_price <- prices %>%
      dplyr::filter(item_name == product)

    # plot minimum, maximum and average price for both cities
    plot_title <- paste("Average price for", product, "(in €)")
    plot_subtitle <- paste("Comparing", product_price$city[1],
                           "and", product_price$city[2])

    ggplot2::ggplot(product_price, ggplot2::aes(x = city,
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
}


