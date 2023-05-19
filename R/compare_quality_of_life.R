# COMPARE QUALITY OF LIFE
#
#
#

library(dplyr)
library(ggplot2)

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
# TODO: create title, subtitle, caption, xlab and ylab, change style
plot_QoL_comparison <- function(comparison_list){
  plot <- ggplot(Ber_Ams, aes(x = city_english,
                      y = percentage)) +
    geom_bar(stat="identity", width=.5, fill="tomato3") +
    #labs(title = title,
     #    subtitle="Make Vs Avg. Mileage",
      #   caption="source: mpg") +
    theme(axis.text.x = element_text(angle=65, vjust=0.6))

  return(plot)
}




