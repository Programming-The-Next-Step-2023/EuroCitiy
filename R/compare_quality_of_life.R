# COMPARE QUALITY OF LIFE DATA
#



#' Function to filter quality of life rating of 2 chosen cities on one
#' chosen variable
#'
#' @description This function returns a data frame containing the satisfaction of
#'    inhabitants of 2 European cities of your choice with a certain criterion of
#'    quality of life.
#'
#' @param city1 First city of choice.
#'
#'    \emph{Valid city names are}:
#'    Aalborg, Amsterdam, Antwerp, Athens, Barcelona, Belfast, Berlin, Białystok,
#'    Bologna, Bordeaux, Braga, Bratislava, Brussels, Bucharest, Budapest,
#'    Burgas, Cardiff, Copenhagen, Dortmund, Dublin, Essen, Gdańsk, Geneva,
#'    Glasgow, Graz, Groningen, Hamburg, Helsinki, Heraklion, Košice, Leipzig,
#'    Liège, Lille, Lisbon, Ljubljana, London, Madrid, Málaga, Malmö, Manchester,
#'    Marseille, Miskolc, Munich, Naples, Nicosia, Oslo, Ostrava, Oulu, Oviedo,
#'    Palermo, Paris, Podgorica, Prague, Rennes, Reykjavík, Riga, Rome, Rostock,
#'    Rotterdam, Skopje, Sofia, Stockholm, Strasbourg, Tallinn, Tirana,
#'    Turin, Valletta, Verona, Vienna, Vilnius, Warsaw, Zagreb, Zurich
#'
#'
#' @param city2 Second city
#'
#' @param criterion Criterion to return; i.e, category that inhabitants were asked
#'    to rate. The following criteria were assessed:
#'
#' @returns A data frame
#'
#' @examples filter_QoL_comparison("Berlin", "Amsterdam", "LGBTQI")
#'
#' @export
filter_QoL_comparison <- function(city1, city2, criterion){
  # only execute when cities are selected to avoid errors
  if(city1 != "Select" & city2 != "Select"){
    comparison <- qualityOL %>%
      dplyr::filter(variable == criterion &
                      (city == city1 | city == city2)) %>%
      dplyr::select(variable, city, percentage)

  } else {
    # return empty df
    comparison <- data.frame(
      country = rep(NA, 2),
      city = rep(NA, 2),
      variable = rep(NA, 2),
      percentage = rep(NA, 2)
    )
  }
  return(comparison)
}

# Function to plot comparison of filtered quality of life data
# TODO: change title & subtitle
plot_QoL_comparison <- function(comparison_df){
  if(is.na(comparison_df$city[1]) & is.na(comparison_df$city[1])){
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("text",
                        x = 1, y = 1,
                        size = 8,
                        label = "Please select two cities to compare.") +
      ggplot2::theme_void()

    # plot error if 2 identical cities are chosen
  } else if(nrow(comparison_df) == 1){
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("text",
                        x = 1,
                        y = 1,
                        size = 6,
                        label = "Please choose two non-identical countries for comparison.") +
      ggplot2::theme_void()

    # plot bar graph
  } else {
    plot_title <- paste("Percentage of inhabitants satisfied with ",
                        variable_names[variable_names$variable == comparison_df$variable[1],2])

    plot_subtitle <- paste("Comparing", comparison_df$city[1],
                           "and" ,  comparison_df$city[2])

    plot <- ggplot2::ggplot(comparison_df, ggplot2::aes(x = city,
                                                        y = percentage,
                                                        fill = city)) +
      ggplot2::geom_bar(stat="identity", width=.5, fill=c("#004346", "#49BEAA")) +
      ggplot2::labs(title = plot_title,
                    subtitle= plot_subtitle,
                    caption="source: Report on the Quality of life in European Cities, 2020",
                    x = " ",
                    y = "%") +
      ggplot2::ylim(0, 1) +
      ggplot2::theme_light() +
      ggplot2::theme(plot.title = ggplot2::element_text(size = 22),
                     axis.text.x = ggplot2::element_text(size = 20),
                     axis.text.y = ggplot2::element_text(size = 15))
  }
  return(plot)
}




