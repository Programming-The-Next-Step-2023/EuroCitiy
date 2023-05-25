# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL

#' @import dplyr plotly
#' @import ggplot2


# Function to plot the trajectory of self-reported life satisfaction in two
# chosen cities between 2003 and 2021
plot_lifeSat <- function(country1, country2){
  # first, check if values entered for country1 and country2 are valid
  if(!(country1 %in% european_countries) & country1 != "Select"){
    stop(paste(country1,
    "is not a valid input. Check documentation to see which countries can be selected for comparison."))
  } else if(!(country2 %in% european_countries) & country2 != "Select"){
    stop(paste(country2,
    "is not a valid input. Check documentation to see which countries can be selected for comparison."))
  }

  # Inform user to choose two countries
  if(country1 == "Select" | country2 == "Select") {
    stop("Please choose two countries for comparison.")

    # Give error when both countries are identical
  } else if(country1 == country2){
    stop("Please choose two non-identical countries for comparison.")

  } else {
    # filter life_satisfaction by chosen countries and plot trajectory
    sub_df <- life_satisfaction %>%
      dplyr::filter(Entity == country1 | Entity == country2)

    # and plot trajectories
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

    return(plot)
    }
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













