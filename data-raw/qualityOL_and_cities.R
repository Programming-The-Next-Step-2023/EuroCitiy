## code to prepare `qualityOL` and `cities` datasets

library(dplyr)
library(tidyr)

# qualitOL dataset ------------------------------------------------------------

qualityOL <- readxl::read_excel("quality_of_life_european_cities_2019_aggregated_data.xlsx",
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
cities$city_english[5] <- "Antwerp"
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

# export cities data frame
usethis::use_data(cities, overwrite = TRUE)

# edit qualityOL dataset based on cities_df ------------------------------------
# replace original city names with english names
qualityOL <- qualityOL %>%
  left_join(cities, by = join_by(city))
qualityOL <- qualityOL %>%
  select(country, city_english, variable, percentage) %>%
  rename(city = city_english)


# export
usethis::use_data(qualityOL, overwrite = TRUE)
