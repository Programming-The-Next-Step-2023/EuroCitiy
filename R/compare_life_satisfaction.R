# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL

#' @import dplyr
#' @importFrom plotly plot_geo
#' @importFrom plotly add_trace
#' @importFrom plotly layout
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 annotate
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 geom_bar
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 xlim
#' @importFrom ggplot2 ylim
#' @importFrom ggplot2 scale_x_continuous
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 theme_void
#' @importFrom ggplot2 theme


# Function to plot the trajectory of self-reported life satisfaction in two
# chosen cities between 2003 and 2021
plot_lifeSat <- function(country1, country2){
    # Inform user to choose two countries
  if(country1 == "Select" | country2 == "Select") {
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("Please select two cities to compare.",
               x = 1, y = 1,
               size = 8) +
      ggplot2::theme_void()

    # Give error when both countries are identical
  } else if(country1 == country2){
    plot <- ggplot2::ggplot() +
      ggplot2::annotate("Please choose two non-identical countries for comparison.",
               x = 1,
               y = 1,
               size = 8) +
      ggplot2::theme_void()

  } else {
    # filter life_satisfaction by chosen countries and plot trajectory
    sub_df <- life_satisfaction %>%
      dplyr::filter(Entity == country1 | Entity == country2)

    plot_title <- paste("Self-reported life satisfaction")

    plot_subtitle <- paste("in", country1, "and", country2, "(2003 - 2021)")

    plot <- ggplot2::ggplot(sub_df, ggplot2::aes(x = Year, y = Life_satisfaction,
                                                 group = Entity)) +
      ggplot2::geom_line(ggplot2::aes(color = Entity)) +
      ggplot2::geom_point(ggplot2::aes(color = Entity)) +
      ggplot2::labs(title = plot_title,
                    subtitle = plot_subtitle,
                    caption="source: World Happines Report (Helliwell et al., 2023)",
                    y = "Self-reported life satisfaction") +
      ggplot2::ylim(0, 9) +
      ggplot2::xlim(2003, 2021) +
      ggplot2::scale_x_continuous(n.breaks = 19) +
      ggplot2::scale_color_manual(values= c("#F6AA1C","#BA324F")) +
      ggplot2::theme_light() +
      ggplot2::theme(plot.title = ggplot2::element_text(size = 22),
                     axis.text.x = ggplot2::element_text(size = 10),
                     axis.text.y = ggplot2::element_text(size = 13))
  }
  return(plot)
}


# Function to plot an interactive map of Europe, illustrating life satisfaction
lifeSat_map <- function(){
  # get data from 2021
  latest_data <- life_satisfaction %>%
    dplyr::filter(Year == 2021)

  # plot map
  fig <- plotly::plot_geo(latest_data)

  fig <- fig %>% plotly::add_trace(
    z = latest_data$Life_satisfaction,
    text = latest_data$Entity,
    locations = latest_data$Code,
    color = latest_data$Life_satisfaction,
    colors = 'Purples')

  fig <- fig %>% plotly::layout(
    title = "Life Satisfaction per country in Europe 2021"
    )

  return(fig)
}













