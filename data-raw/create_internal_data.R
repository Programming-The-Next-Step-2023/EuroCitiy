###################### Code to prepare internal datasets #######################

# Overview of internal datasets:
#
# 1: qualityOL dataset --------------------------------------------------
# raw data is from the latest Report on the Quality of life in European Cities:
# TODO: add citation
#
# Download raw data here:
# https://ec.europa.eu/regional_policy/information-sources/maps/quality-of-life_en
#
# 2: cities datafset -------------------------------------------------------
# overview of cities included in the shiny application
# columns are country, original city name as included in study data,
# and city name in english
#
# 3: `life_satisfaction` dataset ---------------------------------------
# raw data is from the World Happiness Report 2023:
# Helliwell, J. F., Layard, R., Sachs, J. D., De Neve, J.-E., Aknin, L. B.,
# & Wang, S. (Eds.). (2023). World Happiness Report 2023.
# New York: Sustainable Development Solutions Network
# Download raw data here:
# https://ourworldindata.org/grapher/happiness-cantril-ladder
#
#########

# qualityOL dataset ----------------------------------------------------------#

library(dplyr)
library(tidyverse)

qualityOL <- readxl::read_excel("C:/Users/Michael/Documents/Psychologie/Master/01_Stats_Courses/Programming_the_next_step/quality_of_life_european_cities_2019_aggregated_data.xlsx",
                                sheet = "QoL in European cities 2019",
                                col_names = TRUE,
                                range = "A2:CI551")

# define variables of interest and respective row numbers
interest <- data.frame(
  names = c(rep(c("transp", "health", "sport", "culture", "greenery", "publicsp",
                  "edu", "air", "noise", "clean", "satisfaction", "safety"),
                each = 2),
            "LGBTQI", "racial"),
  rows = c(29,30,41,42,53,54,65,66,69,79,82,90,101,102,113,114,125,126,137,138,
           149,150,351,252,243,237)
)

# drop first columns and select only rows of interest
qualityOL <- qualityOL %>%
  select(-c(1:4)) %>%
  slice(interest$rows) %>%
  mutate(variable = interest$names)

# convert to long format
qualityOL <- qualityOL %>%
  pivot_longer(-variable,
               names_to = "city",
               values_to = "percentage")

# combine percentage of "rather satisfied" and "very satisfied"
# for each city and category
qualityOL <- qualityOL %>%
  filter(percentage < 700) %>% # exclude missing data
  group_by(variable, city) %>%
  summarise(across(percentage, sum))


# cities dataset -----------------------------------------------------------#
cities <- data.frame(
  country = c("Denmark", "Netherlands", "Turkey", "Turkey", "Belgium", "Greece",
              "Spain", "Northern Ireland", "Serbia", "Germany", "Poland", "Italy",
              "France", "Portugal", "Slovakia", "Belgium", "Romania", "Hungary",
              "Bulgaria", "Wales", "Romania", "Turkey", "Germany", "Ireland",
              "Germany", "Poland", "Switzerland", "Scotland", "Austria",
              "Netherlands", "Germany", "Finland", "Greece", "Turkey",
              "Slovakia", "Poland", "Denmark", "Cyprus", "Germany", "France",
              "Portugal", "Belgium", "Slovenia", "England", "Spain", "Sweden",
              "England", "France", "Hungary", "Germany", "Spain", "Italy", "Norway",
              "Czechia", "Finland", "Spain", "Italy", "France", "Romania",
              "Montenegro", "Czechia", "France", "Iceland", "Latvia", "Italy",
              "Germany", "Netherlands", "North Macedonia", "Bulgaria", "Sweden",
              "France", "Estonia", "Albania", "Italy", "England", "Malta", "Italy",
              "Lithuania", "Poland", "Austria", "Croatia", "Switzerland", "Luxembourg"),
  city = unique(qualityOL$city),
  city_english = unique(qualityOL$city)
)

cities$city_english[6] <- "Athens"
cities$city_english[9] <- "Belgrade"
cities$city_english[11] <- "Białystok"
cities$city_english[16] <- "Brussels"
cities$city_english[26] <- "Gdańsk"
cities$city_english[27] <- "Geneva"
cities$city_english[32] <- "Helsinki"
cities$city_english[33] <- "Heraklion"
cities$city_english[36] <- "Cracow"
cities$city_english[37] <- "Copenhagen"
cities$city_english[38] <- "Nicosia"
cities$city_english[41] <- "Lisbon"
cities$city_english[55] <- "Oulu"
cities$city_english[61] <- "Prague"
cities$city_english[79] <- "Warsaw"
cities$city_english[80]<- "Vienna"

# edit qualityOL dataset based on cities_df
# replace original city names with english names
qualityOL <- qualityOL %>%
  left_join(cities, by = join_by(city))
qualityOL <- qualityOL %>%
  select(country, city_english, variable, percentage)

# life_satisfaction DATASET --------------------------------------------------#

# load data and filter European countries only
life_satisfaction <- read.csv("C:/Users/Michael/Documents/Psychologie/Master/01_Stats_Courses/Programming_the_next_step/happiness-cantril-ladder.csv") %>%
  filter(grepl(paste(unique(cities$country), collapse="|"),
               Entity)) %>%
  select(Entity, Year, Cantril.ladder.score, Code)  %>%
  rename(Life_satisfaction = Cantril.ladder.score)


# price_categories dataset --------------------------------------------------#

price_categories <- data.frame(
  category = c(rep("Housing", 7),
               rep("Groceries", 7),
               rep("Alcoholic Beverages", 2),
               rep("Leisure time and going out", 4),
               rep("Transportation", 3)),
  item_name = c("Price per square meter to Buy Apartment Outside of City Center",
              "Price per square meter to Buy Apartment in City Center",
              "One bedroom apartment in city centre",
              "Three bedroom apartment in city centre",
              "One bedroom apartment outside of city centre",
              "Three bedroom apartment outside of city centre",
              "Basic utilities for 85 square meter Apartment including Electricity, Heating or Cooling, Water and Garbage",
              "Banana, 1 kg",
              "Lettuce, 1 head",
              "White Rice, 1 kg",
              "Potato, 1 kg",
              "Loaf of Fresh White Bread, 0.5 kg",
              "Eggs, 12 pack",
              "Milk, Regular,1 liter",
              "Imported Beer, 0.33 liter Bottle",
              "Bottle of Wine, Mid-Range Price",
              "Meal for 2 People, Mid-range Restaurant, Three-course",
              "Fitness Club, Monthly Fee for 1 Adult",
              "Cinema ticket, 1 Seat",
              "Cappuccino",
              "Gasoline, 1 liter",
              "Taxi, price for 1 km, Normal Tariff",
              "One-way Ticket, Local Transport"
              )
)



# store all datasets as internal data -------------------------------------#
usethis::use_data(life_satisfaction, qualityOL, cities, price_categories,
                  internal = TRUE, overwrite = TRUE)


