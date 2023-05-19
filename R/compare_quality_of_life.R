# COMPARE QUALITY OF LIFE DATA
#
#
#

library(dplyr)
library(ggplot2)

source("./R/utils.R")

# Function to filter quality of life rating of 2 chosen cities on one
# chosen variable
filter_QoL_comparison <- function(city1, city2, criterion){
  comparison <- qualityOL %>%
    filter(variable == criterion &
           (city_english == city1 | city_english == city2)) %>%
    select(variable, city_english, percentage)

   return(comparison)
}

# Function to plot comparison of filtered quality of life data
# TODO: change title & subtitle
plot_QoL_comparison <- function(comparison_df){
  plot_title <- paste("Percentage of inhabitants satisfied with ",
                      variable_names[variable_names$variable == comparison_df$variable[1],2])

  plot_subtitle <- paste("Comparing", comparison_df$city_english[1],
                         "and" ,  comparison_df$city_english[2])

  plot <- ggplot(comparison_df, aes(x = city_english,
                      y = percentage,
                      fill = city_english)) +
    geom_bar(stat="identity", width=.5, fill=c("#004346", "#49BEAA")) +
    labs(title = plot_title,
         subtitle= plot_subtitle,
         caption="source: Report on the Quality of life in European Cities, 2020",
         x = " ",
         y = "%") +
    ylim(0, 1) +
    theme_light() +
    theme(plot.title = element_text(size = 22),
          axis.text.x = element_text(size = 20),
          axis.text.y = element_text(size = 15))

  return(plot)
}




