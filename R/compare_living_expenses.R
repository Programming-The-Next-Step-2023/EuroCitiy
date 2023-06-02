# SCRIPT TO COMPARE LIFE LIVING EXPENSES


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
  # only execute when cities are selected to avoid errors
  if(city1 != "Select" & city2 != "Select"){
    select_prices <- city_prices %>%
      dplyr::filter(city == city1 | city == city2) %>%
      dplyr::select(city, item_name, category, avg)

    # else return empty df
  } else {
    select_prices <- data.frame(
      city = rep(NA, 2),
      item_name = rep(NA, 2),
      category = rep(NA, 2),
      avg = rep(0, 2)
    )
  }
  return(select_prices)
}



# plot prices -------------------------------------------------
plot_prices <- function(select_prices, product){
  # Input:
  #   `prices`: city_prices data frame, filtered for 2 cities
  #       can also be "No second city" if 2nd city is not chosen yet
  #   `product`: product name, as recorded in price_categories data frame

  # If no city selected, inform user to do so
  if(is.na(unique(select_prices$city)[1]) & is.na(unique(select_prices$city)[2])){
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("text",
                        x = 1, y = 1,
                        size = 8,
                        label = "Please select two cities to compare.") +
      ggplot2::theme_void()

    # Plot error if same cities chosen
  } else if(length(unique(select_prices$city)) == 1){
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("text",
                        x = 1,
                        y = 1,
                        size = 6,
                        label = "Please choose two non-identical countries for comparison.") +
      ggplot2::theme_void()

    # else plot bar graph
  } else {
    # filter data by chosen product
    product_price <- select_prices %>%
      dplyr::filter(item_name == product)

    # plot minimum, maximum and average price for both cities
    plot_title <- paste("Average price for", product, "(in €)")
    plot_subtitle <- paste("Comparing", product_price$city[1],
                           "and", product_price$city[2])
    x_axis_order <- as.factor(c(product_price$city[1],  product_price$city[2]))

    plot <- ggplot2::ggplot(product_price, ggplot2::aes(x = factor(city, x_axis_order),
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
  return(plot)
}


# Make price category-wide price comparison ------------------------------------
lower_price_in_cat <- function(city1, city2, chosen_category){

  # only print if both cities and category are selected:
  if(city1 != "Select" & city2 != "Select" & chosen_category != "Select"){
    #  first check if identical cities chosen
    if(city1 == city2){
      plot <- ggplot2::ggplot() +
        ggplot2::annotate("text",
                          x = 1, y = 1,
                          size = 8,
                          label = paste(
                            "Please choose two non-identical cities to compare average",
                            chosen_category, "prices.")) +
        ggplot2::theme_void()
    } else {
      # compute mean price of chosen category for both cities
      mean_prices <- city_prices %>%
        dplyr::filter(city == city1 | city == city2) %>%
        dplyr::filter(category == chosen_category) %>%
        dplyr::group_by(city) %>%
        dplyr::summarise(mean_price = mean(avg))

      # find city in which price is lower
      lowerprice <- mean_prices[mean_prices$mean_price == min(mean_prices$mean_price), 1]

      # define what to print
      label <- paste("Regarding", chosen_category, lowerprice$city, "is cheaper. \n
                 Average price of all", chosen_category, "products in", mean_prices$city[1], "=" ,round(mean_prices$mean_price[1],2),"€. \n
                 Average price of all", chosen_category, "products in", mean_prices$city[2], "=" ,round(mean_prices$mean_price[2],2), "€.")

      plot <- ggplot2::ggplot() +
        ggplot2::annotate("text",
                          x = 1, y = 1,
                          size = 8,
                          label = label) +
        ggplot2::theme_void()

      # if not yet chosen: return empty plot
    }
  } else {
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("text",
                        x = 1, y = 1,
                        size = 8,
                        label = "") +
      ggplot2::theme_void()
  }

  return(plot)
}

