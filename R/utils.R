# HELPER FUNCTIONS

library(dplyr)

# Define European countries to be included in the data
european_countries <- c("Denmark","Netherlands","Turkey","Belgium","Greece",
                        "Spain","Northern Ireland","Serbia","Germany","Poland",
                        "Italy","France","Portugal","Slovakia","Romania",
                        "Hungary","Bulgaria","Wales","Ireland","Switzerland",
                        "Scotland","Austria","Finland","Cyprus",
                        "Slovenia","England","Sweden","Norway","Czechia",
                        "Montenegro","Iceland","Latvia","North Macedonia",
                        "Estonia","Albania","Malta","Lithuania",
                        "Croatia","Luxembourg")

# Define European cities included
european_cities <- c("Aalborg","Amsterdam","Ankara","Antalya","Antwerpen",
                     "Athens","Barcelona","Belfast",
                     "Belgrade","Berlin","Białystok","Bologna",
                     "Bordeaux","Braga","Bratislava","Brussels",
                     "Bucharest","Budapest","Burgas","Cardiff",
                     "Cluj-Napoca","Diyarbakir","Dortmund","Dublin",
                     "Essen","Gdańsk","Geneva","Glasgow",
                     "Graz","Groningen","Hamburg","Helsinki",
                     "Heraklion","Istanbul","Košice","Cracow",
                     "Copenhagen","Nicosia","Leipzig","Lille",
                     "Lisbon","Liège","Ljubljana","London",
                     "Madrid","Malmö","Manchester","Marseille",
                     "Miskolc","Munich","Málaga","Naples",
                     "Oslo","Ostrava","Oulu","Oviedo",
                     "Palermo","Paris","Piatra Neamt","Podgorica",
                     "Prague","Rennes","Reykjavík","Riga",
                     "Rome","Rostock","Rotterdam","Skopje",
                     "Sofia","Stockholm","Strasbourg","Tallinn",
                     "Tirana","Turin","Tyneside conurbation","Valletta",
                     "Verona","Vilnius","Warsaw","Vienna",
                     "Zagreb","Zurich","luxembourg")

# function to filter cities within one country
filter_cities_by_country <- function(chosen_country){
  # return error if more than several countries chosen
  if(length(chosen_country) > 1){
    stop("Choose one country only.")
  }

  #
  filtered_cities <- cities %>%
    filter(country == chosen_country) %>%
    select(city_english)

  return(filtered_cities$city_english)
}

