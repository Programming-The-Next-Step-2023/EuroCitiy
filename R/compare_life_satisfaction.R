# SCRIPT TO COMPARE LIFE SATISFACTION ON COUNTRY LEVEL

library(dplyr)
library(ggplot2)
library(plotly)

source("./R/utils.R")

# Function to plot the trajectories of self-reported life satisfaction of
# two chosen countries

#' Plot the trajectories of self-reported life satisfaction of two chosen European
#' countries between 2003 and 2021
#'
#' @description
#' Data is taken form the World Happiness Report (Helliwell et al., 2003)
#'
#' @param country1 First country to be plotted.
#'
#'    Valid country names are:
#'
#'    Albania, Austria, Belgium, Bulgaria, Croatia, Cyprus, Czechia,
#'    Denmark, England, Estonia, Finland, France, Germany, Greece,
#'    Hungary, Iceland, Ireland, Italy, Latvia, Lithuania, Luxembourg,
#'    Malta, Montenegro, Netherlands, North Macedonia, Northern Ireland,
#'    Norway, Poland, Portugal, Romania, Scotland, Serbia, Slovakia,
#'    Slovenia, Spain, Sweden, Switzerland, Turkey, Wales
#'
#' @param country2 Second country to be plotted
#'
#' @returns A line plot
#'
#' @examples
#' plot_lifeSat("Netherlands", "Turkey")
#'
#'@export
plot_lifeSat <- function(country1, country2){
  # first, check if values entered for country1 and country2 are valid
  if(!(country1 %in% european_countries) & country1 != "Select"){
    stop(paste(country1,
    "is not a valid input. Check documentation to see which countries can be selected for comparison."))
  } else if(!(country2 %in% european_countries) & country2 != "Select"){
    stop(paste(country2,
    "is not a valid input. Check documentation to see which countries can be selected for comparison."))
  }

  # first, filter life satisfaction data by chosen countries
  sub_df <- life_satisfaction %>%
    filter(Entity == country1 | Entity == country2)

  # plot trajectories
  plot_title <- paste("Self-reported life satisfaction in",
                      country1, "and", country2, "(2003 - 2021)")

  plot <- ggplot(sub_df, aes(x = Year, y = Life_satisfaction,
                             group = Entity)) +
    geom_line(aes(color = Entity)) +
    geom_point(aes(color = Entity)) +
    labs(title = plot_title,
         caption="source: World Happines Report (Helliwell et al., 2023)",
         y = "Self-reported life satisfaction") +
    ylim(0, 9) +
    expand_limits(x = 2003, y = 0) +
    scale_x_continuous(n.breaks = 16) +
    scale_color_manual(values= c("#F6AA1C","#BA324F")) +
    theme_light() +
    theme(plot.title = element_text(size = 22),
          axis.text.x = element_text(size = 15),
          axis.text.y = element_text(size = 20))

  return(plot)
  }


?plot_lifeSat


